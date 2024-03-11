import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _loginState();
}

class _loginState extends State<signup> {
  var accounts = FirebaseFirestore.instance.collection("accounts");
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final TextEditingController name = TextEditingController();
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
          Text("Signup", style: TextStyle(fontSize: 40)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The input should not be empty";
                    }
                    return null;
                  },
                  controller: name,
                ),
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
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Enter your Password again"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The input should not be empty";
                    }
                    return null;
                  },
                  controller: rePassword,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        // add username and user id
                        try {
                          DocumentReference response = await accounts.add({
                            "name": name.text,
                            "userid": credential.user!.uid,
                          });
                          print("///////////////////$response is okkkkkk");
                        } catch (e) {
                          print(
                              "/////////////////////////////firebase error:   $e ");
                        }
                        //If signup is successful, then go to add event page
                        Get.offNamed("/addEvent");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }

                      print('Form data saved');
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
