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
  var floatingActionButtonIcon = Icons.post_add;

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
    DioHelper.postData(url: "api/posts", data: {
      "timeToStart": timeToStart,
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

  void joinInPost(int? postId) {
    emit(JoinPostLoadingState());
    DioHelper.putData(url: "api/posts/$postId", data: {})
        .then((value) => {
              getPosts(0, 20),
              emit(JoinPostSuccessfullyState()),
              print(value.data["status"]),
              print(value.data["message"])
            })
        .catchError((error) {
      emit(JoinPostErrorState(error));
      print(error);
    });
  }

  void submitInPost(int? postId) {
    emit(SubmitPostLoadingState());
    DioHelper.putData(url: "api/posts/submit/$postId", data: {})
        .then((value) => {
              if (value.data["status"] == "success")
                {
                  emit(SubmitPostSuccessfullyState()),
                  getPosts(0, 20),
                }
              else
                {
                  emit(SubmitPostErrorState(value.data["message"]))
                },
            })
        .catchError((error) {
      emit(SubmitPostErrorState(error));
      print(error);
    });
  }
}
