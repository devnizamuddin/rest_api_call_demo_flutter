import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  onTapMenu(String route) {
    Get.toNamed(route);
  }
}
