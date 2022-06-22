import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: <Widget>[
        const Icon(Icons.cancel_outlined, color: Colors.red, size: 10),
        const SizedBox(
          width: 10,
        ),
        Text(
          error,
          softWrap: true,
          maxLines: 2,
          style: const TextStyle(
            fontFamily: "QuickSandMedium",
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
