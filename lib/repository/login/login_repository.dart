import 'package:birthday_tracker/repository/login/ilogin_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository implements ILoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }
}
