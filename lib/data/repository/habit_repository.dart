import 'package:larafit/data/model/healthy_habit_model.dart';
import 'package:larafit/data/provider/healthy_habit_provider.dart';
import 'package:meta/meta.dart';

class HabitRepository {
  HealthyHabitProvider healthyHabitProvider;

  HabitRepository({
    @required this.healthyHabitProvider,
  }) : assert(
          healthyHabitProvider != null,
        );

  // Future<UserModel> getUser() async {
  //   return await userProvider.getUser();
  // }

  Future<void> deleteHealthyHabitById(int id) async {
    return healthyHabitProvider.deleteHealthyHabitById(id);
  }

  Future<void> addHabit(HealthyHabitModel healthyHabitModel) {
    return healthyHabitProvider.addHabit(healthyHabitModel);
  }

  Future<List<HealthyHabitModel>> getAllHealthyHabits() async {
    return await healthyHabitProvider.getAllHealthyHabits();
  }

  Future<void> updateHealthyHabitById(HealthyHabitModel model, int id) async {
    return healthyHabitProvider.updateHealthyHabitById(model, id);
  }
}
