import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_bank_project/core/extensions/responsive.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class UserTerms extends StatelessWidget {
  const UserTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: Strings.byClickMsj,
            children: [
              TextSpan(
                text: Strings.privacyPolice,
                style: _underlineStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => log('$Strings.privacyPolice clicked'),
              ),
            ],
            style: TextStyles.text.copyWith(fontSize: 13.fS),
          ),
        ),
        SizedBox(height: 8.dH),
        RichText(
          text: TextSpan(
            text: Strings.our,
            children: [
              TextSpan(
                text: Strings.termsAndCOnditions,
                style: _underlineStyle,
              ),
            ],
            style: TextStyles.text.copyWith(fontSize: 13.fS),
          ),
        ),
      ],
    );
  }

  TextStyle get _underlineStyle => GoogleFonts.dmSans(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: 13.fS,
        decoration: TextDecoration.underline,
      );
}
