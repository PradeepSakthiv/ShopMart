
import 'dart:convert';
import 'package:logger/logger.dart';

class LoggerFile {

  void logDisplay(String response){
    var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount: 8, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: false, // Colorful log messages
          printEmojis: false, // Print an emoji for each log message
          printTime: false,
          noBoxingByDefault:
          false // Should each log print contain a timestamp
      ),
    );
    logger.v(response+"\n"+dataBeautifier(response));
  }

  String dataBeautifier(String response) {
    final object = json.decode(response);
    final prettyString = JsonEncoder.withIndent('  ').convert(object);
    return prettyString;
  }
}
