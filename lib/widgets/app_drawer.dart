import 'package:flutter/material.dart';
import 'package:frame/auth/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Drawer(
      backgroundColor: const Color(0xff0F1419),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 12,
              right: 24,
              left: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MENU",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.grey,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minHeight: 32, minWidth: 32),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xff242B33), thickness: 1),
          Expanded(flex: 4, child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Color(0xff242B33), thickness: 1),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xff242B33),
                      width: 1,
                    ),
                    color: const Color(0xff151A20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: double.infinity,
                      child: StreamBuilder<AuthState>(
                        stream: Supabase.instance.client.auth.onAuthStateChange,
                        initialData: AuthState(
                          AuthChangeEvent.initialSession,
                          Supabase.instance.client.auth.currentSession,
                        ),
                        builder: (context, snapshot) {
                          final user =
                              Supabase.instance.client.auth.currentUser;

                          if (user == null) {
                            return MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: primary,
                              onPressed: () => context.go('/sign'),
                              child: const Text(
                                'Sign In / Sign Up',
                                style: TextStyle(
                                  color: Color(0xff0F1019),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }

                          final name =
                              (user.userMetadata?['full_name'] ??
                                      user.userMetadata?['name'] ??
                                      'User')
                                  .toString()
                                  .trim();

                          final initial = name.isNotEmpty
                              ? name.characters.first.toUpperCase()
                              : 'U';

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xff151A20),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xff242B33),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff24352F),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    initial,
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        name.isNotEmpty ? name : 'User',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xffE6ECEF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user.email ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xff8B949E),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 150,
                                  ),
                                  color: const Color(0xff1C232B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 8,
                                  onSelected: (value) async {
                                    if (value == 'logout') {
                                      await AuthService().signOut();
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'logout',
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            size: 18,
                                            color: Colors.redAccent,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Log Out',
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Color(0xff8B949E),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
