// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final VoidCallback callBackClear, callBackPrefix, callBackSearch;
  final isPrefixIconVisible;
  final String hintText;
  const TextFieldSearch(
      {required this.textEditingController,
      required this.onChanged,
      required this.callBackClear,
      this.isPrefixIconVisible = false,
      required this.callBackSearch,
      required this.callBackPrefix,
      this.hintText = 'Search'});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        margin: const EdgeInsets.all(10),
        child: TextField(
            controller: textEditingController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                prefixIcon: isPrefixIconVisible
                    ? IconButton(
                        icon: const Icon(Icons.search,
                            size: 20, color: Colors.blue),
                        onPressed: callBackPrefix)
                    : null,
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue)),
                filled: true,
                hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    textBaseline: TextBaseline.alphabetic),
                hintText: hintText,
                fillColor: Colors.grey.withOpacity(0.1))));
  }
}
