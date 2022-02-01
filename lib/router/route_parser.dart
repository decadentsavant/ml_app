import 'package:flutter/material.dart';
import 'package:ml_app/router/ui_pages.dart';

class MLParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return splashPageConfig;
    }

    final path = '/${uri.pathSegments[0]}';
    switch (path) {
      case splashPath:
        return splashPageConfig;
      case loginPath:
        return loginPageConfig;
      case createAccountPath:
        return createAccountPageConfig;
      // case newEntryPath:
      //   return newEntryPageConfig;
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

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.splash:
        return const RouteInformation(location: splashPath);
      case Pages.login:
        return const RouteInformation(location: loginPath);
      case Pages.createAccount:
        return const RouteInformation(location: createAccountPath);
      // case Pages.allEntries:
      //   return const RouteInformation(location: allEntriesPath);
      // case Pages.newEntry:
      //   return const RouteInformation(location: newEntryPath);
      // case Pages.todaysReview:
      //   return const RouteInformation(location: todaysReviewPath);
      // case Pages.stats:
      //   return const RouteInformation(location: statsPath);
      // case Pages.account:
      //   return const RouteInformation(location: accountPath);
    }
  }
}
