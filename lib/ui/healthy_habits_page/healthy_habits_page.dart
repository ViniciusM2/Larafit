import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:larafit/controller/healthy_habit_page_controller.dart';
import 'package:larafit/ui/healthy_habits_page/healthy_habit_form.dart';
import 'package:larafit/ui/widgets/custom_card.dart';
import 'package:larafit/ui/widgets/custom_drawer.dart';

class HealthyHabitsPage extends GetView<HealthyHabitPageController> {
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
        child: Obx(
          () => StaggeredGridView.count(
            staggeredTiles:
                // StaggeredTile.count(2, 2),
                controller.listOfHealthyHabits
                    .map((e) => StaggeredTile.count(2, 2))
                    .toList(),
            crossAxisCount: 4,
            children: controller.listOfHealthyHabits
                .map(
                  (model) => CustomCard(
                    title: 'Hábito',
                    subtitle: '${model.nomehabito}',
                    imageUrl:
                        'https://images.unsplash.com/photo-1487956382158-bb926046304a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80',
                    onLongPress: () {
                      controller.descriptionController.text =
                          model.descricaoTEXT;
                      controller.nameOfHabitController.text = model.nomehabito;
                      controller.urlController.text = model.url;
                      showDialog( context: context, builder: (context) => AlertDialog(
                          content: Container(
                            width: Get.width * 0.8,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: controller.nameOfHabitController,
                                  decoration: InputDecoration(
                                    hintText: 'Nome do Hábito',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: controller.descriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Nome Descrição',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: controller.urlController,
                                  decoration: InputDecoration(
                                    hintText: 'URL da Imagem',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            RaisedButton.icon(
                              onPressed: () => controller
                                  .deleteHealthyHabitById(model.idHabito),
                              icon: Icon(Icons.delete),
                              label: Text('Deletar'),
                            ),
                            RaisedButton.icon(
                              color: Get.theme.primaryColor,
                              onPressed: () =>
                                  controller.updateHealthyHabitById(
                                model.idHabito,
                              ),
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

                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearTextEditingControllers();
          showDialog( context: context, builder: (context) => AlertDialog(
              content: Container(
                width: Get.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: controller.nameOfHabitController,
                      decoration: InputDecoration(
                        hintText: 'Nome do Hábito',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Nome Descrição',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.urlController,
                      decoration: InputDecoration(
                        hintText: 'URL da Imagem',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {},
                  child: Text('Cancelar'),
                ),
                RaisedButton.icon(
                  onPressed: controller.addHabit,
                  icon: Icon(Icons.done),
                  label: Text('Cadastrar'),
                ),
              ],
            )
 ,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
  //   floatingActionButton: FloatingActionButton(
  //   onPressed: () => Get.toNamed(Routes.CREATE_HEALTHY_HABITS),
  //   child: Icon(
  //     Icons.add,
  //   ),
  // ),
}
