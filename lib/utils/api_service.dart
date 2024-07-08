import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/categories_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Category

  final urlCategory = 'https://dev-mahakal.rizrv.in/api/v1/astro/youtube/video/category';
  Future getCategory(String url) async {
    final response = await http.get(Uri.parse(urlCategory));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Sub Category

  Future getSubcategory(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Video Category

  Future getVideo(String url)async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final jsonBody = jsonDecode(response.body);
      return jsonBody;
    }else{
      throw Exception('Failed to load videos');
    }
}
}