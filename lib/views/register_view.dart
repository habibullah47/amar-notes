import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

import '../firebase_options.dart';
import '../utilities/show_error_dialog.dart';

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
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
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
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emal,
                            password: password,
                          );
                          final user = FirebaseAuth.instance.currentUser;
                          await user?.sendEmailVerification();

                          await Navigator.of(context)
                              .pushNamed(verifyEmailRoute);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            await showErrorDialog(
                              context,
                              'Weak Password',
                            );
                          } else if (e.code == 'email-already-in-use') {
                            await showErrorDialog(
                              context,
                              'Email is already in use',
                            );
                          } else if (e.code == 'invalid-email') {
                            await showErrorDialog(
                              context,
                              'Invalid email',
                            );
                          } else if (e.code == e.code) {
                            await showErrorDialog(
                              context,
                              'Error ${e.code} ',
                            );
                          } else {
                            await showErrorDialog(
                              context,
                              e.credential.toString(),
                            );
                          }
                        } catch (e) {
                          await showErrorDialog(
                            context,
                            e.toString(), //this for error catch up when unathorised error occuring
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
