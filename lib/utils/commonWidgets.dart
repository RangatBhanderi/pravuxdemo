import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class CommonWidgets {
  Widget commonText({
    String? text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return Text(
      text.toString(),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget commonTextField({
    String? hintText,
    TextEditingController? controller,
    TextInputType? type,
    TextInputFormatter? formatter,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      inputFormatters: [
       ?formatter
      ],
      onChanged: (a) {},
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  Widget commonButton({VoidCallback? ontap, String? title}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(2.w)),
        width: 100.w,
        child: Center(
          child: CommonWidgets().commonText(
            text: title,
            color: Colors.white,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }

  Future showLoader({BuildContext? context}) {
    return showDialog(
      context: context!,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator(color: Colors.indigo)),
        ],
      ),
    );
  }

  showSnackBar({String? title, String? message, Color? textColor, snackColor}) {
    Get.snackbar(
      "",
      "",
      titleText: CommonWidgets().commonText(
        text: title.toString(),
        color: textColor,
        fontSize: 18.sp,
      ),
      messageText: CommonWidgets().commonText(
        text: message.toString(),
        color: textColor,
        fontSize: 16.sp,
      ),
      backgroundColor: snackColor,
    );
  }
}
