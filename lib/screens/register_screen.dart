import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/screens/login.dart';
import 'package:todolist/screens/regCat.dart';
import 'package:todolist/themeData.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'RegisterPage';

  TextEditingController nameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(Icons.arrow_back,
                color: const Color.fromARGB(255, 247, 246, 246)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.25,
          backgroundColor: Color(0xff0E1E2F),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Register",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Create your account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          // centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'UserName',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
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
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      securedText: true,
                      controller: ConfirmPasswordController,
                      label: "Confirm Password",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter confirm password';
                        }
                        if (text.length < 6) {
                          return "Password must be at least 6 chars";
                        }
                        if (text != PasswordController.text) {
                          return "Confirm password doesn't matched";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape:
                                WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xffC7E780))),
                        onPressed: () {
                          register(context);
                        },
                        child: Text(
                          "Create Account",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Appcolors.blackColorCategory),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void register(context) async {
    if (formKey.currentState!.validate() == true) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text,
          password: PasswordController.text,
        );
        Navigator.pushNamed(context, LoginScreen.routeName);
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('The password provided is too weak.')));
        } else if (e.code == 'email-already-in-use') {
          // print('The account already exists for that email.');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('The account already exists for that email.')));
          Navigator.pushNamed(context, LoginScreen.routeName);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
