import 'package:flutter/material.dart';
import '../../common_widgets/article_card.dart';
import '../../common_widgets/category_tile.dart';
import '../../helper/category_data.dart';
import '../../helper/news_article_api.dart';
import '../../models/article_model.dart';

import '../../models/category_model.dart';
import '../../helper/resources.dart';
import '../../screens/news/article_view.dart';
import '../../services/auth.dart';

class HomePage extends StatefulWidget {
  final bool isSkip;

  HomePage({this.isSkip = false});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Resources r = new Resources();
  List<CategoryModel> categories = new List<CategoryModel>();
  bool _loading = true;

  List<ArticleModel> articles = new List<ArticleModel>();

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getArticles();
  }

  getArticles() async {
    NewsArticle news = NewsArticle();
    await news.getArticles();
    articles = news.articles;
    setState(() {
      _loading = false;
    });
  }

  //TODO: Links -
  // https://www.tech2stop.com/about-us/
  // https://www.tech2stop.com/contact/
  // https://www.tech2stop.com/solve-your-tech-queries/
  // https://www.tech2stop.com/product-decider/
  // https://www.tech2stop.com/wpautoterms/privacy-policy/

  // ------------- USING -------------------

  Widget topBar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                //color: r.black,
                color: Colors.white,
              ),
            ),
          ),
          r.customLogo,
          Icon(null),
        ],
      ),
    );
  }

  Widget listTile({String title, IconData icon, String url}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(title, style: r.style(Colors.grey[800], 16, r.f4)),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  url == 'Home' ? HomePage() : ArticleView(articleUrl: url),
            ));
      },
    );
  }

  Widget drawerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 5), blurRadius: 10),
            ],
            //color: r.bgColor,
            color: Colors.black,
          ),
          height: 80,
          alignment: Alignment.center,
          child: r.customLogo,
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              listTile(
                icon: Icons.home,
                title: 'Home',
                url: 'Home',
              ),
              listTile(
                icon: Icons.people,
                title: 'About us',
                url: 'https://www.tech2stop.com/about-us/',
              ),
              listTile(
                icon: Icons.message,
                title: 'Contact Us',
                url: 'https://www.tech2stop.com/contact/',
              ),
              listTile(
                icon: Icons.help,
                title: 'Solve your Tech queries',
                url: 'https://www.tech2stop.com/solve-your-tech-queries/',
              ),
              listTile(
                icon: Icons.assessment,
                title: 'Product decider',
                url: 'https://www.tech2stop.com/product-decider/',
              ),
              listTile(
                icon: Icons.security,
                title: 'Privacy policy',
                url: 'https://www.tech2stop.com/wpautoterms/privacy-policy/',
              ),
              widget.isSkip ? Container() : ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.grey[800]),
                title: Text('Logout', style: r.style(Colors.grey[800], 16, r.f4)),
                onTap: () => AuthService().signOut(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerText(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(text, style: r.style(r.black, 25, r.f4, isBold: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: r.bgColor,
      appBar: AppBar(
        centerTitle: false,
        //backgroundColor: r.bgColor,
        backgroundColor: Colors.black,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: topBar(),
      ),
      drawer: SafeArea(
        child: Drawer(child: drawerWidget()),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _loading = true;
            });
            NewsArticle news = NewsArticle();
            await news.getArticles();
            articles = news.articles;
            setState(() {
              _loading = false;
            });
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: 70.0,
                  //padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length + 1,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? SizedBox(width: 20)
                          : CategoryTile(
                              categoryId: categories[index - 1].id,
                              imageUrl: categories[index - 1].imageUrl,
                              categoryName: categories[index - 1].categoryName,
                            );
                    },
                  ),
                ),
                headerText('Discover Latest Tech News'),
                _loading
                    ? Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) => ArticleCard(
                            imageUrl: articles[index].imageUrl,
                            title: articles[index].title,
                            description: articles[index].description,
                            url: articles[index].url,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
