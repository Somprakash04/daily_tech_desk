import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({
    required this.article,
    required this.isSaved,
    required this.onBookmark,
    super.key,
  });

  final NewsArticle article;
  final bool isSaved;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final String date = DateFormat(
      'MMMM d, yyyy · h:mm a',
    ).format(article.publishedAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Article',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: <Widget>[
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (article.imageUrl.trim().isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (_, __, ___) => ColoredBox(
                    color: colors.surfaceContainerHighest,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chip(
                    label: Text(_categoryLabel(article.category)),
                    visualDensity: VisualDensity.compact,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    article.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.source_outlined,
                        size: 18,
                        color: colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          article.source,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${article.author} · $date',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _openOriginalArticle(context),
                      icon: const Icon(
                        Icons.open_in_new_rounded,
                      ),
                      label: const Text(
                        'Read Full Article',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openOriginalArticle(BuildContext context) async {
    final Uri? uri = Uri.tryParse(article.articleUrl);

    if (uri == null ||
        !(uri.scheme == 'http' || uri.scheme == 'https')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article link is not available.'),
        ),
      );
      return;
    }

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open article.'),
          ),
        );
      }
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open article.'),
        ),
      );
    }
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

  String _categoryLabel(String category) {
    if (category.trim().isEmpty) {
      return 'Technology';
    }

    return category
        .replaceAll('-', ' ')
        .split(' ')
        .where((String word) => word.isNotEmpty)
        .map(
          (String word) =>
      '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
    )
        .join(' ');
  }
}