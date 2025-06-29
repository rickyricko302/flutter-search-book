import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';
import 'package:cariin_buku/features/books/presentation/screen/search_book_screen.dart';
import 'package:cariin_buku/features/splash_screen/presentation/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/screen/login_screen.dart';
import '../features/books/presentation/screen/detail_book_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/search-book',
      builder: (context, state) => const SearchBookScreen(),
    ),
    GoRoute(
      path: '/detail-book',
      builder: (context, state) {
        final BookEntity bookEntity = state.extra as BookEntity;
        return DetailBookScreen(bookEntity: bookEntity);
      },
    ),
  ],
);
