import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/ui/healthy_habits_page/healthy_habit_form.dart';
import 'package:larafit/ui/widgets/custom_card.dart';
import 'package:larafit/ui/widgets/custom_drawer.dart';

class HealthyHabitsPage extends GetView<DashboardController> {
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
          'Meus Hábitos',
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
                title: 'Caminhar',
                subtitle: controller.age,
                imageUrl:
                    'https://images.unsplash.com/photo-1487956382158-bb926046304a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80',
                onLongPress: () => showDialog(
                  context: context,
                  child: AlertDialog(
                    content: HealthyHabitForm(),
                    actions: [
                      RaisedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        label: Text('Deletar'),
                      ),
                      RaisedButton.icon(
                        color: Get.theme.primaryColor,
                        onPressed: () {},
                        label: Text(
                          'Salvar Mudanças',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          child: AlertDialog(
            content: HealthyHabitForm(),
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
      ),
    );
  }
}
