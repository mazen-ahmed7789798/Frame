import 'package:flutter/material.dart';
import 'package:frame/auth/auth_service.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  static const _logoAssetPath = 'images/logonobg.webp';
  static const _googleAssetPath = 'images/google.png';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: AppBar(
              foregroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
              ),
              leading: IconButton(
                onPressed: () {
                  context.goNamed("home");
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xff10171D),
      body: Center(
        child: Container(
          height: 298,
          width: 420,
          padding: const EdgeInsets.fromLTRB(40, 36, 40, 32),
          decoration: BoxDecoration(
            color: const Color(0xff0F161C),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xff26313A)),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 18),
                blurRadius: 30,
                color: Colors.black54,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(LoginPage._logoAssetPath, width: 54, height: 54),

              const SizedBox(height: 20),

              const Text(
                'Welcome to Frame',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue to your workspace.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xff8B949E)),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: MaterialButton(
                  onPressed: () async {
                    await authService.signInWithGoogle();
                  },
                  color: const Color(0xff19222B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                    side: const BorderSide(color: Color(0xff2B3641)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          LoginPage._googleAssetPath,
                          width: 21,
                          height: 21,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Continue with Google',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 21),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
