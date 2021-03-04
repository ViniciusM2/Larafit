import 'package:get/instance_manager.dart';
import 'package:larafit/controller/goal_page_controller.dart';
import 'package:larafit/data/provider/goal_provider.dart';
import 'package:larafit/data/repository/goal_repository.dart';


class GoalsBiding implements Bindings {
  @override
  void dependencies() {
    Get.put(GoalPageController(
        repository: GoalRepository(
      goalProvider: GoalProvider(),
    )
        // repository: DashboardRepository(
        //   userProvider: UserProvider(),
        //   goalProvider: GoalProvider(),
        //   atitudeProvider: AtitudeProvider(),
        //   GoalProvider: GoalProvider(),
        // ),
        ));
  }
}
