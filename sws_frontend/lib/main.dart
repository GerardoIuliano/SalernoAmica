import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// pagine app
import 'screens/Map.dart';
import 'screens/News.dart';
import 'screens/Introduction.dart';
import 'screens/Events.dart';
import 'screens/Options.dart';

// utilities class
import 'SearchTab.dart';
import 'entity/Servizio.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Introduction(),
    theme: appTheme,
    title: "Salerno Welfare Services",
  ));
}

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF0059B3),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: const Color(0xFF28759E) /* Colors.teal*/
  ,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // fontFamily:
);

int sel = 0;
double? width;
double? height;
final screens = [const HomeScreen(), const Map(), const Events(), const News()];

// Barra di navigazione
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Servizi"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.location_on,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.location_on,
          color: Colors.black,
        ),
        label: "Mappa"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.event,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.event,
          color: Colors.black,
        ),
        label: "Eventi"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.newspaper,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.newspaper,
          color: Colors.black,
        ),
        label: "News"));
    return items;
  }

  //manuelle cuozzo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.black,
          selectedItemColor: appTheme.primaryColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel) {
              setState(() {
                sel = index;
              });
            }
          },
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigation.selIndex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    double h = 50;
    double w = 50;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Hai bisogno di più informazioni?"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[Text("info")],
                ),
              );
            },
          );
        },
        backgroundColor: appTheme.primaryColor.withOpacity(.9),
        child: const Icon(Icons.info_outlined),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[const HomeTop(), homeDown, homeDown],
        ),
      ),
    );
  }
}

// selezione servizi
var selectedService = 0;
List<String> services = ['Mensa', 'Taxi', 'Mensa'];

class HomeTop extends StatefulWidget {
  const HomeTop({super.key});

  @override
  State<HomeTop> createState() => _HomeTop();
}

// parte superiore della Home
class _HomeTop extends State<HomeTop> {
  // Initial Selected Value
  String dropdownvalue = 'Trasporto';
  // List of items in our dropdown menu
  var items = [
    'Trasporto',
    'Mensa',
    'Svago',
    'Assistenza',
  ];

  String dropdownvalue2 = 'Anziani';
  // List of items in our dropdown menu
  var items2 = [
    'Anziani',
    'Giovani',
    'Disabilità Motorie',
    'Autismo',
  ];
  var isServiceSelected = true;
  TextEditingController c = TextEditingController(text: services[2]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            height: height! * .65 < 450 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.account_circle_rounded),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Area Login",
                                  style: TextStyle(),
                                ),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const <Widget>[
                                    Text("form login"),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Options()),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 18,
                ),
                const Text(
                  'Bentornatə!👋\nDi quali servizi\nhai bisogno oggi?',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: c,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: InkWell(
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SearchTab();
                                }));
                              },
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height! * 0.025,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue,
                        dropdownColor: appTheme.primaryColor,
                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue2,
                        dropdownColor: appTheme.primaryColor,
                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),

                        // Array list of items
                        items: items2.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue2 = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Clipper08 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    // ignore: non_constant_identifier_names
    var End = Offset(size.width / 2, size.height - 30.0);
    // ignore: non_constant_identifier_names
    var Control = Offset(size.width / 4, size.height - 50.0);

    path.quadraticBezierTo(Control.dx, Control.dy, End.dx, End.dy);
    // ignore: non_constant_identifier_names
    var End2 = Offset(size.width, size.height - 80.0);
    // ignore: non_constant_identifier_names
    var Control2 = Offset(size.width * .75, size.height - 10.0);

    path.quadraticBezierTo(Control2.dx, Control2.dy, End2.dx, End2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Choice08 extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;
  const Choice08({super.key, this.icon, this.text, this.selected});
  @override
  State<Choice08> createState() => _Choice08State();
}

class _Choice08State extends State<Choice08>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.white.withOpacity(.30),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: width! * .025,
          ),
          Text(
            widget.text!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}

var homeDown = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(
          //   width: width! * 0.05,
          // ),
          const Text(
            "I Servizi più recenti",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            // <-- TextButton
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            iconSize: 28,
          ),
        ],
      ),
    ),
    SizedBox(
      //height: height! * .25 < 170 ? height! * .25 : 170,
      //height: height! * .25 < 300 ? height! * .25 : 300,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 280, minHeight: height! * .10),
        child: ListView.builder(
            itemBuilder: (context, index) => listServices[index],
            shrinkWrap: true,
            padding: const EdgeInsets.all(1.0),
            itemCount: listServices.length,
            scrollDirection: Axis.horizontal),
      ),
    ),
  ],
);

List<Servizio> listServices = [
  const Servizio(
    id: "00001",
    nome: "Mensa",
    contenuto: "Servizio mensa per i senzadimora",
    visibile: true,
    tags: "senzadimora",
    ambito: "SA",
    tipologia: "Mensa",
  ),
  const Servizio(
    id: "00002",
    nome: "Trasporto Anziani",
    contenuto: "Servizio di trasporto per gli anziani",
    visibile: true,
    tags: "anziani",
    ambito: "AZ",
    tipologia: "Trasporto",
  ),
];
