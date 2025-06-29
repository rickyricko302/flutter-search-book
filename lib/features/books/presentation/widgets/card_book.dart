import 'package:cached_network_image/cached_network_image.dart';
import 'package:cariin_buku/core/util.dart';
import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class CardBookWidget extends ConsumerWidget {
  const CardBookWidget({super.key, required this.bookEntity});
  final BookEntity bookEntity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        context.push('/detail-book', extra: bookEntity);
      },
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: bookEntity.coverImage,
              width: 100,
              height: 150,
              errorWidget:
                  (context, url, error) =>
                      Image.asset('assets/images/cover_coming_soon.jpg'),
            ),
            Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookEntity.title,
                    style: titleMediumTextTheme(context: context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4),
                  Text(
                    'Penulis: ${bookEntity.authorName}',
                    style: labelLargeTextTheme(
                      context: context,
                    ).copyWith(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4),
                  Text(
                    'Genre: ${bookEntity.categoryName}',
                    style: labelLargeTextTheme(
                      context: context,
                    ).copyWith(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4),
                  Text(
                    bookEntity.price,
                    style: labelLargeTextTheme(
                      context: context,
                    ).copyWith(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: primaryColor(context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
