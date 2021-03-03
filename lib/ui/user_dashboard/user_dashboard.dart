import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/ui/user_dashboard/widgets/dashboard_card.dart';
import 'package:larafit/ui/widgets/custom_drawer.dart';

class UserDashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Obx(
        () => CustomDrawer(
          nameOfUser: controller.nameOfUser,
          currentRoute: Get.currentRoute,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Oii, Vini',
          style: Get.textTheme.headline6.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: StaggeredGridView.count(
          staggeredTiles: [
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
          ],
          crossAxisCount: 4,
          children: [
            Obx(
              () => DashboardCard(
                title: 'Idade',
                subtitle: controller.age,
                imageUrl:
                    'https://images.unsplash.com/photo-1574680096145-d05b474e2155?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
              ),
            ),
            Obx(
              () => DashboardCard(
                title: 'Sexo',
                subtitle: controller.sex,
              ),
            ),
            Obx(
              () => DashboardCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80',
                title: 'Altura',
                subtitle: controller.height,
              ),
            ),
            Obx(
              () => DashboardCard(
                title: 'Peso',
                subtitle: controller.weight,
              ),
            ),
            Obx(
              () => DashboardCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                title: 'IMC',
                subtitle: controller.imc,
              ),
            ),
            Obx(
              () => DashboardCard(
                title: 'Metas Atingidas',
                subtitle: controller.numberOfSuccessfulGoals,
              ),
            ),
            DashboardCard(
              imageUrl:
                  'https://images.unsplash.com/photo-1514907707149-eca420f5de51?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1349&q=80',
              title: 'Beba',
              subtitle: 'Água',
            ),
            Obx(
              () => DashboardCard(
                title: 'Nº de Atitudes',
                subtitle: controller.numberOfAtitudes,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.fitness_center),
      ),
    );
  }
}
