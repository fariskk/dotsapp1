part of 'form_bloc_bloc.dart';

sealed class FormBlocState {}

final class FormBlocInitial extends FormBlocState {}

class FormValidationSuccessState extends FormBlocState {}

class FormValidationFailedState extends FormBlocState {
  String message;
  FormValidationFailedState({required this.message});
}
