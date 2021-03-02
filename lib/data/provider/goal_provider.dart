import 'package:larafit/data/model/goal_model.dart';

class GoalProvider {
  Future<List<GoalModel>> getAllGoals() async {
    try {} catch (_) {}
  }

  Future<GoalModel> getGoalById() {
    try {} catch (_) {}
  }

  Future<GoalModel> deleteGoalById() {
    try {} catch (_) {}
  }

  Future<GoalModel> updateGoalById() {
    try {} catch (_) {}
  }

  Future<int> countGoals() {
    return Future.delayed(Duration(milliseconds: 500)).then((value) => 9);
  }

  Future<int> countSuccessfulGoals() {
    return Future.delayed(Duration(milliseconds: 500)).then((value) => 8);
  }
}
