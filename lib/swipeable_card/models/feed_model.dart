class FeedModel {
  String category;
  List<FeedData> data;
  bool success;

  FeedModel({this.category, this.data, this.success});

  FeedModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new FeedData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class FeedData {
  String author;
  String content;
  String date;
  String imageUrl;
  String readMoreUrl;
  String time;
  String title;
  String url;
  bool isRead;

  FeedData(
      {this.author,
      this.content,
      this.isRead,
      this.date,
      this.imageUrl,
      this.readMoreUrl,
      this.time,
      this.title,
      this.url});

  FeedData.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    isRead = json['isRead'] ?? false;
    date = json['date'];
    imageUrl = json['imageUrl'];
    readMoreUrl = json['readMoreUrl'];
    time = json['time'];
    title = json['title'];
    url = json['url'];
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['content'] = this.content;
    data['date'] = this.date;
    data["isRead"] = this.isRead;
    data['imageUrl'] = this.imageUrl;
    data['readMoreUrl'] = this.readMoreUrl;
    data['time'] = this.time;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
