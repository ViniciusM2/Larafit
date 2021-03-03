import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerHeader extends StatelessWidget {
  CustomDrawerHeader({this.nameOfUser = ''});
  final String nameOfUser;
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
            ],
          ),
          Row(
            children: [
              CircleAvatar(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameOfUser.split(' ').first,
                    style: Get.textTheme.headline6,
                  ),
                  Text(
                    nameOfUser,
                    style: Get.textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
