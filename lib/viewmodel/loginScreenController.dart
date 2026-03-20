import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pravuxpracticle/services/apiHandler.dart';
import 'package:pravuxpracticle/services/apiUrls.dart';
import 'package:pravuxpracticle/utils/commonWidgets.dart';
import 'package:pravuxpracticle/view/userListScreen.dart';

import '../model/userListModel.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<UserListModel> usersList = [];

  login(context) async {
    if (emailController.text.toString().isEmpty) {
      CommonWidgets().showSnackBar(
        title: "Alert",
        message: "Please enter valid email",
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    } else if (passwordController.text.toString().isEmpty) {
      CommonWidgets().showSnackBar(
        title: "Alert",
        message: "Please enter valid password",
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    } else {
      CommonWidgets().showLoader(context: context);
      try {
        var response = await ApiHandler().getData(url: ApiUrls.apiUrl);

        List data = jsonDecode(response.body);

        usersList = data.map((e) => UserListModel.fromJson(e)).toList();
        final user = usersList.firstWhereOrNull(
          (e) =>
              e.email.toString() == emailController.text.toString() &&
              e.password.toString() == passwordController.text.toString(),
        );
        if (user == null) {
          Navigator.pop(context);
          CommonWidgets().showSnackBar(
            title: "Alert",
            message: "Please enter valid email and password",
            textColor: Colors.white,
            snackColor: Colors.red,
          );
        } else {
          passwordController.clear();
          emailController.clear();
          Navigator.pop(context);
          Get.off(UserListScreen());
        }
      } catch (e) {
        Navigator.pop(context);
      }
    }
  }
}
