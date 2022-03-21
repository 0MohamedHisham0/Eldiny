import 'package:adealy/models/posts/post_model.dart';
import 'package:adealy/modules/el-tlawa/cubit/state.dart';
import 'package:adealy/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TlawaCubit extends Cubit<TlawaState> {
  TlawaCubit() : super(TlawaInitialState());

  static TlawaCubit get(context) => BlocProvider.of(context);

  Posts? posts;
  bool isBottomSheetShown = false;
  var floatingActionButtonIcon = Icons.add;

  void changeBottomSheetState(bool isShow, dynamic icon) {
    isBottomSheetShown = isShow;
    floatingActionButtonIcon = icon;

    emit(ChangeBottomSheetState());
  }

  void getPosts(int page, int limit) {
    DioHelper.getData(url: "api/posts", query: {"page": page, "limit": limit})
        .then((value) => {
              posts = Posts.fromJson(value.data),
              print(posts!.message.toString()),
              emit(GetPostSuccessfullyState())
            })
        .catchError((error) {
      emit(GetPostErrorState(error.toString()));
      print(error.toString());
    });
  }

  void addPost(String timeToStart, String timeToEnd, int numberOfJuzz) {
    DioHelper.postData(url: "/api/posts", data: {
      "title": timeToStart,
      "timeToEnd": timeToEnd,
      "numberOfJuzz": numberOfJuzz
    })
        .then((value) => {
              emit(AddPostSuccessfullyState()),
              print(value.data["status"]),
              print(value.data["message"])
            })
        .catchError((error) {
      emit(AddPostErrorState(error));
      print(error);
    });
  }
}
