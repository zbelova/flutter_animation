import 'package:flutter/material.dart';
import 'package:hw13_animation/car.dart';
import 'package:hw13_animation/hero_page.dart';

void main() {
  runApp(const AnimationApp());
}

class AnimationApp extends StatelessWidget {
  const AnimationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Анимация',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationHomePage(title: 'Капитал шоу'),
    );
  }
}

class AnimationHomePage extends StatefulWidget {
  AnimationHomePage({super.key, required this.title});

  final String title;

  @override
  State<AnimationHomePage> createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage> with TickerProviderStateMixin {
  var players = [
    ['piglet', 'Пятачок', 1100],
    ['owl', "Совунья", 1600],
    ['karlson', 'Карлсон', 200],
  ];
  var avatar = const AssetImage('assets/default.jpg');
  var baraban = const AssetImage('assets/prebaraban.jpg');
  var piglet_gift = const AssetImage('assets/piglet_gift.jpg');
  var owl_gift = const AssetImage('assets/owl_gift.jpg');
  var karlson_gift = const AssetImage('assets/karlson_gift.jpg');
  var gift = const AssetImage('assets/gift.jpg');
  bool arrowUp = false;
  bool dropDownExpanded = false;
  late final AnimationController _controller;
  late final Animation<Offset> _animation;
  late final AnimationController _rotationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.6),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      precacheImage(avatar, context);
      precacheImage(baraban, context);
      precacheImage(karlson_gift, context);
      precacheImage(piglet_gift, context);
      precacheImage(owl_gift, context);
      precacheImage(gift, context);
    }

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(flex: 3,
              child: buildTopRow(context),
            ),
            Expanded(
              flex: 5,
              child: buildBaraban(),
            ),
            Expanded(
              flex: 2,
              child: buildPlayers(context),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget buildTopRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: buildYakubovichColumn(context),
        ),
        Expanded(
          flex: 4,
          child: buildQuestionColumn(context),
        ),
      ],
    );
  }

  Padding buildQuestionColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Что хранится в горшочке?',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          buildSquares(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: SlideTransition(
                        position: _animation,
                        child: dropDownExpanded
                            ? const FractionallySizedBox(
                                widthFactor: 0.98,
                                child: Card(
                                    elevation: 3,
                                    child: SizedBox(
                                      //height: 50,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        child: Text(
                                          'Мёд',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    )),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                        elevation: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Показать ответ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    arrowUp = !arrowUp;
                                    if (arrowUp) {
                                      dropDownExpanded = !dropDownExpanded;
                                      _controller.forward();
                                    } else {
                                      _controller.reverse().whenComplete(() {
                                        setState(() {
                                          dropDownExpanded = !dropDownExpanded;
                                        });
                                      });
                                      // answerExpanded = !answerExpanded;
                                    }
                                  },
                                );
                              },
                              icon: AnimatedRotation(
                                turns: arrowUp ? 0 : 0.5,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(Icons.arrow_downward),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildSquares() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: const Color(0xff39d1ff), width: 3), color: Colors.blue),
          child: const SizedBox(
            width: 20,
            height: 30,
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: const Color(0xff39d1ff), width: 3), color: Colors.blue),
          child: const SizedBox(
            width: 20,
            height: 30,
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: const Color(0xff39d1ff), width: 3), color: Colors.blue),
          child: const SizedBox(
            width: 20,
            height: 30,
          ),
        ),
      ],
    );
  }

  Column buildYakubovichColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeInImage(
          placeholder: AssetImage('assets/default.jpg'),
          image: AssetImage(
            'assets/yakubovich.jpg',
          ),
          height: 120,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              reverseTransitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (context, animation, secondaryAnimation) => const CarPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0, 1);
                const end = Offset.zero;
                const curve = Curves.bounceOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          ),
          child: const Text('Сектор ПРИЗ'),
        ),
      ],
    );
  }

  Widget buildBaraban() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              size: 30,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  if (_rotationController.isAnimating) {
                    _rotationController.stop(); // Stop the animation
                  } else {
                    _rotationController.repeat(); // Start the animation
                  }
                },
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Column(
                    children: const [
                      ClipOval(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: FadeInImage(
                            placeholder: AssetImage('assets/prebaraban.jpg'),
                            image: AssetImage(
                              'assets/барабан1.jpg',
                            ),
                            fit: BoxFit.fitWidth,
                            height: 400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPlayers(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (List player in players) ...[
          Expanded(
            child: buildHero(
              context,
              player[0],
              player[1],
              player[2],
            ),
          )
        ]
      ],
    );
  }

  Hero buildHero(BuildContext context, String heroTag, String name, int points) {
    return Hero(
      tag: heroTag,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              reverseTransitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (context, animation, secondaryAnimation) => PointsScreen(heroTag: heroTag, name: name, points: points),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }),
        ),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: const Color(0xFFFFFFFF), width: 3), borderRadius: BorderRadius.circular(20.0), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: AspectRatio(
              aspectRatio: 0.4,
              child: FadeInImage(
                placeholder: const AssetImage('assets/default.jpg'),
                image: AssetImage(
                  'assets/${heroTag}.jpg',
                ),
                height: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
