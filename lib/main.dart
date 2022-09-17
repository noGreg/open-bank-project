import 'package:flutter/material.dart';
import 'package:open_bank_project/open_bank_app.dart';

import 'features/auth/repositories/auth_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = AuthRepositoryImpl();
  runApp(OpenBanckApp(authRepository: authRepository));
}
