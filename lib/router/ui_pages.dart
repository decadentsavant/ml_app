import 'package:ml_app/router/app_state.dart';

// Constants define the different paths.
const String splashPath = '/splash';
const String loginPath = '/login';
const String createAccountPath = '/createAccount';
const String newEntryPath = '/newEntry';
// const String todaysReviewPath = '/todaysReview';
// const String allEntriesPath = '/allEntries';
// const String statsPath = '/statsPath';
// const String accountPath = '/accountPath';

/// Enum representing the UI for each page
enum Pages {
  splash,
  login,
  createAccount,
  newEntry,
  // todaysReview,
  // allEntries,
  // stats,
  // account,
}

/// Class that combines information for each page, includes
/// [key], [path], [Pages], [currentPageAction]. The latter
/// remembers current page action used for this page.
class PageConfiguration {
  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    this.currentPageAction,
  });

  final String key;
  final String path;
  final Pages uiPage;
  PageAction? currentPageAction;
}

// Use class to hold constant information about each of the pages
// TODO(Corey): null is default so currentPageAction might not need to be there
PageConfiguration splashPageConfig = PageConfiguration(
  key: 'Splash',
  path: splashPath,
  uiPage: Pages.splash,
  // currentPageAction: null,
);
PageConfiguration loginPageConfig = PageConfiguration(
  key: 'Login',
  path: loginPath,
  uiPage: Pages.login,
  // currentPageAction: null,
);
PageConfiguration createAccountPageConfig = PageConfiguration(
  key: '',
  path: createAccountPath,
  uiPage: Pages.createAccount,
// currentPageAction: null,
);
PageConfiguration newEntryPageConfig = PageConfiguration(
  key: 'NewEntry',
  path: newEntryPath,
  uiPage: Pages.newEntry,
  // currentPageAction: null,
);
// PageConfiguration todaysReviewPageConfig = PageConfiguration(
//   key: 'TodaysReview',
//   path: todaysReviewPath,
//   uiPage: Pages.todaysReview,
//   // currentPageAction: null,
// );
// PageConfiguration allEntriesPageConfig = PageConfiguration(
//   key: 'AllEntries',
//   path: allEntriesPath,
//   uiPage: Pages.allEntries,
//   // currentPageAction: null,
// );
// PageConfiguration statsPageConfig = PageConfiguration(
//   key: 'Stats',
//   path: statsPath,
//   uiPage: Pages.stats,
//   // currentPageAction: null,
// );
// PageConfiguration accountPageConfig = PageConfiguration(
//   key: 'Account',
//   path: accountPath,
//   uiPage: Pages.account,
//   // currentPageAction: null,
// );
