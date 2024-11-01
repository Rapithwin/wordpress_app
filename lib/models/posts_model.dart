import 'package:html/parser.dart';

class Posts {
  String? date;
  int? id;
  Content? content;
  Title? title;

  Posts({this.date, this.id, this.content, this.title});

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
      // This part will error out without the curly braces in the constructor above
      // because these are named optional parameters and the names are called
      date: json["date"],
      id: json["id"],
      content: Content.fromJson(json["content"]),
      title: Title.fromJson(json["title"]));
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  @override
  String toString() => parse("$rendered").documentElement!.text;
}

class Title {
  String? rendered;

  Title({this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  @override
  String toString() => parse("$rendered").documentElement!.text;
}
