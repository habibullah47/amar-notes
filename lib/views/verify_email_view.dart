import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verify'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text('Please Verify your email address'),
            TextButton(
              onPressed: () async {
                try {
                  sendEmailVerification();
                } on FirebaseAuthException catch (e) {
                  print(e);
                  print(e.runtimeType);
                  print(e.code.characters);
                  print(e.code.isEmpty);
                  print(e.code.isNotEmpty);
                  print(e.code.codeUnits);
                }
              },
              child: const Text('Verify E-mail'),
            ),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.delete();
              },
              child: const Text('Delete Your account'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/login/');
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

Future sendEmailVerification() async {
  try {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  } catch (e) {
    print(e);
  }
}
