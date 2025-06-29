import 'package:cariin_buku/core/providers/open_url_external_provider.dart';
import 'package:cariin_buku/core/providers/supabase_provider.dart';
import 'package:cariin_buku/core/util.dart';
import 'package:cariin_buku/features/authentication/presentation/providers/auth_notifier.dart';
import 'package:cariin_buku/features/authentication/presentation/providers/auth_providers.dart';
import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';
import 'package:cariin_buku/features/books/domain/entities/filter_entity.dart';
import 'package:cariin_buku/features/books/presentation/widgets/card_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/book_notifiers.dart';
import '../widgets/bottom_sheet_filer.dart';

class SearchBookScreen extends ConsumerStatefulWidget {
  const SearchBookScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<SearchBookScreen> {
  final _scrollController = ScrollController();
  final _bookScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _listenAuthenticateSession();
    _listenScroll();
  }

  void _listenAuthenticateSession() {
    final supabaseClient = ref.read(supabaseClientProvider);
    supabaseClient.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedOut) {
        if (mounted) {
          return context.go('/login');
        }
      }
    });
  }

  void _listenScroll() {
    _scrollController.addListener(() {
      bool isSearchBarStickyState = ref.read(isSearchBarStickyProvider);
      if (_scrollController.position.pixels.round() >= 130) {
        if (!isSearchBarStickyState) {
          ref.read(isSearchBarStickyProvider.notifier).setSticky(true);
        }
      } else {
        if (isSearchBarStickyState) {
          ref.read(isSearchBarStickyProvider.notifier).setSticky(false);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bookScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userAuthtenticateProvider);
    final isSearchBarSticky = ref.watch(isSearchBarStickyProvider);
    final searchBook = ref.watch(searchBookProvider);
    final searchBookNotifier = ref.watch(searchBookProvider.notifier);
    final filter = ref.watch(filterProvider);
    final filterNotifier = ref.watch(filterProvider.notifier);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat\nDatang Kembali,',
                              style: titleLargeTextTheme(
                                context: context,
                              ).copyWith(
                                color: primaryColor(context: context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.userMetadata?['full_name'] ?? 'Pengguna',
                              style: titleLargeTextTheme(
                                context: context,
                              ).copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform.flip(
                          flipX: true,
                          child: SvgPicture.asset(
                            'assets/svg/illustrate_read_book.svg',
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: [
              Column(
                children: [
                  _buildSearchBar(
                    isSearchBarSticky,
                    filter,
                    filterNotifier,
                    context,
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: searchBook.when(
                        data:
                            (data) =>
                                data.books.isEmpty
                                    ? _buildEmptyAnimation(context)
                                    : _buildListViewBook(
                                      data.books,
                                      data.pagination,
                                      searchBookNotifier.loadMore,
                                      data.isLoadMoreLoading,
                                    ),
                        error: (error, s) => Text(error.toString()),
                        loading: () => _buildLoaderAnimation(),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                left: 20,
                right: 20,
                duration: Duration(milliseconds: 300),
                bottom: isSearchBarSticky ? -60 : 40,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(color: Colors.blueGrey, width: .5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Tooltip(
                          message: "Beranda",
                          child: IconButton(
                            onPressed: () {},
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedHome12,
                              color: primaryColor(context: context),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: "Gramedia",
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(openUrlExternalUsecaseProvider)
                                  .call(url: 'https://www.gramedia.com/');
                            },
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedLink02,
                              color: primaryColor(context: context),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: "Keluar",
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(signOutNotifierProvider.notifier)
                                  .signOut();
                            },
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedLogout05,
                              color: primaryColor(context: context),
                            ),
                          ),
                        ),
                      ),
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

  Container _buildLoaderAnimation() {
    return Container(
      child: Lottie.asset(
        'assets/lottie/search-animation.json',
        height: 200,
        width: double.infinity,
        repeat: true,
      ),
    );
  }

  Widget _buildListViewBook(
    List<BookEntity> books,
    PaginationEntity pagination,
    VoidCallback loadMoreCallback,
    bool isLoadMoreLoading,
  ) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemBuilder: (context, index) {
                return CardBookWidget(bookEntity: books[index]);
              },
              itemCount: books.length,
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
            Visibility(
              visible: pagination.hasNextPage,
              child: Container(
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor(context: context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                  onPressed: loadMoreCallback,
                  child:
                      isLoadMoreLoading
                          ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            "Muat Lagi",
                            style: TextStyle(color: Colors.white),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildEmptyAnimation(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            'assets/lottie/empty-animation.json',
            height: 200,
          ),
          Gap(8),
          Text(
            "Buku tidak ditemukan",
            style: labelLargeTextTheme(context: context),
          ),
        ],
      ),
    );
  }

  Container _buildSearchBar(
    bool isSearchBarSticky,
    FilterEntity filter,
    Filter filterNotifier,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 60,
            spreadRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
        borderRadius: BorderRadius.circular(200),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: isSearchBarSticky ? 0 : 20),
        child: SearchBar(
          hintText: "Cari Judul Buku atau Penulis",
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isSearchBarSticky ? 0 : 200),
            ),
          ),
          controller: TextEditingController(text: filter.keyword),
          onSubmitted: (value) => filterNotifier.setKeyword(value),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
          leading: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            color: Colors.grey,
          ),
          trailing: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) {
                    return BottomSheetFilter();
                  },
                );
              },
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedFilterAdd,
                color: primaryColor(context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
