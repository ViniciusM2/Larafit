import 'package:get/instance_manager.dart';
import 'package:larafit/controller/healthy_habit_page_controller.dart';
import 'package:larafit/data/provider/healthy_habit_provider.dart';
import 'package:larafit/data/repository/habit_repository.dart';

class HabitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HealthyHabitPageController(
        repository: HabitRepository(
      healthyHabitProvider: HealthyHabitProvider(),
    )
        // repository: DashboardRepository(
        //   userProvider: UserProvider(),
        //   goalProvider: GoalProvider(),
        //   atitudeProvider: AtitudeProvider(),
        //   healthyHabitProvider: HealthyHabitProvider(),
        // ),
        ));
  }
}
