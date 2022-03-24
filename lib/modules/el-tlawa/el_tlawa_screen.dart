import 'package:adealy/models/posts/post_model.dart';
import 'package:adealy/modules/el-tlawa/cubit/cubit.dart';
import 'package:adealy/modules/el-tlawa/cubit/state.dart';
import 'package:adealy/network/local/CacheHelper.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/components/components.dart';

class el_tlawa_screen extends StatelessWidget {
  const el_tlawa_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    var timeToStartController = TextEditingController();
    var timeToEndController = TextEditingController();
    var numberOfJuzzController = TextEditingController();

    var startTime = "";
    var endTime = "";

    return BlocConsumer<TlawaCubit, TlawaState>(
      listener: (context, state) {
        var cubit = TlawaCubit.get(context);

        if (state is GetPostSuccessfullyState) {}
        if (state is GetPostErrorState) {
          toast(state.error);
        }

        if (state is AddPostSuccessfullyState) {
          toast("نجح رفع المنشور");
          cubit.getPosts(0, 20);
          Navigator.pop(context);
        }
        if (state is AddPostErrorState) {
          toast(state.error);
        }

        if (state is JoinPostErrorState) {
          toast(state.error);
        }
        if (state is JoinPostSuccessfullyState) {
          toast("نجح الانضمام");
        }

        if (state is SubmitPostSuccessfullyState) {
          toast("تهانينا لقد اتممت القراءه في الوقت المطلوب");
        }
        if (state is SubmitPostErrorState) {
          toast(state.error);
        }
      },
      builder: (context, state) {
        var cubit = TlawaCubit.get(context);

        return cubit.posts == null
            ? Center(
                child: loadingShimmer(
                  height: 300,
                  width: 300,
                ),
              )
            : Scaffold(
                key: scaffoldKey,
                floatingActionButton: FloatingActionButton(
                  child: Icon(cubit.floatingActionButtonIcon),
                  onPressed: () {
                    if (cubit.isBottomSheetShown) {
                      if (formKey.currentState!.validate()) {
                        if (toDouble(toTimeOfDay(startTime)) >
                            toDouble(toTimeOfDay(endTime))) {
                          toast("يجب انا يكون وفت البداء قبل وقت الانتهاء.");
                          return;
                        }

                        var numberOfJuzzText = numberOfJuzzController.text;
                        cubit.addPost(
                            startTime, endTime, int.parse(numberOfJuzzText));
                      } else {
                        print("not valid");
                      }
                    } else {
                      scaffoldKey.currentState!
                          .showBottomSheet(
                            (context) => Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(
                                20.0,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultTextField(
                                      controller: numberOfJuzzController,
                                      type: TextInputType.number,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'ادخل عدد الاجزاء';
                                        }
                                      },
                                      label: 'عدد الاجزاء',
                                      prefix: Icons.menu_book,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextField(
                                      isReadOnly: true,
                                      controller: timeToStartController,
                                      type: TextInputType.datetime,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeToStartController.text =
                                              value!.format(context).toString();
                                          startTime = value.toString();
                                        });
                                      },
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'ادخل وقت البدء';
                                        }
                                      },
                                      label: 'وقت البدء',
                                      prefix: Icons.watch_later_outlined,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextField(
                                      isReadOnly: true,
                                      controller: timeToEndController,
                                      type: TextInputType.datetime,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeToEndController.text =
                                              value!.format(context).toString();
                                          endTime = value.toString();
                                        });
                                      },
                                      onChange: (value) {},
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'ادخل وقت الانتهاء';
                                        }
                                      },
                                      label: 'وفت الانتهاء',
                                      prefix: Icons.access_time_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 20.0,
                          )
                          .closed
                          .then((value) {
                        cubit.changeBottomSheetState(false, Icons.post_add);
                      });
                      cubit.changeBottomSheetState(true, Icons.send);
                    }
                  },
                ),
                body: ListView.builder(
                  itemCount: cubit.posts!.data!.data!.length,
                  itemBuilder: (context, index) {
                    return buildPostItem(
                        cubit.posts!.data!.data![index], cubit, context);
                  },
                ),
              );
      },
    );
  }

  Widget buildPostItem(
      PostData postData, TlawaCubit cubit, BuildContext context) {
    String buttonName = postSchedule(
        startTime: postData.timeToStart.toString(),
        endTime: postData.timeToEnd.toString(),
        joinedUsers: postData.joined,
        submittedUsers: postData.submittedUsers);
    print(postData.id.toString() + buttonName);

    // var createdAtFormat = postData.cretedAt!.substring(0, 10) +
    //     ' ' +
    //     postData.cretedAt!.substring(11, 23);

    int shownCountSubmitted = 0;
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        // color: color, <-- Don't need the color here, will cause the above issue
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postData.publisher!.name.toString(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        formatDate(postData.cretedAt!),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              defaultDivider(paddingEnd: 0, paddingStart: 0),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${postData.numberOfJuzz}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            " اجزاء",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset:
                              const Offset(2, 5), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        postData.timeToStart!.contains("TimeOfDay")
                            ? "من :${toTimeOfDay(postData.timeToStart.toString()).format(context).toString()}"
                            : "من :${postData.timeToStart.toString()}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        postData.timeToEnd!.contains("TimeOfDay")
                            ? "الي :${toTimeOfDay(postData.timeToEnd.toString()).format(context).toString()}"
                            : "الي :${postData.timeToEnd.toString()}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              Center(
                child: defaultButton(
                    width: double.infinity,
                    height: 45,
                    function: () {
                      if (buttonName == "انضم الان") {
                        cubit.joinInPost(postData.id);
                      }
                      if (buttonName == "تم") {
                        cubit.submitInPost(postData.id);
                      }
                      if (buttonName != "تم" && buttonName != "انضم الان") {
                        toast(buttonName);
                      }
                    },
                    text: buttonName,
                    radius: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    " عدد المنضمين ${postData.joined!.length}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    " عدد المنجزين ${postData.submittedUsers!.length}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String postSchedule({
    required String startTime,
    required String endTime,
    required List<dynamic>? joinedUsers,
    required List<dynamic>? submittedUsers,
  }) {
    if (startTime.contains("TimeOfDay") && endTime.contains("TimeOfDay")) {
      var currentTimeDouble = toDouble(TimeOfDay.now());
      var startTimeDouble = toDouble(toTimeOfDay(startTime));
      var endTimeDouble = toDouble(toTimeOfDay(endTime));
      var userID = CacheHelper.getData(key: "userId");
      print(currentTimeDouble);
      print(startTimeDouble);
      print(endTimeDouble);

      //  User didn't join yet
      if (!joinedUsers!.contains(userID)) {
        //  in the top time
        if (currentTimeDouble <= startTimeDouble &&
            currentTimeDouble <= endTimeDouble) {
          return "انضم الان";
        } else {
          //  in the mid or bot
          return "لقد انتهى وقت التسجيل";
        }
      }

      //  user joined
      else {
        //  he is joined and the time is allowed to submit
        //  in the mid time
        if (currentTimeDouble >= startTimeDouble &&
            currentTimeDouble <= endTimeDouble) {
          //  USER submitted
          if (submittedUsers!.contains(userID)) {
            //  in the mid time and user submitted
            return "انت اتممت هذا التحدي";
          } else {
            return "تم";
          }
        } else {
          //  top time
          if (currentTimeDouble <= startTimeDouble &&
              currentTimeDouble <= endTimeDouble) {
            return "انتظر حتي يبداء الوقت";
          }
          //  in the bot time
          if (currentTimeDouble >= startTimeDouble &&
              currentTimeDouble >= endTimeDouble) {
            return "عفواً، لقد انتهى الوقت";
          } else {
            return "";
          }
        }
      }
    }
    //the is a problem with the time in the server side
    else {
      return "هناك مشكله في هذا المنشور";
    }
  }

  String formatDate(String date) {
    return DateFormat("EEE, d MMM yyyy HH:mm:ss").format(DateTime.parse(date));
  }
}
