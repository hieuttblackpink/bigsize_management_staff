import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/theme_manager.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {required this.controller,
      this.fillHint,
      required this.title,
      required this.prefix,
      this.isPass = false,
      this.validator,
      this.keyboardType,
      this.suffix,
      this.border = false,
      Key? key,
      this.onChange,
      this.onTap,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.readOnly = false,
      this.maxLenght,
      this.inputFormaterLenght})
      : super(key: key);

  final bool border;
  final TextEditingController controller;
  final String? fillHint;
  final String title;
  final IconData prefix;
  final bool isPass;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final bool readOnly;
  final int? maxLenght;
  final int? inputFormaterLenght;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        onEditingComplete: onEditingComplete,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        obscureText: isPass,
        autofillHints: fillHint == null ? null : [fillHint!],
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 20),
        readOnly: readOnly,
        maxLength: maxLenght,
        inputFormatters: [
          LengthLimitingTextInputFormatter(inputFormaterLenght),
        ],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: border
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.4), width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          suffixIcon: suffix,
          prefixIcon: Icon(
            prefix,
            size: 20,
            color: ColorManager.lightGrey,
          ),
          labelText: title,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          counterText: "",
        ),
      ),
    );
  }
}
