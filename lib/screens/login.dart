import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:get/get.dart";

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController password = TextEditingController();

  final TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  //get the user
  void getUser() async {
    CollectionReference accounts =
        FirebaseFirestore.instance.collection("accounts");

    QuerySnapshot response = await accounts.get();
    if (response.docs.isNotEmpty) {
      print(
          "///////////////////////////${response.docs[0]}//////////////////////");
      Get.offNamed("/addEvent");
    } else {
      print("No user");
    }
  }

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
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Get.offNamed("/addEvent");
                          // _formKey.currentState!.save();
                          // print('Form data saved');
                          getUser();
                        }
                      },
                      child: Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.

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
