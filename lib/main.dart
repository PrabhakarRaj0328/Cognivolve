import 'package:cognivolve/blocs/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:cognivolve/screens/landing_page.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomBarBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: GlobalVariables.primaryColor
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: LandingPage(),
      ),
    );
  }
}


