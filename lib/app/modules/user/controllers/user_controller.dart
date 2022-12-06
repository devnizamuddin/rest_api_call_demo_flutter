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
  late TextEditingController _nameController;
  late TextEditingController _jobController;

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

  onTapCreateUserDialog() {
    _nameController.clear();
    _jobController.clear();
    Get.dialog(Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green,
            child: const Text(
              'Create New User',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _jobController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    hintText: 'Job',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ))),
                const SizedBox(width: 20),
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () {
                          Get.back();
                          createUser();
                        },
                        child: const Text('Create',
                            style: TextStyle(color: Colors.white))))
              ],
            ),
          ),
        ],
      ),
    ));
  }

  createUser() async {
    Map<String, dynamic> mapdata = {
      "name": _nameController.text,
      "job": _jobController.text
    };

    final response = await _apiCommunication.postData('api/users', mapdata);
    if (response != null) {
      Map<String, dynamic> mapdata = response.data;
      debugPrint(mapdata.toString());
      successSnack("User Created Successfully");
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
    _nameController = TextEditingController();
    _jobController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    scrollController.dispose();
    _nameController.dispose();
    _jobController.dispose();
    super.onClose();
  }
}
