import 'package:adealy/modules/login/cubit/cubit.dart';
import 'package:adealy/modules/sign-up/cubit/cubit.dart';
import 'package:adealy/modules/sign-up/sign_up_screen.dart';
import 'package:adealy/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/layout_screen.dart';
import 'modules/el-quran/el_quran.dart';
import 'modules/el-salah/el_salah_screen.dart';
import 'modules/el-tlawa/el_tlawa_screen.dart';
import 'modules/el_ada3ea/el_ada3ea_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/ranking/ranking_scree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..createDb()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => SignUpCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: SignUpScreen(),
        ),
      ),
    );
  }
}
