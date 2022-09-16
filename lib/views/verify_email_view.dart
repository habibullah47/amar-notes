import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

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
        title: const Text('Email Verify'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
                'We\'ve sent you a verification Email, Please open it to verify your account.'),
            const Text(
                'If you haven\'t received a verification Email yet, press the button below. '),
            TextButton(
              onPressed: () async {
                final user = AuthService.firebase().SendEmailVerification();
              },
              child: const Text('Send email verification'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                await Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Restart '),
            ),
          ],
        ),
      ),
    );
  }
}
