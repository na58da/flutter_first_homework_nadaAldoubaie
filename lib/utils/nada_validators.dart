class NadaFormValidators {
  static String? nadaValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? nadaValidateTextOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Please enter only letters';
    }
    return null;
  }

  static String? nadaValidatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? nadaValidateNumberOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter only numbers';
    }
    return null;
  }
} 
