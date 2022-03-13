import 'package:adealy/models/surah/surah.dart';
import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/cubit/cubit.dart';
import 'package:adealy/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Surah_Quran_Screen extends StatelessWidget {
  const Surah_Quran_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        cubit.getSurahList();

        return Scaffold(
          appBar: AppBar(
            leading: Image.asset("assets/images/logo-white.png"),
            title: const Text("اَلْقُرْآنِ اَلْكَرِيمِ"),
          ),
          body: cubit.surahs!.isEmpty
              ? Center(
                  child: loadingShimmer(
                    height: 100,
                    width: 100,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),

                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        height: 2.0,
                      );
                    },
                    itemCount: cubit.surahs!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          "${cubit.surahs![index].number}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        title: Text(
                          "${cubit.surahs![index].name}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text(
                            "${cubit.surahs![index].englishNameTranslation}"),
                        trailing: Text(
                          "${cubit.surahs![index].englishName}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SurahAyats(
                          //       ayatsList: _surahs![index].ayahs,
                          //       surahName: _surahs![index].name,
                          //       surahEnglishName: _surahs![index].englishName,
                          //       englishMeaning:
                          //       _surahs![index].englishNameTranslation,
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
