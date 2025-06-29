import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/util.dart';
import '../providers/book_notifiers.dart';
import '../providers/book_providers.dart';

class BottomSheetFilter extends ConsumerWidget {
  const BottomSheetFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listYear = ref.watch(listYearProvider);
    final genreState = ref.watch(listGenreProvider);
    final listSortBy = ref.watch(sortByProvider);
    final filterEntity = ref.watch(filterProvider);
    final filterEntityNotifier = ref.watch(filterProvider.notifier);
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Terapkan Filter Tambahan',
                  style: titleLargeTextTheme(
                    context: context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Gap(30),
              Text(
                'Tahun',
                style: labelLargeTextTheme(
                  context: context,
                ).copyWith(color: Colors.grey),
              ),
              Gap(4),
              DropdownMenu(
                width: double.infinity,
                hintText: 'Pilih Tahun',
                menuHeight: 400,
                initialSelection: filterEntity.year,
                expandedInsets: EdgeInsets.zero,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
                dropdownMenuEntries: List.generate(listYear.length, (index) {
                  return DropdownMenuEntry(
                    value: listYear[index],
                    label: listYear[index],
                  );
                }),
                onSelected:
                    (value) => filterEntityNotifier.selectYear(value ?? ''),
              ),
              Gap(16),
              Text(
                'Genre',
                style: labelLargeTextTheme(
                  context: context,
                ).copyWith(color: Colors.grey),
              ),
              Gap(4),
              Stack(
                children: [
                  DropdownMenu(
                    enabled: !genreState.isLoading,
                    width: double.infinity,
                    hintText: 'Pilih Genre',
                    initialSelection: filterEntity.genre,
                    menuHeight: 400,
                    expandedInsets: EdgeInsets.zero,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                    dropdownMenuEntries: List.generate(
                      genreState.value?.length ?? 0,
                      (index) {
                        final genre = genreState.value![index];
                        return DropdownMenuEntry(
                          value: genre.genre,
                          label:
                              genre.genre != 'Semua Genre'
                                  ? "${genre.genre} (${genre.count})"
                                  : genre.genre,
                        );
                      },
                    ),
                    onSelected:
                        (value) =>
                            filterEntityNotifier.selectGenre(value ?? ''),
                  ),
                  Positioned(
                    right: 16,
                    top: 15,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: genreState.isLoading ? 1 : 0,
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primaryColor(context: context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16),
              Text(
                'Urutkan Berdasarkan',
                style: labelLargeTextTheme(
                  context: context,
                ).copyWith(color: Colors.grey),
              ),
              Gap(4),
              DropdownMenu(
                width: double.infinity,
                hintText: 'Terbaru',
                menuHeight: 400,
                initialSelection: filterEntity.sort,
                expandedInsets: EdgeInsets.zero,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
                dropdownMenuEntries: List.generate(listSortBy.length, (index) {
                  return DropdownMenuEntry(
                    value: listSortBy[index],
                    label: listSortBy[index],
                  );
                }),
                onSelected:
                    (value) => filterEntityNotifier.selectSort(value ?? ''),
              ),
              Gap(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    filterEntityNotifier.reset();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedFilterReset,
                        color: Colors.white,
                      ),
                      Gap(12),
                      Text(
                        'Riset Filter',
                        style: labelLargeTextTheme(
                          context: context,
                        ).copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
