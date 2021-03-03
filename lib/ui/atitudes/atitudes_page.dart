import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/ui/widgets/custom_card.dart';
import 'package:larafit/ui/widgets/custom_drawer.dart';

import 'atitude_form.dart';

class AtitudesPage extends GetView<DashboardController> {
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
            'Minhas Atitudes',
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
            ],
            crossAxisCount: 4,
            children: [
              Obx(
                () => CustomCard(
                  title: 'Idade',
                  subtitle: controller.age,
                  imageUrl:
                      'https://images.unsplash.com/photo-1574680096145-d05b474e2155?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
                  onLongPress: () {},
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            child: AlertDialog(
              content: AtitudeForm(),
              actions: [
                FlatButton(
                  onPressed: () {},
                  child: Text('Cancelar'),
                ),
                RaisedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.done),
                  label: Text('Cadastrar'),
                ),
              ],
            ),
          ),
          child: Icon(
            Icons.add,
          ),
        ));
  }
}
