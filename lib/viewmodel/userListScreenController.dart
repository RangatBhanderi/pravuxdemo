import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../model/userListModel.dart';
import '../services/apiHandler.dart';
import '../services/apiUrls.dart';
import '../utils/commonWidgets.dart';

class UserListScreenController extends GetxController {
  List<UserListModel> usersList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool isCallLogLoaded = false;
  Map<String, CallLogEntry> latestCalls = {};

  Future<List<UserListModel>> getUserList() async {
    var response = await ApiHandler().getData(url: ApiUrls.apiUrl);

    List data = jsonDecode(response.body);

    usersList = data.map((e) => UserListModel.fromJson(e)).toList();


    if (!isCallLogLoaded) {
      await loadCallLogs();
      isCallLogLoaded = true;
    }

    return usersList;
  }

  Future<void> loadCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();

    latestCalls.clear();

    for (var call in entries) {
      String number = formatNumber(call.number ?? "");

      if (number.isEmpty) continue;

      if (!latestCalls.containsKey(number)) {
        latestCalls[number] = call;
      } else {
        if ((call.timestamp ?? 0) >
            (latestCalls[number]?.timestamp ?? 0)) {
          latestCalls[number] = call;
        }
      }
    }

  }
  String formatNumber(String num) {
    return num
        .replaceAll("+91", "")
        .replaceAll(" ", "")
        .replaceAll("-", "");
  }
  Future<void> removeUserDetail({String? id}) async {
    try {
      var response = await ApiHandler().removeData(url: ApiUrls.apiUrl, id: id);

      if (response.statusCode == 200) {
        CommonWidgets().showSnackBar(
          title: "Success",
          message: "User Deleted successfully",
          textColor: Colors.white,
          snackColor: Colors.green,
        );
        update();
      } else {
        CommonWidgets().showSnackBar(
          title: "Failed",
          message: "User Deletion Failed!",
          textColor: Colors.white,
          snackColor: Colors.red,
        );
      }
    } catch (e) {
      CommonWidgets().showSnackBar(
        title: "Failed",
        message: e.toString(),
        textColor: Colors.white,
        snackColor: Colors.red,
      );
    }
  }

  showUpdateDialog(context, name, email, password, phoneNumber, id) {
    nameController.text = name;
    emailController.text = email;
    passwordController.text = password;
    phoneNumberController.text = phoneNumber;
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonWidgets().commonText(
                    text: "Update User Detail",
                    fontSize: 20.sp,
                  ),
                  CommonWidgets().commonSizedBox(height: 3.w),
                  CommonWidgets().commonTextField(
                    hintText: "Name",
                    controller: nameController,
                  ),
                  CommonWidgets().commonSizedBox(height: 3.w),
                  CommonWidgets().commonTextField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  CommonWidgets().commonSizedBox(height: 3.w),
                  CommonWidgets().commonTextField(
                    hintText: "Password",
                    controller: passwordController,
                  ),
                  CommonWidgets().commonSizedBox(height: 3.w),
                  CommonWidgets().commonTextField(
                    hintText: "Phone Number",
                    type: TextInputType.number,
                    formatter: FilteringTextInputFormatter.digitsOnly,
                    controller: phoneNumberController,
                  ),
                  CommonWidgets().commonSizedBox(height: 3.w),
                  CommonWidgets().commonButton(
                    ontap: () {
                      updateUserDetails(context, id);
                    },
                    title: "Update",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateUserDetails(context, id) async {
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
          // "lastCallAt": "",
        };
        var response = await ApiHandler().updateData(
          url: ApiUrls.apiUrl,
          id: id,
          passedData: userData,
        );
        if (response.statusCode == 200) {
          nameController.clear();
          passwordController.clear();
          emailController.clear();
          phoneNumberController.clear();
          update();
          CommonWidgets().showSnackBar(
            title: "Success",
            message: "User Detail Updated Successfully",
            textColor: Colors.white,
            snackColor: Colors.green,
          );
        } else {
          CommonWidgets().showSnackBar(
            title: "Failed",
            message: "User Detail Not Updated",
            textColor: Colors.white,
            snackColor: Colors.green,
          );
        }
      } catch (e) {
        CommonWidgets().showSnackBar(
          title: "Failed",
          message: e.toString(),
          textColor: Colors.white,
          snackColor: Colors.red,
        );
      }
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
