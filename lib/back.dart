import 'package:flutter/material.dart';
import 'next.dart';
import 'const.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'scan.dart';

class Back extends StatefulWidget {
  const Back({Key? key, required this.selectLan, required this.lan})
      : super(key: key);
  final String lan;
  final dynamic selectLan;

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  List ls = [
    ["one", "two"],
    ["three", "four"],
    ["five", "six"],
    ["seven", "eight"],
    ["nine", "ten"],
    ["eleven", "twelve"],
    ["thirteen", "fourteen"],
    ["fifteen", "sixteen"],
    ["seventeen", "eighteen"],
    ["nineteen", "twenty"],
    ["twentyone", "twentytwo"],
    ["twentythree", "twentyfour"]
  ];
  final ScrollController _scrollController = ScrollController();
  double val = 0;
  bool isDark = false;
  BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  Color drColor = Color.fromARGB(255, 60, 71, 71);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? drColor : Colors.transparent,
      appBar: AppBar(
        backgroundColor: isDark ? drColor : Colors.transparent,
        elevation: 0,
        title: Text(
          "Telegid",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: isDark ? Colors.white : Colors.grey[900], fontSize: 25),
        ),
        actions: [
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
                            width: 220,
                            decoration: BoxDecoration(
                              color: isDark ? drColor : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: Text(
                                    widget.lan == "UZ"
                                        ? "Tilni tanlash"
                                        : widget.lan == "RU"
                                            ? "Выберите язык"
                                            : "Select language",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.grey[700],
                                        fontSize: 19),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.selectLan("UZ");
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/images/UZ.png"),
                                    ),
                                    title: Text(
                                      "O'zbek",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.grey[600],
                                          fontSize: 19),
                                    ),
                                    trailing: widget.lan == "UZ"
                                        ? Icon(
                                            Icons.check,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.grey[600],
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.selectLan("RU");
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/images/RU.png"),
                                    ),
                                    title: Text(
                                      "Русский",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.grey[600],
                                          fontSize: 19),
                                    ),
                                    trailing: widget.lan == "RU"
                                        ? Icon(
                                            Icons.check,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.grey[600],
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.selectLan("US");
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/images/EN.png"),
                                    ),
                                    title: Text(
                                      "English",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.grey[600],
                                          fontSize: 19),
                                    ),
                                    trailing: widget.lan == "US"
                                        ? Icon(
                                            Icons.check,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.grey[600],
                                          )
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
              child: Container(
                width: 29,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.lan == "UZ"
                            ? "assets/images/UZ.png"
                            : widget.lan == "RU"
                                ? "assets/images/RU.png"
                                : "assets/images/EN.png"))),
              )),
          InkWell(
            onTap: () {
              setState(() {
                isDark = !isDark;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: isDark ? Colors.white : drColor,
                size: 29,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 2),
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: LinearProgressIndicator(
                  color: isDark
                      ? Colors.white
                      : Color.fromARGB(255, 139, 147, 170),
                  value: val,
                  minHeight: 2,
                  backgroundColor: isDark
                      ? Colors.white.withOpacity(0.4)
                      : Color.fromARGB(255, 139, 147, 170).withOpacity(0.4),
                ))),
      ),
      body: Stack(
        children: [
          NotificationListener(
            onNotification: (t) {
              setState(() {
                val = _scrollController.position.pixels / 342 / 11;
              });
              return true;
            },
            child: ListView.builder(
                itemCount: ls.length,
                controller: _scrollController,
                itemBuilder: ((context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 9.0, top: 9, bottom: 9),
                        child: wd(
                            MediaQuery.of(context).size.width / 2 - 18,
                            "${ls[index][0]}",
                            isDark
                                ? index == 0
                                    ? "${ls[index][0]}-night.jpeg"
                                    : "${ls[index][0]}-night.jpg"
                                : "${ls[index][0]}-day.jpg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 9.0, top: 9, bottom: 9),
                        child: wd(
                            MediaQuery.of(context).size.width / 2 - 18,
                            "${ls[index][1]}",
                            isDark
                                ? "${ls[index][1]}-night.jpg"
                                : "${ls[index][1]}-day.jpg"),
                      ),
                    ],
                  );
                })),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlidingUpPanel(
              boxShadow: [],
              minHeight: 70,
              maxHeight: 190,
              color: Colors.transparent,
              panel: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QRViewExample(
                        isDark: isDark,
                        lan: widget.lan,
                      ),
                    ));
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: isDark
                                  ? Colors.white
                                  : Color.fromARGB(255, 139, 147, 170),
                              blurRadius: 19)
                        ],
                        shape: BoxShape.circle,
                        color: isDark
                            ? Colors.white
                            : Color.fromARGB(255, 143, 159, 196)),
                    child: Center(
                      child: Icon(
                        Icons.qr_code_scanner_outlined,
                        color: isDark ? drColor : Colors.white,
                        size: 39,
                      ),
                    ),
                  ),
                ),
              ),
              collapsed: Center(
                child: Container(
                  height: 12,
                  width: 80,
                  decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white
                          : Color.fromARGB(255, 143, 159, 196),
                      boxShadow: [
                        BoxShadow(
                            color: isDark
                                ? Colors.white
                                : Color.fromARGB(255, 139, 147, 170),
                            blurRadius: 19)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                ),
              ),
              borderRadius: radius,
            ),
          ),
        ],
      ),
    );
  }

  Widget wd(double w, String name, String img) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                      child: Next(
                    isDark: isDark,
                    name: name,
                    lan: widget.lan,
                  ))),
        );
      },
      child: SizedBox(
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: w,
              height: 300,
              decoration: BoxDecoration(
                  color: isDark ? drColor : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[200]!, blurRadius: 5)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/tele-guide.appspot.com/o/$img?alt=media",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: SizedBox(
                              height: 39,
                              width: 39,
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: isDark
                                    ? Colors.white
                                    : Color.fromARGB(255, 143, 159, 196),
                              ))),
                  errorWidget: (context, url, error) => Text(error),
                ),
              ),
            ),
            SizedBox(
              width: w,
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0, top: 9),
                child: Text(
                  names[widget.lan][name],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.grey[900],
                      fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
