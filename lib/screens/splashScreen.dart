import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profiles_app/blocs/events/accountCubit.dart';
import 'package:profiles_app/screens/homeScreen.dart';
import 'package:profiles_app/screens/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomePage();
  }

  navigateToHomePage() async {
    bool? saveLogin;
    BlocProvider.of<AccountCubit>(context)
        .isLoginSaved()
        .then((value) => saveLogin = value!);
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => saveLogin!
            ? HomeScreen()
            : LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage(
                    'assets/images/profile_background_image.jpg',
                  ))),
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  height: 300,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'ITG Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * 0.1,
                left: size.width * 0.36,
                child: Text(
                  'By Ammar Abu Srour',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
