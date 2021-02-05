import 'package:flutter/material.dart';
import 'package:g123_schnell/screens/chamarWhats/ChamarWhats.dart';
import 'package:g123_schnell/screens/Ramos.dart';
import 'package:g123_schnell/screens/destaques/Destaques.dart';
import 'package:g123_schnell/screens/Favoritos.dart';
import 'package:g123_schnell/screens/RightMenu.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class HomePageTeste extends StatefulWidget {
  @override
  _HomePageTesteState createState() => _HomePageTesteState();
}

class _HomePageTesteState extends State<HomePageTeste> with TickerProviderStateMixin {
  //AnimationController _controller;
  MotionTabController _tabController;

  /*int currentTab = 0;
  final List<Widget> screens = [
    Destaques(),
    Ramos(),
    ChamarWhats(),
    TelefonesUteis(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen =
  Destaques();*/

  @override
  void initState() {
    super.initState();

    //_controller = AnimationController(
    //vsync: this, duration: Duration(milliseconds: 2000));

    //_controller.forward();

    _tabController = MotionTabController(initialIndex: 2, vsync: this);
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      //endDrawer: new Menu(),
      //key: _scaffoldKey,
      /*body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),*/
      /*floatingActionButton: FloatingActionButton(
        child:
          Image.asset("imagens/whatsapp.png"),

        backgroundColor: Color.fromRGBO(69, 199, 99, 1.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChamarWhats()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
        bottomNavigationBar: MotionTabBar(
          labels: ["Início", "Home", "Dashboard"],
          initialSelectedTab: "Início",
          tabIconColor: Color.fromRGBO(2, 30, 105, 1.0),
          tabSelectedColor: Color.fromRGBO(208, 0, 27, 1.0),
          onTabItemSelected: (int value) {
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.account_box, Icons.home, Icons.menu],
          textStyle: TextStyle(color: Colors.red),
        ),
        body: MotionTabBarView(
            controller: _tabController, children: <Widget>[
          Container(
            child: Center(
              child: Text("Início"),
            ),
          ),
          Container(
            child: Center(
              child: Text("Home"),
            ),
          ),
          Container(
            child: Center(
              child: Text("Dashboard"),
            ),
          )
        ]));
  }

/* Widget _getBottomBar(scaffoldKey){
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          Destaques(); // if user taps on this dashboard tab will be active
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: currentTab == 0
                            ? Color.fromRGBO(208, 0, 27, 1.0)
                            : Color.fromRGBO(2, 30, 105, 1.0),
                      ),
                      Text(
                        'Início',
                        style: TextStyle(
                          color: currentTab == 0
                              ? Color.fromRGBO(208, 0, 27, 1.0)
                              : Color.fromRGBO(2, 30, 105, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          Ramos(); // if user taps on this dashboard tab will be active
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.format_list_numbered,
                        color: currentTab == 1
                            ? Color.fromRGBO(208, 0, 27, 1.0)
                            : Color.fromRGBO(2, 30, 105, 1.0),
                      ),
                      Text(
                        'Ramos',
                        style: TextStyle(
                          color: currentTab == 1
                              ? Color.fromRGBO(208, 0, 27, 1.0)
                              : Color.fromRGBO(2, 30, 105, 1.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          TelefonesUteis(); // if user taps on this dashboard tab will be active
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.local_hospital,
                        color: currentTab == 2
                            ? Color.fromRGBO(208, 0, 27, 1.0)
                            : Color.fromRGBO(2, 30, 105, 1.0),
                      ),
                      Text(
                        'Úteis',
                        style: TextStyle(
                          color: currentTab == 2
                              ? Color.fromRGBO(208, 0, 27, 1.0)
                              : Color.fromRGBO(2, 30, 105, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.more_horiz,
                        color: currentTab == 3
                            ? Color.fromRGBO(208, 0, 27, 1.0)
                            : Color.fromRGBO(2, 30, 105, 1.0),
                      ),
                      Text(
                        'Mais',
                        style: TextStyle(
                          color: currentTab == 3
                              ? Color.fromRGBO(208, 0, 27, 1.0)
                              : Color.fromRGBO(2, 30, 105, 1.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }*/
}
