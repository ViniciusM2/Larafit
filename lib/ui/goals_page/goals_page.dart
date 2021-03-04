import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/controller/goal_page_controller.dart';
import 'package:larafit/ui/widgets/custom_card.dart';
import 'package:larafit/ui/widgets/custom_drawer.dart';

import 'goal_form.dart';

class GoalsPage extends GetView<GoalPageController> {
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
          'Minhas Metas',
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
                controller.listOfGoals
                    .map((e) => StaggeredTile.count(2, 2))
                    .toList(),
            crossAxisCount: 4,
            children: controller.listOfGoals
                .map(
                  (model) => CustomCard(
                    title: 'Meta',
                    subtitle: '${model.description}',
                    imageUrl:
                        'https://images.unsplash.com/photo-1487956382158-bb926046304a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80',
                    onLongPress: () {
                      controller.descricaoController.text = model.description;
                      controller.dataComecoController.text =
                          model.startDate;
                      controller.dataFinalController.text = model.finalDate;
                      controller.urlImagemController.text = model.url;
                      showDialog( context: context, builder: (context) => AlertDialog(
                          content: Container(
                            width: Get.width * 0.8,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: controller.descricaoController,
                                  decoration: InputDecoration(
                                    hintText: 'Nome da meta',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: controller.dataComecoController,
                                  decoration: InputDecoration(
                                    hintText: 'Data do começo',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: controller.dataFinalController,
                                  decoration: InputDecoration(
                                    hintText: 'Data limite',
                                  ),
                                ),
                                
                                TextFormField(
                                  controller: controller.urlImagemController,
                                  decoration: InputDecoration(
                                    hintText: 'URL da imagem',
                                  ),
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                          actions: [
                            RaisedButton.icon(
                              onPressed: () => controller
                                  .deleteGoalById(model.idGoal),
                              icon: Icon(Icons.delete),
                              label: Text('Deletar'),
                            ),
                            RaisedButton.icon(
                              color: Get.theme.primaryColor,
                              onPressed: () =>
                                  controller.updateGoalById(
                                model.idGoal,
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
                                  controller: controller.descricaoController,
                                  decoration: InputDecoration(
                                    hintText: 'Nome da meta',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: controller.dataComecoController,
                                  decoration: InputDecoration(
                                    hintText: 'Data do começo',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: controller.dataFinalController,
                                  decoration: InputDecoration(
                                    hintText: 'Data limite',
                                    
                                  ),
                                ),
                                SizedBox(height: 10)
                                ,TextFormField(
                                  controller: controller.urlImagemController,
                                  decoration: InputDecoration(
                                    hintText: 'URL da imagem',
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
                  onPressed: controller.addGoal,
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
}
