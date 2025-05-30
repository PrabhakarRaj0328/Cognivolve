import 'package:cognivolve/blocs/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final BottomBarBloc bottomBarBloc = context.read<BottomBarBloc>();

    return BlocBuilder<BottomBarBloc, BottomBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          elevation: 10,
          onTap: (index) => {bottomBarBloc.add(BottomBarIndexChanged(index))},
          currentIndex: state.index,
          selectedItemColor: GlobalVariables.iconColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.blueGrey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_data_bar_vertical_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_data_bar_vertical_filled),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_more_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_more_filled),
              label: 'More',
            ),
          ],
        );
      },
    );
  }
}