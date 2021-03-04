import 'package:get/route_manager.dart';
import 'package:larafit/bindings/dashboard_bindings.dart';
import 'package:larafit/bindings/goals_binding.dart';
import 'package:larafit/bindings/habits_binding.dart';
import 'package:larafit/ui/atitudes/atitudes_page.dart';
import 'package:larafit/ui/goals_page/goals_page.dart';
import 'package:larafit/ui/healthy_habits_page/create_healthy_habit_page.dart';
import 'package:larafit/ui/healthy_habits_page/healthy_habits_page.dart';
import 'package:larafit/ui/user_dashboard/user_dashboard.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: Routes.DASHBOARD,
      page: () => UserDashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.HEALTHY_HABITS,
      page: () => HealthyHabitsPage(),
      binding: HabitBinding(),
    ),
    GetPage(
      name: Routes.CREATE_HEALTHY_HABITS,
      page: () => CreateHealthyHabitPage(),
      binding: HabitBinding(),
    ),
    GetPage(
      name: Routes.GOALS,
      page: () => GoalsPage(),
      binding: GoalsBiding()
    ),
    GetPage(
      name: Routes.ATITUDES,
      page: () => AtitudesPage(),
    ),
  ];
}
