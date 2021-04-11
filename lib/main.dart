import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card/swipeable_card/controller/provider.dart';
import 'package:swipeable_card/swipeable_card/view/feed_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MultiProvider(
        providers: [

          ChangeNotifierProvider<FeedProvider>(create: (_) => FeedProvider()),
        ],
        child:FeedView(),
      ),
    );
  }
}
