// import 'package:assignmentecom/main.dart';
// import 'package:assignmentecom/ui/signup.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String? _email, _password;

//   // Function to handle login
//   Future<void> _login() async {
//     final formState = _formKey.currentState;
//     if (formState?.validate() ?? false) {
//       formState?.save();
//       try {
//         await _auth.signInWithEmailAndPassword(
//           email: _email!,
//           password: _password!,
//         );
//         // Navigate to another page after successful login
//         if (mounted) {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => const MyHomePage()),
//           );
//         }
//       } catch (e) {
//         print(e.toString());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
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
//                     if (input?.isEmpty ?? true) {
//                       return 'Enter your password';
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
//                   onPressed: _login,
//                   child: const Text('Login'),
//                 ),

//                 // Add a button to navigate to the registration page
//                 TextButton(
//                   onPressed: () {
//                     if (mounted) {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => SignUpPage()),
//                       );
//                     }
//                   },
//                   child: const Text('Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:assignmentecom/main.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Ecom, please sign in!')
                    : const Text('Welcome to Ecom, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                ),
              );
            },
          );
        }
        return const MyHomePage();
      },
    );
  }
}
