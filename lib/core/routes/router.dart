import 'package:flutter/material.dart';
import 'package:quizz_app/core/routes/route_name.dart';
import 'package:quizz_app/features/quizz_page/presentation/ui/homepage/homepage.dart';
import 'package:quizz_app/features/quizz_page/presentation/ui/question_page/question_page.dart';
import '../../features/splash_screen/splash_screen.dart';

class RouteGenerator {
  static pushNamedAndRemoveAll(BuildContext context, String pageName) {
    return Navigator.pushNamed(context, pageName);
  }

  Future<dynamic> pushNamedSms(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  static pushNamedforAdvanceSearch(
      BuildContext context, String pageName, Function filterActionEvent) {
    return Navigator.of(context).pushNamed(pageName);
  }


  static pushReplacementNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushReplacementNamed(context, pageName,
        arguments: arguments);
  }

  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }
  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  // ================================== Routing =============================================

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.homepage:
        return MaterialPageRoute(
          builder: (context) =>  Homepage(),
        );
      case Routes.questionpage:
        return MaterialPageRoute(
          builder: (context) =>  QuestionPage(),
        );

    }
    return null;
  }
}
