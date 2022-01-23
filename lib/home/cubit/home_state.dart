part of 'home_cubit.dart';

enum HomeTab { newEntry, all, daily, stats, account }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.daily,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
