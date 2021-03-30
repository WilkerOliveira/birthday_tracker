import 'package:birthday_tracker/models/birthday.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IHomeRepository {
  Future<void> insertBirthday(Birthday data);
  Future<void> updateBirthday(Birthday data);
  Future<QuerySnapshot> loadAll();
  Future<void> listening(Function toCall);
  Future<void> logout();
  Future<void> delete(Birthday birthday);
}
