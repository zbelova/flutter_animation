import 'package:flutter/material.dart';

class CarPage extends StatelessWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Приз',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'АВТОМОБИЛЬ!!!',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            SizedBox(height: 20,),
            Image(
              image: AssetImage('assets/car.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
