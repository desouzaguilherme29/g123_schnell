import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:g123_schnell/screens/chamarWhats/ChamarWhats.dart';
import 'package:g123_schnell/screens/Ramos.dart';
import 'package:g123_schnell/screens/destaques/Destaques.dart';
import 'package:g123_schnell/screens/Favoritos.dart';
import 'package:g123_schnell/screens/RightMenu.dart';
import 'package:g123_schnell/screens/fonesUteis.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTab = 0;
  final List<Widget> screens = [
    Destaques(),
    Ramos(),
    ChamarWhats(),
    TelefonesUteis(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Destaques();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: new Menu(),
      key: _scaffoldKey,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton:FloatingActionButton(
        child:
        Image.asset("imagens/whatsapp.png"),

        backgroundColor: Color.fromRGBO(69, 199, 99, 1.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChamarWhats()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentTab,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end,
        //new
        hasNotch: true,
        //new
        hasInk: true,
        //new, gives a cute ink effect

        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor:Colors.indigo,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.indigo,
              ),
              title: Text("Início", style: TextStyle(fontFamily: "LatoBlackItalic"))),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.format_list_bulleted,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.format_list_bulleted,
                color: Colors.indigo,
              ),
              title: Text("Ramos", style: TextStyle(fontFamily: "LatoBlackItalic"))),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.local_hospital,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.local_hospital,
                color: Colors.indigo,
              ),
              title: Text("Úteis", style: TextStyle(fontFamily: "LatoBlackItalic"))),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.menu,
                color: Colors.indigo,
              ),
              title: Text("Menu", style: TextStyle(fontFamily: "LatoBlackItalic"),))
        ],
      ),
    );
  }

  void changePage(int index) {
    var intPage;

    switch (index) {
      case 0:
        {
          setState(() {
            currentScreen =
                Destaques(); // if user taps on this dashboard tab will be active
            currentTab = 0;
          });
        }

        break;
      case 1:
        {
          setState(() {
            currentScreen =
                Ramos(); // if user taps on this dashboard tab will be active
            currentTab = 1;
          });
        }
        break;
      case 2:
        {
          setState(() {
            currentScreen =
                TelefonesUteis(); // if user taps on this dashboard tab will be active
            currentTab = 2;
          });
        }
        break;
      case 3:
        {
          _scaffoldKey.currentState.openEndDrawer();
          break;
        }
    }

    setState(() {
      currentTab = index;
    });
  }
}
