import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/model/repository/dates_repository.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';

import '../../../../model/module/old_edit_money.dart';
import '../../../resources/styles_manager.dart';
import '../../../shared/functions/dialog.dart';
import '../../../shared/widgets/numeric_field.dart';

// ignore: must_be_immutable
class EditBox extends StatelessWidget {
  EditBox(this.notesController, this.amountController, {Key? key})
      : super(key: key);
  final TextEditingController amountController;
  final TextEditingController notesController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditType editType = EditType.add;
  DateTime editDate = DateTime.now();
  TimeOfDay editTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              boxShadow: StyleManager.shadow,
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: StyleManager.border),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: NumericField(amountController)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _radioButtons(context),
                  )
                ],
              ),
              _getDate(context),
              DefaultFormField(
                controller: notesController,
                title: "Notes",
                prefix: Icons.notes,
                validator: (val) => val!.isEmpty ? "Please add a note" : null,
                border: true,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      if (await chooseDialog(context,
                          title: "Confirmation",
                          content: "Are you sure you want to edit money")) {}
                    }
                  },
                  child: const Text("Save"))
            ],
          )),
    );
  }

  Widget _getDate(BuildContext context) => StatefulBuilder(
      builder: (context, setState) =>
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(' Start date', style: Theme.of(context).textTheme.subtitle1),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: OutlinedButton(
                key: Key(editDate.toString()),
                onPressed: () async {
                  editDate = await DateRepository.selectDate(
                      context: context, initial: editDate);
                  setState(() {});
                },
                child: Text(
                  editDate.formatDate,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: OutlinedButton(
                key: Key(editTime.toString()),
                onPressed: () async {
                  editTime = await DateRepository.selectTime(
                      context: context, initial: editTime);
                  setState(() {});
                },
                child: Text(
                  editTime.format(context),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]));

  Widget _radioButtons(BuildContext context) => StatefulBuilder(
      builder: (context, setState) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                SizedBox(
                  width: 30,
                  child: Radio<EditType>(
                      value: editType,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                      groupValue: EditType.add,
                      onChanged: (val) {
                        setState(() {
                          editType = EditType.add;
                        });
                      }),
                ),
                Text(
                  "Add",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.red),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 30,
                  child: Radio<EditType>(
                      value: editType,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      groupValue: EditType.remove,
                      onChanged: (val) {
                        setState(() {
                          editType = EditType.remove;
                        });
                      }),
                ),
                Text(
                  "Remove",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.blue),
                ),
              ]),
            ],
          ));
}
