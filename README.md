# Ml App

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

---

### Most Learned 🎯

Utilize self-reflection and spaced-repetition to hammer into your brain anything and everything that makes you the better version of you.

1. Enter learnings and assign them a repetition pattern.
2. Visit the 'Today's Review' tab daily to see the curated list for the day.
3. Get wicked smart.

---

### Learning Goals

This app currently serves as my primary project for learning software development. Applied learnings include:

##### Tools

1. VSCode, Android Studio, Xcode
    * various VSCode extensions
    * Vim bindings
2. Git
    * using CLI
3. Firebase
    * Authentication
    * Cloud Firestore
4. CLI
    * Dart/Flutter CLI
    * GitHub CLI tool

##### Dart / Flutter

1. State management
    * Bloc (current)
    * Provider (initial solution)
    * Riverpod (implemented in another repo for learning purposes)
2. Storage
    * Client persistence (Shared Preferences)
    * Cloud Firestore 
    * Utilized repository pattern to easily swap from Shared Pref to cloud (see packages/entries_packages/)
3. Routing
    * FlowBuilder (utilizing GoRouter in another repo for learning purposes)
3. Internal Packages
    * Created packages for auth and entries APIs (see packages/)
4. Graphics
    * Implemented CustomPaint widget to create dynamic circular progress indicator (see Stats page)
5. Select External Packages
    * equatable (heavily utilized in Bloc)
    * json_serializable & build_runner (creation of entries model)
    * flow_builder (currently utilizing GoRouter in another repo and plan to migrate)
    * url_launcher (opening external links)
    * very_good_analysis (a personal preference to utilize VGV's heavily opinionated lints for learning 'best' practices)