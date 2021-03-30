import 'package:intl/intl.dart';

extension DaateParsing on DateTime {
  String dateToString() {
    return DateFormat('MM/dd/yyyy').format(this);
  }
}
