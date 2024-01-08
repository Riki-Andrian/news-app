import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/model/article.dart';


class ApiService{
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '99827af2f6e64b0487c168df0e75ea6c';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<ArticlesResult> topHeadlines() async{
    final response = await http.get(Uri.parse("${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
  if(response.statusCode == 200){

     if (json.decode(response.body)['totalResults'] == 0) {
      // Tidak ada data, kembalikan nilai null atau objek khusus yang menunjukkan ketiadaan data
      return throw Exception('Tolol');
    }
    return ArticlesResult.fromJson(json.decode(response.body));


  }else{
    throw Exception('Failed to load top headlines');
  }
  }
}