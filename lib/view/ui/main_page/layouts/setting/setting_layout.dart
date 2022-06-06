import 'package:bigsize_management_staff/model/module/storage_item.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/routes_manger.dart';
import 'package:bigsize_management_staff/view/resources/vaultCard.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile/userprofile_screen.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/setting/components/setting_menu.dart';
import 'package:bigsize_management_staff/view/ui/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/shared/widgets/numeric_field.dart';
import 'package:bigsize_management_staff/view_model/setting_provider.dart';

import '../../../../resources/styles_manager.dart';

class SettingLayout extends StatefulWidget {
  const SettingLayout({Key? key}) : super(key: key);

  @override
  State<SettingLayout> createState() => _SettingLayout();
}

class _SettingLayout extends State<SettingLayout> {
  SettingProvider settingProvider(BuildContext context) =>
      context.read<SettingProvider>();

  final StorageService _storageService = StorageService();
  late List<StorageItem> _items;
  bool _loading = true;

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
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text("Setting"),
            ),
            const SizedBox(
              height: 20,
            ),
            SettingMenu(
                text: "Profile",
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
            const SettingMenu(text: "Setting", icon: Icons.settings),
            const SizedBox(
              height: 0.5,
            ),
            const SettingMenu(text: "Help center", icon: Icons.help),
            const SizedBox(
              height: 0.5,
            ),
            const SettingMenu(text: "About app", icon: Icons.info_rounded),
            const SizedBox(
              height: 0.5,
            ),
            SettingMenu(
              text: "Logout",
              icon: Icons.logout,
              press: () async {
                _storageService.deleteAllSecureData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                    (route) => false);
              },
            ),
            const SizedBox(
              height: 20,
            ),
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
}
