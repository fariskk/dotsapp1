import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formapplication/coommon/common_widgets.dart';
import 'package:formapplication/features/homeScreen/bloc/form_bloc_bloc.dart';
import 'package:formapplication/features/homeScreen/screens/success_screen.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  List dropitems = [
    "Leave Application",
    "Docment Request",
    "Accound Opening-Bank Letter",
    "Resignation Letter",
  ];
  String radioResult = "individual";
  String? requestType;
  DateTime? date;
  FilePickerResult? file;
  TextEditingController behalfController = TextEditingController();
  TextEditingController subFeild1Controller = TextEditingController();
  TextEditingController subFeild2Controller = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 209, 255),
        leading: const Icon(Icons.arrow_back),
        title: const Text("HR Request Form"),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 209, 255),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: BlocConsumer<FormBlocBloc, FormBlocState>(
              listener: (BuildContext context, FormBlocState state) {
                if (state is FormValidationFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    mySnackbar(state),
                  );
                }
                if (state is FormValidationSuccessState) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SuccessScreen()));
                }
              },
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      mySpacer(height: 20),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            boxShadow: myShadow(),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),

                        // radio section
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: RadioListTile(
                                  title: myText(text: "Individual", size: 15),
                                  value: "individual",
                                  groupValue: radioResult,
                                  onChanged: (value) {
                                    radioResult = value!;
                                    context
                                        .read<FormBlocBloc>()
                                        .add(RadioButtonClickedEvent());
                                  }),
                            ),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: RadioListTile(
                                  title: myText(text: "On behalf", size: 15),
                                  value: "on behalf",
                                  groupValue: radioResult,
                                  onChanged: (value) {
                                    radioResult = value!;
                                    context
                                        .read<FormBlocBloc>()
                                        .add(RadioButtonClickedEvent());
                                  }),
                            )
                          ],
                        ),
                      ),

                      Visibility(
                        visible: radioResult == "on behalf" ? true : false,
                        child: Column(
                          children: [
                            mySpacer(height: 20),
                            myTextField(
                                hintText: "Behalf of",
                                controller: behalfController),
                          ],
                        ),
                      ),
                      mySpacer(height: 20),

                      // dropdown section
                      Container(
                          padding: const EdgeInsets.only(top: 12, left: 7),
                          height: 55,
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 223, 221, 221),
                                    blurRadius: 3,
                                    offset: Offset(-3, 3))
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: DropdownButtonFormField(
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                            hint: const Text(
                              "    Request Type",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 182, 182, 182)),
                            ),
                            items: dropitems.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: myText(
                                  text: "    $e",
                                  size: 18,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              requestType = value.toString();
                              context
                                  .read<FormBlocBloc>()
                                  .add(DropDownButtonClickedEvent());
                            },
                          )),
                      mySpacer(height: 20),

                      Builder(builder: (context) {
                        switch (requestType) {
                          case "Docment Request":
                            return Column(
                              children: [
                                myTextField(
                                    hintText: "Document Name",
                                    controller: subFeild1Controller),
                                mySpacer(height: 20),
                              ],
                            );
                          case "Accound Opening-Bank Letter":
                            return Column(
                              children: [
                                myTextField(
                                    hintText: "Name of the Institustion",
                                    controller: subFeild1Controller),
                                mySpacer(height: 20),
                                myTextField(
                                    hintText: "Address of the Institustion",
                                    controller: subFeild2Controller),
                                mySpacer(height: 20),
                              ],
                            );
                          default:
                            const Text("no data");
                        }
                        return const SizedBox();
                      }),

                      GestureDetector(
                        onTap: () async {
                          var res = await showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(
                                      firstDate: DateTime.now()),
                              dialogSize: Size(
                                  MediaQuery.of(context).size.width - 80,
                                  MediaQuery.of(context).size.width - 80));
                          if (res != null) {
                            date = res[0];

                            context
                                .read<FormBlocBloc>()
                                .add(CalenderButtonClickedEvent());
                          }
                        },
                        // datepicker section
                        child: Container(
                          height: 55,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: myShadow(),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myText(
                                  text: date == null
                                      ? "  Required Date"
                                      : "   ${date!.day}/${date!.month}/${date!.year}",
                                  size: 19,
                                  color:
                                      const Color.fromARGB(255, 182, 182, 182),
                                  fontWeight: FontWeight.w600),
                              const Icon(Icons.calendar_month)
                            ],
                          ),
                        ),
                      ),
                      mySpacer(height: 20),
                      // textarea 3
                      myTextField(
                          hintText: "Purpose", controller: purposeController),
                      mySpacer(height: 20),
                      Row(
                        children: [
                          myText(
                              text: "Attach file",
                              size: 20,
                              fontWeight: FontWeight.bold),
                        ],
                      ),

                      mySpacer(height: 20),

                      //file picker section
                      file == null
                          ? GestureDetector(
                              onTap: () async {
                                var res = await FilePicker.platform.pickFiles();
                                if (res != null) {
                                  file = res;
                                  context
                                      .read<FormBlocBloc>()
                                      .add(DropDownButtonClickedEvent());
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: myText(
                                      text: "Browse File",
                                      size: 20,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(text: file!.files[0].name, size: 18),
                                  IconButton(
                                      onPressed: () {
                                        file = null;
                                        context
                                            .read<FormBlocBloc>()
                                            .add(DropDownButtonClickedEvent());
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        size: 23,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                      mySpacer(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            boxShadow: myShadow(),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          controller: remarksController,
                          minLines: 2,
                          maxLines: 3,
                          decoration: const InputDecoration(
                              hintText: "  Remarks",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 19,
                                  color: Color.fromARGB(255, 182, 182, 182))),
                        ),
                      ),
                      mySpacer(height: 20),
                      // submit section
                      GestureDetector(
                        onTap: () {
                          context.read<FormBlocBloc>().add(
                              SubmitButtonClickedEvent(
                                  selectedType: radioResult,
                                  date: date,
                                  file: file,
                                  behalfController: behalfController.text,
                                  purpose: purposeController.text,
                                  remark: remarksController.text,
                                  requestType: requestType,
                                  subText1: subFeild1Controller.text,
                                  subText2: subFeild2Controller.text));
                        },
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: myText(
                                text: "Submit", size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
