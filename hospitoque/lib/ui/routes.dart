import 'package:flutter/material.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/ui/auth_or_home_screen.dart';
import 'package:hospitoque/ui/auth_screen.dart';
import 'package:hospitoque/ui/home_screen.dart';
import 'package:hospitoque/ui/medicine_details_screen.dart';
import 'package:hospitoque/ui/register_medicine_screen.dart';
import 'package:hospitoque/ui/search_medicine_screen.dart';

class HospitoqueRouter {
  static const AUTH_OR_HOME_ROUTE = '/auth-or-home';
  static const AUTH_ROUTE = '/auth';
  static const HOME_ROUTE = '/home';
  static const SEARCH_MEDICINE_ROUTE = '/search-medicine';
  static const MEDICINE_DETAILS_ROUTE = '/medicine-details';
  static const REGISTER_MEDICINE_ROUTE = '/register-medicine';
  static const DISCARD_MEDICINE_ROUTE = '/discard-medicine';
  static const EDIT_MEDICINE_ROUTE = '/edit-medicine';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTH_OR_HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const AuthOrHomeScreen());
      case AUTH_ROUTE:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case SEARCH_MEDICINE_ROUTE:
        return MaterialPageRoute(builder: (_) => const SearchMedicineScreen());
      case MEDICINE_DETAILS_ROUTE:
        return MaterialPageRoute(builder: (_) => MedicineDetailsScreen(medicine: settings.arguments as Medicine));
      case REGISTER_MEDICINE_ROUTE:
        return MaterialPageRoute(builder: (_) => const RegisterMedicineScreen());
      default:
        return _defaultRoute('404');
    }
  }

  static Route<dynamic> _defaultRoute(String text) => MaterialPageRoute(
    builder: (_) => Scaffold(
      body: Center(child: Text(text)),
    ),
  );
}