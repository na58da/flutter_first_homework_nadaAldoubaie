import 'package:get/get.dart';

class NadaFormValidators {
  static String? nadaValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_email_required'.tr;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'enter_valid_email'.tr;
    }
    return null;
  }

  static String? nadaValidateTextOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_text_required'.tr;
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'enter_letters_only'.tr;
    }
    return null;
  }

  static String? nadaValidatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_phone_required'.tr;
    }
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'enter_valid_phone'.tr;
    }
    return null;
  }

  static String? nadaValidateNumberOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_number_required'.tr;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'enter_numbers_only'.tr;
    }
    return null;
  }
}
