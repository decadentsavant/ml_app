import 'package:flutter/material.dart';
import 'package:ml_app/router/ui_pages.dart';


// Delegate used by Router to parse information into any type T, which here
// is PageConfiguration
class MLParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    // 'location' from 'routeInformation` is a String that represents location
    // of the application. Usually strings and slashes, ex. '/', '/path',
    // 'path/to/the/app', etc. Equivalent of URL in web.
    final uri = Uri.parse(routeInformation.location!);
    // Case when launching app
    if (uri.pathSegments.isEmpty) {
      return splashPageConfig;
    }
    // Otherwiseget first path segment...
    final path = '/${uri.pathSegments[0]}';
    // ...then return corresponding PageConfiguration.
    switch (path) {
      case splashPath:
        return splashPageConfig;
      case loginPath:
        return loginPageConfig;
      case createAccountPath:
        return createAccountPageConfig;
      case newEntryPath:
        return newEntryPageConfig;
      // case todaysReviewPath:
      //   return todaysReviewPageConfig;
      // case allEntriesPath:
      //   return allEntriesPageConfig;
      // case statsPath:
      //   return statsPageConfig;
      // case accountPath:
      //   return accountPageConfig;
    }
    throw Exception('Corey - pareseRouteInformation failed. null?');
  }

  // Only needed when opting ofr route information reporting which is mainly
  // used for updating browser history for web apps. In a ways, does opposite
  // of parseRouteInformation method above.
  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.splash:
        return const RouteInformation(location: splashPath);
      case Pages.login:
        return const RouteInformation(location: loginPath);
      case Pages.createAccount:
        return const RouteInformation(location: createAccountPath);
      case Pages.newEntry:
        return const RouteInformation(location: newEntryPath);
      // case Pages.allEntries:
      //   return const RouteInformation(location: allEntriesPath);
      // case Pages.todaysReview:
      //   return const RouteInformation(location: todaysReviewPath);
      // case Pages.stats:
      //   return const RouteInformation(location: statsPath);
      // case Pages.account:
      //   return const RouteInformation(location: accountPath);
    }
  }
}
