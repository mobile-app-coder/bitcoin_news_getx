import 'package:bitcoin_news_getx/services/http_service.dart';
import 'package:get/get.dart';

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
}
