import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:pravuxpracticle/viewmodel/userListScreenController.dart';
import 'package:sizer/sizer.dart';

import '../utils/commonWidgets.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({super.key});

  UserListScreenController userListScreenController = Get.put(
    UserListScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserListScreenController>(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CommonWidgets().commonText(
                    text: "Registered Users",
                    fontSize: 20.sp,
                  ),
                ),
                CommonWidgets().commonSizedBox(height: 6.w),
                Expanded(
                  child: FutureBuilder(
                    future: userListScreenController.getUserList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: CommonWidgets().commonText(
                            text:"Something Went Wrong",
                            fontSize: 20.sp,
                          ),
                        );
                      } else if (snapshot.data?.length == 0) {
                        return Center(
                          child: CommonWidgets().commonText(
                            text: "No Data Found",
                            fontSize: 20.sp,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(2.w),
                              margin: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonWidgets().commonText(
                                        text:
                                            "Name : ${snapshot.data?[index].name}",
                                        fontSize: 16.sp,
                                      ),
                                      CommonWidgets().commonSizedBox(
                                        height: 1.w,
                                      ),

                                      CommonWidgets().commonText(
                                        text:
                                            "Email : ${snapshot.data?[index].email}",
                                        fontSize: 16.sp,
                                      ),
                                      CommonWidgets().commonSizedBox(
                                        height: 1.w,
                                      ),
                                      CommonWidgets().commonText(
                                        text:
                                            "Password : ${snapshot.data?[index].password}",
                                        fontSize: 16.sp,
                                      ),
                                      CommonWidgets().commonSizedBox(
                                        height: 1.w,
                                      ),
                                      CommonWidgets().commonText(
                                        text:
                                            "Phone-Number : ${snapshot.data?[index].phoneNumber}",
                                        fontSize: 16.sp,
                                      ),
                                      CommonWidgets().commonSizedBox(
                                        height: 1.w,
                                      ),
                                      CommonWidgets().commonText(
                                        text: userListScreenController.latestCalls[
                                        userListScreenController.formatNumber(
                                          snapshot.data?[index].phoneNumber.toString() ?? "",
                                        )] !=
                                            null
                                            ? "Last Call: ${DateFormat('dd MMM yyyy, hh:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            userListScreenController.latestCalls[
                                            userListScreenController.formatNumber(
                                              snapshot.data?[index].phoneNumber ?? "",
                                            )]
                                                ?.timestamp ??
                                                0,
                                          ),
                                        )}"
                                            : "No Calls",
                                        fontSize: 16.sp,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await userListScreenController
                                              .showUpdateDialog(
                                                context,
                                                snapshot.data?[index].name
                                                    .toString(),
                                                snapshot.data?[index].email
                                                    .toString(),
                                                snapshot.data?[index].password
                                                    .toString(),
                                                snapshot
                                                    .data?[index]
                                                    .phoneNumber
                                                    .toString(),
                                                snapshot.data?[index].id
                                                    .toString(),
                                              );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),

                                      IconButton(
                                        onPressed: () async {
                                          await userListScreenController
                                              .removeUserDetail(
                                                id: snapshot.data?[index].id,
                                              );
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
