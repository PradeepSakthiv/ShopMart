import 'dart:math' as math;

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_mart/NavHeader.dart';
import 'package:shop_mart/models/HandShake.dart';
import 'package:shop_mart/models/TermData.dart';
import 'package:shop_mart/network/ApiModel.dart';
import 'package:shop_mart/view/NavItem.dart';
import 'package:shop_mart/view/ProductModel.dart';
import 'package:shop_mart/view/app_clipper.dart';
import 'package:shop_mart/view/const.dart';
import 'network/ApiService.dart';
import 'network/Encryption.dart';
import 'network/Logger.dart';

class BookCard extends StatefulWidget {
  const BookCard({Key? key}) : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  List<ProductModel> shoeList = ProductModel.list;
  List<String> typeList = ProductModel.typeList;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late List<ApiModel>? details = [];
  late HandShakeModel handshake;
  final LoggerFile loggerFile = new LoggerFile();

  //State class
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    details = (await ApiService().getUsers())!.cast<ApiModel>();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        child: ListView(
          children: [
            NavHeader(),
            Divider(),
            NavItem(title: "Interest", icon: Icons.list_alt_outlined),
            NavItem(title: "Support", icon: Icons.support_agent_outlined),
            NavItem(title: "Settings", icon: Icons.settings),
            NavItem(title: "Log out", icon: Icons.logout),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.5,
        toolbarHeight: 75,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.doorbell, color: Colors.black),
              onPressed: () {}),
        ],
        title: Text(
          'Flutter Demo',
        ),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
      ),
      body: details == null || details!.isEmpty
          ? const Center(
              // child: CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              // ),

              child: CupertinoActivityIndicator(
                radius: 15.0,
                color: Colors.black,
              ),
            )
          : SingleChildScrollView(
              child: Column(children: [
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Grid View Static',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold))
                      ])),
              GridView.count(
                padding: const EdgeInsets.all(15),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  getGridItem(Colors.green, Icons.mail),
                  getGridItem(Colors.red, Icons.person),
                  getGridItem(Colors.purple, Icons.settings),
                  getGridItem(Colors.indigo, Icons.deblur_rounded),
                  getGridItem(Colors.teal, Icons.access_time_sharp),
                  getGridItem(Colors.orangeAccent, Icons.add_a_photo),
                  // getGridItem(Colors.brown, Icons.account_box),
                  // getGridItem(Colors.pink, Icons.ad_units_rounded),
                  // getGridItem(Colors.blueGrey, Icons.accessibility),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('List View Dynamic Horizontal',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold))
                      ])),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                height: 250,
                child: ListView.builder(
                  itemCount: shoeList.length,
                  scrollDirection: Axis.horizontal,
                  //physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              new CupertinoAlertDialog(
                                  title: Text("Accept"),
                                  content: Text("Do you want to continue"),
                                  actions: [
                                CupertinoButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      print('Cancelled');
                                      Navigator.of(context).pop();
                                    }),
                                CupertinoButton(
                                  child: Text('I agree'),
                                  onPressed: () async {
                                    handshake =
                                        (await ApiService().getTestDataPost())!;
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((value) => setState(() {}));

                                    print(handshake.body.handshake.publicKey);

                                    String? encryptResult = Cryptom().text(
                                        "GENERIC-TERMS",
                                        handshake.body.handshake.publicKey);

                                    // Term term = Term(id: handshake.body.handshake.id,
                                    //      type: encryptResult);

                                    final term = termToJson(Term(
                                        id: handshake.body.handshake.id,
                                        type: encryptResult));

                                    ApiService().getTerm(term);

                                    Navigator.of(context).pop();
                                  },
                                )
                              ]),
                        );
                      },
                      child: Container(
                        width: 230,
                        margin: EdgeInsets.only(right: 16),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: _buildBackground(index, 230),
                            ),
                            Positioned(
                              bottom: 130,
                              right: 10,
                              child: Hero(
                                tag: "hero${shoeList[index].imgPath}",
                                child: Transform.rotate(
                                  angle: -math.pi / 7,
                                  child: Image(
                                    width: 100,
                                    image: AssetImage(
                                        "assets/${shoeList[index].imgPath}"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('List View Dynamic Vertical',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold))
                      ])),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  // gridDelegate:
                  //SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          padding: EdgeInsets.all(16),
                          height: 100,
                          width: 125,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(details![index].image),
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Text(typeList[index].toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )),
                          alignment: Alignment.center),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Grid View Dynamic',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold))
                      ])),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: PageScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(details![index].image),
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ),
                            ),
                            alignment: Alignment.center),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Image Assets',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold))
                      ])),
              Container(
                  margin: EdgeInsets.all(16),
                  height: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/banner.png'),
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                  )),
            ])),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.black,
        height: 70,
        animationCurve: Curves.easeOut,
        buttonBackgroundColor: AppColors.blueColor,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.history, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          _page = index;
        },
      ),
    );
  }

  Widget _buildBackground(int index, double width) {
    return ClipPath(
      clipper: AppClipper(cornerSize: 25, diagonalHeight: 100),
      child: Container(
        color: shoeList[index].color,
        width: width,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 125,
                    child: Text(
                      "${shoeList[index].name}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${shoeList[index].price}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getGridItem(Color color, IconData icon) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Icon(icon, size: 50),
    );
  }
}
