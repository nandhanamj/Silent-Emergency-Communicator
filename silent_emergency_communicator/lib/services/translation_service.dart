class TranslationService {
  static String medical(
    String language,
  ) {
    switch (language) {
      case "Malayalam":
        return "മെഡിക്കൽ അടിയന്തരാവസ്ഥ";

      case "Hindi":
        return "चिकित्सा आपातकाल";

      case "Tamil":
        return "மருத்துவ அவசரம்";

      default:
        return "MEDICAL EMERGENCY";
    }
  }
}