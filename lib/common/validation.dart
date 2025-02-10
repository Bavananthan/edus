class Validation {
  // validation for name
  String? validateName(String value, {String name = "* required"}) {
    if (value.trim().isEmpty) {
      return name;
    }
    return null;
  }
}
