import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profiles_app/blocs/events/accountCubit.dart';
import 'package:profiles_app/blocs/states/accountStates.dart';
import 'package:profiles_app/providers/authenticationProfile.dart';
import 'package:profiles_app/screens/homeScreen.dart';
import 'package:provider/provider.dart';

import 'screens/loginScreen.dart';
import 'screens/signUpScreen.dart';
import 'screens/splashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProfile>(
          create: (ctx)=>AuthenticationProfile(),
        ),
      ],
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (blocContext)=> AccountCubit(),
      child: BlocConsumer<AccountCubit,AccountStates>(
        listener: (listenerContext,listenerState){},
        builder:(builderContext,builderState)=> MaterialApp(
          routes: {
            SignUpScreen.routeName: (context) => SignUpScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            LoginScreen.routeName:(context)=> LoginScreen()
          },
          title: 'Profile App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
              accentColor: Colors.red),
          home: SplashScreen(),

        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
