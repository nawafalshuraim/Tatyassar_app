import 'package:intl/intl.dart';

class CFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); // Customize the date format as needed
  }

  static String formatCurrency(double amount) {
  return NumberFormat.currency(locale: 'ar_SA', symbol: 'SAR').format(amount);
  }


  static String formatPhoneNumber(String phoneNumber) {
   // Remove any non-digit characters
   phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

   // Handle international formats starting with +966 or 00966
   if (phoneNumber.startsWith('00966')) {
     phoneNumber = '0' + phoneNumber.substring(5);
   } else if (phoneNumber.startsWith('966')) {
     phoneNumber = '0' + phoneNumber.substring(3);
  }

   // Format local Saudi number: 05X XXX XXXX
   if (phoneNumber.length == 10 && phoneNumber.startsWith('05')) {
     return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
   }

   // Fallback: return as-is if it doesn't match known formats
   return phoneNumber;
  }
}


