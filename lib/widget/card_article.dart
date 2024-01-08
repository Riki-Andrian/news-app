import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:news_app/ui/detail_page.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: article.urlToImage!,
                  child: Image.network(
                    article.urlToImage!,
                    width: 100,
                  ),
                ),
                title: Text(
                  article.title,
                ),
                subtitle: Text(article.author ?? ""),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.bookmark),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeBookmark(article.url),
                      )
                    : IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addBookmark(article),
                      ),
                onTap: () => Navigation.intentWithData(
                    ArticleDetailPage.routeName, article),
              ),
            );
          },
        );
      },
    );
  }
}