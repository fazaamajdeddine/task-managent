import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource extends ChangeNotifier{
  User? currentUser;
  String? _token;

  Future<void> initialize() async {
    await getCurrentUser();
  }
  Future<void> setCurrentUser(User user) async {
    var box = await Hive.openBox('currentUser');
    await box.put('user', user);
    currentUser = user;
    notifyListeners();
  }
  Future<void> getCurrentUser() async {
    var box = await Hive.openBox('currentUser');
    currentUser = box.get('user', defaultValue: null);
    _token = box.get('token', defaultValue: null);
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    var box = await Hive.openBox('currentUser');
    await box.put('token', token);
    _token = token;
    notifyListeners();
  }



  Future<void> logout() async {
    var box = await Hive.openBox('currentUser');
    await box.clear();
    currentUser = null;
    _token = null;
  }

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox('currentUser');
    currentUser = box.get('user', defaultValue: null);
    _token = box.get('token', defaultValue: null);
    return currentUser != null && _token != null;
  }

  String? get token => _token;
}