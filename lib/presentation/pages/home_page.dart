import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';
import 'package:flutter_news/presentation/bloc/news/news_bloc.dart';
import 'package:flutter_news/presentation/bloc/news/news_event.dart';
import 'package:flutter_news/presentation/bloc/news/news_state.dart';
import 'package:flutter_news/presentation/widgets/card_news.dart';
import 'package:flutter_news/presentation/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ArticleEntity> _articles = [];
  final ScrollController _scrollController = ScrollController();
  String keyword = "";

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Center(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<NewsBloc>(context)
                ..add(const OnReset())
                ..add(const OnGetNews());
            },
            child:
                BlocConsumer<NewsBloc, NewsState>(listener: (context, state) {
              if (state is NewsLoading) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Loading")));
              } else if (state is NewsError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Error")));
              } else if (state is NewsInitialState) {
                _articles.clear();
              }
            }, builder: (context, state) {
              if (state is NewsInitialState || state is NewsEmptyData) {
                return const Text("Empty");
              } else if (state is NewsHasLocalData) {
                _articles.addAll(state.result);
              } else if (state is NewsHasData) {
                if (BlocProvider.of<NewsBloc>(context).loadFromLocal) {
                  _articles.clear();
                }
                _articles.addAll(state.result);
                BlocProvider.of<NewsBloc>(context)
                  ..isFetching = false
                  ..loadFromLocal = false;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
              // return Text("hi");
              return ListView.builder(
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.offset ==
                              _scrollController.position.maxScrollExtent &&
                          !BlocProvider.of<NewsBloc>(context).isFetching) {
                        BlocProvider.of<NewsBloc>(context)
                          ..isFetching = true
                          ..add(const OnGetNews());
                      }
                    }),
                  itemCount: _articles.length,
                  itemBuilder: (context, index) {
                    return CardNews(articleEntity: _articles[index]);
                  });
            }),
          ),
        ),
      ),
    );
  }
}
