import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';

enum MenuAction { logout }

class LogOutView extends StatefulWidget {
  const LogOutView({Key? key}) : super(key: key);

  @override
  State<LogOutView> createState() => _LogOutViewState();
}

class _LogOutViewState extends State<LogOutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Precius Notes"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
                  devtools.log(shouldLogOut.toString());

                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Log Out'),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(' Signout'),
        content: const Text('Are You Sure You want to Sign-out?'),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cencel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
