import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/screens/homepage.dart';
import 'package:todolist/screens/regCat.dart';
import 'package:todolist/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController EmailController = TextEditingController(text: "ahmed@gmail.com");

  TextEditingController PasswordController = TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login "),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Welcom Back"),
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: EmailController,
                      label: "Email",
                      validator: (email) {
                        if (email == null || email.trim().isEmpty) {
                          return 'Please enter your Email';
                        }

                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email);
                        if (!emailValid) {
                          print('Invalid Email');
                        }

                        return null;
                      },
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      securedText: true,
                      controller: PasswordController,
                      label: "Password",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your Password';
                        }
                        if (text.length < 6) {
                          return "Password must be at least 6 chars";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Loginfunc();
                        },
                        child: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Appcolors.blackColorCategory),
                        )),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text('Or Create Account',
                              style: TextStyle(color: Colors.blue))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void Loginfunc() async {
    if (formKey.currentState!.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: EmailController.text, password: PasswordController.text);
        print(credential.user?.uid ?? "");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('signed in as ${EmailController.text}')));
        Navigator.pushNamed(context, Homepage.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No user found for that email.')));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Wrong password provided for that user.')));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('auth credential is inccorrect or not found .')));
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
