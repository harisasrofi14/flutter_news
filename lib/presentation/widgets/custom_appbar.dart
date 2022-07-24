import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/presentation/bloc/news/news_bloc.dart';
import 'package:flutter_news/presentation/bloc/news/news_event.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String keyword = "";
    return AppBar(
      elevation: 0.0,
      leading: Container(),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white),
                    onChanged: (value) {
                      keyword = value;
                    },
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      onPressed: () {
                        BlocProvider.of<NewsBloc>(context)
                          ..add(const OnReset())
                          ..keyword = keyword
                          ..add(const OnGetNews());
                      },
                      icon: const Icon(Icons.search)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);
}
