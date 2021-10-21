import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:nasa_api/api_data.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // ignore: override_on_non_overriding_member
  var client = http.Client();
  List imageList = [];

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'NasaApi',
        ),
      ),
      body: Column(
        children: [
          Container(
            height: _height * 0.89,
            child: FutureBuilder(
              future: apiResponse(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data);
                  return snapshot.data.length != 0
                      ? Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 0.01, crossAxisCount: 1),
                            itemBuilder: (context, i) {
                              final dataGet = snapshot.data[i];
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: InkWell(
                                  focusColor: Colors.white,
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: dataGet["hdurl"] != null
                                            ? dataGet["hdurl"]
                                            : AssetImage("images/nasaImg.jpeg"),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text("No data Avilable"),
                        );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SpinKitChasingDots(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
//  ListView.builder(
                              // itemCount: snapshot.data.length,
                              // itemBuilder: (context, i) {
                              //   final dataGet = snapshot.data[i];
                              //   return InkWell(
                              //     onTap: () {},
                              //     child: Column(
                              //       children: [
                              //         Text(dataGet["title"]),
                              //         SizedBox(
                              //           height: _height * 0.005,
                              //         )
                              //       ],
                              //     ),
                              //   );
                              // }),