import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
}

enum HomeTab { today, all, stats, account }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.today,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
