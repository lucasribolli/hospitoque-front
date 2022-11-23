import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospitoque/bloc/auth/auth_bloc.dart';
import 'package:hospitoque/ui/hospitoque_dialogs.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _GoogleSignInButton(),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthorizedState) {
          debugPrint('state -> $state');
          showHospitoqueDialog(context,
              content: const Text('Sem permissão de acesso'));
        }
        if (state is AuthSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HospitoqueRouter.HOME_ROUTE,
            (route) => false,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [
                  Colors.white,
                  Colors.red,
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: context.layoutHeight(2.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/large_logo.svg',
                  height: context.layoutHeight(18),
                  width: context.layoutHeight(18),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(context.layoutHeight(0.5)),
                        ),
                      ),
                    ),
                    onPressed: () =>
                        BlocProvider.of<AuthBloc>(context, listen: false)
                            .add(AuthEventSignIn()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.layoutHeight(1.8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/google_logo.svg',
                            fit: BoxFit.contain,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
