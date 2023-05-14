import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Authorization extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var accessToken = Provider.of<Auth>(context).accessToken;
    var refreshToken = Provider.of<Auth>(context).refreshToken;
    var auth = Provider.of<Auth>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: const Text(
            "Persons App",
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Приложение для учета сотрудников",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/positions");
                      },
                      child: const Text(
                          "Должности"
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/employees");
                      },
                      child: const Text(
                          "Сотрудники"
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87
                ),
                onPressed: () {
                  auth.clearData();
                },
                child: const Text(
                    "Выход из аккаунта"
                ),
              ),
            ],
          ),
        )
    );
  }

}