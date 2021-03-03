import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/controller/healthy_habit_page_controller.dart';
import 'package:larafit/ui/widgets/custom_drawer.dart';

class CreateHealthyHabitPage extends GetView<HealthyHabitPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Crie um novo Hábito!',
          style: Get.textTheme.headline6.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
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
            RaisedButton.icon(
              onPressed: controller.addHabit,
              icon: Icon(Icons.done),
              label: Text('Cadastrar'),
            )
          ],
        ),
      ),
    );
  }
}
