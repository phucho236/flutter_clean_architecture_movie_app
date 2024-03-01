import 'package:flutter/material.dart';

class AppTextFeild extends StatelessWidget {
  const AppTextFeild({
    required this.textFormField,
    this.err,
    super.key,
  });
  final TextFormField textFormField;
  final String? err;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              width: 2,
              color: Colors.blue,
            ),
          ),
          child: textFormField,
        ),
        if (err != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(err!),
          ),
      ],
    );
  }
}
