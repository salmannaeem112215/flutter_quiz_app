import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFE5EAEE);
const kPrimaryColor = Color(0xFF6493B8);
const kDarkPrimaryColor = Color(0xFF2D465A);
const kGreyTextColor = Color(0xFFCBCBCB);
const kSideBarDividerColor = Color.fromARGB(127, 45, 70, 90);

//Form Key
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter your Valid Email";

const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";

const String kMatchingPassError = "Passwords don't match";
const String kPhoneNumberNullError = "Please Enter your number";
const String kAddressNullError = "Please Enter your address";
const String kOTPNullError = "Please Enter OTP code";
const String kMatchingOTPError = "OTP code don't match";

final RegExp nameValidatorRegExp = RegExp(r"^[a-zA-z]+");
const String kInvalidNameError = "Invalid Name ";
const String kFirstNameNullError = "Please Enter your First name";
const String kLastNameNullError = "Please Enter your Last name";

final RegExp rollnoValidatorRegExp = RegExp(r"^[0-9]+[a-z]+[0-9]");
const String kRollnoNullErrpr = "Please Enter your Roll No : 2000se1";
const String kInvalidRollnoError = "Invalid Form : 2000se1";

const String kSelectRouteMessage = 'Plesse select route';

// Firebase Exception
const String kfeInvalidPasswordError =
    "The password is invalid or the user does not have a password.";

const String kfeNotRegisterEmail =
    "There is no user record corresponding to this identifier. The user may have been deleted.";
