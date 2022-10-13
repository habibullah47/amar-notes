import 'package:flutter/material.dart';
import 'package:mynotes/constants/buildcontext/loc.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.logout_button,
    content: context.loc.logout_dialog_prompt,
    optionsBuilder: () => {
      context.loc.cancel: false,
      context.loc.logout_button: true,
    },
  ).then(
    (value) =>
        value ??
        false, //I think if I keep [?] on <bool> of showLogOutDialog, may doesn't need this line of code anymore
  );
}
