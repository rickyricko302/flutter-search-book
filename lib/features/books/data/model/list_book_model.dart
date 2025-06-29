import 'dart:convert';

import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';

ListBookModel listBookModelFromJson(String str) =>
    ListBookModel.fromJson(json.decode(str));

String listBookModelToJson(ListBookModel data) => json.encode(data.toJson());

class ListBookModel {
  List<Book> books;
  Pagination pagination;

  ListBookModel({required this.books, required this.pagination});

  factory ListBookModel.fromJson(Map<String, dynamic> json) => ListBookModel(
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "books": List<dynamic>.from(books.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Book {
  String id;
  String title;
  String coverImage;
  Author author;
  Author category;
  String summary;
  Details details;
  List<Tags> tags;
  List<BuyLink> buyLinks;
  String publisher;

  Book({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.author,
    required this.category,
    required this.summary,
    required this.details,
    required this.tags,
    required this.buyLinks,
    required this.publisher,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["_id"],
    title: json["title"],
    coverImage: json["cover_image"],
    author: Author.fromJson(json["author"]),
    category: Author.fromJson(json["category"]),
    summary: json["summary"],
    details: Details.fromJson(json["details"]),
    tags: List<Tags>.from(json["tags"].map((x) => Tags.fromJson(x))),
    buyLinks: List<BuyLink>.from(
      json["buy_links"].map((x) => BuyLink.fromJson(x)),
    ),
    publisher: json["publisher"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "cover_image": coverImage,
    "author": author.toJson(),
    "category": category.toJson(),
    "summary": summary,
    "details": details.toJson(),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "buy_links": List<dynamic>.from(buyLinks.map((x) => x.toJson())),
    "publisher": publisher,
  };

  BookEntity toEntity() {
    return BookEntity(
      id: id,
      title: title,
      coverImage: coverImage,
      authorName: author.name,
      categoryName: category.name,
      summary: summary,
      publisher: publisher,
      isbn: details.isbn,
      price: details.price,
      totalPages: details.totalPages,
      size: details.size,
      publishedDate: details.publishedDate,
      format: details.format,
      tags: tags.map((tag) => tag.name).toList(),
      buyLinks:
          buyLinks
              .map((link) => BuyLinkEntity(store: link.store, url: link.url))
              .toList(),
    );
  }
}

class Author {
  String name;
  String url;

  Author({required this.name, required this.url});

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

class Tags {
  String name;
  String url;

  Tags({required this.name, required this.url});

  factory Tags.fromJson(Map<String, dynamic> json) =>
      Tags(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

class BuyLink {
  String store;
  String url;

  BuyLink({required this.store, required this.url});

  factory BuyLink.fromJson(Map<String, dynamic> json) =>
      BuyLink(store: json["store"], url: json["url"]);

  Map<String, dynamic> toJson() => {"store": store, "url": url};
}

class Details {
  String noGm;
  String isbn;
  String price;
  String totalPages;
  String size;
  String publishedDate;
  String format;

  Details({
    required this.noGm,
    required this.isbn,
    required this.price,
    required this.totalPages,
    required this.size,
    required this.publishedDate,
    required this.format,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    noGm: json["no_gm"],
    isbn: json["isbn"],
    price: json["price"],
    totalPages: json["total_pages"],
    size: json["size"],
    publishedDate: json["published_date"],
    format: json["format"],
  );

  Map<String, dynamic> toJson() => {
    "no_gm": noGm,
    "isbn": isbn,
    "price": price,
    "total_pages": totalPages,
    "size": size,
    "published_date": publishedDate,
    "format": format,
  };
}

class Pagination {
  int currentPage;
  int totalPages;
  int totalItems;
  int itemsPerPage;
  bool hasNextPage;
  bool hasPrevPage;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalItems: json["totalItems"],
    itemsPerPage: json["itemsPerPage"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalItems": totalItems,
    "itemsPerPage": itemsPerPage,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };

  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      totalItems: totalItems,
      hasNextPage: hasNextPage,
    );
  }
}
