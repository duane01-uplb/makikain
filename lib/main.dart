import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:makikain/firebase_options.dart'; 
import 'package:makikain/screens/auth/login_screen.dart';
// import 'package:makikain/screens/home_screen.dart';  

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ElbiFoodShareApp());
}

class ElbiFoodShareApp extends StatelessWidget {
  const ElbiFoodShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbi Food Share',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

/// Listens to the Firebase auth stream and routes accordingly.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Still waiting for the first auth event
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // if (snapshot.hasData) {
        //   return ;
        // }

        // Not signed in, show login
        return const LoginScreen();
      },
    );
  }
}