import 'package:flutter/material.dart';
import 'package:open_bank_project/core/constants/strings.dart';
import 'package:open_bank_project/core/extensions/responsive.dart';
import 'package:open_bank_project/core/extensions/validators.dart';
import 'package:open_bank_project/core/theme/text_styles.dart';
import 'package:open_bank_project/features/auth/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/input_decorations.dart';
import '../../../core/utils/alerts.dart';
import '../../../core/widgets/app_btn.dart';
import '../../home/ui/screens/home_screen.dart';
import '../bloc/login_bloc.dart';
import '../repositories/auth_repository_impl.dart';
import '../widgets/google_auth_btn.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:

            // SizedBox(
            //   height: 100.h,
            //   width: 100.w,
            //   child: RegisterScreen(
            //     providerConfigs: [
            //       GoogleProviderConfiguration(
            //         clientId:
            //             "551970385340-nhcp7vqe8mejdqjbn17um3n9oplig1o3.apps.googleusercontent.com",
            //       )
            //     ],
            //   ),
            // ),
            Column(
          children: [
            SizedBox(height: 113.dH),
            Text(Strings.login, style: TextStyles.mainLabel),
            SizedBox(height: 21.dH),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 90.dW),
              child: Text(
                Strings.loginMsj,
                style: TextStyles.text,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 38.dH),
            ChangeNotifierProvider(
              create: (_) => LoginBloc(authRepository: AuthRepositoryImpl()),
              child: const _LoginForm(),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignUpScreen.routeName, (route) => false);
              },
              child: RichText(
                text: TextSpan(
                  text: Strings.dontHaveAnAccount,
                  children: [
                    TextSpan(
                      text: Strings.signUp,
                      style: TextStyles.blueText.copyWith(fontSize: 16.fS),
                    ),
                  ],
                  style: TextStyles.text.copyWith(fontSize: 16.fS),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 37.dW),
      child: Form(
        key: loginBloc.formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: Strings.hintEmail,
                labelText: Strings.email,
              ),
              onChanged: (value) => loginBloc.email = value,
              validator: (email) => email!.isEmailValid,
            ),
            SizedBox(height: 22.dH),
            TextFormField(
              obscureText: loginBloc.obscureText,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: Strings.password,
                labelText: Strings.password,
                suffix: InkWell(
                  onTap: () => loginBloc.toggleVisibility(),
                  child: Icon(loginBloc.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              onChanged: (value) => loginBloc.password = value,
              validator: (password) => password!.isPasswordValid,
            ),
            SizedBox(height: 49.dH),
            InkWell(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(Strings.forgotPasswordBtn, style: TextStyles.text)),
            SizedBox(height: 38.dH),
            AppBtn(
              label: Strings.login,
              onPressed: loginBloc.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!loginBloc.isValidForm()) return;
                      final success =
                          await context.read<LoginBloc>().onLoginRequest();
                      if (success) {
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      } else {
                        Alerts.buildScaffoldMessenger(
                            context: context, text: loginBloc.errorMsg);
                      }
                    },
            ),
            SizedBox(height: 70.dH),
            GoogleAuthBtn(
              loginBloc: loginBloc,
              label: Strings.loginWithGoogle,
            ),
            SizedBox(height: 19.dH),
          ],
        ),
      ),
    );
  }
}
