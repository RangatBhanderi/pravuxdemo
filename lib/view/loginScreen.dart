import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pravuxpracticle/utils/commonWidgets.dart';
import 'package:pravuxpracticle/view/registerUserScreen.dart';
import 'package:pravuxpracticle/viewmodel/loginScreenController.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginScreenController loginScreenController = Get.put(
    LoginScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidgets().commonText(text: "Login", fontSize: 20.sp),
            CommonWidgets().commonSizedBox(height: 6.w),
            CommonWidgets().commonTextField(
              hintText: "Email",
              controller: loginScreenController.emailController,
            ),
            CommonWidgets().commonSizedBox(height: 3.w),
            CommonWidgets().commonTextField(
              hintText: "Password",
              controller: loginScreenController.passwordController,
            ),
            CommonWidgets().commonSizedBox(height: 5.w),
            CommonWidgets().commonButton(
              ontap: () {
                loginScreenController.login(context);
              },
              title: "Login",
            ),
            CommonWidgets().commonSizedBox(height: 2.w),
            GestureDetector(
              onTap: () {
                Get.off(RegisterUserScreen());
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: CommonWidgets().commonText(
                  text: "have't account! Register it",
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
