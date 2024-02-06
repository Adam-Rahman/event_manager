import "package:event_manager/screens/addEvent.dart";
import "package:event_manager/screens/signup.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:event_manager/screens/login.dart";

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(getPages: [
      GetPage(name: "/addEvent", page: () => addEvent()),
      GetPage(name: "/signup", page: () => signup())
    ], theme: ThemeData(scaffoldBackgroundColor: Colors.amber), home: login());
  }
}
