import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/controller/healthy_habit_page_controller.dart';

class HealthyHabitForm extends StatelessWidget {
  HealthyHabitForm({this.controller});
  final HealthyHabitPageController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
