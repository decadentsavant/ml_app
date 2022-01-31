// import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_entries_api/local_storage_entries_api.dart';
import 'package:ml_app/router/ui_pages.dart';

const String loggedInKey = 'LoggedIn';

enum PageState {
  none,
  addPage,
  addAll,
  addWidget,
  pop,
  replace,
  replaceAll,
}

class PageAction {
  PageAction({
    this.state = PageState.none,
    this.page,
    this.pages,
    this.widget,
  });

  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;
}

class AppState extends ChangeNotifier {
  AppState() {
    getLoggedInState();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  bool _splashFinished = false;
  bool get splashFinished => _splashFinished;
  // final List entries = _todosRepository.getTodos();
  String emailAddress = '';
  String password = '';

  PageAction _currentAction = PageAction();

  PageAction get currentAction => _currentAction;

  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  void resetCurrentAction() {
    _currentAction = PageAction();
  }

  // void addEntry(Entry entry) {
  //   entries.add(entry);
  //   notifyListeners();
  // }

  // void removeEntry(Entry entry) {
  //   entries.add(entry);
  //   notifyListeners();
  // }

  void setSplashFinished() {
    _splashFinished = true;
    if (_loggedIn) {
      _currentAction =
          PageAction(state: PageState.replaceAll, page: todaysReviewPageConfig);
    } else {
      _currentAction =
          PageAction(state: PageState.replaceAll, page: loginPageConfig);
    }
    notifyListeners();
  }

  void login() {
    _loggedIn = true;
    saveLoginState(loggedIn: loggedIn);
    _currentAction =
        PageAction(state: PageState.replaceAll, page: todaysReviewPageConfig);
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    saveLoginState(loggedIn: loggedIn);
    _currentAction =
        PageAction(state: PageState.replaceAll, page: loginPageConfig);
  }

  Future<bool> saveLoginState({required bool loggedIn}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loggedInKey, loggedIn);
    throw Exception('Corey - saveLoginState failed');
  }

  Future<bool> getLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    final dynamic result = prefs.getBool(loggedInKey);
    if (result is bool) {
      _loggedIn = result;
    } else if 
    //might be unnecessary contingency. I don't understand exception yet 
    (result is Exception) {
      throw Exception(
        'Corey - getLoggedInState failed because SharedPrefs getBool',
      );
    }
    throw Exception('Corey - getLoggedInState failed');
  }
}
