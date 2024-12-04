class NadaFormValidators {
  static String? nadaValidateField(String? value, String fieldName, {bool isEmail = false}) {
    if (value == null || value.isEmpty) {
      return fieldName.contains('ال') 
          ? 'يرجى إدخال $fieldName' 
          : 'Please enter your $fieldName';
    }
    if (isEmail && !value.contains('@')) {
      return fieldName.contains('ال')
          ? 'يرجى إدخال بريد إلكتروني صحيح'
          : 'Please enter a valid email address';
    }
    return null;
  }
} 