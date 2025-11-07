import 'package:careme/presentation/view/details_screen.dart';
import 'package:careme/presentation/view/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/route_names.dart';
import '../presentation/view/edit_customer_screen.dart';
import '../presentation/view/home_screen.dart';
import '../presentation/view/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(path: RouteNames.home, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: RouteNames.search,
        builder: (context, state) => SearchScreen(),
      ),

      GoRoute(
        path: RouteNames.details,
        builder: (context, state) {
          Map<String, String> extra = state.extra as Map<String, String>;
          String title = extra['title'] ?? '';
          String id = extra['id'] ?? '';
          return DetailsScreen(title: title, id: id);
        },
      ),

      GoRoute(
        path: RouteNames.edit,
        builder: (context, state) {
          Map<String, dynamic> customerData =
              state.extra as Map<String, dynamic>;
          return EditCustomerScreen(customerData: customerData);
        },
      ),
    ],
  );
});
