import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/providers/app_config_provider.dart';
import 'package:todolist/screens/homepage.dart';
import 'package:todolist/screens/regCat.dart';
import 'package:todolist/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static const String routeName = 'Login';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController EmailController =
      TextEditingController();

  TextEditingController PasswordController =
      TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color(0xff0E1E2F),
            toolbarHeight: MediaQuery.of(context).size.height * 0.20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign in to your \nAccount",
                  style: TextStyle(
                      color: Appcolors.whiteColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign in to your Account",
                  style: TextStyle(
                    color: Color.fromARGB(255, 127, 136, 146),
                    fontSize: 16,
                  ),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CustomTextFormField(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CustomTextFormField(
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
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                                backgroundColor:
                                    WidgetStatePropertyAll(Color(0xffBAE162))),
                            onPressed: () {
                              Loginfunc();
                            },
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Appcolors.blackColorCategory),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 2,
                            color: Color(0xffF6F6F6),
                          ),
                          Text(
                            'Or login with',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 2,
                            color: Color(0xffF6F6F6),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 205, 199, 199))),
                        // color: Colors.transparent,
                        width: 150,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                // decoration: BoxDecoration(color: Colors.blue),
                                child: Image.network(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                                    fit: BoxFit.cover)),
                            SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  signInWithGoogle();
                                },
                                child: Text(
                                  'Google',
                                  style: TextStyle(color: Appcolors.blueColor),
                                ))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ? "),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                              child: Text('Register',
                                  style: TextStyle(color: Color(0xffC7E780)))),
                        ],
                      ),
                    ],
                  ),
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
              content: Text('Auth credential is incorrect or not found.')));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await widget.googleSignIn.signIn();

      // If the user cancels the sign-in, googleUser will be null
      if (googleUser == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Google Sign-In canceled.')));
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signed in as ${user.email}')));
        Navigator.pushNamed(context, Homepage.routeName);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firebase auth error: ${e.message}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in failed: ${e.toString()}')));
    }
  }
}
