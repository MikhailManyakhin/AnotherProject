import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import 'package:vedita_learning_project/ui/screens/to_do_list/view/to_do_list_screen.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  bool isAuthInProcess = false;
  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    TextEditingController textPin = TextEditingController();
    storage.deleteAll();

    readPin() async {
      String? value = await storage.read(key: 'pin');
      if (value == textPin.text) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const ToDoListScreen();
        }));
      } else if (value == null) {
        setState(() {
          isAuthInProcess = true;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Reg')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong Pin')));
      }
    }

    regPin() {
      storage.write(key: 'pin', value: textPin.text);
      setState(() {
        isAuthInProcess = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registered')));
      readPin();
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: isAuthInProcess? (0.2 * height) : (0.4 * height),
                left: 0.3 * width, right: 0.3*width),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: textPin,
              decoration: InputDecoration(
                  hintText: isAuthInProcess ? 'reg new pin' : 'pin'),
            ),
          ),
          // TextFormField(decoration: const InputDecoration(
          //   hintText: 'password'
          // ),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(75)),
                  gradient: AppColors.gradient,
                ),
                child: MaterialButton(
                    onPressed: () {
                      readPin();
                    },
                    child: const Text("Auth"))),
          ),
          isAuthInProcess
              ? DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75)),
                    gradient: AppColors.gradient,
                  ),
                  child: MaterialButton(
                      onPressed: () {
                        regPin();
                      },
                      child: const Text("Reg")),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
