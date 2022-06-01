import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/model/repository/database_repo.dart';
import 'package:bigsize_management_staff/model/repository/dates_repository.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';
import 'package:bigsize_management_staff/view/shared/widgets/numeric_field.dart';

import '../../../model/module/product.dart';
import '../../resources/styles_manager.dart';

class AddProductView extends StatefulWidget {
  const AddProductView(this.product, {Key? key}) : super(key: key);
  final Product? product;

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  Uint8List? img;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController =
      TextEditingController(text: '10');
  final TextEditingController _realPriceController =
      TextEditingController(text: '10');
  final TextEditingController _sellPriceController =
      TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save_outlined),
            onPressed: () {},
          ),
          appBar: AppBar(
            title: Text("${widget.product == null ? "Add" : "Edit"} Product"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                      "Last Updated: ${widget.product?.date ?? DateTime.now().formatDate}",
                      style: Theme.of(context).textTheme.headline4),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                      ),
                      borderRadius: StyleManager.border,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: StyleManager.border, // Image border
                          child: img != null
                              ? Image.memory(img!)
                              : Image.network(
                                  'https://design-milk.com/images/2014/09/PLAAT-Bag-Dewi-Bekker-qoowl-1.jpg',
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 20,
                            foregroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Center(
                              child: IconButton(
                                iconSize: 25,
                                icon: const Icon(Icons.camera_alt_outlined),
                                onPressed: () async {
                                  img = await ImageFileHandling()
                                      .pickImage(context);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: StyleManager.border,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    child: DefaultFormField(
                      border: true,
                      controller: _nameController,
                      title: "Name",
                      prefix: Icons.text_fields_outlined,
                    ),
                  ),
                  const Divider(),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: StyleManager.border,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      child: NumericField(_amountController, title: 'Amount')),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: StyleManager.border,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              child: NumericField(_realPriceController,
                                  title: 'Real Price'))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: StyleManager.border,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              child: NumericField(_sellPriceController,
                                  title: 'Sell Price'))),
                    ],
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: StyleManager.border,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    child: DefaultFormField(
                      border: true,
                      controller: _notesController,
                      title: "Notes",
                      prefix: Icons.notes_outlined,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
