// //write a splash screen to display white screen for 2 seconds and then check if user is logged in or not. If user is logged in then navigate to home screen else navigate to login screen.

// import 'package:assignmentecom/main.dart';
// import 'package:assignmentecom/ui/login.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     //initialise firebase

//     //check if user is logged in or not
//     _auth.authStateChanges().listen((User? user) {
//       if (user == null) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => LoginPage()),
//         );
//       } else {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const MyHomePage()),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
