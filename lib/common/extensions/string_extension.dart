extension StringExtension on String{
  bool isEmail() {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (isEmpty) return false;
    return RegExp(regexEmail).hasMatch(this);
  }
}