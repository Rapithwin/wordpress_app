import 'package:flutter/material.dart';
import 'package:wordpress_app/models/posts_model.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';

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
      appBar: CustomAppBar.customAppBarDetail(context),
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
