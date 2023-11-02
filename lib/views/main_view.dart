import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_framework_app/views/physical_persons_page.dart';
import 'package:projeto_framework_app/views/legal_persons_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(15);

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.rectangle;

  Color selectedColor = const Color(0xFF1d4491);
  Color unselectedColor = const Color(0xFF1d4491);

  final PageController _myPageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Sym Pay',
          style: GoogleFonts.ibmPlexMono(
              fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView(
        controller: _myPageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          PhysicalPersonsPage(),
          LegalPersonsPage(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: const Color(0xFFd2dae9),
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
          _myPageController.animateToPage(index,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 300));
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person)),
          BottomNavigationBarItem(icon: Icon(Icons.domain))
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
