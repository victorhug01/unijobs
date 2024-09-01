import 'package:flutter/material.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/theme/theme_color.dart';
import 'package:unijobs/src/views/navigation/home/home_page.dart';
import 'package:unijobs/src/views/navigation/newpost/newpost_page.dart';
import 'package:unijobs/src/views/navigation/profile/profile_page.dart';
import 'package:unijobs/src/views/navigation/search/search_page.dart';

class NavigationBottomNavigation extends StatefulWidget {
  const NavigationBottomNavigation({super.key});

  @override
  State<NavigationBottomNavigation> createState() =>
      _NavigationBottomNavigationState();
}

class _NavigationBottomNavigationState
    extends State<NavigationBottomNavigation> {
  int paginaAtual = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: paginaAtual);
  }

  void setPageActual(page) {
    setState(() {
      paginaAtual = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: setPageActual,
        children: const [
          NewpostPage(),
          MyHomePage(),
          SearchPage(),
          ProfilePage(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: responsive.isMobile ? responsive.width / 1.1 : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorSchemeManagerClass.colorPrimary,
                  ColorSchemeManagerClass.colorSecondary,
                ],
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: paginaAtual,
              elevation: 0,
              onTap: (page) {
                _pageController.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
              selectedItemColor: ColorSchemeManagerClass.colorSecondary,
              unselectedIconTheme:
                  IconThemeData(color: ColorSchemeManagerClass.colorWhite),
              selectedLabelStyle:
                  TextStyle(color: ColorSchemeManagerClass.colorWhite),
              backgroundColor: Colors.transparent,
              unselectedItemColor: ColorSchemeManagerClass.colorWhite,
              showUnselectedLabels: true,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              type: BottomNavigationBarType.fixed,
              
              items: const [
                BottomNavigationBarItem(
                  label: 'Postagem',
                  icon: Icon(Icons.add_circle_outline),
                ),
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                    label: 'Buscar', icon: Icon(Icons.search)),
                BottomNavigationBarItem(
                  label: 'Usuário',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
