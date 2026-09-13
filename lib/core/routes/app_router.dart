import 'package:daily_tech_desk/core/routes/app_routes.dart';
import 'package:daily_tech_desk/features/authentication/presentation/pages/login_page.dart';
import 'package:daily_tech_desk/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:daily_tech_desk/features/home/presentation/pages/article_details_page.dart';
import 'package:daily_tech_desk/features/home/presentation/pages/home_page.dart';
import 'package:daily_tech_desk/features/menu/presentation/pages/saved_items_page.dart';
import 'package:daily_tech_desk/features/onboarding/presentation/pages/interest_selection_page.dart';
import 'package:daily_tech_desk/features/onboarding/presentation/pages/splash_page.dart';
import 'package:daily_tech_desk/features/menu/presentation/pages/daily_digest_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/menu/presentation/cubit/saved_articles_cubit.dart';
import '../../features/menu/presentation/cubit/saved_articles_state.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoutes.splash,
        builder: (_, __) => const SplashPage(),
      ),

      GoRoute(
        path: '/login',
        name: AppRoutes.login,
        builder: (_, __) => const LoginPage(),
      ),

      GoRoute(
        path: '/sign-up',
        name: AppRoutes.signUp,
        builder: (_, __) => const SignUpPage(),
      ),

      GoRoute(
        path: '/interests',
        name: AppRoutes.interests,
        builder: (_, __) => const InterestSelectionPage(),
      ),

      GoRoute(
        path: '/home',
        name: AppRoutes.home,
        builder: (_, __) => const HomePage(),
      ),

      GoRoute(
        path: '/daily-digest',
        name: AppRoutes.dailyDigest,
        builder: (_, __) => const DailyDigestPage(),
      ),

      GoRoute(
        path: '/saved-items',
        name: AppRoutes.savedItems,
        builder: (_, __) => const SavedItemsPage(),
      ),

      GoRoute(
        path: '/article-details',
        name: 'article-details',
        builder: (context, state) {
          final NewsArticle article = state.extra! as NewsArticle;

          return BlocBuilder<SavedArticlesCubit, SavedArticlesState>(
            builder: (
                BuildContext context,
                SavedArticlesState savedState,
                ) {
              return ArticleDetailsPage(
                article: article,
                isSaved: savedState.contains(article.id),
                onBookmark: () {
                  context.read<SavedArticlesCubit>().toggle(article);
                },
              );
            },
          );
        },
      ),

      GoRoute(
        path: '/personalized-feed',
        name: AppRoutes.personalizedFeed,
        builder: (_, __) => const InterestSelectionPage(
          title: 'Tune your personalized feed',
          subtitle:
          'Choose the technologies you want to see. Your dashboard will show only these topics.',
        ),
      ),
    ],
  );
}