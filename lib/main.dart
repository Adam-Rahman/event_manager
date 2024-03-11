import "package:event_manager/screens/addEvent.dart";
import "package:event_manager/screens/signup.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:get/get.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:event_manager/screens/login.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB6zxaNYTjrXPokK1HSPB32yircEiVXadY",
          appId: "1:785070045488:android:8850483c1a2b825addb0f5",
          messagingSenderId: "785070045488",
          projectId: "event-management-405a3"));
  runApp(myApp());
}

class myApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/addEvent", page: () => addEvent()),
        GetPage(name: "/signup", page: () => signup()),
        GetPage(
          name: "/login",
          page: () => login(),
        )
      ],
      theme: ThemeData(scaffoldBackgroundColor: Colors.amber),
      //if user is already signed in then take them to add event page
      // else take them to login page
      home: FirebaseAuth.instance.currentUser == null ? login() : addEvent(),
    );
  }
}
