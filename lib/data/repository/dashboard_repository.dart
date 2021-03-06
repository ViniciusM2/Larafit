import 'package:larafit/data/model/user_model.dart';
import 'package:larafit/data/provider/atitude_provider.dart';
import 'package:larafit/data/provider/goal_provider.dart';
import 'package:larafit/data/provider/healthy_habit_provider.dart';
import 'package:larafit/data/provider/user_provider.dart';
import 'package:meta/meta.dart';

class DashboardRepository {
  UserProvider userProvider;
  GoalProvider goalProvider;
  AtitudeProvider atitudeProvider;
  HealthyHabitProvider healthyHabitProvider;

  DashboardRepository({
    @required this.userProvider,
    @required this.goalProvider,
    @required this.atitudeProvider,
    @required this.healthyHabitProvider,
  }) : assert(
          userProvider != null &&
              goalProvider != null &&
              atitudeProvider != null &&
              healthyHabitProvider != null,
        );

  Future<UserModel> getUser() async {
    return await userProvider.getUser();
  }

  Future<int> countSuccessfulGoals() async {
    return await goalProvider.countSuccessfulGoals();
  }

  Future<int> countAtitudes() {
    return atitudeProvider.countAtitudes();
  }
}
