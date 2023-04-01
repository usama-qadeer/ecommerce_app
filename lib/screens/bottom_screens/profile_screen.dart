// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:ecommerce_app/widget/mHeader.dart';
import 'package:ecommerce_app/widget/myButton.dart';
import 'package:ecommerce_app/widget/myTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({super.key});
  String? profilePic;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController houseC = TextEditingController();
  TextEditingController streetC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: myHeader(
              title: "Profile",
            ),
            preferredSize: Size.fromHeight(10.h)),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final XFile? pickImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                      if (pickImage != null) {
                        setState(() {
                          profilePic = pickImage.path;
                        });
                      }
                    },
                    child: Container(
                      child: profilePic == null
                          ? CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              radius: 50,
                              child: Image.asset(
                                "assets/profile-photo.png",
                                height: 70,
                                width: 70,
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(
                                File(profilePic!),
                              ),
                            ),
                    ),
                  ),
                ),
                MyTextFormField(
                  controller: nameC,
                  validate: (p0) {
                    'value should not empty';
                    return null;
                  },
                  hintText: "Full Name",
                ),
                MyTextFormField(
                  controller: phoneC,
                  validate: (p0) {
                    'value should not empty';
                    return null;
                  },
                  hintText: "Contact No#",
                ),
                MyTextFormField(
                  controller: houseC,
                  validate: (p0) {
                    'value should not empty';
                    return null;
                  },
                  hintText: "House No#",
                ),
                MyTextFormField(
                  controller: streetC,
                  validate: (p0) {
                    'value should not empty';
                    return null;
                  },
                  hintText: "Street No#",
                ),
                MyTextFormField(
                  controller: cityC,
                  validate: (p0) {
                    'value should not empty';
                    return null;
                  },
                  hintText: "City",
                ),
                MyTextFormField(
                  controller: addressC,
                  hintText: "Address",
                ),
                MyButton(
                  buttonText: "Save",
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      SystemChannels.textInput
                          .invokeMapMethod("TextInput.hide");
                    }
                  },
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ));
  }
}
