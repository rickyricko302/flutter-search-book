/// Exception yang dilempar dari data source (misalnya API)
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Terjadi kesalahan pada server.']);

  @override
  String toString() => 'ServerException: $message';
}

/// Exception ketika tidak ada koneksi internet
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Tidak ada koneksi internet.']);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception untuk data lokal (misalnya database, cache)
class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Gagal mengambil data dari cache.']);

  @override
  String toString() => 'CacheException: $message';
}

/// Exception untuk otorisasi/token API
class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = 'Tidak memiliki otorisasi.']);

  @override
  String toString() => 'UnauthorizedException: $message';
}
