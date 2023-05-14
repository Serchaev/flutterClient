import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/pages/Stateless/Authorization.dart';
import 'package:untitled1/pages/Stateless/NotAuthorization.dart';

import '../main.dart';

class Index extends StatelessWidget{
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    var accessToken = Provider.of<Auth>(context).accessToken;
    var refreshToken = Provider.of<Auth>(context).refreshToken;

    print("accessToken - $accessToken : refreshToken - $refreshToken");
    if (accessToken == "" && refreshToken == "") {
      return NotAuthorization();
    } else {

      return Authorization();
    }
  }



  
}