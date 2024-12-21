import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NadaThemeController extends GetxController {
  final _isDarkMode = false.obs;
  final _isArabic = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  bool get isArabic => _isArabic.value;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode.value = Get.isPlatformDarkMode;
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleLanguage() {
    _isArabic.value = !_isArabic.value;
    Get.updateLocale(_isArabic.value ? const Locale('ar') : const Locale('en'));
  }
}
