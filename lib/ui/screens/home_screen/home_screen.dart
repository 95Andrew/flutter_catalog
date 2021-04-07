import 'package:flutter/material.dart';
import 'package:flutter_catalog/ui/screens/catalog_screen/catalog_screen.dart';
import 'package:flutter_catalog/ui/screens/login_screen/login_screen.dart';
import 'package:flutter_catalog/ui/screens/register_screen/register_screen.dart';
import 'package:flutter_catalog/ui/shared/const_strings.dart';
import 'package:flutter_catalog/ui/shared/gradient_background.dart';
import 'package:flutter_catalog/ui/util/ui_helpers.dart';
import 'package:flutter_catalog/ui/widgets/custom_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(text: login, onTap: () => Get.to(() => LoginScreen())),
            verticalSpacer(verticalSpaceMedium),
            CustomButton(
              text: registration,
              onTap: () {
                Get.to(() => RegisterScreen());
              },
            ),
            verticalSpacer(verticalSpaceMedium),
            CustomButton(
                text: withoutRegistering,
                onTap: () {
                  Get.to(() => CatalogScreen());
                }),
          ],
        ),
      ),
    );
  }
}
