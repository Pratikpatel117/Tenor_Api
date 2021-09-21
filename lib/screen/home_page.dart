import 'package:flutter/material.dart'; // path = results[0].media[0].gif.url
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? urlData;
  List<String?>? urls;
  static int limit = 50;
  var Url =
      "https://g.tenor.com/v1/search?q=funny&key=X3Z6T1PVU7XZ&limit=${limit.toString()}";

  Future getData() async {
    final responce = await http.get(Uri.parse(Url));
    // print("data Print it===${responce.body}");
    // if (responce.statusCode == 200) {
    //   var data = Animal.fromJson(jsonDecode(responce.body));
    //   print(data);
    //   return data;
    // }
    // var animalModel = null;
    //   List<String> data = responce.body;

    if (responce.statusCode == 200) {
      Map<String, dynamic> animalDeco = jsonDecode(responce.body);

      List<dynamic> call = animalDeco['results'];
      //  print("data = = ${call}");

      //  print("bhhhvhjgj ==${gaiili}");

      int callIndex = 0;
      urls = [];
      call.forEach((element) {
        Map<String, dynamic> gaiili = element;
        List<dynamic> media = gaiili['media'];

        //   print("vgwhvdhgv=====${media}");
        print('call index : $callIndex');
        int mediaIndex = 0;
        media.forEach((element) {
          Map<String, dynamic> gifData = element;
          print('Media INdex : $mediaIndex');
          //  print('gvhvhgvghv===${gifData}');
          Map<String, dynamic> mediaData = gifData['gif'];
          String url = mediaData['url'];
          print(url);
          urls!.add(url);
        });
      });

      setState(() {});
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print('urls : $urls');
    return Scaffold(
      body: (urls == null)
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: FutureBuilder(
                future: getData(),
                builder: (context, index) {
                  return GridView.builder(
                      itemCount: urls!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, i) {
                        return Card(
                          child: Column(
                            children: [
                              Image.network(
                                urls![i]!,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
    );
  }
}
