import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larafit/data/model/goal_model.dart';
import 'package:larafit/data/repository/goal_repository.dart';
import 'package:meta/meta.dart';

class GoalPageController extends GetxController {
  final GoalRepository repository;
  GoalPageController({@required this.repository})
      : assert(repository != null);

  final _nameOfUser = ''.obs;
  get nameOfUser => this._nameOfUser.value;
  set nameOfUser(value) => this._nameOfUser.value = value;

  var listOfGoals = <GoalModel>[].obs;

  @override
  void onInit() async {
    listOfGoals.assignAll(await repository.getAllGoals());
    print(listOfGoals);
    super.onInit();
  }

  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataComecoController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();
  TextEditingController urlImagemController = TextEditingController();

  Future<void> addGoal() {
    var model = GoalModel(
    description: descricaoController.text,
    startDate: dataComecoController.text,
    finalDate: dataFinalController.text,
    url: urlImagemController.text
    );
    clearTextEditingControllers();
    return repository.addGoal(model).whenComplete(
      () async {
        listOfGoals.assignAll(
          await repository.getAllGoals(),
        );
        Get.back();
      },
    );
  }

  Future<void> deleteGoalById(int id) async {
    repository.deleteGoalById(id).whenComplete(
      () async {
        listOfGoals.assignAll(
          await repository.getAllGoals(),
        );
        Get.back();
      },
    );
  }

  Future<void> updateGoalById(int id) async {
    repository
        .updateGoalById(
            GoalModel(
              idGoal: id,
              startDate: dataComecoController.text,
              finalDate: dataFinalController.text,
              url: urlImagemController.text,
              description: descricaoController.text
            ),
            id)
        .whenComplete(() async {
      listOfGoals.assignAll(
        await repository.getAllGoals(),
      );
      Get.back();
    });
  }

  clearTextEditingControllers() {
    dataFinalController.clear();
    dataComecoController.clear();
    urlImagemController.clear();
    descricaoController.clear();
  }
}
