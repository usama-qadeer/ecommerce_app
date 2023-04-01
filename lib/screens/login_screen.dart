import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/widget/myButton.dart';
import 'package:ecommerce_app/widget/myTextFormField.dart';
import 'package:flutter/material.dart';

import '../services/firebase_wok.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();
  bool formStateLoding = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> ecoDialogue(String error, BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              MyButton(
                buttonText: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        formStateLoding = true;
      });
      String? acctStatus =
          await FirebaseWork.signAccount(_emailC.text, _passC.text);
      if (acctStatus != null) {
        ecoDialogue(acctStatus, context);
        setState(() {
          formStateLoding = false;
        });
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Welcome \nLogin First",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFormField(
                    validate: (p0) {
                      if (p0!.isEmpty || p0.length < 5) {
                        return ("Enter a valid email");
                      }
                    },
                    controller: _emailC,
                    hintText: "Enter Your Email",
                  ),
                  MyTextFormField(
                    controller: _passC,
                    hintText: "Enter Your Password",
                  ),
                  MyButton(
                    isLoading: formStateLoding,
                    onPress: () {
                      submit(context);
                    },
                    buttonText: "Login",
                    isLogin: false,
                  ),
                ],
              ),
            ),
            MyButton(
              buttonText: "Register",
              isLogin: true,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
