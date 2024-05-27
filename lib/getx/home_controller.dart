import 'package:bitcoin_news_getx/services/http_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/new_response_model.dart';

class HomeController extends GetxController {
  List<Article> news = [];

  loadNews() async {
    var response = await Network.GET();
    if (response != null) {
      var articles = responseModelFromJson(response);
      news.addAll(articles.articles!);
      update();
    }
  }

  Future<void> openBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  launch(String url) async {
    await openBrowser(url);
  }
}
