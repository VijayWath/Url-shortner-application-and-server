import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('$bloc.runtimeType $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('$bloc.runtimeType $change');
  }
}
