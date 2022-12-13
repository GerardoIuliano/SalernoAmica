import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? validator;

  const CustomTextField(
      {Key? key, required this.controller, required this.label, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return validator;
          }
        },
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: label,
        ),
      ),
    );
  }
}