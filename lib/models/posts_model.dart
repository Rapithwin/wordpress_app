import 'package:html/parser.dart';

class Posts {
  final String? date;
  final int? id;
  final Content? content;
  final Title? title;

  Posts({this.date, this.id, this.content, this.title});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        // This part will error out without the curly braces in the constructor above
        // because these are named optional parameters and the names are called
        date: json["date"],
        id: json["id"],
        content: Content.fromJson(json["content"]),
        title: Title.fromJson(json["title"]));
  }
}

class Content {
  final String? rendered;
  final bool? protected;

  Content({this.rendered, this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json["rendered"],
      protected: json["protected"],
    );
  }

  @override
  String toString() {
    return parse("$rendered").documentElement!.text;
  }
}

class Title {
  final String? rendered;

  Title({this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      rendered: json["rendered"],
    );
  }

  @override
  String toString() {
    return parse("$rendered").documentElement!.text;
  }
}
