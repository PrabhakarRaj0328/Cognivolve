import 'package:cognivolve/blocs/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:cognivolve/screens/splash_screen.dart';
import 'package:cognivolve/services/auth_provider.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(create: (_) => AuthProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => BottomBarBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: GlobalVariables.primaryColor),
          fontFamily: 'monospace',
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: SplashScreen(),
      ),
    );
  }
}
