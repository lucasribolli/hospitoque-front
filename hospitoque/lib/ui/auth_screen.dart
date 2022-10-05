import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({ Key? key }) : super(key: key);

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.layoutHeight(0.5)),
            ),
          ),
        ),
        onPressed: () async {
          
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.layoutHeight(1.8)),
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
                'Login with Google',
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
    );
  }
}