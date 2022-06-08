import 'package:city_guide_app/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oktoast/oktoast.dart';

class BodyBehindPanel extends StatefulWidget {
  BodyBehindPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyBehindPanel> createState() => _BodyBehindPanelState();
}

class _BodyBehindPanelState extends State<BodyBehindPanel> {
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> getUserInfo(String username, String password) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? pass = sharedPreferences.getString(username);
    // if pass is null, username did not sign up
    if (pass == null) {
      //Toast.show("Such username does not exist, try signing up.", duration: Toast.lengthShort, gravity: Toast.bottom);
      showToast('Such username does not exist, try signing up.', position: ToastPosition.bottom, backgroundColor: Colors.red);
    }
    // if pass is different than password, wrong password has been entered
    else if (pass != password) {
      //Toast.show("Your password is wrong, try again.", duration: Toast.lengthShort, gravity: Toast.bottom);
      showToast('Your password is wrong, try again.', position: ToastPosition.bottom, backgroundColor: Colors.red);
    } else {
      // successful login
      //Toast.show("Login successful.", duration: Toast.lengthShort, gravity: Toast.bottom);
      showToast('Login successful.', position: ToastPosition.bottom, backgroundColor: Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => new CategoriesScreen(username: username)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //ToastContext().init(context);

    return Center(
      child: Column(children: [
        Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20)),
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
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              getUserInfo(myUsernameController.text, myPasswordController.text);
            },
            child: Text('Login'),
          ),
        )
      ]),
    );
  }
}
