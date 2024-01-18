import 'package:data_volley_match/core/utils/strings.dart';
import 'package:data_volley_match/features/match_layout/presentation/pages/dataset/all_matches.dart';
import 'package:data_volley_match/features/match_layout/presentation/pages/dataset/all_teams.dart';
import 'package:data_volley_match/features/match_layout/presentation/pages/match/select_teams.dart';
import 'package:data_volley_match/features/match_layout/presentation/pages/match/start_match.dart';
import 'package:data_volley_match/features/registration/presentation/pages/create_account.dart';
import 'package:data_volley_match/features/registration/presentation/pages/login.dart';
import 'package:data_volley_match/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = "/";
  static const String createAccount = "/createAccount";
  static const String login = "/login";
  static const String allMatches = "/allMatches";
  static const String allTeams = "/allTeams";
  static const String selectTeams = "/selectTeams";
  static const String startMatch = "/startMatch";

  Routes._();

  factory Routes() => Routes._();
  Map<String, Route<dynamic> Function(RouteSettings settings)> get routes {
    return {
      initialRoute: (settings) => MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
      createAccount: (settings) => MaterialPageRoute(
            builder: (context) => const CreateAccount(),
          ),
      login: (settings) => MaterialPageRoute(
            builder: (context) => const Login(),
          ),
      allMatches: (settings) => MaterialPageRoute(
            builder: (context) => const AllMatches(),
          ),
      allTeams: (settings) => MaterialPageRoute(
            builder: (context) => const AllTeams(),
          ),
      selectTeams: (settings) => MaterialPageRoute(
            builder: (context) => const SelectTeams(),
          ),
      startMatch: (settings) => MaterialPageRoute(
            builder: (context) => const StartMatch(),
          ),
    };
  }

  Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            MainStrings.undefinedRoute,
            style: Theme.of(_).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}

class OnGenerateRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    final routeBuilder = Routes().routes[settings.name];
    if (routeBuilder == null) {
      return Routes().undefinedRoute();
    }
    return routeBuilder(settings);
  }
}
