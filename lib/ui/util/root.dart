import 'package:flutter/material.dart';
import 'package:flutter_catalog/ui/screens/catalog_screen/catalog_screen.dart';
import 'package:flutter_catalog/ui/screens/home_screen/home_screen.dart';
import 'package:flutter_catalog/ui/shared/gradient_background.dart';
import 'package:flutter_catalog/ui/util/secure_storage_service.dart';

import 'package:get/get.dart';

class Root extends StatelessWidget {
  final SecureStorageService _secureStorage = SecureStorageService();

  @override
  Widget build(BuildContext context) {
    verificationToken();
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future verificationToken() async {
    final token = await _secureStorage.readToken();
    if (token != null) {
      Get.offAll(() => CatalogScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
}
