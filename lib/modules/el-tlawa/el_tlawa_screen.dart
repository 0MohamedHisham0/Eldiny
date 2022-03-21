import 'package:adealy/models/auth/sign_up_model.dart';
import 'package:adealy/models/posts/post_model.dart';
import 'package:adealy/modules/el-tlawa/cubit/cubit.dart';
import 'package:adealy/modules/el-tlawa/cubit/state.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (state is GetPostErrorState) {}

        if (state is AddPostSuccessfullyState) {
          cubit.getPosts(0, 10);
          Navigator.pop(context);
        }
        if (state is AddPostErrorState) {}
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
                        var numberOfJuzzText = numberOfJuzzController.text;
                        cubit.addPost(
                            startTime, endTime, int.parse(numberOfJuzzText));
                        print("valid");
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
                    return buildPostItem(cubit.posts!.data!.data![index]);
                  },
                ),
              );
      },
    );
  }

  Widget buildPostItem(PostData postData) {
    int shownCountSubmitted = 0;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        // color: color, <-- Don't need the color here, will cause the above issue
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurStyle: BlurStyle.normal,
            spreadRadius: -3,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
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
                        postData.timeToStart.toString(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "من :${postData.timeToStart.toString()}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "الي :${postData.timeToEnd.toString()}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  defaultButton(
                      width: 100,
                      function: () {},
                      text: "انضم الان",
                      radius: 16),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Text(" عدد المنضمين ${postData.submittedUsers!.length}"),
                      SizedBox(
                        width: 200,
                        height: 51,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildStoryItem(
                              "${postData.submittedUsers![index]}"),
                          itemCount: postData.submittedUsers!.length > 4
                              ? shownCountSubmitted = 4
                              : shownCountSubmitted =
                                  postData.submittedUsers!.length,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem(String name) => SizedBox(
        width: 45.0,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
}
