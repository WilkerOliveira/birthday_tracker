import 'package:intl/intl.dart';

extension StringParsing on String {
  DateTime toDate() {
    return DateFormat('MM/dd/yyyy').parse(this);
  }
}
