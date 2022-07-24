import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/domain/usecases/get_local_news.dart';
import 'package:flutter_news/domain/usecases/get_news.dart';
import 'package:flutter_news/presentation/bloc/news/news_event.dart';
import 'package:flutter_news/presentation/bloc/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;
  final GetLocalNews getLocalNews;
  int page = 1;
  int pageSize = 10;
  String keyword = "";
  bool isFetching = false;
  bool loadFromLocal = false;

  NewsBloc({required this.getNews, required this.getLocalNews})
      : super(NewsInitialState()) {
    on<OnGetNews>((event, emit) async {
      emit(NewsLoading());
      if (page == 1) {
        final localData = await getLocalNews.execute(keyword);
        localData.fold((failure) {
          emit(NewsError());
        }, (result) {
          loadFromLocal = result.isNotEmpty;
          if(result.isNotEmpty){
            emit(NewsHasLocalData(result));
          }
        });
      }
      final result = await getNews.execute(keyword, page, pageSize);
      result.fold((failure) {
        emit(NewsError());
      }, (result) {
        page++;
        //emit(NewsHasData(result));
        emit(result.isNotEmpty ? NewsHasData(result) : NewsEmptyData());
      });
    });
    on<OnReset>((event, emit) async {
      emit(NewsInitialState());
      page = 1;
    });
  }
}
