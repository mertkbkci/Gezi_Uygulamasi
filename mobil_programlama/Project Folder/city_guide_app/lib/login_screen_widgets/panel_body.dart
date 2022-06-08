import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oktoast/oktoast.dart';

class BodyInPanel extends StatefulWidget {
  BodyInPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyInPanel> createState() => _BodyInPanelState();
}

class _BodyInPanelState extends State<BodyInPanel> {
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();

  Future<void> initSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> saveUserInfo(String username, String password) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(username, password);
    //Toast.show("Signed Up! You can login now.", duration: Toast.lengthShort, gravity: Toast.bottom);
    showToast('Signed Up! You can login now.', position: ToastPosition.bottom, backgroundColor: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    //ToastContext().init(context);

    return Column(children: [
      Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03)),
      Text(
        "Sign Up for İzmir Tour Guide",
        style: TextStyle(fontSize: 25),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: myUsernameController,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: myPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 40,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            saveUserInfo(myUsernameController.text, myPasswordController.text);
          },
          child: Text('Sign Up'),
        ),
      )
    ]);
  }
}
