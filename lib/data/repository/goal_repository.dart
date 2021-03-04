import 'package:larafit/data/model/goal_model.dart';
import 'package:larafit/data/provider/goal_provider.dart';
import 'package:meta/meta.dart';

class GoalRepository {
  GoalProvider goalProvider;

  GoalRepository({
    @required this.goalProvider,
  }) : assert(
          goalProvider != null,
        );

  // Future<UserModel> getUser() async {
  //   return await userProvider.getUser();
  // }

  Future<void> deleteGoalById(int id) async {
    return goalProvider.deleteGoalById(id);
  }

  Future<void> addGoal(GoalModel goalModel) {
    return goalProvider.addGoal(goalModel);
  }

  Future<List<GoalModel>> getAllGoals() async {
    return await goalProvider.getAllGoals();
  }

  Future<void> updateGoalById(GoalModel model, int id) async {
    return goalProvider.updateGoalById(model, id);
  }
}
