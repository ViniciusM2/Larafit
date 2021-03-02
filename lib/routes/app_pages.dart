import 'package:get/route_manager.dart';
import 'package:larafit/bindings/dashboard_bindings.dart';
import 'package:larafit/ui/user_dashboard/user_dashboard.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: Routes.DASHBOARD,
      page: () => UserDashboardPage(),
      binding: DashboardBinding(),
    )
  ];
}
