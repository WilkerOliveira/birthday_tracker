import 'package:birthday_tracker/models/birthday.dart';
import 'package:birthday_tracker/repository/home/ihome_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepository extends IHomeRepository {
  final _birthdaysDb = "birthdays_v2";

  @override
  Future<void> insertBirthday(Birthday data) {
    return FirebaseFirestore.instance
        .collection(_birthdaysDb)
        .doc(data.currentDate.millisecond.toString())
        .set(data.toJson());
  }

  @override
  Future<void> updateBirthday(Birthday data) {
    return FirebaseFirestore.instance
        .collection(_birthdaysDb)
        .doc(data.currentDate.millisecond.toString())
        .update(data.toJson());
  }

  @override
  Future<QuerySnapshot> loadAll() {
    return FirebaseFirestore.instance.collection(_birthdaysDb).get();
  }

  @override
  Future<void> listening(Function toCall) async {
    FirebaseFirestore.instance
        .collection(_birthdaysDb)
        .snapshots()
        .listen((event) {
      toCall();
    });
  }

  @override
  Future<void> delete(Birthday birthday) {
    return FirebaseFirestore.instance
        .collection(_birthdaysDb)
        .doc(birthday.currentDate.millisecond.toString())
        .delete();
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
