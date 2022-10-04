import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Center(child: Text('Register'))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: AuthService.firebase().initialize(), //focus on changed
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        final emal = _email.text;
                        final password = _password.text;

                        try {
                          await AuthService.firebase().createUser(
                            emal: emal,
                            password: password,
                          ); //focus on changed
                          await AuthService.firebase().SendEmailVerification();
                          await Navigator.of(context)
                              .pushNamed(verifyEmailRoute);
                        } on WeakPasswordAuthException {
                          await showErrorDialog(
                            context,
                            'Weak Password',
                          );
                        } on EmailAlreadyInUseAuthException {
                          await showErrorDialog(
                            context,
                            'Email is already in use',
                          );
                        } on InvalidEmailAuthException {
                          await showErrorDialog(
                            context,
                            'Invalid email',
                          );
                        } on GenericAuthException {
                          await showErrorDialog(
                            context,
                            'Failed to register', //this is for error catch up when unathorised error occuring
                          );
                        }
                      },
                      child: const Text('Registration'),
                    ),
                    TextButton(
                      onPressed: (() => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              loginRoute, (route) => false)),
                      child: const Text('Already have a account? Login here!'),
                    ),
                  ],
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
