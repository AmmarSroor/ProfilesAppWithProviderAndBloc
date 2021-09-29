import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthenticationProfile with ChangeNotifier{

  Future<void> _authenticate (String email ,String password ,String urlSegment)async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCNlhDn9_9ikOgOX3BNDkvB2VUTehRI6dY';

    try{
      final response = await http.post(Uri(path: url),body: json.encode({
        'email':email,
        'password':password,
        'returnSecureToken':true
      }));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw '${responseData['error']['message']}';
      }
    }catch(e){
      print(e);
      throw e;
    }
    notifyListeners();
  }

  Future<void> login(String email ,String password )async{
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email ,String password )async{
    return _authenticate(email, password, 'signUp');
  }

}