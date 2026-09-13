import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    required this.article,
    required this.isSaved,
    required this.onBookmark,
    this.onTap,
    super.key,
  });

  final NewsArticle article;
  final bool isSaved;
  final VoidCallback onBookmark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String date = DateFormat('MMM d, y').format(article.publishedAt);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 8.5,
              child: CachedNetworkImage(
                imageUrl: article.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => ColoredBox(
                  color: colors.surfaceContainerHighest,
                  child: const Center(
                    child: Icon(Icons.image_outlined, size: 40),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chip(
                    label: Text(article.category),
                    visualDensity: VisualDensity.compact,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    article.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${article.source} · ${article.author} · $date',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),

                      IconButton(
                        tooltip: isSaved
                            ? 'Remove from saved'
                            : 'Save article',
                        onPressed: onBookmark,
                        icon: Icon(
                          isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                        ),
                      ),

                      IconButton(
                        tooltip: 'Share article',
                        onPressed: () => _shareArticle(context),
                        icon: const Icon(Icons.share_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareArticle(BuildContext context) async {
    if (article.articleUrl.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article link is not available.'),
        ),
      );
      return;
    }

    try {
      await SharePlus.instance.share(
        ShareParams(
          text: '${article.title}\n\n${article.articleUrl}',
          subject: article.title,
        ),
      );
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to share this article.'),
        ),
      );
    }
  }
}