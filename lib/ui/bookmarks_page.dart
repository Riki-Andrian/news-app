import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widget/card_article.dart';
import 'package:news_app/widget/platform_widget.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  static const String bookmarksTitle = 'Bookmarks';
 
  const BookmarksPage({Key? key}) : super(key: key);
 
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(bookmarksTitle),
      ),
      body: _buildList(),
    );
  }
 
  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(bookmarksTitle),
      ),
      child: _buildList(),
    );
  }
 
  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.bookmarks.length,
            itemBuilder: (context, index) {
              return CardArticle(article: provider.bookmarks[index]);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}