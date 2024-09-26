import 'package:intl/intl.dart';

class AppFunction {
  static String formatRupiah({required double currency, String symbol = 'Rp'}) {
    var rupiahFormat = NumberFormat.currency(
        locale: 'id_ID', symbol: symbol, decimalDigits: 0);
    String formattedRupiah = rupiahFormat.format(currency);
    return formattedRupiah;
  }

  static double reverseRupiah(String formattedString) {
    final numericString = formattedString.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  static String parsePhoneNumber(String phoneString) {
    // Remove non-digit characters from the phone string
    String digitsOnly = phoneString.replaceAll(RegExp(r'\D'), '');

    // Replace '62' with '0'
    String modifiedNumber = digitsOnly.replaceFirst(RegExp(r'^62'), '0');

    return modifiedNumber;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }
}
