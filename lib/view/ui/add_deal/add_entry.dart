import 'package:bigsize_management_staff/view/ui/add_deal/widgets/customer_box.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/model/module/deals.dart';

import '../../../model/repository/dates_repository.dart';
import '../../resources/styles_manager.dart';
import 'widgets/add_box.dart';
import 'widgets/old_entries.dart';

class AddDealView extends StatelessWidget {
  const AddDealView(this.isEntry, {this.deal, Key? key}) : super(key: key);
  final Deal? deal;
  final bool isEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
                "${deal == null ? "Tao" : "Edit"} ${isEntry ? "entry" : "don hang"}"),
            actions: [
              IconButton(
                  onPressed: () {
                    DateRepository.selectDate(
                        context: context, initial: DateTime.now());
                  },
                  icon: const Icon(Icons.calendar_today))
            ],
          ),
          bottomNavigationBar: BottomAppBar(
              color: Colors.white.withOpacity(0),
              child: BlurryContainer(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.2),
                blur: 0,
                height: 170,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      width: 400,
                      child: ListTile(
                        title: Text(
                          "Tam tinh",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "QuicksandBold",
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        isThreeLine: false,
                        trailing: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            "1000000 VND",
                            style: TextStyle(
                              fontFamily: "QuicksandBold",
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      side: BorderSide(color: Colors.black)))),
                          child: Container(
                            width: 120,
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              "Tao don hang",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text("Date: ${DateTime.now().formatDate}",
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 10),
                upperBox(context),
                ...List.generate(2, (index) => divider()),
                Text("Khach hang",
                    style: Theme.of(context).textTheme.headline4),
                divider(),
                const CustomerBox(),
                const SizedBox(height: 10),
                Text("Phuong thuc thanh toan",
                    style: Theme.of(context).textTheme.headline4),
                divider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: StyleManager.shadow,
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: StyleManager.border),
                  height: 45,
                  child: GestureDetector(
                    onTap: () => {},
                    child: const Text(
                      "Chon phuong thuc thanh toan",
                      style: TextStyle(
                        fontFamily: "QuicksandMedium",
                        fontSize: 20,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text("Them san pham",
                    style: Theme.of(context).textTheme.headline4),
                divider(),
                AddBox(),
                ...List.generate(2, (index) => divider()),
                Text("Danh sach san pham",
                    style: Theme.of(context).textTheme.headline4),
                divider(),
                OldEntryList(),
              ],
            ),
          )),
    );
  }

  Widget upperBox(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Tong tien",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                divider(),
                Text(
                  "1000000 VND",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            verticalLine(context),
            Column(
              children: [
                Text("San pham", style: Theme.of(context).textTheme.subtitle1),
                divider(),
                Text("50", style: Theme.of(context).textTheme.subtitle1),
                divider(),
              ],
            ),
          ],
        ),
      );

  Widget verticalLine(BuildContext context) => Container(
        height: 60.0,
        width: 1.0,
        color: Theme.of(context).colorScheme.onPrimary,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      );

  Widget divider() => const SizedBox(
        height: 5.0,
      );
}
