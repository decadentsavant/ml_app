part of 'home_cubit.dart';

enum HomeTab { newEntry, all, stats, account }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.newEntry,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
