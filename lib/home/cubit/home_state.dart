part of 'home_cubit.dart';

enum HomeTab { todaysReview, allEntries, stats }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.todaysReview,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
