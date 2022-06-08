import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'login_screen_widgets/behind_panel.dart';
import 'login_screen_widgets/collapsed_panel.dart';
import 'login_screen_widgets/panel_body.dart';

class LoginScreen extends StatefulWidget {
  //const HomeViewStateful({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late String username;
  late String password;

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panel: BodyInPanel(),
        backdropEnabled: true,
        collapsed: PanelBody(radius: radius),
        minHeight: MediaQuery.of(context).size.height * 0.08,
        body: BodyBehindPanel(),
        borderRadius: radius,
      ),
    );
  }
}
