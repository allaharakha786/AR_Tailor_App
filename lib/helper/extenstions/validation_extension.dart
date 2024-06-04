extension ValidationExtentions on String {
  bool fieldValidation() {
    return this.isEmpty;
  }

  bool passwordValidation() {
    return this.length < 8;
  }

  bool phoneValidation() {
    return this.length < 10;
  }

  bool numericValidation() {
    final numRegEcp = RegExp(r'^[0-9]+$');
    return !numRegEcp.hasMatch(this);
  }

  bool emailValidation() {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    return !emailRegExp.hasMatch(this);
  }
}
