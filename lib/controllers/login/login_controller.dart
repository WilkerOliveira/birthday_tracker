import 'package:birthday_tracker/business/login/ilogin_business.dart';
import 'package:birthday_tracker/controllers/base/base_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginBaseController with _$LoginController;

abstract class _LoginBaseController extends BaseController with Store {
  final String _loginError = "Oops, something went wrong with the login!";
  ILoginBusiness _loginBusiness;
  _LoginBaseController(this._loginBusiness);

  Future<void> signInAnonymously() async {
    setState(ViewState.Busy);

    super.error = false;
    super.errorMessage = null;

    try {
      if (await this._loginBusiness.signInAnonymously()) {
        Modular.to.navigate('/home');
      } else {
        super.error = true;
        showToast(_loginError);
      }
    } catch (ex) {
      super.error = true;
      showToast(_loginError);
    } finally {
      setState(ViewState.Idle);
    }
  }
}
