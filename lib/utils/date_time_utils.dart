import 'package:intl/intl.dart';

String convertEpochToDDMMYYYYNHHMMAA(int millis) {
  return DateFormat("dd MMM, yyyy, h:mm a").format(DateTime.fromMillisecondsSinceEpoch(millis));
}
