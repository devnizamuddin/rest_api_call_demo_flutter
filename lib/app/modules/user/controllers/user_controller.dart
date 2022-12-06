import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_call_demo_flutter/app/modules/user/models/user.dart';
import 'package:rest_api_call_demo_flutter/app/services/api_communication.dart';

import '../../../utils/snackbar.dart';

class UserController extends GetxController {
  late ApiCommunication _apiCommunication;

  RxList<UserModel> userList = List<UserModel>.empty(growable: true).obs;
  final Rx<int> _currentPageNumber = 1.obs;
  final Rx<int> _totalPageCount = 0.obs;
  late ScrollController scrollController;

  getUsers() async {
    final response =
        await _apiCommunication.getData('users?page=$_currentPageNumber');
    if (response != null) {
      Map<String, dynamic> mapdata = response.data;
      final list =
          (mapdata['data'] as List).map((x) => UserModel.fromMap(x)).toList();
      _totalPageCount.value = mapdata['total_pages'];
      userList.addAll(list);
      debugPrint(userList.length.toString());
    }
  }

  deleteUser(int id) async {
    String? message = await _apiCommunication.deleteData('users/$id');
    if (message != null) {
      successSnack(message);
    } else {
      alertSnack('Something went wrong');
    }
  }

  @override
  void onInit() async {
    _apiCommunication = ApiCommunication();
    getUsers();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (_currentPageNumber.value != _totalPageCount.value) {
        _currentPageNumber.value += 1;
        getUsers();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    scrollController.dispose();
    super.onClose();
  }
}
