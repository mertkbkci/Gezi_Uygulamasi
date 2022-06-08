import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Material App',
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: LoginScreen(),
      ),
    );
  }
}
