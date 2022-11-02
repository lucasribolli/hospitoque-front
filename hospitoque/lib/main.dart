import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/auth/auth_bloc.dart';
import 'package:hospitoque/bloc/search_medicine/search_medicine_bloc.dart';
import 'package:hospitoque/ui/auth_screen.dart';
import 'package:hospitoque/ui/home_screen.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const HospitoqueApp());
}

class HospitoqueApp extends StatelessWidget {
  const HospitoqueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<SearchMedicineBloc>(create: (context) => SearchMedicineBloc()),
      ],
      child: MaterialApp(
        title: 'Hospitoque',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => HospitoqueRouter.generateRoute(settings),
        home: const HomeScreen(),
      ),
    );
  }
}