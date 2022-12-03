import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/auth/auth_bloc.dart';
import 'package:hospitoque/bloc/discard_medicine/discard_medicine_bloc.dart';
import 'package:hospitoque/bloc/hospitoque_bloc_observer.dart';
import 'package:hospitoque/bloc/list_medicine/list_medicine_bloc.dart';
import 'package:hospitoque/bloc/register_medicine/register_medicine_bloc.dart';
import 'package:hospitoque/bloc/search_medicine/search_medicine_bloc.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hospitoque/ui/screens/auth_or_home_screen.dart';

void main() {
  Bloc.observer = HospitoqueBlocObserver();
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
        BlocProvider<SearchMedicineBloc>(
            create: (context) => SearchMedicineBloc()),
        BlocProvider<ListMedicineBloc>(create: (context) => ListMedicineBloc()),
        BlocProvider<RegisterMedicineBloc>(
            create: (context) => RegisterMedicineBloc()),
        BlocProvider<DiscardMedicineBloc>(
            create: (context) => DiscardMedicineBloc()),
      ],
      child: MaterialApp(
        title: Constants.APP_NAME,
        theme: _getAppTheme(context),
        onGenerateRoute: (settings) => HospitoqueRouter.generateRoute(settings),
        debugShowCheckedModeBanner: false,
        home: const AuthOrHomeScreen(),
      ),
    );
  }
}

ThemeData _getAppTheme(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return theme.copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
      accentColor: Colors.red,
    ),
    highlightColor: Colors.black,
  );
}

extension HospitoqueTheme on ThemeData {
  Color get successColor => colorScheme.primary;
}
