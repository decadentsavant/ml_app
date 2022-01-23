import 'package:flutter/material.dart';

//NEW ENTRY PAGE
class NewEntryPage extends StatelessWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  static Route<void> route(){
    return MaterialPageRoute(
    builder: (BuildContext context) => const NewEntryView(),);
}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NewEntryView extends StatelessWidget {
  const NewEntryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('NewEntryView'),);
  }
}


// TODAY'S REVIEW PAGE
class TodaysReviewPage extends StatelessWidget {
  const TodaysReviewPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const TodaysReviewView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TodaysReviewView extends StatelessWidget {
  const TodaysReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Todays Review'),
    );
  }
}


//STATS PAGE
class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const StatsView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class StatsView extends StatelessWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Stats'),
    );
  }
}



//All ENTRIES PAGE
class AllEntriesPage extends StatelessWidget {
  const AllEntriesPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const AllEntriesView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('All Entries'),
    );
  }
}


//ACCOUNT PAGE
class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const AccountView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Account Page'),
    );
  }
}
