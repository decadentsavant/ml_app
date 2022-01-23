import 'package:flutter/material.dart';
import 'package:ml_app/home/home.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const height = 56.0;

    const primaryColor = Colors.orange;
    const secondaryColor = Colors.black54;
    // const accentColor = const Color(0xffffffff);
    final backgroundColor = Colors.white.withOpacity(.2);

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, height + 6),
            painter: BottomNavCurvePainter(backgroundColor: backgroundColor),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              elevation: 0.1,
              onPressed: () =>
                  Navigator.of(context).push(TodaysReviewPage.route()),
              child: const Icon(Icons.shopping_basket),
            ),
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: 'Home',
                  icon: Icons.home_outlined,
                  selected: true,
                  onPressed: () =>
                      Navigator.of(context).push(NewEntryPage.route()),
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                  text: 'Search',
                  icon: Icons.search_outlined,
                  selected: false,
                  onPressed: () =>
                      Navigator.of(context).push(AllEntriesPage.route()),
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                const SizedBox(width: 56),
                NavBarIcon(
                  text: 'Cart',
                  icon: Icons.local_grocery_store_outlined,
                  selected: false,
                  onPressed: () =>
                      Navigator.of(context).push(StatsPage.route()),
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                  text: 'Calendar',
                  icon: Icons.date_range_outlined,
                  selected: false,
                  onPressed: () =>
                      Navigator.of(context).push(AccountPage.route()),
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter({
    this.backgroundColor = Colors.white,
    this.insetRadius = 38,
  });

  Color backgroundColor;
  double insetRadius;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, 12);

    final insetCurveBeginnningX = size.width / 2 - insetRadius;
    final insetCurveEndX = size.width / 2 + insetRadius;
    final transitionToInsetCurveWidth = size.width * .05;
    path
      ..quadraticBezierTo(
        size.width * 0.20,
        0,
        insetCurveBeginnningX - transitionToInsetCurveWidth,
        0,
      )
      ..quadraticBezierTo(
        insetCurveBeginnningX,
        0,
        insetCurveBeginnningX,
        insetRadius / 2,
      )
      ..arcToPoint(
        Offset(insetCurveEndX, insetRadius / 2),
        radius: const Radius.circular(10),
        clockwise: false,
      )
      ..quadraticBezierTo(
        insetCurveEndX,
        0,
        insetCurveEndX + transitionToInsetCurveWidth,
        0,
      )
      ..quadraticBezierTo(size.width * 0.80, 0, size.width, 12)
      ..lineTo(size.width, size.height + 56)
      ..lineTo(
        0,
        size.height + 56,
      );
//+56 here extends the navbar below app bar to include
//extra space on some screens (iphone 11)
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    this.selectedColor = const Color(0xffFF8527),
    this.defaultColor = Colors.black54,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? selectedColor : defaultColor,
          ),
        ),
      ],
    );
  }
}
