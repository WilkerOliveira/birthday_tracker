import 'package:birthday_tracker/business/home/ihome_business.dart';
import 'package:birthday_tracker/models/birthday.dart';
import 'package:birthday_tracker/repository/home/ihome_repository.dart';
import 'package:birthday_tracker/service/notifications/CalendarNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeBusiness extends IHomeBusiness {
  CalendarNotification _calendarNotification;
  HomeBusiness(IHomeRepository homeRepository, this._calendarNotification)
      : super(homeRepository);

  @override
  Future<String> saveBirthday(Birthday birthday) async {
    if (birthday.birthday == null)
      return Future.value("Birthday date cannot be empty!");

    if (birthday.currentDate == null) {
      birthday.currentDate = DateTime.now();
      await homeRepository.insertBirthday(birthday);
    } else {
      await homeRepository.updateBirthday(birthday);
    }

    return Future.value("");
  }

  void checkCalendarPermission() =>
      this._calendarNotification.checkPermissions();

  Future<void> _setCalendar(Birthday birthday) async {
    DateTime now = DateTime.now();
    int year = now.year;
    int day = birthday.birthday.subtract(Duration(days: 1)).day;
    if (birthday.birthday.month < now.month ||
        (now.month == birthday.birthday.month &&
            birthday.birthday.day < now.day)) {
      year += 1;
    }

    await this._calendarNotification.setAgendaNotification(
        DateTime(year, birthday.birthday.month, day, 8, 0, 0),
        birthday.birthday,
        birthday);
  }

  @override
  Future<List<Birthday>> loadAll() async {
    QuerySnapshot response = await homeRepository.loadAll();
    List<Birthday> birthdays = [];

    if (response != null) {
      for (QueryDocumentSnapshot document in response.docs) {
        birthdays.add(Birthday.fromJson(document.data()));
      }

      birthdays
          .sort((a, b) => isBefore(a.birthday, b.birthday, DateTime.now()));
    }

    return birthdays;
  }

  int isBefore(DateTime firstDate, DateTime secondDate, DateTime targetDate) {
    var firstNewDate =
        DateTime(targetDate.year, firstDate.month, firstDate.day);
    var secondNewDate =
        DateTime(targetDate.year, secondDate.month, secondDate.day);

    var diffFirstDate = firstNewDate.difference(targetDate).inMilliseconds;
    var diffSecondDate = secondNewDate.difference(targetDate).inMilliseconds;

    if (diffFirstDate >= 0 && diffSecondDate >= 0 ||
        diffFirstDate < 0 && diffSecondDate < 0)
      return diffFirstDate.compareTo(diffSecondDate);
    else if (diffFirstDate < 0 && diffSecondDate >= 0)
      return 1;
    else
      return 0;
  }

  @override
  Future<void> listening(Function toCall) async {
    await homeRepository.listening(toCall);
  }

  @override
  Future<void> delete(Birthday birthday) {
    return homeRepository.delete(birthday);
  }

  @override
  Future<void> logout() async {
    await homeRepository.logout();
  }
}
