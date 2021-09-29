import 'dart:convert';

import 'package:dio/dio.dart';

Dio dio = Dio();
String _url = 'https://profile-app-eadf7-default-rtdb.firebaseio.com/profile.json';

class ProfileData{
  final String? profileId;
  final String firstName;
  final String lastName;
  final String? username;
  final String password;
  final String email;
  final String phone;
  final String imageUrl;

  static List<ProfileData> profileDataList = [];

  ProfileData({
    this.profileId,
    this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.firstName,
    required this.lastName
  });

  static postProfileDataOnFirebase(ProfileData profileData) async{

    dio.post(_url,data: json.encode({
      'fullName':profileData.firstName + " " +profileData.lastName,
      'password':profileData.password,
      'email':profileData.email,
      'phone':profileData.phone,
      'username':profileData.username,
      'imageUrl':profileData.imageUrl,
    })).asStream();
    //return response;
  }

  static fetchProfileDataFromFirebase() async{
    final response = await dio.get(_url);
    final allProfilesData = await json.decode(response.data) as Map<String ,dynamic>;
    allProfilesData.forEach((profileId, profileData){
      //print(weatherId.toString());
      profileDataList.add(
        ProfileData(
          profileId: profileId,
          username: profileData['username'],
          password: profileData['password'],
          email: profileData['email'],
          phone: profileData['phone'],
          imageUrl: profileData['imageUrl'],
          firstName: profileData['firstName'],
          lastName: profileData['lastName']
        ),
      );
    });

  }

}