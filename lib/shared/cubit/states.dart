import 'package:adealy/models/auth/sign_up_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeScreenIndexState extends AppStates {}

class ChangeCheckBoxElFagrState extends AppStates {}

class ChangeCheckBoxElZharState extends AppStates {}

class ChangeCheckBoxElAserState extends AppStates {}

class ChangeCheckBoxElMagrbState extends AppStates {}

class ChangeCheckBoxElAshaaState extends AppStates {}

class ChangeNumberOfLeftSalahState extends AppStates {}

class SurahListSuccessfulState extends AppStates {}

class SurahListErrorState extends AppStates {
  SurahListErrorState(String error);
}

