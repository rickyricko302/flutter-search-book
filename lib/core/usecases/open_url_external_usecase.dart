import 'package:url_launcher/url_launcher.dart';

class OpenUrlExternalUsecase {
  Future<void> call({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}
