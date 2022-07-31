import 'dart:collection';
import 'dart:io';

import 'package:bigsize_management_staff/blocs/avatar_bloc.dart';
import 'package:bigsize_management_staff/model/module/storage_item.dart';
import 'package:bigsize_management_staff/models/avatar/avatar.dart';
import 'package:bigsize_management_staff/services/firebase_messaging.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/routes_manger.dart';
import 'package:bigsize_management_staff/view/resources/theme_manager.dart';
import 'package:bigsize_management_staff/view/shared/widgets/custom_dialog.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/about_app/about_app_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/change_password/change_password.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile/userprofile_screen.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/setting/components/in_setting_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/setting/components/setting_menu.dart';
import 'package:bigsize_management_staff/view/ui/signin/signin_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/shared/widgets/numeric_field.dart';
import 'package:bigsize_management_staff/view_model/setting_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../resources/styles_manager.dart';

class GetInfo {
  Future<HashMap<String, String>> getInfo() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    //print('Android $release (SDK $sdkInt), $manufacturer $model');
    HashMap<String, String> info = HashMap();
    Map<String, String> info1 = {
      'osVer': release.toString(),
      'sdkVer': sdkInt.toString(),
      'manuInfo': manufacturer.toString(),
      'modelInfo': model.toString()
    };
    info.addAll(info1);
    //print(info);
    return info;
  }
}

class SettingLayout extends StatefulWidget {
  const SettingLayout({Key? key}) : super(key: key);

  @override
  State<SettingLayout> createState() => _SettingLayout();
}

class _SettingLayout extends State<SettingLayout> {
  SettingProvider settingProvider(BuildContext context) =>
      context.read<SettingProvider>();

  final StorageService _storageService = StorageService();
  final AvatarBloc _avatarBloc = AvatarBloc();
  Avatar? avatar;
  late List<StorageItem> _items;
  bool _loading = true;
  GetInfo g = GetInfo();
  HashMap<String, String> info = new HashMap();

  bool isHasAvatar = false;

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<Avatar?> getAvatar(String token) async {
    Avatar _avatar = await _avatarBloc.getAvatar(token);
    if (mounted && !isHasAvatar) {
      setState(() {
        avatar = _avatar;
        isHasAvatar = true;
      });
    }
    //print(avatar);
    return _avatar;
  }

  Future<void> _uploadAvatar(String token, String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImg;
    try {
      pickedImg = await picker.pickImage(
        source:
            inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1920,
      );
      //final String fileName = path.basename(pickedImg!.path);
      File imgFile = File(pickedImg!.path);
      try {
        showLoading(context);
        Avatar _avatar = await _avatarBloc.uploadAvatar(token, imgFile);
        if (_avatar.isSuccess!) {
          Fluttertoast.showToast(
              msg: "Thay ảnh đại diện thành công!", // message
              toastLength: Toast.LENGTH_LONG, // length
              gravity: ToastGravity.BOTTOM, // location
              timeInSecForIosWeb: 2 // duration
              );
          Navigator.pop(context);
          setState(() {
            isHasAvatar = false;
          });
        } else {
          showLoading(context);
          Fluttertoast.showToast(
              msg: "Thay ảnh đại diện thất bại!", // message
              toastLength: Toast.LENGTH_LONG, // length
              gravity: ToastGravity.BOTTOM, // location
              timeInSecForIosWeb: 2 // duration
              );
          Navigator.pop(context);
        }
      } catch (error) {
        if (kDebugMode) {
          print("Upload error in api: " + error.toString());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Upload error in picker: " + e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void initList() async {
    _items = await _storageService.readAllSecureData();
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    g.getInfo().then((value) => info = value);
    return SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<String?>(
              future: getUserToken(),
              builder: (context, token) {
                if (token.hasData) {
                  if (!isHasAvatar) {
                    getAvatar(token.data.toString());
                  }
                  if (isHasAvatar &&
                      avatar != null &&
                      avatar!.content != null) {
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                                //backgroundImage:
                                //NetworkImage(avatar!.content.toString()),
                                backgroundColor:
                                    const Color.fromARGB(255, 230, 246, 252),
                                child: ClipOval(
                                  child: Image.network(
                                    avatar!.content.toString(),
                                    height: 105,
                                    width: 105,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Positioned(
                              right: 130,
                              bottom: -10,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    primary: Colors.white,
                                    backgroundColor: const Color(0xFFF5F6F9),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) => CustomAlertDialog(
                                              title: "Thay ảnh đại diện",
                                              description:
                                                  "Chọn nguồn hình ảnh",
                                              camera: () {
                                                _uploadAvatar(
                                                    token.data.toString(),
                                                    "camera");
                                                Navigator.of(context).pop();
                                              },
                                              gallery: () async {
                                                _uploadAvatar(
                                                    token.data.toString(),
                                                    "galerry");
                                                Navigator.of(context).pop();
                                              },
                                            ));
                                    //_uploadAvatar(
                                    //token.data.toString(), "galerry");
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/Camera Icon.svg"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Shimmer.fromColors(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60)),
                      ),
                      baseColor: const Color.fromARGB(255, 230, 230, 230),
                      highlightColor: Colors.white,
                    );
                  }
                }

                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            SettingMenu(
                text: "Hồ sơ",
                icon: Icons.account_circle_rounded,
                press: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UserProfileScreen()))
                    }),
            const SizedBox(
              height: 0.5,
            ),
            SettingMenu(
                text: "Cài đặt",
                icon: Icons.settings,
                press: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const InSettingLayout()))
                    }),
            const SizedBox(
              height: 0.5,
            ),
            SettingMenu(
              text: "Thông báo",
              icon: Icons.notifications_rounded,
              press: () =>
                  {Navigator.pushNamed(context, Routes.notificationRoute)},
            ),
            const SizedBox(
              height: 0.5,
            ),
            SettingMenu(
                text: "Về ứng dụng",
                icon: Icons.info_rounded,
                press: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AppInfo(info2: info))),
                    }),
            const SizedBox(
              height: 0.5,
            ),
            SettingMenu(
              text: "Đăng xuất",
              icon: Icons.logout,
              press: () async {
                String userName =
                    _storageService.readSecureData("Username").toString();
                if (userName.isNotEmpty) {
                  //await HandleMessagingFirebase.unReceiveMessagingFromServer(
                  //userName);
                }
                _storageService.deleteAllSecureData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                    (route) => false);
              },
              colors: Colors.red,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "10.3.6",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "QuicksandLight",
                fontSize: 20,
              ),
            ),
            /*
            Container(
              child: _loading
                  ? const CircularProgressIndicator()
                  : _items.isEmpty
                      ? const Text("Empty secure storage!")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _items.length,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (_, index) {
                            return Dismissible(
                              key: Key(_items[index].toString()),
                              child: VaultCard(item: _items[index]),
                              onDismissed: (direction) async {
                                await _storageService
                                    .deleteSecureData(_items[index])
                                    .then((value) => _items.removeAt(index));
                                initList();
                              },
                            );
                          }),
            ),
            */
          ],
        ));
  }

  Widget database(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _button(context, 'Import database',
                () => settingProvider(context).importDataBase()),
            _divider(context),
            _button(context, 'Export database',
                () => settingProvider(context).exportDataBase()),
            _divider(context),
            _button(context, 'Clear database',
                () => settingProvider(context).clearDataBase()),
          ],
        ),
      );
  Widget product(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minimum amount',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                      width: 120,
                      child: NumericField(
                        TextEditingController(
                            text: settingProvider(context)
                                .minimumAmount
                                .toString()),
                        onChange: (v) => settingProvider(context)
                            .changeMinimumAmount(int.parse(v)),
                      ))
                ],
              ),
            ),
            _divider(context),
            _button(
              context,
              'Hide wholesale price',
              () => settingProvider(context).hidePrice(),
            ),
          ],
        ),
      );

  Widget reports(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, _) => _divider(context),
          itemCount: 5,
          itemBuilder: (context, index) => Align(
            alignment: Alignment.centerLeft,
            child: [
              _button(
                context,
                'Not in stock items',
                () => settingProvider(context).printZeroProduct(),
              ),
              _button(
                context,
                'Less than minimum amount',
                () => settingProvider(context).printLessProduct(),
              ),
              _button(
                context,
                'All products',
                () => settingProvider(context).printAllProduct(),
              ),
              _button(
                context,
                'All entries',
                () => settingProvider(context).printAllEntries(),
              ),
              _button(
                context,
                'All Orders',
                () => settingProvider(context).printAllOrders(),
              ),
            ][index],
          ),
        ),
      );

  Widget _button(BuildContext context, String text, Function() onPressed) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );

  Widget _title(BuildContext context, String text) => Row(
        children: [
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.onBackground,
              // thickness: 10,
              height: 10,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text, style: Theme.of(context).textTheme.headline4),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.onBackground,
              // thickness: 10,
              height: 10,
            ),
          ),
        ],
      );

  Widget _divider(BuildContext context) => Padding(
        padding: EdgeInsets.zero,
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          height: 0,
        ),
      );

  showLoading(context) {
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text(
                    "Đang xử lí...",
                    style: TextStyle(fontFamily: "QuicksandMedium"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
