import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AdvanceSplash>(_doChecks);
  }

  Future<dynamic> _doChecks(
    AdvanceSplash event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    //do additional checks here -> check if internet available, etc.
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(SplashLoaded());
  }
}
