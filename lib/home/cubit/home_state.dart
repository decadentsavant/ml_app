part of 'home_cubit.dart';

enum HomeTab { entries, stats }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.entries,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
