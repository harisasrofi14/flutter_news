import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';
import 'package:intl/intl.dart';

class CardNews extends StatelessWidget {
  final ArticleEntity articleEntity;

  const CardNews({required this.articleEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Hero(
            tag: articleEntity.title,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                articleEntity.urlToImage,
                fit: BoxFit.cover,
                width: 120,
                height: 120,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const SizedBox(
                    width: 120,
                    height: 120,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  articleEntity.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  DateFormat.yMMMEd()
                      .format(DateTime.parse(articleEntity.publishedAt)),
                  // articleEntity.publishedAt,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  articleEntity.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
