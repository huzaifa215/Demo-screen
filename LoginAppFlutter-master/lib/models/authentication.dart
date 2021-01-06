import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class Authentication with ChangeNotifier
{

  Future<void> signUp(String email, String password,String name,String lastname, String phonenumber,String gender) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCy2RVjlIyUoAJtt_7ztWfq6oPTUfGhB3M';

    try{
      final response = await http.post(url, body: json.encode(
          {
            'email' : email,
            'password' : password,
            'name' : name,
            'lastname': lastname,
            'phonenumber':phonenumber,
            'gender':gender,
            'returnSecureToken' : true,
          }
      ));
      final responseData = json.decode(response.body);
//      print(responseData);
      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }

    } catch (error)
    {
      throw error;
    }

  }

  Future<void> logIn(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCy2RVjlIyUoAJtt_7ztWfq6oPTUfGhB3M';

    try{
      final response = await http.post(url, body: json.encode(
          {
            'email' : email,
            'password' : password,
            'returnSecureToken' : true,
          }
      ));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }
//      print(responseData);

    } catch(error)
    {
      throw error;
    }

  }
  Future<void> dataemtry(String gender, String dateofbirth,String favouritedish,String favouritesoccerteam) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyCy2RVjlIyUoAJtt_7ztWfq6oPTUfGhB3M';

    try{
      final response = await http.post(url, body: json.encode(
          {
            'gender' : gender,
            'dateofbirth' : dateofbirth,
            'favouritedish' : favouritedish,
            'favouritesoccerteam': favouritesoccerteam,
            'returnSecureToken' : true,
          }
      ));
      final responseData = json.decode(response.body);
//      print(responseData);
      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }

    } catch (error)
    {
      throw error;
    }

  }
}
