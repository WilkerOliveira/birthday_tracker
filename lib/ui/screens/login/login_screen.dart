import 'package:birthday_tracker/controllers/login/login_controller.dart';
import 'package:birthday_tracker/ui/resources/AppDimen.dart';
import 'package:birthday_tracker/ui/resources/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ModularState<LoginScreen, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: AppDimen.logoMarginTop,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.logo,
                width: AppDimen.logoLoginWidth,
                height: AppDimen.logoLoginHeight,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Birthday Tracker",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                width: AppDimen.loginButtonWidth,
                height: AppDimen.loginButtonHeight),
            child: ElevatedButton.icon(
                icon: Icon(Icons.lock_open),
                onPressed: () => controller.signInAnonymously(),
                label: Text(
                  "Log in",
                  style: TextStyle(fontSize: AppDimen.loginLabelFontSize),
                )),
          )
        ],
      ),
    );
  }
}
