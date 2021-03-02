import 'package:get/instance_manager.dart';
import 'package:larafit/controller/dashboard_controller.dart';
import 'package:larafit/data/provider/atitude_provider.dart';
import 'package:larafit/data/provider/goal_provider.dart';
import 'package:larafit/data/provider/healthy_habit_provider.dart';
import 'package:larafit/data/provider/user_provider.dart';
import 'package:larafit/data/repository/dashboard_repository.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(
      repository: DashboardRepository(
        userProvider: UserProvider(),
        goalProvider: GoalProvider(),
        atitudeProvider: AtitudeProvider(),
        healthyHabitProvider: HealthyHabitProvider(),
      ),
    ));
  }
}
