abstract class TlawaState {}

class TlawaInitialState extends TlawaState {}

class GetPostSuccessfullyState extends TlawaState {}

class GetPostErrorState extends TlawaState {
  final String error;

  GetPostErrorState(this.error);

}class AddPostSuccessfullyState extends TlawaState {}

class AddPostErrorState extends TlawaState {
  final String error;

  AddPostErrorState(this.error);
}

class ChangeBottomSheetState extends TlawaState {}
