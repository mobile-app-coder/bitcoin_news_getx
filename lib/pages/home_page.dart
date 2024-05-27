import 'package:bitcoin_news_getx/getx/home_controller.dart';
import 'package:bitcoin_news_getx/models/new_response_model.dart';
import 'package:bitcoin_news_getx/pages/details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.find<HomeController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeController.loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Bitcoin news"),
          elevation: 10,
          leading: const Icon(
            Icons.currency_bitcoin,
            color: Colors.orange,
            size: 35,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollController.jumpTo(0);
          },
          child: const Icon(CupertinoIcons.up_arrow),
        ),
        body: ListView.builder(
            controller: scrollController,
            itemCount: _homeController.news.length,
            itemBuilder: (context, index) {
              return _itemArticle(_homeController.news[index]);
            }),
      );
    });
  }

  Widget _itemArticle(Article article) {
    return GestureDetector(
      onTap: () {
        _homeController.launch(article.url!);
      },
      onLongPress: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return DetailsPage(
            url: article.url!,
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5, left: 5, bottom: 5),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              article.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(article.description ?? '',
                      overflow: TextOverflow.clip),
                ),
                if (article.urlToImage != null)
                  Expanded(
                    flex: 1,
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
