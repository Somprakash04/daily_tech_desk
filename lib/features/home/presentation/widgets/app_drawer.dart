import 'package:daily_tech_desk/core/routes/app_routes.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('No'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

// User selected "No" or closed the dialog.
    if (shouldLogout != true) {
      return;
    }

// Perform logout.
    await context.read<AuthSessionCubit>().logout();

    if (!context.mounted) {
      return;
    }

// Go to login screen and remove the current navigation stack.
    context.goNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                24,
                16,
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.newspaper_rounded,
                    size: 34,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Daily Tech Desk',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your personal tech briefing',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                18,
                16,
                6,
              ),
              child: Text('PERSONAL'),
            ),
            _DrawerItem(
              label: 'Daily Digest',
              icon: Icons.today_outlined,
              onTap: () {
                context.goNamed(AppRoutes.dailyDigest);
              },
            ),
            _DrawerItem(
              label: 'Saved Items',
              icon: Icons.bookmark_outline_rounded,
              onTap: () {
                context.goNamed(AppRoutes.savedItems);
              },
            ),
            _DrawerItem(
              label: 'Personalized Feed',
              icon: Icons.tune_rounded,
              onTap: () {
                context.goNamed(AppRoutes.personalizedFeed);
              },
            ),
            const Divider(),
            _DrawerItem(
              label: 'Logout',
              icon: Icons.logout_rounded,
              onTap: () {
                _confirmLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
