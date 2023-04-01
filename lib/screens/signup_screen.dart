import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/services/firebase_wok.dart';
import 'package:ecommerce_app/widget/myButton.dart';
import 'package:ecommerce_app/widget/myTextFormField.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  bool? formStateLoading = false;
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

TextEditingController _nameC = TextEditingController();
TextEditingController _emailC = TextEditingController();
TextEditingController _passC = TextEditingController();
TextEditingController _confirmPass = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool formStateLoding = false;

@override
void dispose() {
  _emailC.dispose();
  _nameC.dispose();
  _passC.dispose();
  _confirmPass.dispose();
  // super.dispose();
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
    if (_passC.text == _confirmPass.text) {
      setState(() {
        formStateLoding = true;
      });
      String? acctStatus =
          await FirebaseWork.createAccount(_emailC.text, _passC.text);
      if (acctStatus != null) {
        ecoDialogue(acctStatus, context);
        setState(() {
          formStateLoding = false;
        });
      } else {
        _nameC.clear();
        _emailC.clear();
        _passC.clear();
        _confirmPass.clear();
        Navigator.pop(context);
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const LoginPage(),
      //   ));
    }
  }
}

void setState(Null Function() param0) {}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Sign-up",
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
                    hintText: "Enter Your Full Name",
                    controller: _nameC,
                    validate: (v) {
                      if (v!.isEmpty || v.length < 5) {
                        return ("Enter a valid name");
                      }
                    },
                  ),
                  MyTextFormField(
                    validate: (v) {
                      if (v!.isEmpty || !v.contains("@gmail.com")) {
                        return ("Enter a valid email");
                      }
                    },
                    hintText: "Enter Your Email",
                    controller: _emailC,
                  ),
                  MyTextFormField(
                    validate: (v) {
                      if (v!.isEmpty || v.length < 5) {
                        return ("Password Value should be 5 to 8 words");
                      }
                    },
                    hintText: "Enter Your Password",
                    controller: _passC,
                    isPass: true,
                  ),
                  MyTextFormField(
                    validate: (v) {
                      if (_passC.text != _confirmPass.text) {
                        return ("Enter Same Password");
                      }
                    },
                    hintText: "Confirm Your Password",
                    controller: _confirmPass,
                    isPass: true,
                  ),
                  MyButton(
                    onPress: () {
                      setState(() {
                        formStateLoding = true;
                      });
                      submit(context);
                    },
                    buttonText: "Register",
                    isLogin: false,
                    isLoading: formStateLoding,
                  ),
                ],
              ),
            ),
            MyButton(
              buttonText: "Back TO Login",
              isLogin: true,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
