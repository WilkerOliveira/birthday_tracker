import 'package:birthday_tracker/models/birthday.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

class CalendarNotification {
  final CalendarPlugin _calendarPlugin = CalendarPlugin();
  Calendar _calendar;

  Future<void> setAgendaNotification(
      DateTime startDate, DateTime endDate, Birthday birthday) async {
    _calendarPlugin.hasPermissions().then((value) async {
      if (!value) {
        _calendarPlugin.requestPermissions();
      } else {
        var calendars = await _calendarPlugin.getCalendars();
        if (calendars != null && calendars.length > 0) {
          CalendarEvent _newEvent = CalendarEvent(
              title:
                  "Next Birthday: ${birthday.birthday.month}/${birthday.birthday.day}",
              description: "Birthday",
              startDate: startDate,
              endDate: endDate,
              isAllDay: true,
              hasAlarm: true);

          String eventId = await _calendarPlugin.createEvent(
              calendarId: calendars[0].id, event: _newEvent);

          _calendarPlugin.addReminder(
              calendarId: birthday.currentDate.millisecond.toString(),
              eventId: eventId,
              minutes: 5);
        }
      }
    });
  }

  void checkPermissions() {
    _calendarPlugin.hasPermissions().then((value) {
      if (!value) {
        _calendarPlugin.requestPermissions();
      }
    });
  }
}
