extension ExtString on String {
  bool get isEmailValid {
    final emailRegEx = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegEx.hasMatch(this);
  }
}

extension FarsiNumber on String {
  String get farsiNumber {
    const eng = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    const farsi = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"];
    String text = this;

    for (int i = 0; i < eng.length; i++) {
      text = text.replaceAll(eng[i], farsi[i]);
    }
    return text;
  }
}
