import 'package:get/get.dart';

import '../controllers/seat_controller.dart';

class SeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeatController>(
      () => SeatController(),
    );
  }
}
