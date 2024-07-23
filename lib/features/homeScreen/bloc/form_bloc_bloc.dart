import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

part 'form_bloc_event.dart';
part 'form_bloc_state.dart';

class FormBlocBloc extends Bloc<FormBlocEvent, FormBlocState> {
  int test = 0;
  FormBlocBloc() : super(FormBlocInitial()) {
    on<RadioButtonClickedEvent>((event, emit) {
      emit(FormBlocInitial());
    });
    on<DropDownButtonClickedEvent>((event, emit) {
      emit(FormBlocInitial());
    });
    on<CalenderButtonClickedEvent>((event, emit) {
      emit(FormBlocInitial());
    });
    on<SubmitButtonClickedEvent>((event, emit) {
      if (event.selectedType == "on behalf" && event.behalfController == "") {
        emit(FormValidationFailedState(
            message: "Please Fill the Name of Person"));
      } else if (event.requestType == null) {
        emit(FormValidationFailedState(message: "Select Your request type"));
      } else if (event.subText1 == "" &&
          (event.requestType == "Docment Request" ||
              event.requestType == "Accound Opening-Bank Letter")) {
        if (event.requestType == "Docment Request") {
          emit(FormValidationFailedState(message: "Please fill Document Name"));
        } else {
          emit(FormValidationFailedState(
              message: "Please fill Name of Institution"));
        }
      } else if (event.subText2 == "" &&
          event.requestType == "Accound Opening-Bank Letter") {
        emit(FormValidationFailedState(
            message: "Please fill Address of Institution"));
      } else if (event.date == null) {
        emit(FormValidationFailedState(message: "Select Your Required Date"));
      } else if (event.purpose == "") {
        emit(FormValidationFailedState(message: "Please fill your Purpose"));
      } else {
        emit(FormValidationSuccessState());
      }
    });
  }
}
