import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pravuxpracticle/utils/commonWidgets.dart';
import 'package:pravuxpracticle/view/loginScreen.dart';

import '../model/userListModel.dart';
import '../services/apiHandler.dart';
import '../services/apiUrls.dart';

class RegisterScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  registerUser(context) async {
    if (nameController.text.toString().isEmpty) {
      CommonWidgets().showSnackBar(
        title: "Alert",
        message: "Please enter valid name",
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    } else if (!emailRegex.hasMatch(emailController.text.toString())) {
      CommonWidgets().showSnackBar(
        title: "Alert",
        message: "Please enter valid mail as test@gmail.com",
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    } else if (passwordController.text.toString().length != 8) {
      CommonWidgets().showSnackBar(
        title: "Alert",
        message: "Please enter password with 8 character",
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    } else if (phoneNumberController.text.toString().length != 10) {
      CommonWidgets().showSnackBar(
        title: "Alert",
        message: "Please enter valid 10 digit phone number",
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    } else {
      CommonWidgets().showLoader(context: context);
      try {
        var userData = {
          "name": nameController.text.toString(),
          "email": emailController.text.toString(),
          "password": passwordController.text.toString(),
          "phoneNumber": phoneNumberController.text.toString(),
        };
        var getResponse = await ApiHandler().getData(url: ApiUrls.apiUrl);
        List data = jsonDecode(getResponse.body);

        var usersList = data.map((e) => UserListModel.fromJson(e)).toList();

        final isExist = usersList.any(
          (e) =>
              e.email == emailController.text.trim() ||
              e.phoneNumber == phoneNumberController.text.trim(),
        );

        if (isExist) {
          Navigator.pop(context);
          CommonWidgets().showSnackBar(
            title: "Failed",
            message: "Email or phone number already exist",
            textColor: Colors.white,
            snackColor: Colors.red,
          );
          return;
        }
        var response = await ApiHandler().postData(
          url: ApiUrls.apiUrl,
          passedData: userData,
        );
        if (response.statusCode == 201) {
          nameController.clear();
          passwordController.clear();
          emailController.clear();
          phoneNumberController.clear();
          Navigator.pop(context);
          CommonWidgets().showSnackBar(
            title: "Success",
            message: "User registered successfully",
            textColor: Colors.white,
            snackColor: Colors.green,
          );

          Get.offAll(LoginScreen());
        } else {
          Navigator.pop(context);
          CommonWidgets().showSnackBar(
            title: "Failed",
            message: "User Not Registered!",
            textColor: Colors.white,
            snackColor: Colors.green,
          );
        }
      } catch (e) {
        Navigator.pop(context);
        CommonWidgets().showSnackBar(
          title: "Failed",
          message: e.toString(),
          textColor: Colors.white,
          snackColor: Colors.red,
        );
      }

    }
  }
}
