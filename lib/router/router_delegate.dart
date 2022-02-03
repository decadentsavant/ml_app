import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:ml_app/account/account.dart.dart';
// import 'package:ml_app/all_entries/all_entries.dart';
// import 'package:ml_app/create_account/create_account.dart';
import 'package:ml_app/create_account/view/view.dart';
import 'package:ml_app/login/login.dart';
import 'package:ml_app/new_entry/new_entry.dart';
import 'package:ml_app/router/app_state.dart';
import 'package:ml_app/router/ui_pages.dart';
import 'package:ml_app/splash/splash.dart';
// import 'package:ml_app/stats/stats.dart';
// import 'package:ml_app/todays_review/todays_review.dart';

class MLRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  MLRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(notifyListeners);
  }

  /// List of pages is core of app's navigation and denotes the current list of
  /// pages in the navigation stack.
  final List<Page> _pages = [];

  final AppState appState;

  /// [PopNavigatorRouterDelegateMixin] requires a [navigatorKey] used for
  /// retrieving the current navigator of the [Router]. Important that its
  /// only created once.
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// Getter for a list that cannot be changed.
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  /// Number of pages function.
  int numPages() => _pages.length;

  /// Is called by [Router] when it detects route information may have changed.
  /// 'current' means the top most page of app i.e. [_pages].last. Returns the
  /// configuration of type [PageConfiguration] as defined when creating
  /// routerDelegate<PageConfiguration> in [MLRouterDelegate] constructor. The
  /// [currentConfiguration] for this last page can be accessed as 
  /// _pages.last.arguments.
  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments! as PageConfiguration;

  /// Called by [RouterDelegate] to obtain the widget tree that represents
  /// the current state. In this app, the current state is the navigation
  /// history of the app.
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      // Tells Navigator what to do when app requests removal of page via back
      // button.
      onPopPage: _onPopPage,
      // Call to return the current list of pages representing this app's
      // navigation stack. 
      pages: buildPages(),
    );
  }

  // Called when pop is invoked, but current Route corresponds to a Page
  // found in the pages list.
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void _removePage(Page<dynamic>? page) {
    if (page != null) {
      _pages.remove(page);
    }
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }
  // 'key' -> ex. String 'Splash'
  // 'name' is path -> String '/splash' 
  // 'arguments' passes through the PageConfiguration to easily access it, 
  //  if needed.
  // 'child' is the UI widget.
  MaterialPage _createPage(Widget? child, PageConfiguration? pageConfig) {
    return MaterialPage<dynamic>(
      key: ValueKey(pageConfig?.key),
      name: pageConfig?.path,
      arguments: pageConfig,
      child: child!,
    );
  }

  // Adds page to navigation stack.
  void _addPageData(Widget? child, PageConfiguration? pageConfig) {
    _pages.add(_createPage(child, pageConfig));
  }

  // Public method to add page. Also, see pushWidget().
  void addPage(PageConfiguration? pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        // Make sure we don't duplicate pages
        (_pages.last.arguments! as PageConfiguration).uiPage !=
            pageConfig?.uiPage;
    if (shouldAddPage) {
      switch (pageConfig?.uiPage) {
        case Pages.splash:
          _addPageData(const SplashPage(), splashPageConfig);
          break;
        case Pages.login:
          _addPageData(const LoginPage(), loginPageConfig);
          break;
        case Pages.createAccount:
          _addPageData(const CreateAccountPage(), createAccountPageConfig);
          break;
        case Pages.newEntry:
          _addPageData(const NewEntryPage(), newEntryPageConfig);
          break;
        // case Pages.todaysReview:
        //   _addPageData(const TodaysReviewPage(), newEntryPageConfig);
        //   break;
        // case Pages.allEntries:
        //   _addPageData(const AllEntriesPage(), allEntriesPageConfig);
        //   break;
        // case Pages.stats:
        //   _addPageData(const StatsPage(), statsPageConfig);
        //   break;
        // case Pages.account:
        //   _addPageData(const AccountPage(), accountPageConfig);
        // break;
        case null:
          break;
      }
      return;
    }
  }

  void replace(PageConfiguration? newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages
      ..clear()
      ..addAll(path);
  }

  void replaceAll(PageConfiguration? newRoute) {
    setNewRoutePath(newRoute);
  }

  // same as add page, but with different name to be in line with Flutter's push/pop
  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  // Allows adding a new widget using the argumnet of type Widget.
  // Use for pages you dont use addPage for.
  void pushWidget(Widget? child, PageConfiguration? newRoute) {
    _addPageData(child, newRoute);
  }

  // Adds a list of pages
  void addAll(List<PageConfiguration>? routes) {
    _pages.clear();
    routes!.forEach(addPage);
  }

  // Clears the list and adds a new page, replacing all pages there before.
  @override
  Future<void> setNewRoutePath(PageConfiguration? configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments! as PageConfiguration).uiPage !=
            configuration?.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
  // Not sure why this is necessary.
    return SynchronousFuture(null);
  }

  // Records action associated with the page.
  void _setPageAction(PageAction action) {
    switch (action.page?.uiPage) {
      case Pages.splash:
        splashPageConfig.currentPageAction = action;
        break;
      case Pages.login:
        loginPageConfig.currentPageAction = action;
        break;
      case Pages.createAccount:
        createAccountPageConfig.currentPageAction = action;
        break;
      case Pages.newEntry:
        newEntryPageConfig.currentPageAction = action;
        break;
      // case Pages.allEntries:
      //   allEntriesPageConfig.currentPageAction = action;
      //   break;
      // case Pages.todaysReview:
      //   todaysReviewPageConfig.currentPageAction = action;
      //   break;
      // case Pages.stats:
      //   statsPageConfig.currentPageAction = action;
      //   break;
      // case Pages.account:
      //   accountPageConfig.currentPageAction = action;
      //   break;
      case null:
        break;
    }
    return;
  }

  // Returns a list of pages based on current app state
  List<Page> buildPages() {
    if (!appState.splashFinished) {
      replaceAll(splashPageConfig);
    } else {
      switch (appState.currentAction.state) {
        case PageState.none:
          break;
        case PageState.addPage:
          _setPageAction(appState.currentAction);
          addPage(appState.currentAction.page);
          break;
        case PageState.pop:
          pop();
          break;
        case PageState.replace:
          _setPageAction(appState.currentAction);
          replace(appState.currentAction.page);
          break;
        case PageState.replaceAll:
          _setPageAction(appState.currentAction);
          replaceAll(appState.currentAction.page);
          break;
        case PageState.addWidget:
          _setPageAction(appState.currentAction);
          pushWidget(
            appState.currentAction.widget,
            appState.currentAction.page,
          );
          break;
        case PageState.addAll:
          addAll(appState.currentAction.pages);
      }
    }
    // Resets page state to 'none' (default in PageAction).
    appState.resetCurrentAction();
    return List.of(_pages);
  }

  // see https://www.raywenderlich.com/19457817-flutter-navigator-2-0-and-deep-links
  // to handle deep linking in this method
  void parseRoute(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      setNewRoutePath(splashPageConfig);
      return;
    }
  }
}
