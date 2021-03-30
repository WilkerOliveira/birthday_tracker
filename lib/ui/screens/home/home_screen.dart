import 'package:birthday_tracker/controllers/base/base_controller.dart';
import 'package:birthday_tracker/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'birthday_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ModularState<HomeScreen, HomeController> {
  @override
  void initState() {
    super.initState();

    //Load only when build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBirthdays();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Birthday Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () => controller.logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          _form(),
          SizedBox(
            height: 30,
          ),
          _birthdayList()
        ],
      ),
    );
  }

  Widget _form() {
    final txtBirthday = TextFormField(
      controller: controller.txtBirthday,
      keyboardType: TextInputType.emailAddress,
      maxLength: 10,
      obscureText: false,
      onSaved: (String value) {
        controller.birthday = value.trim();
      },
      textInputAction: TextInputAction.next,
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Birthday Date (MM/dd/yyyy)",
                      ),
                    ),
                  ),
                  txtBirthday,
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Observer(
            builder: (_) {
              return Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: controller.viewState == ViewState.Busy
                    ? SpinKitThreeBounce(
                        color: Colors.blue,
                        size: 20,
                      )
                    : ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 200, height: 50),
                        child: ElevatedButton.icon(
                            icon: Icon(Icons.save),
                            onPressed: () => controller.save(),
                            label: Text(
                              "SAVE",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _birthdayList() {
    return Observer(
      builder: (BuildContext context) {
        return BirthdayListWidget(
          items: controller.birthdayList,
          onEditPressed: controller.loadData,
          onDeletedPressed: controller.delete,
        );
      },
    );
  }
}
