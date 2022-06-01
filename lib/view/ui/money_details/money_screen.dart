import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/money_details/widgets/edit_box.dart';
import 'package:bigsize_management_staff/view/ui/money_details/widgets/old_edits.dart';

class MoneyDetailsView extends StatelessWidget {
  MoneyDetailsView({Key? key}) : super(key: key);
  final TextEditingController amountController =
      TextEditingController(text: "10");
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Money Box"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                upperBox(context),
                ...List.generate(2, (index) => divider()),
                Text("Edit Money",
                    style: Theme.of(context).textTheme.headline4),
                divider(),
                EditBox(notesController, amountController),
                ...List.generate(2, (index) => divider()),
                Text("Old Edits", style: Theme.of(context).textTheme.headline4),
                divider(),
                OldEditList(),
              ],
            ),
          )),
    );
  }

  Widget upperBox(BuildContext context) => Hero(
        tag: "MoneyBox",
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              boxShadow: StyleManager.shadow,
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: StyleManager.border),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Money",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  divider(),
                  Text(
                    "850 EGP",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  divider(),
                  Text(
                    "Revenue 75 EGP",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              verticalLine(context),
              Column(
                children: [
                  Text("Today", style: Theme.of(context).textTheme.subtitle1),
                  divider(),
                  Text("500 EGP", style: Theme.of(context).textTheme.subtitle1),
                  divider(),
                  Text(
                    "75 EGP",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
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
