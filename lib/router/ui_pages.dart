import 'package:ml_app/router/app_state.dart';

const String splashPath = '/splash';
const String loginPath = '/login';
const String createAccountPath = '/createAccount';
// const String newEntryPath = '/newEntry';
// const String todaysReviewPath = '/todaysReview';
// const String allEntriesPath = '/allEntries';
// const String statsPath = '/statsPath';
// const String accountPath = '/accountPath';

enum Pages {
  splash,
  login,
  createAccount,
  // newEntry,
  // todaysReview,
  // allEntries,
  // stats,
  // account,
}

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
// PageConfiguration newEntryPageConfig = PageConfiguration(
//   key: 'NewEntry',
//   path: newEntryPath,
//   uiPage: Pages.newEntry,
//   // currentPageAction: null,
// );
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
