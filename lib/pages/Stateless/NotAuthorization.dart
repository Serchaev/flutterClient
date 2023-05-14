import 'package:flutter/material.dart';

class NotAuthorization extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
            "Persons App"
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Приложение для учета сотрудников",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    minimumSize: const Size(1000, 40),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: const Text(
                      "Вход"
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    minimumSize: const Size(1000, 40),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/registration");
                  },
                  child: const Text(
                      "Регистрация"
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}