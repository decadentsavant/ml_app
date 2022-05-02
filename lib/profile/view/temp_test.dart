// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// // demo image url list
// List<String> _imageUrlList = [
//   'https://live.staticflickr.com/8506/8407172630_18d28a2ed3_c_d.jpg',
//   'https://live.staticflickr.com/8330/8406212067_4802ee432c_c_d.jpg',
//   'https://live.staticflickr.com/8328/8406290529_a422ef077b_c_d.jpg',
//   'https://live.staticflickr.com/8071/8407417316_2b09fe27cf_c_d.jpg',
//   'https://live.staticflickr.com/8226/8407445386_dd416a558b_c_d.jpg',
//   'https://live.staticflickr.com/8046/8407446162_2c8331fde8_c_d.jpg',
//   'https://live.staticflickr.com/8334/8407459084_c59da3d8e0_c_d.jpg',
//   'https://live.staticflickr.com/8370/8406368213_b44c3c5e53_c_d.jpg',
//   'https://live.staticflickr.com/8237/8406383473_d4552a1cb9_c_d.jpg',
//   'https://live.staticflickr.com/8323/8407506118_915f7fb1a1_c_d.jpg',
//   'https://live.staticflickr.com/8077/8406419819_9530514a87_c_d.jpg',
//   'https://live.staticflickr.com/8048/8406431731_6a3962958d_c_d.jpg',
//   'https://live.staticflickr.com/8329/8406514685_2473bd6e90_c_d.jpg',
//   'https://live.staticflickr.com/8506/8407172630_18d28a2ed3_c_d.jpg',
//   'https://live.staticflickr.com/8330/8406212067_4802ee432c_c_d.jpg',
//   'https://live.staticflickr.com/8328/8406290529_a422ef077b_c_d.jpg',
//   'https://live.staticflickr.com/8071/8407417316_2b09fe27cf_c_d.jpg',
//   'https://live.staticflickr.com/8226/8407445386_dd416a558b_c_d.jpg',
//   'https://live.staticflickr.com/8046/8407446162_2c8331fde8_c_d.jpg',
//   'https://live.staticflickr.com/8334/8407459084_c59da3d8e0_c_d.jpg',
//   'https://live.staticflickr.com/8370/8406368213_b44c3c5e53_c_d.jpg',
//   'https://live.staticflickr.com/8237/8406383473_d4552a1cb9_c_d.jpg',
//   'https://live.staticflickr.com/8323/8407506118_915f7fb1a1_c_d.jpg',
//   'https://live.staticflickr.com/8077/8406419819_9530514a87_c_d.jpg',
//   'https://live.staticflickr.com/8048/8406431731_6a3962958d_c_d.jpg',
//   'https://live.staticflickr.com/8329/8406514685_2473bd6e90_c_d.jpg',
// ];

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.blueGrey[700],
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(title: 'Demo of long press popup dialog'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {

//   late OverlayEntry _popupDialog;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: GridView.count(
//         crossAxisCount: 3,
//         childAspectRatio: 1,
//         children: _imageUrlList.map(_createGridTileWidget).toList(),
//       ),
//     );
//   }

//   // create a tile widget from image url
//   Widget _createGridTileWidget(String url) => Builder(
//         // use Builder here in order to show the snakbar
//         builder: (context) => GestureDetector(
//           // keep the OverlayEntry instance, and insert it into Overlay
//           onLongPress: () {
//             _popupDialog = _createPopupDialog(url);
//             Overlay.of(context)!.insert(_popupDialog);
//           },
//           // remove the OverlayEntry from Overlay, so it would be hidden
//           onLongPressEnd: (details) => _popupDialog.remove(),

//           child: Image.network(url, fit: BoxFit.cover),
//         ),
//       );

//   OverlayEntry _createPopupDialog(String url) {
//     return OverlayEntry(
//       builder: (context) => AnimatedDialog(
//         child: _createPopupContent(url),
//       ),
//     );
//   }

//   // this is the main popup dialog content, which includes:
//   // 1. a container with border radius
//   // 2. a title bar
//   // 3. a larger image in the middle
//   // 4. a bottom action bar
//   Widget _createPopupContent(String url) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _createPhotoTitle(),
//               Image.network(url, fit: BoxFit.fitWidth),
//               _createActionBar(),
//             ],
//           ),
//         ),
//       );

//   Widget _createPhotoTitle() => Container(
//         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//         width: double.infinity,
//         color: Theme.of(context).primaryColor,
//         child: const Text(
//           'this is a large image',
//           style: TextStyle(color: Colors.white),
//         ),
//       );

//   Widget _createActionBar() => Container(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         color: Theme.of(context).primaryColor,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: const [
//             Icon(
//               Icons.favorite_border,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.chat_bubble_outline,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.send,
//               color: Colors.white,
//             ),
//           ],
//         ),
//       );
// }

// // This a widget to implement the image scale animation, 
// //and background grey out effect.
// class AnimatedDialog extends StatefulWidget {
//   const AnimatedDialog({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   State<StatefulWidget> createState() => AnimatedDialogState();
// }

// class AnimatedDialogState extends State<AnimatedDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> opacityAnimation;
//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//     scaleAnimation =
//         CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);
//     opacityAnimation = Tween<double>(begin: 0, end: 0.6).animate(
//       CurvedAnimation(parent: controller, curve: Curves.easeOutExpo),
//     );

//     controller.addListener(() => setState(() {}));
//     controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black.withOpacity(opacityAnimation.value),
//       child: Center(
//         child: FadeTransition(
//           opacity: scaleAnimation,
//           child: ScaleTransition(
//             scale: scaleAnimation,
//             child: widget.child,
//           ),
//         ),
//       ),
//     );
//   }
// }
