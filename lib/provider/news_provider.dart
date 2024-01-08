import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/article.dart';

enum ResultState { loading, noData, hasData, error }
 
class NewsProvider extends ChangeNotifier {
  final ApiService apiService;
 
  NewsProvider({required this.apiService}) {
    _fetchAllArticle();
  }
 
  late ArticlesResult _articlesResult;
  late ResultState _state;
  String _message = '';
 
  String get message => _message;
 
  ArticlesResult get result => _articlesResult;
 
  ResultState get state => _state;
 
  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.topHeadlines();
      if (article.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}