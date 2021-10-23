// @dart=2.9

import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nasa_api/api_data.dart';
// import '';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:nasa_api/liatData.dart';

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
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        height: _height,
        child: FutureBuilder(
          future: apiResponse(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Swiper(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return cardWidget(_height, snapshot.data[index], _width);
                },
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.blueAccent,
                ),
              );
            }
          },
        ),
        // child: Swiper(
        //   itemCount: data.sublist(1).length,
        //   scrollDirection: Axis.vertical,
        //   itemBuilder: (context, index) {
        //     return cardWidget(_height, data.sublist(1)[index], _width);
        //   },
        // ),
      )),
    );
  }

  Container cardWidget(double _height, dataElementVal, double _width) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: _height,
            child: CachedNetworkImage(
              imageUrl: dataElementVal["url"],
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset("images/nasaImg.jpeg");
              },
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: _height * 0.1, horizontal: _width * 0.1),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                dataElementVal["title"],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: _height * 0.65,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _height * 0.3,
                width: _width,
                alignment: Alignment.bottomCenter,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 50,
                      sigmaY: 50,
                      tileMode: TileMode.clamp,
                    ),
                    child: Text("          " + dataElementVal["explanation"],
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )
                        // textBaseline: TextBaseline.alphabetic),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
