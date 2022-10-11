import 'package:flutter/material.dart';
import 'package:hospitoque/ui/auth_screen.dart';
import 'package:hospitoque/ui/home_screen.dart';

class HospitoqueRouter {
  static const AUTH_ROUTE = '/';
  static const HOME_ROUTE = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTH_ROUTE:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _defaultRoute('404');
    }
    //   case CONFIRMATION_ROUTE:
    //     if (settings.arguments is ConfirmationScreenArguments) {
    //       final argument = settings.arguments as ConfirmationScreenArguments;
    //       return MaterialPageRoute(
    //         builder: (_) => ConfirmationScreen(
    //           onNoTap: argument.onNoTap,
    //           onYesTap: argument.onYesTap,
    //           text: argument.text,
    //         ),
    //       );
    //     }
    //     return _defaultRoute('No arguments defined for $CONFIRMATION_ROUTE');
    //   default:
    //     return _defaultRoute('No route defined for ${settings.name}');
    // }
  }

  static Route<dynamic> _defaultRoute(String text) => MaterialPageRoute(
    builder: (_) => Scaffold(
      body: Center(child: Text(text)),
    ),
  );
}