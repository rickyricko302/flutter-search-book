import 'package:cached_network_image/cached_network_image.dart';
import 'package:cariin_buku/core/providers/open_url_external_provider.dart';
import 'package:cariin_buku/core/util.dart';
import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';
import 'package:cariin_buku/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

class DetailBookScreen extends ConsumerWidget {
  const DetailBookScreen({super.key, required this.bookEntity});
  final BookEntity bookEntity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Detail Buku",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(20),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor(
                          context: context,
                        ).withValues(alpha: 0.2),
                        blurRadius: 100,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: bookEntity.coverImage,
                      width: 200,
                      errorWidget:
                          (context, url, error) => Image.asset(
                            'assets/images/cover_coming_soon.jpg',
                          ),
                    ),
                  ),
                ),
              ),
              Gap(12),
              Text(
                bookEntity.title,
                style: displaySmallTextTheme(
                  context: context,
                ).copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Gap(20),
              Text(
                bookEntity.authorName,
                style: titleLargeTextTheme(context: context)
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text(
                      'Genre: ${bookEntity.categoryName}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                  Chip(
                    label: Text(
                      'Hal.: ${bookEntity.totalPages}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                  Chip(
                    label: Text(
                      'Ukuran: ${bookEntity.size}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                  Chip(
                    label: Text(
                      'Format: ${bookEntity.format}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                  Chip(
                    label: Text(
                      'Diterbitkan: ${bookEntity.publishedDate}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                  Chip(
                    label: Text(
                      'Penerbit: ${bookEntity.publisher}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                  Chip(
                    label: Text(
                      'ISBN: ${bookEntity.isbn}',
                      style: bodySmallTextTheme(
                        context: context,
                      ).copyWith(color: primaryColor(context: context)),
                    ),
                    backgroundColor: primaryColor(
                      context: context,
                    ).withValues(alpha: .1),
                  ),
                ],
              ),
              Gap(20),
              Text(
                bookEntity.summary,
                style: bodyLargeTextTheme(context: context)
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)
                    .copyWith(height: 1.8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor(context: context),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            ref
                .read(openUrlExternalUsecaseProvider)
                .call(url: bookEntity.buyLinks[0].url);
          },
          child: Text(
            'Cari di Gramedia | ${bookEntity.price}',
            style: bodyLargeTextTheme(
              context: context,
            ).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
