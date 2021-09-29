import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profiles_app/blocs/events/accountCubit.dart';
import 'package:profiles_app/providers/authenticationProfile.dart';
import 'package:profiles_app/screens/homeScreen.dart';
import 'package:profiles_app/widgets/customTextField.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'signUpScreen.dart';


class LoginScreen extends StatefulWidget {
  static final String routeName = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? saveLogin;

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<AccountCubit>(context).isLoginSaved().then((value) => saveLogin = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54, //black54
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text(
              'SignIn',
              style: TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'welcome back',
              textAlign: TextAlign.left,
              style: TextStyle(

              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(100),
                        topRight: Radius.circular(100)
                    )
                ),
                margin: EdgeInsets.only(top: 30,),
                child: Column(
                  children: [
                    // email
                    CustomTextField(
                      label: 'Email',
                      hint: 'test@domain.com',
                      isSecured: false,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: null,
                      controller: _emailField,
                    ),
                    // password
                    CustomTextField(
                        label: 'Password',
                        hint: 'Please enter your password',
                        textInputType: TextInputType.visiblePassword,
                        prefixIcon: Icon(Icons.lock),
                        isSecured: BlocProvider.of<AccountCubit>(context,listen: true).isHidePassword,
                        suffixIcon: IconButton(
                          onPressed: ()=> BlocProvider.of<AccountCubit>(context).hidePassword(),
                          icon: Icon(BlocProvider.of<AccountCubit>(context,listen: true).isHidePassword?Icons.visibility_off:Icons.visibility),
                        ),
                        controller: _passwordField,
                    ),
                    // create account (Text Button)
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: TextButton(
                        onPressed: ()=> Navigator.of(context).pushNamed(SignUpScreen.routeName),
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                    // save login Checkbox
                    Row(
                      children: [
                        Text(
                          'Do you want to save the login ?  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        Checkbox(
                          //activeColor: Colors.red,
                          value: saveLogin,
                          fillColor: MaterialStateProperty.all(Colors.red),
                          onChanged: (newValue) async{
                            await BlocProvider.of<AccountCubit>(context).saveLoginOnMyDevice(saveLogin!);
                          })
                      ],
                    ),
                    // login button
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Builder(
                          builder: (innerContext)=>ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.black),
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            ),
                            onPressed: ()async{
                              // if(_emailField.text.isEmpty){
                              //   Toast.show('Please enter email!', context,duration: 4);
                              // } else if(_passwordField.text.isEmpty){
                              //   Toast.show('Please enter your password!', context,duration: 4);
                              // } else if(!_emailField.text.contains('@')){
                              //   Toast.show('Please enter correct email!\nFor example:  test@domain.com', context,duration: 5);
                              // } else if(_passwordField.text.length <6){
                              //   Toast.show('Please enter strong password, at least 6 letters', context,duration: 4);
                              // } else{
                              //   Navigator.of(context).pushNamed(HomeScreen.routeName);
                              // }
                              try{
                                await Provider.of<AuthenticationProfile>(context,listen: false).login(
                                    _emailField.text, _passwordField.text
                                );
                                Navigator.of(context).pushNamed(HomeScreen.routeName);
                              } catch(error){
                                var errorMessage = 'Authentication failed';
                                if(error.toString().contains('EMAIL_EXISTS'))
                                  errorMessage = 'This email address is already in use';
                                else if(error.toString().contains('INVALID_EMAIL'))
                                  errorMessage = 'This is a not valid email address';
                                else if(error.toString().contains('WEAK_PASSWORD'))
                                  errorMessage = 'This password is too weak';
                                else if(error.toString().contains('EMAIL_NOT_FOUND'))
                                  errorMessage = 'Could not find a user with that email';
                                else if(error.toString().contains('INVALID_PASSWORD'))
                                  errorMessage = 'Invalid password.';

                                Toast.show(errorMessage, context);
                                Navigator.of(context).pushNamed(HomeScreen.routeName);
                              }

                            },

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
