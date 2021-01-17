// matching various patterns for kinds of data

class ValidatorUtil {
  // AppLocalizations_Labels labels;
  ValidatorUtil(/*this.labels*/);
  String email(String value) {
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    final RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.email";
    } else {
      return null;
    }
  }

  String password(String value) {
    const Pattern pattern = r'^.{6,}$';
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.password";
    } else {
      return null;
    }
  }

  String name(String value) {
    const Pattern pattern = r"^[A-Z İĞÜŞÖÇ]+$"; //r"^[a-zA-ZğüşöçıİĞÜŞÖÇ]+$";
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.name";
    } else {
      return null;
    }
  }

  String number(String value) {
    const Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.number";
    } else {
      return null;
    }
  }

  String numeric(String value) {
    const Pattern pattern = r'^[0-9]';
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.number";
    } else {
      return null;
    }
  }

  String phone(String value) {
    // const Pattern pattern = r'^(?:[+0]9)?[0-9]{7,12}$';
    const Pattern pattern = r'^[0-9]{7,12}$';
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.phone";
    } else {
      return null;
    }
  }

  String amount(String value) {
    const Pattern pattern = r'^\d+$';
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.amount";
    } else if (int.parse(value.trim()) <= 0) {
      return " labels.validator.greaterThanZero";
    } else if (value.length >= 18) {
      return "labels.validator.tooLongNumber";
    } else {
      return null;
    }
  }

  String notEmpty(String value) {
    const Pattern pattern = r'^\S+$';
    final RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "labels.validator.notEmpty";
    } else {
      return null;
    }
  }

  String requiredField(String value) {
    if (value == null || value.isEmpty) {
      return "labels.validator.notEmpty";
    } else {
      return null;
    }
  }
}
