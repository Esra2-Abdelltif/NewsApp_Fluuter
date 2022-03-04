import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

class NewsScreens extends StatefulWidget {
  const NewsScreens({Key key}) : super(key: key);

  @override
  State<NewsScreens> createState() => _NewsScreensState();
}

class _NewsScreensState extends State<NewsScreens> {
  var newslist,Article;
  Future getNews() async{
   var res = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ff780098bab6417fb46e4c9abe37ace1"));
   if (res.statusCode ==200)
     {
       var obj =json.decode((res.body))['articles'];
       return obj;
     }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News'),
      centerTitle: true,
      ),
      body:FutureBuilder(
        future: getNews(),
        builder: (ctx,snapShot)
        {

            return ListView.builder(
              itemBuilder:(_,int index)=>
                  BuildNews(title:snapShot.data[index]['title'],
                      name:snapShot.data[index]['source']['name'],
                      url: snapShot.data[index]['urlToImage'],
                    publishedAt: snapShot.data[index]['publishedAt']
                  ) ,

              itemCount: snapShot.data.length,
            );


},

      ),

    );
  }
}
// ignore: non_constant_identifier_names
Widget BuildNews({String title,String name,String url,String publishedAt})=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Container(
        height: 120,
        width: 150,
        child: Image(image: NetworkImage("${url}"),
            fit: BoxFit.cover),
        //clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      SizedBox(width: 10.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text ('${title}',
              style: TextStyle(color: Colors.grey[700] ,fontSize: 16, fontWeight: FontWeight.w700),
              maxLines: 2,),
            SizedBox(height: 10.0),
            Text ('${name}',
              style: TextStyle(color: Colors.grey[700] , fontSize: 13 , fontWeight: FontWeight.w400),),
            SizedBox(height: 2.0),
            Text ('${publishedAt}',
              style: TextStyle(color: Colors.grey[700] , fontSize: 13 , fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    ],
  ),
);