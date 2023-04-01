import 'package:flutter/material.dart';

import '../utitlies/style.dart';

class HomeCards extends StatelessWidget {
  String? title;
  VoidCallback? onPress;
  HomeCards({
    Key? key,
    this.title,
    this.onPress,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Colors.redAccent.withOpacity(0.8),
                Colors.blueAccent.withOpacity(0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title ?? "title".toUpperCase(),
                style: BoldStyle.boldStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
