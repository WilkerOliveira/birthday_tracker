import 'package:birthday_tracker/ui/resources/AppColors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

part "base_controller.g.dart";

/// Represents the state of the view
enum ViewState { Idle, Busy }

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  @observable
  ViewState _state = ViewState.Idle;

  ViewState get viewState => this._state;

  @protected
  bool error;
  @protected
  bool alert;

  String errorMessage;

  bool isEditing = false;

  bool get isError => error;

  bool get isAlert => alert;

  @action
  void setState(ViewState viewState) {
    _state = viewState;
  }

  void logError(ex) {
    print(ex.toString());
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.alertButtonColor,
      textColor: Colors.black,
      fontSize: 16,
    );
  }
}
