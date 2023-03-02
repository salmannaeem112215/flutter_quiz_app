// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import '../firebase_ref/references.dart';
import '../functions/snack_bar_custom.dart';
import '../screens/home/home_screen.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  RxBool isLoggedIn = false.obs;
  // RxBool isLoggedIn = true.obs;
  FirebaseAuth? _auth;
  final _user =
      Rxn<User>(); //when getx is used put the User(from firebase) to Rxn
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    print('debug: init Auth');
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance; // single tone
    _authStateChanges =
        _auth!.authStateChanges(); // to check user changed or not
    _authStateChanges.listen(((User? user) {
      _user.value = user;
    }));

    navigateToIntroduction();
    // navigateToHome();
  }

  void navigateToIntroduction() {
    Get.offAllNamed('/intro');
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  User? getUser() {
    _user.value = _auth!.currentUser;
    return _user.value;
  }


  saveUser(UserCredential userCr, String username) {
    User user = userCr.user!;
    userRf.doc(user.email).set({
      //set in firebase takes a map
      "email": user.email,
      "username": username,
    });
  }

  Future<void> signOut() async {
    await _auth!.signOut();
    isLoggedIn.value = false;
    
  }

  // Sign Up Method or Register Methods
  void signUserUp({
    required BuildContext ctx,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    required TextEditingController? userTextController,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        final userCredentials = await _auth!.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
        );
        // Account Created code do to after account created
        saveUser(userCredentials, userTextController!.text);
        _auth!.currentUser!.updateDisplayName(userTextController.text);
        isLoggedIn.value = true;
        Get.back();
        update();
      } on FirebaseAuthException catch (e) {
        String message = e.message!;
        if (e.message == kfeInvalidPasswordError) {
          message = 'Incorrect Password';
        } else if (e.message == kfeNotRegisterEmail) {
          message = 'Email not registered with us. Try Sign up!';
        }
        SnackBarCutom(ctx: ctx, text: message);
      }
    } else {}
  }


  // Login Or Sign In Method
  void loginUserIn({
    required BuildContext ctx,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth!.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
        );
        isLoggedIn.value = true;
        update();
    
      } on FirebaseAuthException catch (e) {
        String message = e.message!;
        if (e.message == kfeInvalidPasswordError) {
          message = 'Incorrect Password';
        } else if (e.message == kfeNotRegisterEmail) {
          message = 'Email not registered with us. Try Sign up!';
        }
        SnackBarCutom(ctx: ctx, text: message);
      }
    } else {}
  }

  void changePassword({
    required BuildContext ctx,
    required GlobalKey<FormState> formKey,
    required String newPassword,
  }) async {
    if (formKey.currentState!.validate()) {
      _auth!.currentUser!.updatePassword(newPassword)
    .then((_) => SnackBarCutom(ctx: ctx, text: "Password updated successfully"))
    // ignore: invalid_return_type_for_catch_error
    .catchError((error) => print("Error updating password: $error"));
    } else {

      print('In valid');
    }
  }


  Future<String?> getUserName() async {
    final userEmail = _auth!.currentUser!.email;
    final DocumentReference currentUserRef = userRf.doc(userEmail);
    final snapshot = await currentUserRef.get() as DocumentSnapshot<Map<String, dynamic>>;
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      return data['username'];
    } else {
      return null;
    }
  }

  String? getRegisteredName(){
    if(_auth==null) return "null";
    if(_auth!.currentUser==null) return "guest";
   return  _auth!.currentUser!.displayName;
  }
}
