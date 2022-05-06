// import 'dart:async';
// import 'package:flutter/material.dart';

// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   List animations = <dynamic>[];
//   List icons = <dynamic>[
//     Icons.face,
//     Icons.settings,
//     Icons.search,
//   ];

//   late OverlayEntry overlayEntry;

//   GlobalKey _key = GlobalKey();

//   @override
//   void initState() {
    
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     for (int i = 3; i > 0; i--) {
//       animations.add(
//         Tween(begin: 0.0, end: 1.0).animate(
//           CurvedAnimation(
//             curve: Curves.easeOutCubic,
//             parent: animationController,
//           ),
//         ),
//       );
//     }

//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     animationController.removeListener(() {
//       setState(() {});
//     });

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         key: _key,
//         onPressed: showOverlay,
//         child: Icon(Icons.menu),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onLongPressStart: (_) => showOverlay(),
//           onLongPressEnd: (_) => removeOverlay(),
//           child: Icon(
//             (Icons.ac_unit_outlined),
//           ),
//         ),
//       ),
//     );
//   }

//   void showOverlay() async {
//     RenderBox renderBox = _key.currentContext!
//.findRenderObject() as RenderBox;
//     Offset offset = renderBox.localToGlobal(Offset.zero);

//     final OverlayState? overlayState = Overlay.of(context);

//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         left: offset.dx,
//         bottom: renderBox.size.height + 21,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             for (int i = 0; i < animations.length; i++)
//               ScaleTransition(
//                 scale: animations[i] as Animation<double>,
//                 child: FloatingActionButton(
//                   onPressed: () {},
//                   mini: true,
//                   child: Icon(icons[i] as IconData?),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );

//     animationController.addListener(() {
//       overlayState!.setState(() {});
//     });
//     unawaited(animationController.forward());
//     overlayState!.insert(overlayEntry);
//     // await Future<void>.delayed(const Duration(seconds: 1));
//     // unawaited(animationController.reverse());
//   }

//   void removeOverlay() {
//     animationController.reverse();
//   }
// }
