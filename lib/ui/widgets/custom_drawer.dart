import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larafit/routes/app_routes.dart';
import 'package:larafit/ui/widgets/custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    this.nameOfUser = '',
    this.currentRoute,
  });
  final String nameOfUser;
  final String currentRoute;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CustomDrawerHeader(
            nameOfUser: nameOfUser,
          ),
          ListTile(
            selected:
                (currentRoute ?? false) == Routes.DASHBOARD ? true : false,
            leading: Icon(
              Icons.dashboard,
            ),
            title: Text(
              'Dashboard',
              style: Get.textTheme.subtitle2,
            ),
            onTap: () => Get.toNamed(Routes.DASHBOARD),
          ),
          ListTile(
            selected:
                (currentRoute ?? false) == Routes.HEALTHY_HABITS ? true : false,
            leading: Icon(
              Icons.favorite,
            ),
            title: Text(
              'Meus Hábitos',
              style: Get.textTheme.subtitle2,
            ),
            onTap: () => Get.toNamed(Routes.HEALTHY_HABITS),
          ),
          ListTile(
            selected: (currentRoute ?? false) == Routes.GOALS ? true : false,
            leading: Icon(Icons.eco),
            title: Text(
              'Minhas Metas',
              style: Get.textTheme.subtitle2,
            ),
            onTap: () => Get.toNamed(Routes.GOALS),
          ),
          ListTile(
            selected: (currentRoute ?? false) == Routes.ATITUDES ? true : false,
            leading: Icon(Icons.spa),
            title: Text(
              'Minhas Atitudes',
              style: Get.textTheme.subtitle2,
            ),
           onTap: () => Get.toNamed(Routes.ATITUDES),
          ),
        ],
      ),
    );
  }
}
