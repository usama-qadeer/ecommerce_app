// ignore_for_file: empty_constructor_bodies, camel_case_types

import 'package:flutter/material.dart';

class myHeader extends StatelessWidget {
  final String? title;
  myHeader({this.title});

  //final myHeader widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "$title",
        style: const TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
    );
  }
}
