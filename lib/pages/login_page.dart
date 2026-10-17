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
  bool isHovered = false;
  Offset mousePosition = Offset.zero;

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: AppBar(
            foregroundColor: primary.withValues(alpha: 0.65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            leading: IconButton(
              onPressed: () {
                context.goNamed('home');
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF10171D),
      body: Center(
        child: Container(
          height: 298,
          width: 420,
          padding: const EdgeInsets.only(
            left: 42,
            top: 36,
            right: 42,
            bottom: 32,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0F161C),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF26313A)),
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

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),

                  MouseRegion(
                    cursor: SystemMouseCursors.basic,
                    onEnter: (event) {
                      setState(() {
                        isHovered = true;
                        mousePosition = event.localPosition;
                      });
                    },
                    onHover: (event) {
                      setState(() {
                        mousePosition = event.localPosition;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        if (!isHovered) {
                          return LinearGradient(colors: [primary, primary])
                              .createShader(bounds);
                        }

                        return RadialGradient(
                          center: Alignment(
                            (mousePosition.dx / bounds.width) * 2 - 1,
                            (mousePosition.dy / bounds.height) * 2 - 1,
                          ),
                          radius: 0.8,
                          colors: [primary.withValues(alpha: 0.35), primary],
                          stops: const [0.0, 1.0],
                        ).createShader(bounds);
                      },
                      child: Text(
                        'Frame',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue to your workspace.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: MaterialButton(
                  onPressed: () async {
                    await authService.signInWithGoogle();
                  },
                  color: const Color(0xFF19222B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                    side: const BorderSide(color: Color(0xFF2B3641)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
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
