import 'package:flutter/material.dart';
import 'package:open_bank_project/core/extensions/responsive.dart';
import 'package:open_bank_project/core/extensions/validators.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/input_decorations.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/alerts.dart';
import '../../../core/widgets/app_btn.dart';
import '../../home/ui/screens/home_screen.dart';
import '../bloc/login_bloc.dart';
import '../bloc/signup_bloc.dart';
import '../repositories/auth_repository_impl.dart';
import '../widgets/google_auth_btn.dart';
import '../widgets/user_terms.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = 'register_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 113.dH),
            Text(Strings.signUp, style: TextStyles.mainLabel),
            SizedBox(height: 21.dH),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 90.dW),
              child: Text(
                Strings.signUpMsj,
                style: TextStyles.text,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 38.dH),
            MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) =>
                      SignUpBloc(authRepository: AuthRepositoryImpl()),
                ),
                ChangeNotifierProvider(
                  create: (_) =>
                      LoginBloc(authRepository: AuthRepositoryImpl()),
                ),
              ],
              child: const _SignUpForm(),
            ),

            // SizedBox(height: 19.dH),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              child: RichText(
                text: TextSpan(
                  text: Strings.alreadyhaveAnAccount,
                  children: [
                    TextSpan(
                      text: Strings.login,
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

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.watch<SignUpBloc>();
    final loginBloc = context.watch<LoginBloc>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 37.dW),
      child: Form(
        key: signUpBloc.formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: Strings.hintFullName,
                labelText: Strings.fullName,
              ),
              onChanged: (value) => signUpBloc.name = value,
              validator: (name) => name!.isNameValid,
            ),
            SizedBox(height: 19.dH),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: Strings.hintEmail,
                labelText: Strings.email,
              ),
              onChanged: (value) => signUpBloc.email = value,
              validator: (email) => email!.isEmailValid,
            ),
            SizedBox(height: 19.dH),
            TextFormField(
              obscureText: signUpBloc.obscureText,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: Strings.password,
                labelText: Strings.password,
                suffix: InkWell(
                  onTap: () => signUpBloc.toggleVisibility(),
                  child: Icon(signUpBloc.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              onChanged: (value) => signUpBloc.password = value,
              validator: (password) => password!.isPasswordValid,
            ),
            SizedBox(height: 19.dH),
            UserTerms(),
            SizedBox(height: 38.dH),
            AppBtn(
              label: Strings.signUp,
              onPressed: signUpBloc.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!signUpBloc.isValidForm()) return;
                      final success =
                          await context.read<SignUpBloc>().onSignUpRequest();
                      if (success) {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      } else {
                        Alerts.buildScaffoldMessenger(
                            context: context, text: signUpBloc.errorMsg);
                      }
                    },
            ),
            SizedBox(height: 70.dH),
            GoogleAuthBtn(
              loginBloc: loginBloc,
              label: Strings.signUpWithGoogle,
            ),
            SizedBox(height: 19.dH),
          ],
        ),
      ),
    );
  }
}