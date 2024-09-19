import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Home/bloc/home_bloc.dart';

class HomeNavbarSection extends StatelessWidget {
  const HomeNavbarSection({
    super.key,
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: state is NavbarHiddenState ? -80 : 0,
          left: 0,
          right: 0,
          child: BottomNavigationBar(
            currentIndex: homeBloc.isNavbarVisible ? 0 : 1,
            onTap: (int index) {
              if (index == 0) {
                // Home tapped, do nothing
              } else if (index == 1) {
                // Orders tapped, add navigation to Orders page
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Orders',
              ),
            ],
          ),
        );
      },
    );
  }
}
