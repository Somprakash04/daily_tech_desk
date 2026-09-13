import 'package:daily_tech_desk/core/dummy_data/dummy_categories.dart';
import 'package:daily_tech_desk/core/routes/app_routes.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_cubit.dart';
import 'package:daily_tech_desk/features/onboarding/domain/entities/interest_topic.dart';
import 'package:daily_tech_desk/features/onboarding/presentation/cubit/interest_selection_cubit.dart';
import 'package:daily_tech_desk/features/onboarding/presentation/cubit/interest_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InterestSelectionPage extends StatelessWidget {
  const InterestSelectionPage({
    this.title = 'Personalize your Daily Tech Desk',
    this.subtitle =
        'Choose one or more technologies to build your personalized news feed. You can change these later.',
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InterestSelectionCubit>(
      create: (_) => InterestSelectionCubit(),
      child: _InterestSelectionView(
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}

class _InterestSelectionView extends StatelessWidget {
  const _InterestSelectionView({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child:
                        BlocBuilder<
                          InterestSelectionCubit,
                          InterestSelectionState
                        >(
                          builder:
                              (
                                BuildContext context,
                                InterestSelectionState state,
                              ) {
                                return LayoutBuilder(
                                  builder:
                                      (
                                        BuildContext context,
                                        BoxConstraints constraints,
                                      ) {
                                        final int columns =
                                            constraints.maxWidth >= 720
                                            ? 4
                                            : constraints.maxWidth >= 480
                                            ? 3
                                            : 2;
                                        return GridView.builder(
                                          itemCount:
                                              DummyCategories.interests.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: columns,
                                                mainAxisSpacing: 12,
                                                crossAxisSpacing: 12,
                                                childAspectRatio: columns == 2
                                                    ? 1.18
                                                    : 1.42,
                                              ),
                                          itemBuilder:
                                              (
                                                BuildContext context,
                                                int index,
                                              ) {
                                                final InterestTopic topic =
                                                    DummyCategories
                                                        .interests[index];
                                                return _InterestCard(
                                                  topic: topic,
                                                  selected: state.contains(
                                                    topic.id,
                                                  ),
                                                  onTap: () => context
                                                      .read<
                                                        InterestSelectionCubit
                                                      >()
                                                      .toggle(topic.id),
                                                );
                                              },
                                        );
                                      },
                                );
                              },
                        ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<InterestSelectionCubit, InterestSelectionState>(
                    buildWhen: (previous, current) =>
                        previous.selectedIds != current.selectedIds,
                    builder: (BuildContext context, InterestSelectionState state) {
                      return FilledButton(
                        onPressed: state.hasSelection
                            ? () async {
                                await context.read<AuthSessionCubit>().saveInterests(
                                  state.selectedIds,
                                );
                                if (context.mounted) {
                                  context.goNamed(
                                    AppRoutes.home,
                                    extra: state.selectedIds,
                                  );
                                }
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                        child: Text(
                          state.hasSelection
                              ? 'Continue with ${state.selectedIds.length} selected'
                              : 'Select at least one topic',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InterestCard extends StatelessWidget {
  const _InterestCard({
    required this.topic,
    required this.selected,
    required this.onTap,
  });

  final InterestTopic topic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Color background = selected
        ? colors.secondaryContainer
        : colors.surfaceContainerLow;
    final Color foreground = selected
        ? colors.onSecondaryContainer
        : colors.onSurface;

    return Semantics(
      button: true,
      selected: selected,
      label: topic.label,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.add_circle_outline_rounded,
                    size: 20,
                    color: selected ? colors.primary : colors.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(topic.icon, color: foreground),
                const SizedBox(height: 8),
                Text(
                  topic.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
