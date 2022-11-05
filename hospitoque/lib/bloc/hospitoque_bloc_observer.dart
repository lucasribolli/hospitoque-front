import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitoqueBlocObserver extends BlocObserver {
  final String _TAG = '[HospitoqueBlocObserver]';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('$_TAG onCreate: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('$_TAG onChange: ${bloc.runtimeType}, ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('$_TAG onError: ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('$_TAG onClose: ${bloc.runtimeType}');
  }
}