import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/posts_model.dart';

class BlogPostsPage extends StatefulWidget {
  const BlogPostsPage({super.key, this.post});
  final Posts? post;

  @override
  State<BlogPostsPage> createState() => _BlogPostsPageState();
}

class _BlogPostsPageState extends State<BlogPostsPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            decoration: BoxDecoration(
              color: Constants.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Constants.primaryColor,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite,
                color: Constants.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.post!.title.toString(),
              style: textTheme.headlineMedium,
            ),
            Text(
              widget.post!.content.toString(),
              style: textTheme.bodyLarge,
            ),
            Text(
              widget.post!.date.toString().replaceAll(RegExp(r"T"), " "),
              style: textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
