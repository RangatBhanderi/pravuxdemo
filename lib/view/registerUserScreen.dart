import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pravuxpracticle/view/loginScreen.dart';
import 'package:pravuxpracticle/viewmodel/registerScreenController.dart';
import 'package:sizer/sizer.dart';

import '../utils/commonWidgets.dart';
import '../viewmodel/registerScreenController.dart';

class RegisterUserScreen extends StatelessWidget {
  RegisterUserScreen({super.key});

  RegisterScreenController registerScreenController = Get.put(
    RegisterScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidgets().commonText(text: "Register", fontSize: 20.sp),
            CommonWidgets().commonSizedBox(height: 6.w),

            CommonWidgets().commonTextField(
              hintText: "Name",
              controller: registerScreenController.nameController,
            ),
            CommonWidgets().commonSizedBox(height: 3.w),
            CommonWidgets().commonTextField(
              hintText: "Email",
              controller: registerScreenController.emailController,
            ),
            CommonWidgets().commonSizedBox(height: 5.w),
            CommonWidgets().commonTextField(
              hintText: "Password",
              controller: registerScreenController.passwordController,
            ),
            CommonWidgets().commonSizedBox(height: 3.w),
            CommonWidgets().commonTextField(
              hintText: "Phone Number",
              type: TextInputType.number,
              formatter: FilteringTextInputFormatter.digitsOnly,
              controller: registerScreenController.phoneNumberController,
            ),
            CommonWidgets().commonSizedBox(height: 5.w),
            CommonWidgets().commonButton(
              ontap: () {
                registerScreenController.registerUser(context);
              },
              title: "Register",
            ),

            CommonWidgets().commonSizedBox(height: 2.w),
            GestureDetector(
              onTap: () {
                Get.off(LoginScreen());
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: CommonWidgets().commonText(
                  text: "Already have an account? Login",
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
