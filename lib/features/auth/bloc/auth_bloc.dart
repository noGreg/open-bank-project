import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../models/user.dart';
import '../repositories/auth_repository_impl.dart';

class AuthBloc extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository;

  AuthBloc({required AuthRepositoryImpl authRepository})
      : _authRepository = authRepository,
        super();

  String errorMsg = '';
  // Stream<User> get user => _authRepository.user;
  User currentUser = User.empty;

  Future<void> logOut() async {
    try {
      await _authRepository.logOut();
    } on Exception catch (_) {
      errorMsg = Strings.unknownFailure;
      notifyListeners();
    }
  }

  Future<bool> deleteAccount() async {
    try {
      await _authRepository.deleteAccount();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
