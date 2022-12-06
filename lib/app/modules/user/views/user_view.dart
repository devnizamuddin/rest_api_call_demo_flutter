import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../models/user.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onTapCreateUser,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() {
            return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.userList.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel userModel = controller.userList[index];
                return Card(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          userModel.avatar ?? '',
                          height: 104,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(userModel.first_name ?? ''),
                              Text(userModel.last_name ?? ''),
                              Text(userModel.email ?? ''),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.deleteUser(userModel.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                );
              },
            );
          }),
        ));
  }
}
