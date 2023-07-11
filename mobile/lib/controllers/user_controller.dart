import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front/config/firebase_instance.dart';
import 'package:front/models/user_model.dart';
import 'package:front/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
  static const sessionID = 'id';
  static const sessionLoggedIn = 'loggedIn';

  final _initialization = FirebaseInstance.initialization;
  final _auth = FirebaseInstance.auth;
  final _userService = UserService();

  late User _user = _auth.currentUser!;
  late UserModel _userModel;
  late Status _status = Status.unInitialized;

  User get user => _user;
  UserModel get userModel => _userModel;
  Status get status => _status;

  // Public variables
  final formkey = GlobalKey<FormState>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void reset() {
    firstname.text = "";
    lastname.text = "";
    username.text = "";
    email.text = "";
    password.text = "";
  }

  UserController.initialize() {
    _fireSetUp();
  }

  _fireSetUp() async {
    await _initialization.then((value) {
      _auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<void> _onStateChanged(User? firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (firebaseUser == null) {
      _status = Status.unAuthenticated;
    } else {
      _user = firebaseUser;
      await prefs.setString(sessionID, firebaseUser.uid);

      _userModel = await _userService.getUserById(user.uid).then((value) {
        _status = Status.authenticated;
        return value;
      });
    }
    notifyListeners();
  }

  ///maj utilisateur
  void updateUser(Map<String, dynamic> data) async {
    _userService.updateUser(data);
  }

  //se connecter
  Future<bool> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.authenticating;
      notifyListeners();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      await prefs.setString(sessionID, userCredential.user!.uid);
      await prefs.setBool(sessionLoggedIn, true);

      _userModel = await _userService.getUserById(userCredential.user!.uid);

      return true;
    } catch (e) {
      _status = Status.unAuthenticated;
      notifyListeners();
      debugPrint(e.toString());
      return false;
    }
  }

  //inscription
  Future<bool> register() async {
    try {
      _status = Status.unAuthenticated;
      notifyListeners();

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(sessionID, userCredential.user!.uid);
      await prefs.setBool(sessionLoggedIn, false);

      _userService.createUser(
        id: userCredential.user!.uid,
        firstname: firstname.text.trim(),
        lastname: lastname.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
      );
      return true;
    } catch (e) {
      _status = Status.unAuthenticated;
      notifyListeners();
      debugPrint(e.toString());
      return false;
    }
  }

  /// @Todo logout
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _auth.signOut();
    _status = Status.unAuthenticated;
    await prefs.setString(sessionID, '');
    await prefs.setBool(sessionLoggedIn, false);
    await prefs.clear();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  /// @Todo reload user account
  Future<void> reloadUser() async {
    _userModel = await _userService.getUserById(user.uid);
    notifyListeners();
  }
}

enum Status { unInitialized, unAuthenticated, authenticating, authenticated }
