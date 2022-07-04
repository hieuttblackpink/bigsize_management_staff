// ignore_for_file: use_key_in_widget_constructors

import 'package:bigsize_management_staff/model/module/product.dart';
import 'package:bigsize_management_staff/models/product/product_detail.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatefulWidget {
  final ProductDetailList productDetailList;
  const CustomRow(this.productDetailList);

  @override
  CustomRowLayout createState() => CustomRowLayout();
}

class CustomRowLayout extends State<CustomRow> {
  static CustomRowLayout? of(BuildContext context) =>
      context.findAncestorStateOfType<CustomRowLayout>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.productDetailList.colour!.colourName.toString() +
                " - " +
                widget.productDetailList.size!.sizeName.toString(),
          ),
          widget.productDetailList.selected == true
              ? const Icon(
                  Icons.radio_button_checked,
                  color: Colors.amber,
                )
              : const Icon(Icons.radio_button_unchecked),
        ],
      ),
    );
  }
}
