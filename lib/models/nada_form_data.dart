class NadaFormData {
  String? nadaId;
  String? nadaFirstName;
  String? nadaEmail;
  String? nadaPhoneNumber;
  bool nadaAcceptTerms = false;

  NadaFormData({
    this.nadaId,
    this.nadaFirstName,
    this.nadaEmail,
    this.nadaPhoneNumber,
    this.nadaAcceptTerms = false,
  });

  bool isValid() {
    return nadaId != null &&
        nadaFirstName != null &&
        nadaEmail != null &&
        nadaPhoneNumber != null &&
        nadaAcceptTerms;
  }
} 