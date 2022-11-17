import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/auth/auth_bloc.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/routes.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final String title;
  final bool showAppBar;
  final bool showExitButtonOnMobile;

  const BaseScreen({
    Key? key,
    required this.child,
    this.title = Constants.APP_NAME,
    this.showAppBar = true,
    this.showExitButtonOnMobile = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        debugPrint('AuthOrHomeScreen listener!!');
        if (state is AuthUnauthorizedState) {
          debugPrint('unauthorized state!!');
          await Navigator.of(context).pushNamedAndRemoveUntil(
            HospitoqueRouter.AUTH_ROUTE,
            (route) => false,
          );
        }
        if (state is AuthSuccessState) {
          debugPrint('authorized state!!');
          await Navigator.of(context).pushNamedAndRemoveUntil(
            HospitoqueRouter.HOME_ROUTE,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: getAppBar(context),
        body: child,
      ),
    );
  }

  AppBar? getAppBar(BuildContext context) {
    if (!showAppBar) {
      return null;
    }
    if (kIsWeb) {
      return AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
            ),
            TextButton(
              child: Text(
                'Sair',
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              onPressed: () => BlocProvider.of<AuthBloc>(context, listen: false)
                  .add(AuthEventSignOut()),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: null,
      );
    }
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: showExitButtonOnMobile ? [
        TextButton(
          child: Text(
            'Sair',
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          onPressed: () => BlocProvider.of<AuthBloc>(context, listen: false)
              .add(AuthEventSignOut()),
        )
      ] : null,
    );
  }
}
