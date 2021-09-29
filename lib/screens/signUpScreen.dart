import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profiles_app/blocs/events/accountCubit.dart';
import 'package:profiles_app/classes/profileClass.dart';
import 'package:profiles_app/widgets/customTextField.dart';
import 'package:toast/toast.dart';

import 'homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  static final String routeName = '/SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstNameField = TextEditingController();
  TextEditingController _lastNameField = TextEditingController();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _confirmPasswordField = TextEditingController();
  TextEditingController _phoneField = TextEditingController();
  File? imageFile;


  _uploadImage(BuildContext context ,ImageSource imageSource)async{
    var picture = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showDialogToUploadImage(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Upload Image'),
        actions: [
          ListTile(
            title: Text('From Gallery'),
            onTap: (){
              _uploadImage(context,ImageSource.gallery);
            },
          ),
          ListTile(
            title: Text('From Camera'),
            onTap: (){
              _uploadImage(context ,ImageSource.camera);
            },
          ),
        ],
        scrollable: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red, //black54
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              //topLeft: Radius.circular(35),
                              topRight: Radius.circular(100)
                          )
                      ),
                      margin: EdgeInsets.only(top: 30,),
                      child: Column(
                        children: [
                         Row(
                           children: [
                             // first name
                             Expanded(
                               child: CustomTextField(
                                 label: 'First Name',
                                 hint: 'Enter first name',
                                 isSecured: false,
                                 textInputType: TextInputType.text,
                                 prefixIcon: Icon(Icons.person),
                                 suffixIcon: null,
                                 controller: _firstNameField,
                               ),
                             ),
                             SizedBox(width: 20,),
                             // last name
                             Expanded(child: CustomTextField(
                               label: 'Last Name',
                               hint: 'Enter last name',
                               isSecured: false,
                               textInputType: TextInputType.text,
                               prefixIcon: Icon(Icons.person),
                               suffixIcon: null,
                               controller: _lastNameField,
                             )),
                           ],
                         ),
                          // password
                          CustomTextField(
                            label: 'Password',
                            hint: 'Please enter your password',
                            textInputType: TextInputType.visiblePassword,
                            prefixIcon: Icon(Icons.lock,color: Colors.yellow,),
                            isSecured: BlocProvider.of<AccountCubit>(context,).isHidePassword,
                            suffixIcon: IconButton(
                              onPressed: ()=> BlocProvider.of<AccountCubit>(context).hidePassword(),
                              icon: Icon(BlocProvider.of<AccountCubit>(context).isHidePassword?Icons.visibility_off:Icons.visibility),
                            ),
                            controller: _passwordField,
                          ),
                          // confirm password
                          CustomTextField(
                            label: 'Confirm Password',
                            hint: 'Confirm Password',
                            textInputType: TextInputType.visiblePassword,
                            prefixIcon: Icon(Icons.lock,color: Colors.yellow,),
                            isSecured: BlocProvider.of<AccountCubit>(context,).isHidePassword,
                            suffixIcon: IconButton(
                              onPressed: ()=> BlocProvider.of<AccountCubit>(context,).hidePassword(),
                              icon: Icon(BlocProvider.of<AccountCubit>(context,).isHidePassword?Icons.visibility_off:Icons.visibility),
                            ),
                            controller: _confirmPasswordField,
                          ),
                          // email
                          CustomTextField(
                            label: 'Email',
                            hint: 'ammarabusroor@gmail.com',
                            isSecured: false,
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email_outlined),
                            suffixIcon: null,
                            controller: _emailField,
                          ),
                          // phone
                          CustomTextField(
                            label: 'Phone',
                            hint: '07********',
                            textInputType: TextInputType.phone,
                            prefixIcon: Icon(Icons.phone,color: Colors.green,),
                            isSecured: false,
                            suffixIcon: null,
                            controller: _phoneField,
                          ),
                          // upload image
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  _showDialogToUploadImage(context);
                                },
                                child: Text('Upload Image',style: TextStyle(color: Colors.white),),
                                style: ButtonStyle(
                                  //backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                                ),

                              ),
                              Container(
                                width: 140,
                                height: 160,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                ),
                                child: imageFile == null
                                    ?Center(child: Text('No Image Selected!',style: TextStyle(color: Colors.black),textAlign: TextAlign.center,))
                                    :Image.file(
                                  File(imageFile!.path),
                                  width: 50, height: 80,
                                  errorBuilder: (BuildContext context,Object error,StackTrace? stackTrace,){
                                    return Icon(Icons.image,size: 45,);
                                  },
                                ),
                              ),
                            ],
                          ),
                          // SignUp button
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child: Builder(
                                builder: (innerContext)=>ElevatedButton(
                                  onPressed: ()async{
                                    ProfileData.postProfileDataOnFirebase(
                                        ProfileData(
                                          password: _passwordField.text,
                                          email: _emailField.text,
                                          phone: _phoneField.text,
                                          imageUrl: imageFile!.path,
                                          firstName: _firstNameField.text,
                                          lastName: _lastNameField.text,
                                        ));
                                    BlocProvider.of<AccountCubit>(context).setProfileDate(
                                        ProfileData(
                                          password: _passwordField.text,
                                          email: _emailField.text,
                                          phone: _phoneField.text,
                                          imageUrl: imageFile!.path,
                                          firstName: _firstNameField.text,
                                          lastName: _lastNameField.text,
                                        )
                                    );

                                    if(_firstNameField.text == ''){
                                      Toast.show('Please enter first name!', context);
                                    } else if(_lastNameField.text == ''){
                                      Toast.show('Please enter last name!', context);
                                    } else if(_passwordField.text == ''){
                                      Toast.show('Please enter your password!', context);
                                    } else if(_confirmPasswordField.text == ''){
                                      Toast.show('Please confirm password!', context);
                                    } else if(_emailField.text == ''){
                                      Toast.show('Please enter your email!', context);
                                    } else if(_phoneField.text == ''){
                                      Toast.show('Please phone number!', context,duration: 4);
                                    } else if(imageFile == null){
                                      Toast.show('Please upload image!', context,duration: 4);
                                    } else if(_passwordField.text.length <6){
                                      Toast.show('Please enter strong password, at least 6 letters', context,duration: 4);
                                    } else if(_confirmPasswordField.text != _passwordField.text){
                                      Toast.show('password and confirm password do not match', context,duration: 4);
                                    } else if(!_emailField.text.contains('@')){
                                      Toast.show('Please enter correct email!\nFor example:  test@domain.com', context,duration: 4);
                                    } else{
                                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                                    }


                                    // try{
                                    //   await Provider.of<AuthenticationProfile>(context,listen: false).signUp(
                                    //       _emailField.text, _passwordField.text
                                    //   );
                                    //   Navigator.of(context).pushNamed(HomeScreen.routeName);
                                    // } catch(error){
                                    //   var errorMessage = 'Authentication failed';
                                    //   if(error.toString().contains('EMAIL_EXISTS'))
                                    //     errorMessage = 'This email address is already in use';
                                    //   else if(error.toString().contains('INVALID_EMAIL'))
                                    //     errorMessage = 'This is a not valid email address';
                                    //   else if(error.toString().contains('WEAK_PASSWORD'))
                                    //     errorMessage = 'This password is too weak';
                                    //   else if(error.toString().contains('EMAIL_NOT_FOUND'))
                                    //     errorMessage = 'Could not find a user with that email';
                                    //   else if(error.toString().contains('INVALID_PASSWORD'))
                                    //     errorMessage = 'Invalid password.';
                                    //
                                    //   Toast.show(errorMessage, context);
                                    // }
                                    // Navigator.of(context).pushNamed(HomeScreen.routeName);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.red),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
