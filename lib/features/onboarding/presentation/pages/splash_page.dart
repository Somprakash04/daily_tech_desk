import 'dart:async';

import 'package:daily_tech_desk/core/constants/app_constants.dart';
import 'package:daily_tech_desk/core/routes/app_routes.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_cubit.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..forward();
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.82,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  void _navigateForSession(AuthSessionState state) {
    _navigationTimer?.cancel();
    _navigationTimer = Timer(AppConstants.splashDuration, () {
      if (!mounted) return;
      switch (state.status) {
        case AuthSessionStatus.signedIn:
          context.goNamed(AppRoutes.home, extra: state.interestIds);
        case AuthSessionStatus.selectingInterests:
          context.goNamed(AppRoutes.interests);
        case AuthSessionStatus.signedOut:
          context.goNamed(AppRoutes.login);
        case AuthSessionStatus.checking:
          break;
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Size size = MediaQuery.sizeOf(context);

    return BlocListener<AuthSessionCubit, AuthSessionState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (_, AuthSessionState state) {
          if (state.status != AuthSessionStatus.checking)
            _navigateForSession(state);
        },
        child: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[colors.primary, colors.primaryContainer],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: size.width * 0.82),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: colors.onPrimary,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(color: Colors.black26, blurRadius: 24),
                            ],
                          ),
                          child: Icon(
                            Icons.newspaper_rounded,
                            size: 48,
                            color: colors.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          AppConstants.appName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: colors.onPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your daily signal from the tech world',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: colors.onPrimary.withValues(alpha: 0.82),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
