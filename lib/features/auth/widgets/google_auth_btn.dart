import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/alerts.dart';
import '../../home/ui/screens/home_screen.dart';
import '../bloc/login_bloc.dart';

class GoogleAuthBtn extends StatelessWidget {
  const GoogleAuthBtn({
    Key? key,
    required this.loginBloc,
    required this.label,
  }) : super(key: key);

  final LoginBloc loginBloc;
  final String label;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon:
          const FaIcon(FontAwesomeIcons.google, color: AppColors.primaryColor),
      label: Text(
        label,
        style: TextStyles.blueText,
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(310.0, 53.0),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      onPressed: loginBloc.isLoading
          ? null
          : () async {
              FocusScope.of(context).unfocus();

              final success =
                  await context.read<LoginBloc>().onLoginWithGoogle();
              if (success) {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              } else {
                Alerts.buildScaffoldMessenger(
                    context: context, text: loginBloc.errorMsg);
              }
            },
    );
  }
}
