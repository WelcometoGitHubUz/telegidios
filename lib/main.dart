import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'back.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List ls = [
    {'w': 140, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '1.jpg'},
    {'w': 0, 'd': 400, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '2.jpg'},
    {'w': 0, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '3.jpg'},
    {'w': 0, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '4.jpg'},
    {'w': 0, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '8.jpg'},
    {'w': 0, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '6.jpg'},
    {'w': 0, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '7.png'},
    {'w': 0, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '5.jpg'},
  ];
  List lss = [
    {'w': 140, 'd': 300, 'l': 0, 'r': 0, 't': 0, 'b': 50, 'img': '1.jpg'},
    {'w': 90, 'd': 600, 'l': 0, 'r': 270, 't': 0, 'b': 50, 'img': '2.jpg'},
    {'w': 65, 'd': 800, 'l': 0, 'r': 200, 't': 210, 'b': 0, 'img': '3.jpg'},
    {'w': 85, 'd': 1100, 'l': 80, 'r': 0, 't': 250, 'b': 0, 'img': '4.jpg'},
    {'w': 60, 'd': 1300, 'l': 250, 'r': 0, 't': 50, 'b': 0, 'img': '8.jpg'},
    {'w': 85, 'd': 800, 'l': 280, 'r': 0, 't': 0, 'b': 180, 'img': '6.jpg'},
    {'w': 105, 'd': 800, 'l': 130, 'r': 0, 't': 0, 'b': 350, 'img': '7.png'},
    {'w': 80, 'd': 500, 'l': 0, 'r': 190, 't': 0, 'b': 320, 'img': '5.jpg'},
  ];
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  String lan = "UZ";
  dynamic selectLan(String newLan) {
    setState(() {
      lan = newLan;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        ls = lss;
      });
    });
    return Material(
      child: FlipCard(
        flipOnTouch: false,
        key: cardKey,
        back: Back(
          lan: lan,
          selectLan: selectLan,
        ),
        front: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  children: [
                    for (var i in ls)
                      ls.indexOf(i) != 0
                          ? Align(
                              alignment: Alignment.center,
                              child: wg(ls.indexOf(i)),
                            )
                          : const SizedBox(),
                    Align(
                      alignment: Alignment.center,
                      child: wg(0),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        lan == "UZ"
                            ? "Xush kelibsiz"
                            : lan == "RU"
                                ? "Добро пожаловать"
                                : "Welcome",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[900], fontSize: 22),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: 250,
                        child: Text(
                          lan == "UZ"
                              ? "Keling, Telegid-ga qo'shilib dunyo teleminoralari haqida ma'lumot olaylik"
                              : lan == "RU"
                                  ? "Присоединяйтесь к Телегиду и узнайте больше о телебашнях мира"
                                  : "Let's join Telegid and learn about the world's TV towers",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          cardKey.currentState!.toggleCard();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 19),
                          height: 42,
                          width: 250,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400]!, blurRadius: 5)
                              ],
                              color: Color.fromARGB(255, 143, 159, 196),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(29))),
                          child: Center(
                            child: Text(
                              lan == "UZ"
                                  ? "Boshlash"
                                  : lan == "RU"
                                      ? "Начать"
                                      : "Get started",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 19),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 240,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(19)),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 9),
                                            child: Text(
                                              lan == "UZ"
                                                  ? "Tilni tanlash"
                                                  : lan == "RU"
                                                      ? "Выберите язык"
                                                      : "Select language",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 19),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectLan("UZ");
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/images/UZ.png"),
                                              ),
                                              title: Text(
                                                "O'zbek",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 19),
                                              ),
                                              trailing: lan == "UZ"
                                                  ? const Icon(Icons.check)
                                                  : const SizedBox(),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 19),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey[200]!))),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectLan("RU");
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/images/RU.png"),
                                              ),
                                              title: Text(
                                                "Русский",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 19),
                                              ),
                                              trailing: lan == "RU"
                                                  ? const Icon(Icons.check)
                                                  : const SizedBox(),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 19),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey[200]!))),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectLan("US");
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/images/EN.png"),
                                              ),
                                              title: Text(
                                                "English",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 19),
                                              ),
                                              trailing: lan == "US"
                                                  ? const Icon(Icons.check)
                                                  : const SizedBox(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            lan == "UZ"
                                ? "Tilni tanlash"
                                : lan == "RU"
                                    ? "Выберите язык"
                                    : "Select language",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget wg(int index) {
    return AnimatedContainer(
      width: double.parse(ls[index]['w'].toString()),
      margin: EdgeInsets.only(
          top: double.parse(ls[index]['t'].toString()),
          bottom: double.parse(ls[index]['b'].toString()),
          right: double.parse(ls[index]['r'].toString()),
          left: double.parse(ls[index]['l'].toString())),
      height: double.parse(ls[index]['w'].toString()),
      duration: Duration(milliseconds: ls[index]['d']),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey[400]!, blurRadius: 9)],
          image: DecorationImage(
              image: AssetImage("assets/images/${ls[index]['img']}"),
              fit: BoxFit.cover)),
    );
  }
}
