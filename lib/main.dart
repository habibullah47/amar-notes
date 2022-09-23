import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

import 'views/notes/new_note_view.dart'; //dekhi pore jamelai pori kina

// import 'dart:developer' as devtools
//     show log; //'as' is use for easy recogonise of import
//'show' is use for specific  item from import stuff.

void main() async {
  WidgetsFlutterBinding.ensureInitialized; //I don't understand it clearly
  //await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: const HomePage(),
      routes: {
        notesRoute: (context) => const NotesView(),
        registerRoute: (context) => const RegisterView(),
        loginRoute: (context) => const LoginView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newNoteRoute: (context) => const NewNoteView(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase()
          .initialize(), // I need to understand this line fuction. It's new for me.
      //So, It come from our Auth Service;
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser; //focus in here.
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
