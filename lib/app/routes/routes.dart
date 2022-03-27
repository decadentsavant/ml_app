import 'package:flutter/widgets.dart';
import 'package:ml_app/app/app.dart';
import 'package:ml_app/home/home.dart';
import 'package:ml_app/login/login.dart';


List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
