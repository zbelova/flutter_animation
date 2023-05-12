import 'package:flutter/material.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({Key? key, required this.heroTag, required this.name, required this.points}) : super(key: key);
  final String heroTag;
  final String name;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,

      //backgroundColor: Color(0xffff8e00),
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Текущие очки: $points',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Hero(
                    tag: heroTag,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFffffff), width: 3), borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image(
                          image: AssetImage('assets/${heroTag}.jpg'),
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Привезенный подарок',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/gift.jpg'),
                      image: AssetImage('assets/${heroTag}_gift.jpg'),
                    width: 200,
                    fit: BoxFit.fitWidth,
                    ),

                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
