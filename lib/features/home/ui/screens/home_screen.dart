import 'package:flutter/material.dart';
import 'package:open_bank_project/core/extensions/responsive.dart';
import 'package:open_bank_project/features/auth/models/user.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/theme/box_decorators.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../widgets/bottom_tab_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return const _HomeBody();
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appUser = User(id: "id", name: "Juan", email: "juan_perez@gmail.com");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 115.dH, width: double.infinity),
            const UserProfileImage(appUser: appUser),
            SizedBox(height: 46.dH),
            Text(Strings.welcome, style: TextStyles.mainLabel),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.dW),
              child: Text(
                appUser.name ?? " ",
                style: TextStyles.mainLabel,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 82.dH),
            _HomeCard(
              iconUrl: AppImages.bookIcon,
              title: Strings.explore,
              onTap: () {},
            ),
            _HomeCard(
              iconUrl: AppImages.blueHeart,
              title: Strings.favorites,
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabSelector(),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({
    Key? key,
    required this.title,
    required this.iconUrl,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String iconUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150.dH,
        width: 340.dW,
        padding: EdgeInsets.only(left: 40.dW),
        margin: EdgeInsets.only(bottom: 19.dH),
        decoration: whiteBoxDecoration,
        child: Row(
          children: <Widget>[
            Image.asset(
              iconUrl,
              height: 59.dW,
              width: 59.dW,
            ),
            SizedBox(width: 19.dW),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(Strings.books, style: TextStyles.text),
                Text(title, style: TextStyles.mainLabel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
