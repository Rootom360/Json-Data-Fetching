import 'package:fetchingdatafromapi/model/newsartical.dart';
import 'package:fetchingdatafromapi/services/newsservices.dart';
import 'package:fetchingdatafromapi/utils/constants.dart';
import 'package:flutter/material.dart';

class NewsListState extends StatefulWidget {
  @override
  _NewsListStateState createState() => _NewsListStateState();
}

class _NewsListStateState extends State<NewsListState> {
  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
          setState(() => {_newsArticles = newsArticles})
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: _newsArticles[index].urlToImage == null
          ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL)
          : Image.network(_newsArticles[index].urlToImage),
      subtitle: Text(
        _newsArticles[index].title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('News'),
      ),
      body: ListView.builder(
        itemCount: _newsArticles.length,
        itemBuilder: _buildItemsForListView,
      ),
    );
  }
}
