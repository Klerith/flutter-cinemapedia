import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';




class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  // final Widget childView;
  final int pageIndex;

  const HomeScreen({
    super.key, 
    // required this.childView
    this.pageIndex = 0
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: HomeView(),
      // body: childView,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}

