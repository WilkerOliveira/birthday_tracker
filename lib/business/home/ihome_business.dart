import 'package:birthday_tracker/models/birthday.dart';
import 'package:birthday_tracker/repository/home/ihome_repository.dart';

abstract class IHomeBusiness {
  IHomeRepository homeRepository;
  IHomeBusiness(this.homeRepository);

  Future<String> saveBirthday(Birthday birthday);
  Future<List<Birthday>> loadAll();
  Future<void> listening(Function toCall);
  Future<void> logout();
  Future<void> delete(Birthday birthday);
  void checkCalendarPermission();
}
