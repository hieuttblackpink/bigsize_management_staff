import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';

import '../../../resources/styles_manager.dart';
import '../../../shared/widgets/numeric_field.dart';

class AddBox extends StatelessWidget {
  AddBox({Key? key}) : super(key: key);
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    amountController.text = "1";
    return Form(
      key: formKey,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              boxShadow: StyleManager.shadow,
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: StyleManager.border),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: StyleManager.border,
                  color: Theme.of(context).colorScheme.background,
                ),
                child: DefaultFormField(
                  border: true,
                  controller: TextEditingController(),
                  title: "Search Product",
                  prefix: Icons.search,
                ),
              ),
              const SizedBox(height: 20),
              Text("Laser Bag", style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: NumericField(
                    amountController,
                    title: "Price",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: NumericField(
                    amountController,
                    title: "Amount",
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                    onPressed: () async {}, child: const Text("Them")),
              )
            ],
          )),
    );
  }
}
