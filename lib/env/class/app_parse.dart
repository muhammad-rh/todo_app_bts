part of '../class/app_env.dart';

class AppParse {
  static String formatDate(DateTime time,
      {required String Function(AppDateModel value) format}) {
    return format(AppDateModel.fromDate(time));
  }

  static String formattedDate({required String date}) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(date));
  }

  static String formatVaNumber(String input) {
    List<String> chunks = [];
    int length = input.length;
    int index = 0;
    while (index < length) {
      int end = index + 4;
      if (end > length) {
        end = length;
      }
      chunks.add(input.substring(index, end));
      index = end;
    }
    return chunks.join(' ');
  }
}
