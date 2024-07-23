part of 'form_bloc_bloc.dart';

sealed class FormBlocEvent {}

class RadioButtonClickedEvent extends FormBlocEvent {}

class DropDownButtonClickedEvent extends FormBlocEvent {}

class CalenderButtonClickedEvent extends FormBlocEvent {}

class BrowseFileButtonClickedEvent extends FormBlocEvent {}

class SubmitButtonClickedEvent extends FormBlocEvent {
  String? selectedType;
  String? requestType;
  String? subText1;
  String? subText2;
  String? behalfController;
  DateTime? date;
  String? purpose;
  FilePickerResult? file;
  String? remark;
  SubmitButtonClickedEvent(
      {required this.selectedType,
      required this.date,
      required this.file,
      required this.purpose,
      required this.behalfController,
      required this.remark,
      required this.requestType,
      required this.subText1,
      required this.subText2});
}
