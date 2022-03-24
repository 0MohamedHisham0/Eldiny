abstract class TlawaState {}

class TlawaInitialState extends TlawaState {}

class GetPostSuccessfullyState extends TlawaState {}

class GetPostErrorState extends TlawaState {
  final String error;

  GetPostErrorState(this.error);
}

class AddPostSuccessfullyState extends TlawaState {}

class AddPostErrorState extends TlawaState {
  final String error;

  AddPostErrorState(this.error);
}

class JoinPostSuccessfullyState extends TlawaState {}

class JoinPostLoadingState extends TlawaState {}

class JoinPostErrorState extends TlawaState {
  final String error;

  JoinPostErrorState(this.error);
}
class SubmitPostSuccessfullyState extends TlawaState {}

class SubmitPostLoadingState extends TlawaState {}

class SubmitPostErrorState extends TlawaState {
  final String error;

  SubmitPostErrorState(this.error);
}

class ChangeBottomSheetState extends TlawaState {}
