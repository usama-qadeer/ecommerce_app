import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool isPass;
  int? maxLines_;
  MyTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.validate,
    this.isPass = false,
    this.maxLines_,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        // minLines: 1,
        // maxLines: maxLines_ == 1 ? 1 : 5,
        obscureText: isPass == false ? isPass : isPass == true,
        controller: controller,
        validator: validate,
        decoration: InputDecoration(
          hintText: hintText ?? "Null",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
