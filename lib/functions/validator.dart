import '../constants.dart';

class Validator {
  // To use email you have to use it like this in TextFormField
  // validator: Validator.email,
  static String? email(String? value) {
    if (value!.isEmpty) {
      return kEmailNullError;
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      return kInvalidEmailError;
    }
    return null;
  }

  // To use Password you have to use it like this in TextFormField
  // validator: Validator.password,
  static String? password(String? value) {
    if (value!.isEmpty) {
      return kPassNullError;
    } else if (value.length < 8) {
      return kShortPassError;
    }
    return null;
  }

  // To user Confirm Password you have to use it like this in TextFormField
  //  validator: (val) {
  //               return Validator.confirmPassword(
  //                 val,
  //                 passwordTextController.text,
  //               );
  //             },

  static String? confirmPassword(String? val1, String val2) {
    if (val1 != val2) {
      return kMatchingPassError;
    }
    return null;
  }

  static String? rollno(String? value) {
    value = value!.trim();
    if (value.isEmpty) {
      return kRollnoNullErrpr;
    } else if (!rollnoValidatorRegExp.hasMatch(value)) {
      return kInvalidRollnoError;
    }
    return null;
  }

  static String? firstName(String? value) {
    value = value!.trim();
    if (value.isEmpty) {
      return kFirstNameNullError;
    } else if (!nameValidatorRegExp.hasMatch(value)) {
      return kInvalidNameError;
    }
    return null;
  }

  static String? lastName(String? value) {
    value = value!.trim();
    if (value.isEmpty) {
      return kLastNameNullError;
    } else if (!nameValidatorRegExp.hasMatch(value)) {
      return kInvalidNameError;
    }
    return null;
  }
}
