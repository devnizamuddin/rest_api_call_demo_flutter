import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MenuItem('User', () {
                      controller.onTapMenu(Routes.USER);
                    }),
                  ),
                  Expanded(
                    child: MenuItem('Bus', () {
                      controller.onTapMenu(Routes.USER);
                    }),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget MenuItem(String name, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        height: Get.width / 3,
        child: Card(
          child: Center(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
