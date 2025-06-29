import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecases/open_url_external_usecase.dart';
part 'open_url_external_provider.g.dart';

@riverpod
OpenUrlExternalUsecase openUrlExternalUsecase(Ref ref) {
  return OpenUrlExternalUsecase();
}
