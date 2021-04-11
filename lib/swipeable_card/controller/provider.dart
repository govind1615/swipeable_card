// Flutter imports:
import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card/models/feed_model.dart';

class FeedProvider extends ChangeNotifier {
  List<FeedData> _feedData;
  List<FeedData> _feedDataAll;

  bool _showAppBar = false;

  int _filter;

  get feedData => _feedData;
  get feedDataAll => _feedDataAll;
  get showAppBar => _showAppBar;
  get filter => _filter;

  void setFeedData(val) {
    _feedData = val;
    notifyListeners();
  }
  void setFeedDataAll(val) {
    _feedDataAll = val;
    notifyListeners();
  }

  void setFinal(val) {
    _feedData = val;
    notifyListeners();
  }

  void setShowAppBar(val) {
    _showAppBar = val;
    notifyListeners();
  }

  void setFeedRead(index, read) {
    _feedData[index].isRead = read;
    _feedDataAll[index].isRead = read;
    notifyListeners();
  }

  void setFilter(index) {
    _filter = index;
    notifyListeners();
  }

  void setFilterRead() {
    _feedData = [];
    for (var filterData in feedDataAll) {
      if (filterData.isRead) {
        _feedData.add(filterData);
      }
    }
    notifyListeners();
  }

  void setFilterUnRead() {
    _feedData = [];
    for (var filterData in feedDataAll) {
      if (!filterData.isRead) {
        _feedData.add(filterData);
      }
    }
    notifyListeners();
  }

  void setFilterAll() {
    _feedData = _feedDataAll;

    notifyListeners();
  }
}
