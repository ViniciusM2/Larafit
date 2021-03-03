import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larafit/data/model/healthy_habit_model.dart';
import 'package:larafit/data/repository/habit_repository.dart';
import 'package:meta/meta.dart';

class HealthyHabitPageController extends GetxController {
  final HabitRepository repository;
  HealthyHabitPageController({@required this.repository})
      : assert(repository != null);

  final _nameOfUser = ''.obs;
  get nameOfUser => this._nameOfUser.value;
  set nameOfUser(value) => this._nameOfUser.value = value;

  var listOfHealthyHabits = <HealthyHabitModel>[].obs;

  @override
  void onInit() async {
    listOfHealthyHabits.assignAll(await repository.getAllHealthyHabits());
    print(listOfHealthyHabits);
    super.onInit();
  }

  TextEditingController nameOfHabitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  Future<void> addHabit() {
    var model = HealthyHabitModel(
      descricaoTEXT: descriptionController.text,
      nomehabito: nameOfHabitController.text,
      url: urlController.text,
    );
    clearTextEditingControllers();
    return repository.addHabit(model).whenComplete(
      () async {
        listOfHealthyHabits.assignAll(
          await repository.getAllHealthyHabits(),
        );
        Get.back();
      },
    );
  }

  Future<void> deleteHealthyHabitById(int id) async {
    repository.deleteHealthyHabitById(id).whenComplete(
      () async {
        listOfHealthyHabits.assignAll(
          await repository.getAllHealthyHabits(),
        );
        Get.back();
      },
    );
  }

  Future<void> updateHealthyHabitById(int id) async {
    repository
        .updateHealthyHabitById(
            HealthyHabitModel(
              descricaoTEXT: descriptionController.text,
              nomehabito: nameOfHabitController.text,
              url: urlController.text,
            ),
            id)
        .whenComplete(() async {
      listOfHealthyHabits.assignAll(
        await repository.getAllHealthyHabits(),
      );
      Get.back();
    });
  }

  clearTextEditingControllers() {
    nameOfHabitController.clear();
    descriptionController.clear();
    urlController.clear();
  }
}
