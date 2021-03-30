import 'package:birthday_tracker/business/home/ihome_business.dart';
import 'package:birthday_tracker/controllers/base/base_controller.dart';
import 'package:birthday_tracker/extensions/datetime_extensions.dart';
import 'package:birthday_tracker/extensions/string_extensions.dart';
import 'package:birthday_tracker/models/birthday.dart';
import 'package:birthday_tracker/ui/utils/ScreenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBaseController with _$HomeController;

abstract class _HomeBaseController extends BaseController with Store {
  MaskedTextController txtBirthday;
  String birthday;
  final formKey = GlobalKey<FormState>();
  Birthday _currentBirthday;

  @observable
  ObservableList<Birthday> birthdayList = ObservableList.of([]);

  final IHomeBusiness _homeBusiness;
  _HomeBaseController(this._homeBusiness) {
    txtBirthday = ScreenUtils.dateMaskedTextController();
    _homeBusiness.listening(listening);
    _homeBusiness.checkCalendarPermission();
  }

  @action
  Future<void> save() async {
    setState(ViewState.Busy);

    super.error = false;
    super.errorMessage = null;

    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      formKey.currentState.save();

      if (_currentBirthday == null) _currentBirthday = Birthday();

      _currentBirthday.birthday = this.birthday.toDate();

      var result = await _homeBusiness.saveBirthday(_currentBirthday);

      if (result.isNotEmpty)
        showToast(result);
      else
        showToast("Birthday successfully saved!");

      _currentBirthday = null;

      this.txtBirthday.updateText("");
    } catch (ex) {
      super.error = true;
      showToast("Oops, something went wrong!");
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<void> logout() async {
    await _homeBusiness.logout();
    Modular.to.navigate('/');
  }

  @action
  Future<void> getBirthdays() async {
    setState(ViewState.Busy);

    try {
      var response = await _homeBusiness.loadAll();

      if (response != null) this.birthdayList = response.asObservable();
    } catch (ex) {
      super.error = true;
      showToast("Oops, something went wrong!");
    } finally {
      setState(ViewState.Idle);
    }
  }

  void listening() {
    getBirthdays();
  }

  void loadData(Birthday item) {
    this._currentBirthday = item;
    this.txtBirthday.updateText(item.birthday.dateToString());
  }

  void delete(Birthday item) async {
    setState(ViewState.Busy);

    try {
      await _homeBusiness.delete(item);
    } catch (ex) {
      super.error = true;
      showToast("Oops, something went wrong!");
    } finally {
      setState(ViewState.Idle);
    }
  }
}
