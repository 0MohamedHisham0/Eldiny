class Posts {
  String? status;
  String? message;
  ListPostData? data;

  Posts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = ListPostData.fromJson(json['data']);
  }
}

class ListPostData {
  List<PostData>? data = [];

  ListPostData.fromJson(List<dynamic> json) {
    for (var element in json) {
      data!.add(PostData.fromJson(element));
    }
  }
}

class PostData {
  int? id;
  String? timeToStart;
  String? timeToEnd;
  String? title;
  int? numberOfJuzz;
  bool? done;

  List<dynamic>? joined;
  List<dynamic>? submittedUsers;
  List<dynamic>? unSubmittedUsers;

  int? publisherId;
  Publisher? publisher;

  // named constructor
  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeToStart = json['timeToStart'];
    timeToEnd = json['timeToEnd'];
    title = json['title'];
    numberOfJuzz = json['numberOfJuzz'];
    done = json['done'];
    joined = json['joined'];
    submittedUsers = json['submittedUsers'];
    publisherId = json['publisherId'];
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
  }
}

class Publisher {
  String? name;
  String? email;

  Publisher.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }
}
