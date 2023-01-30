import 'package:intl/intl.dart';

class ToolFunction {

  String getCustomFormattedDateTime(int givenDateTime, String dateFormat) {
      final DateTime docDateTime = DateTime.fromMillisecondsSinceEpoch(givenDateTime * 1000);
      return DateFormat(dateFormat).format(docDateTime);
  }

  DateTime addDays(int givenDateTime, int daysToAdd){
    final DateTime docDateTime = DateTime.fromMillisecondsSinceEpoch(givenDateTime * 1000);
    return docDateTime.add(Duration(days: daysToAdd));
  }

  DateTime unixToDateTime(int givenDateTime) => DateTime.fromMillisecondsSinceEpoch(givenDateTime * 1000);
}

ToolFunction toolFunction = ToolFunction();
