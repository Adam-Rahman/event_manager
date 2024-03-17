// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import "package:awesome_dialog/awesome_dialog.dart";
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:get/get.dart";
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('/////////////////////////////User is currently signed out!');
      } else {
        print('/////////////////////////////////////User is signed in!');
      }
    });
  }

  final TextEditingController password = TextEditingController();

  final TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Login", style: TextStyle(fontSize: 40)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The input should not be empty";
                    }
                    return null;
                  },
                  controller: email,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The input should not be empty";
                    }
                    return null;
                  },
                  controller: password,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // print('Form data saved');
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            Get.offNamed("/addEvent");
                          } on FirebaseAuthException catch (e) {
                            print(e);
                            if (e.code == 'user-not-found') {
                              print(
                                  '//////////////////No user found for that email.');
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'No user found for that email.',
                              ).show();
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Wrong password provided for that user.',
                              ).show();
                            }
                          }
                        }
                      },
                      child: Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //takes the user to signup page

                        Get.offNamed("/signup");
                      },
                      child: Text('Create account'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
