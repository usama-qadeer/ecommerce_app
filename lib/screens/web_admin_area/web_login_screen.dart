// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/web_body.dart';
import 'package:ecommerce_app/services/firebase_wok.dart';
import 'package:ecommerce_app/widget/myButton.dart';
import 'package:ecommerce_app/widget/myTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utitlies/style.dart';

class WebLoginScreen extends StatefulWidget {
  static const String id = "weblogin";
  const WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  /*BOOL STRINGs */
  bool formStateLoding = false;

  /*Editing Controller*/
  final TextEditingController _adminUserNameC = TextEditingController();

  final TextEditingController _adminPassword = TextEditingController();

  /*End Editing Controller*/
  final _adminFormKey = GlobalKey<FormState>();

  /*End Form Key */
  submit(BuildContext context) async {
    if (_adminFormKey.currentState!.validate()) {
      setState(() {
        formStateLoding = true;
      });
      await FirebaseWork.signInAnonymous(_adminUserNameC.text)
          .then((value) async {
        if (value["admin1"] == _adminUserNameC.text &&
            value["123456"] == _adminPassword.text) {
          UserCredential user = await FirebaseAuth.instance.signInAnonymously();
          try {
            if (user != null) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebMainScreen(),
                  ));

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("ADMIN LOGIN SUCCESSFULLY ")));
              print("ddddd");
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebLoginScreen(),
                  ));
            }
          } catch (e) {
            setState(() {
              formStateLoding = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      });
    }
  }

/*End Submit User */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        child: Material(
          elevation: 5,
          shadowColor: Colors.grey,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3.5,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(161, 221, 221, 221).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: Form(
                key: _adminFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "WELCOME \n ADMIN PANNEL",
                      textAlign: TextAlign.center,
                      style: BoldStyle.boldStyle,
                    ),
                    MyTextFormField(
                      controller: _adminUserNameC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return ("Value Should not be empty".toUpperCase());
                        } else {
                          return null;
                        }
                      },
                      hintText: "Enter Your Name....",
                    ),
                    MyTextFormField(
                      controller: _adminPassword,
                      validate: (p1) {
                        if (p1!.isEmpty) {
                          return ("Value Should not be empty".toUpperCase());
                        } else {
                          return null;
                        }
                      },
                      hintText: "Enter Your '6 Digit' Password",
                      isPass: true,
                    ),
                    MyButton(
                      onPress: () {
                        submit(context);
                      },
                      isLoading: formStateLoding,
                      buttonText: "L O G I N ",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
