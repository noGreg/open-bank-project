import 'package:flutter/material.dart';

import '../repositories/auth_repository_impl.dart';

class SignUpBloc extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository;

  SignUpBloc({required AuthRepositoryImpl authRepository})
      : _authRepository = authRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String password = '';
  String errorMsg = '';

  bool _isLoading = false;
  bool obscureText = true;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> onSignUpRequest() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      _isLoading = false;

      notifyListeners();
      return true;
    } on Exception catch (e) {
      errorMsg = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
