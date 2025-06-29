class BookEntity {
  final String id;
  final String title;
  final String coverImage;
  final String authorName;
  final String categoryName;
  final String summary;
  final String publisher;
  final String isbn;
  final String price;
  final String totalPages;
  final String size;
  final String publishedDate;
  final String format;
  final List<String> tags;
  final List<BuyLinkEntity> buyLinks;

  BookEntity({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.authorName,
    required this.categoryName,
    required this.summary,
    required this.publisher,
    required this.isbn,
    required this.price,
    required this.totalPages,
    required this.size,
    required this.publishedDate,
    required this.format,
    required this.tags,
    required this.buyLinks,
  });
}

class BuyLinkEntity {
  final String store;
  final String url;

  BuyLinkEntity({required this.store, required this.url});
}

class PaginationEntity {
  final int currentPage;
  final int totalItems;
  final bool hasNextPage;

  PaginationEntity({
    required this.currentPage,
    required this.totalItems,
    required this.hasNextPage,
  });
}
