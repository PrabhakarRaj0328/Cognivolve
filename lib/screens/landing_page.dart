import 'package:cognivolve/blocs/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:cognivolve/screens/home_screen.dart';
import 'package:cognivolve/screens/more_screen.dart';
import 'package:cognivolve/screens/stats_screen.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landingpage';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    StatsScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: GlobalVariables.bgColor,
        body: BlocBuilder<BottomBarBloc, BottomBarState>(
          builder: (context, state) {
            return SafeArea(child: _widgetOptions[state.index]);
          },
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
