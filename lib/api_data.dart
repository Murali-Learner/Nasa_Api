import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

Future<List> apiResponse() async {
  String apiKey = 'Fty80HkuF2LSDWPVutz34KJ4MXh9JWWKo8degZO4';
  var client = http.Client();

  try {
    final response = await client
        .get('https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=100');
    final jsonData = json.decode(response.body);
    // print(jsonData['date']);
    return (jsonData as List);
  } catch (e) {
    print(e);
    return [];
  }
}

// Future<List> imgUrl() async {
//   String apiKey = 'Fty80HkuF2LSDWPVutz34KJ4MXh9JWWKo8degZO4';
//   var client = http.Client();
//   List imgurls = [];
//   List imgnulls = [];
//   try {
//     final response = await client
//         .get('https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=100');
//     final jsonData = jsonDecode(response.body) as List;
//     for (var item in jsonData) {
//       item['hdurl'] != null
//           ? imgnulls.add(item['hdurl'])
//           : imgurls.add(item['hdurl']);
//     }

//     print(imgnulls.length);

//     print(imgurls.length);
//     return (imgurls);
//   } catch (e) {
//     print(e);
//     return [];
//   }
// }
