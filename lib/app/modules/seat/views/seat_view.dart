import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seat_controller.dart';

class SeatView extends GetView<SeatController> {
  const SeatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeatView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SeatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
