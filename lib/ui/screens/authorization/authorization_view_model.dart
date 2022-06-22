import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../to_do_list/view/to_do_list_screen.dart';

Future<bool> readPin(
    {required BuildContext context,
    required FlutterSecureStorage storage,
    required TextEditingController textPin,
    required bool isAuthInProcess}) async {
  String? value = await storage.read(key: 'pin');
  if (value == textPin.text) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const ToDoListScreen();
    }));
  } else if (value == null) {
    isAuthInProcess = true;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Reg')));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Wrong Pin')));
  }
  return isAuthInProcess;
}

regPin(
    {required FlutterSecureStorage storage,
    required TextEditingController textPin,
    required bool isAuthInProcess,
    required BuildContext context}) async {
  storage.write(key: 'pin', value: textPin.text);
  isAuthInProcess = false;
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Registered')));
  isAuthInProcess = await readPin(
      context: context,
      storage: storage,
      textPin: textPin,
      isAuthInProcess: isAuthInProcess);
}
