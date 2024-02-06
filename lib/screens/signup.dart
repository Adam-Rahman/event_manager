import "package:flutter/material.dart";
import "package:get/get.dart";

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _loginState();
}

class _loginState extends State<signup> {
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
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      Get.offNamed("/addEvent");
                      _formKey.currentState!.save();
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
