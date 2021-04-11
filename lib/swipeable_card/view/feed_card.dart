import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card/swipeable_card/controller/provider.dart';
import 'package:swipeable_card/swipeable_card/models/feed_model.dart';

class FeedCard extends StatefulWidget {
  final FeedData feedData;
  final int index;

  const FeedCard({Key key, this.feedData, this.index}) : super(key: key);
  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool read = false;

  @override
  void initState() {
    read = widget.feedData.isRead;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.feedData.imageUrl))),
                )),
            Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: Text(
                                      widget.feedData.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  read = !read;
                                  Provider.of<FeedProvider>(context,
                                          listen: false)
                                      .setFeedRead(widget.index, read);
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  child: Image.asset(
                                    "assets/double_check.png",
                                    color:
                                        read ? Color(0xff0CCBC4) : Colors.black,
                                  ),
                                  padding: EdgeInsets.all(8),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Text(
                          widget.feedData.content,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
