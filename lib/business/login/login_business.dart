import 'package:birthday_tracker/business/login/ilogin_business.dart';
import 'package:birthday_tracker/repository/login/ilogin_repository.dart';

class LoginBusiness extends ILoginBusiness {
  LoginBusiness(ILoginRepository loginRepository) : super(loginRepository);

  @override
  Future<bool> signInAnonymously() async {
    var userData = await loginRepository.signInAnonymously();
    return userData != null;
  }
}
