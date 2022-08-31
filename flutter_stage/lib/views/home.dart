import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stage/api/apicalls.dart';
import 'package:flutter_stage/views/tagview.dart';
import 'package:flutter_stage/widgets/promoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  List list = [];
  final List _tags = [
    'pc portable',
    'pc gamer',
    'pc portable pro',
    'apple macbook'
  ];

  Future<dynamic>? _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = ApiInstance().getPromo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height + 600,
              color: Color(0xfff9ac66),
              child: Center(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: AnimSearchBar(
                      width: MediaQuery.of(context).size.width - 30,
                      textController: textController,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xffed6b5b),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xffed6b5b),
                      ),
                      onSuffixTap: () {
                        setState(() {
                          _future = ApiInstance()
                              .search(textController.text.toString());
                          //update(textController.text.toString());
                        });
                      },
                    ),
                  ),
                  FutureBuilder(
                    future: _future,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                decoration: BoxDecoration(
                                  color: Color(0xff165945),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(16.0),
                                height: 320.0,
                                width: MediaQuery.of(context).size.width - 50,
                                child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      log(snapshot.data[index].image);
                                      return PromoItem(
                                          model: snapshot.data[index]);
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 35,
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultTabController(
                          length: _tags.length,
                          child: Flexible(
                            child: Scaffold(
                              resizeToAvoidBottomInset: false,
                              appBar: PreferredSize(
                                preferredSize: Size.fromHeight(30.0),
                                child: AppBar(
                                  automaticallyImplyLeading: true,
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  flexibleSpace: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        color: Color(0xfff9ac66),
                                        child: TabBar(
                                          isScrollable: false,
                                          labelStyle: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                          labelColor: Colors.white,
                                          unselectedLabelColor: Colors.black,
                                          indicatorColor: Colors.amberAccent,
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          indicator: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                50), // Creates border
                                            color: Color(0xff165945),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(1,
                                                    4), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          tabs: [
                                            //for each tag add a tab
                                            for (var tag in _tags)
                                              Container(
                                                child: Tab(
                                                  text: tag,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  for (var tag in _tags)
                                    Container(
                                        child: TagView(
                                      tag: tag,
                                    ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
