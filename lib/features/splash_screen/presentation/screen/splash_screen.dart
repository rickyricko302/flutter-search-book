import 'package:cariin_buku/core/providers/supabase_provider.dart';
import 'package:cariin_buku/core/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isBallFall = false;
  bool isBallBig = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isBallFall = true;
      });
    });
    Future.delayed(Duration(milliseconds: 3500), () {
      setState(() {
        isBallBig = true;
      });
    });
    Future.delayed(Duration(milliseconds: 5000), () {
      final SupabaseClient supabaseClient = ref.read<SupabaseClient>(
        supabaseClientProvider,
      );
      if (mounted) {
        supabaseClient.auth.currentSession != null
            ? context.go('/search-book')
            : context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(context: context),
      body: Stack(
        children: [
          Positioned(
            top: -200,
            left: -200,
            right: -200,
            bottom: -200,
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: isBallBig ? 1 : 0,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  width: isBallBig ? 2000 : 20,
                  height: isBallBig ? 2000 : 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedBook02,
              color: primaryColor(context: context),
              size: 92,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.bounceOut,
            top:
                MediaQuery.of(context).size.height / 2 -
                10 -
                (isBallFall ? 0 : 50),
            left: MediaQuery.of(context).size.width / 2 - 10,
            child: Visibility(
              visible: !isBallBig,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
