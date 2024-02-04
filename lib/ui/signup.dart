// import 'package:assignmentecom/main.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String? _email, _password;

//   // Function to handle sign up
//   Future<void> _signUp() async {
//     final formState = _formKey.currentState;
//     if (formState?.validate() ?? false) {
//       formState?.save();
//       _auth
//           .createUserWithEmailAndPassword(
//         email: _email!,
//         password: _password!,
//       )
//           .then((_) {
//         // Navigate to another page after successful sign up
//         if (mounted) {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => MyHomePage()),
//           );
//         }
//       }).catchError((error) {
//         print(error.toString());
//         // Handle error scenario here
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextFormField(
//                   validator: (input) {
//                     if (input?.isEmpty ?? true) {
//                       return 'Enter your email';
//                     }
//                     return null;
//                   },
//                   onSaved: (input) => _email = input?.trim(),
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                   ),
//                 ),
//                 TextFormField(
//                   validator: (input) {
//                     if ((input?.length ?? 0) < 6) {
//                       return 'Provide minimum 6 characters';
//                     }
//                     return null;
//                   },
//                   onSaved: (input) => _password = input,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                   ),
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: _signUp,
//                   child: const Text('Sign Up'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
