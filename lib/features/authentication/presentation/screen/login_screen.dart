import 'package:cariin_buku/core/providers/supabase_provider.dart';
import 'package:cariin_buku/core/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/auth_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    ref.read(supabaseClientProvider).auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        if (mounted) {
          context.go('/search-book');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: LottieBuilder.asset(
                'assets/lottie/bg_auth_animation.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                repeat: true,
                animate: true,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: constraint.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(10),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedBook02,
                                color: primaryColor(context: context),
                                size: 92,
                              ),
                            ),
                            Positioned(
                              right: 18,
                              top: 35,
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedSearch01,
                                color: primaryColor(context: context),
                              ),
                            ),
                          ],
                        ),
                        Gap(12),
                        Text(
                          'Cariin Buku',
                          style: displayMediumTextTheme(
                            context: context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Silakan login untuk melanjutkan',
                          style: bodyMediumTextTheme(
                            context: context,
                          ).copyWith(color: secondaryColor(context: context)),
                        ),
                        Gap(40),

                        Center(child: ButtonLoginGoogle()),
                      ],
                    ),
                  ),
                );
              },
            ),
            SvgPicture.asset(
              'assets/svg/illustration_top.svg',
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/svg/illustration_bottom.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonLoginGoogle extends ConsumerStatefulWidget {
  const ButtonLoginGoogle({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ButtonLoginGoogleState();
}

class _ButtonLoginGoogleState extends ConsumerState<ButtonLoginGoogle> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(loginGoogleNotifierProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginGoogleProvider = ref.watch(loginGoogleNotifierProvider.notifier);
    final bool isLoading = ref.watch(loginGoogleNotifierProvider).isLoading;
    return SizedBox(
      width: 100,
      height: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: .1),
            ),
          ),
        ),
        onPressed:
            isLoading
                ? null
                : () async {
                  await loginGoogleProvider.loginGoogle();
                },
        child: Column(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedGoogle,
              color: Theme.of(context).colorScheme.onSurface,
              size: 48,
            ),
            Gap(8),
            Text('Google'),
          ],
        ),
      ),
    );
  }
}
