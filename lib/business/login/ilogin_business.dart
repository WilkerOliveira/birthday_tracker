import 'package:birthday_tracker/repository/login/ilogin_repository.dart';

abstract class ILoginBusiness {
  final ILoginRepository loginRepository;
  ILoginBusiness(this.loginRepository);

  Future<bool> signInAnonymously();
}
