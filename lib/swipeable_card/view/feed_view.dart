import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card/swipeable_card/controller/provider.dart';
import 'package:swipeable_card/swipeable_card/models/feed_model.dart';
import 'package:swipeable_card/swipeable_card/view/feed_card.dart';

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  PageController _pageController = PageController();
  Duration pageTurnDuration = Duration(milliseconds: 0);
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ));

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    FeedModel feedModel= FeedModel.fromJson(jsonDecode(response));
    Provider.of<FeedProvider>(context, listen: false).setFeedData(feedModel.data);
    Provider.of<FeedProvider>(context, listen: false).setFeedDataAll(feedModel.data);
    Provider.of<FeedProvider>(context, listen: false).setFilter(2);
    print(feedModel.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FeedProvider>(builder: (context, feedProvider, child) {
          return feedProvider.feedData == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        feedProvider.setShowAppBar(!feedProvider.showAppBar);
                      },
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: feedProvider.feedData.length,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return Draggable(
                              axis: Axis.vertical,
                              feedback: FeedCard(
                                feedData: feedProvider.feedData[index],
                              ),
                              affinity: Axis.vertical,
                              onDragEnd: (int) {
                                print(int.offset.direction > 1);
                                if (int.offset.direction < 1) {
                                  _pageController.jumpToPage(index + 1);
                                } else if (int.offset.direction > 1) {
                                  _pageController.jumpToPage(index - 1);
                                }
                              },
                              key: UniqueKey(),
                              child: FeedCard(
                                index: index,
                                feedData: feedProvider.feedData[index],
                              ));
                        },
                      ),
                    ),
                    if (Provider.of<FeedProvider>(context, listen: true)
                        .showAppBar)
                      Positioned(
                        top: 10,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white.withOpacity(0.4)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 40,
                                    color: Color(0xff0CCBC4),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          96,
                                      child: Center(
                                          child: Text(
                                        "Current Affairs",
                                        style: TextStyle(fontSize: 22),
                                      ))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (feedProvider.showAppBar)
                      Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50))),
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  feedProvider
                                      .setFilter(0);
                                  feedProvider
                                      .setFilterUnRead();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Padding(
                                            child: Image.asset(
                                              "assets/double_check.png",
                                              color: Colors.black,
                                            ),
                                            padding: EdgeInsets.all(8),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            feedProvider
                                                .setFilter(1);
                                            feedProvider
                                                .setFilterRead();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Padding(
                                              child: Image.asset(
                                                "assets/double_check.png",
                                                color: Color(0xff0CCBC4),
                                              ),
                                              padding: EdgeInsets.all(8),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            feedProvider
                                                .setFilter(1);
                                            feedProvider
                                                .setFilterAll();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xff0CCBC4),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Padding(
                                              child: Image.asset(
                                                "assets/double_check.png",
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.all(8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                          width: 40,
                                          child: Text(
                                            "Unread",
                                            style: TextStyle(fontSize: 12),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          width: 40,
                                          child: Center(
                                            child: Text("Read",
                                                style: TextStyle(fontSize: 12)),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          width: 40,
                                          child: Center(
                                            child: Text("All",
                                                style: TextStyle(fontSize: 12)),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                );
        }),
      ),
    );
  }
}
