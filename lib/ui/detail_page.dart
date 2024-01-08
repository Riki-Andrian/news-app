import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/ui/article_web_view.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article.urlToImage!,
              child: Icon(Icons.abc), 
              //Image.network(article.urlToImage),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.description?? "_"),
                  Divider(color: Colors.grey),
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text('Date: ${article.publishedAt}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Author: ${article.author}'),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.content ?? "_",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigation.intentWithData(
                        ArticleWebView.routeName, article.url
                      );
                    },
                    child: const Text('Read more'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
