import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formapplication/coommon/common_widgets.dart';
import 'package:formapplication/features/homeScreen/bloc/form_bloc_bloc.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/screens/success_screen.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  List<String> dropitems = [
    "Leave Application",
    "Docment Request",
    "Accound Opening-Bank Letter",
    "Resignation Letter",
  ];
  String radioResult = "individual";
  String dropdownSerchFielHint = "-Select Requset Type-";
  String? requestType;
  DateTime? date;
  FilePickerResult? file;
  TextEditingController behalfController = TextEditingController();
  TextEditingController reQuestTypeController = TextEditingController();
  TextEditingController subFeild1Controller = TextEditingController();
  TextEditingController subFeild2Controller = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              leading: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              title: myText(
                  text: "HR Request Form", size: 20, color: Colors.white),
              actions: const [
                Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                )
              ],
              bottom: TabBar(
                  dividerHeight: 8,
                  labelPadding: EdgeInsets.zero,
                  dividerColor: Colors.white,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    GestureDetector(
                      onTap: () {
                        provider.radioResult = "individual";
                        context
                            .read<FormBlocBloc>()
                            .add(RadioButtonClickedEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: radioResult == "individual"
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: myText(
                              text: "Individual",
                              size: 18,
                              color: radioResult == "individual"
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        radioResult = "on behalf";
                        context
                            .read<FormBlocBloc>()
                            .add(RadioButtonClickedEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: radioResult == "individual"
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: myText(
                              text: "On Behalf Of",
                              size: 18,
                              color: radioResult == "individual"
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            )),
                      ),
                    ),
                  ]),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                      Container(
                        height: 55,
                        child: DropDownSearchField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: reQuestTypeController,
                            decoration: InputDecoration(
                                labelText: "Select Requset Type",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                                suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                border: const OutlineInputBorder(),
                                hintText: dropdownSerchFielHint,
                                hintStyle: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: dropdownSerchFielHint ==
                                            "-Select Requset Type-"
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                          displayAllSuggestionWhenTap: true,
                          suggestionsCallback: (String pattern) {
                            return dropitems.where((element) => element
                                .toUpperCase()
                                .contains(pattern.toUpperCase()));
                          },
                          itemBuilder: (BuildContext context, itemData) {
                            return Container(
                              padding: const EdgeInsets.only(left: 8),
                              height: 45,
                              child: Text(
                                itemData,
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          },
                          onSuggestionSelected: (Object? suggestion) {
                            dropdownSerchFielHint = suggestion.toString();

                            reQuestTypeController.text = suggestion.toString();
                            requestType = suggestion.toString();
                            context
                                .read<FormBlocBloc>()
                                .add(DropDownButtonClickedEvent());
                          },
                        ),
                      ),
                      // dropdown section

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
                      // datepicker section
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
                        child: SizedBox(
                          height: 66,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 55,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 117, 117, 117)),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      myText(
                                          text: date == null
                                              ? "-Select Required Date-"
                                              : "${date!.day}/${date!.month}/${date!.year}",
                                          size: 18,
                                          color: date == null
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                      const Icon(Icons.calendar_month)
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                color: Colors.white,
                                child: const Text(
                                  "  Select Required Date",
                                  style: TextStyle(
                                      fontSize: 13.5, color: Colors.grey),
                                ),
                              )
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
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
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
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 23,
                                        color: Theme.of(context).primaryColor,
                                      ))
                                ],
                              ),
                            ),
                      mySpacer(height: 20),
                      Container(
                        child: TextField(
                          controller: remarksController,
                          minLines: 2,
                          maxLines: 3,
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Remarks",
                              labelText: "Remarks",
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                              border: OutlineInputBorder(),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                        ),
                      ),
                      mySpacer(height: 20),
                      // submit section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              radioResult = "individual";
                              dropdownSerchFielHint = "-Select Requset Type-";
                              requestType = null;
                              date = null;
                              file = null;
                              behalfController.clear();
                              subFeild1Controller.clear();
                              subFeild2Controller.clear();
                              purposeController.clear();
                              reQuestTypeController.clear();
                              remarksController.clear();
                              context
                                  .read<FormBlocBloc>()
                                  .add(RadioButtonClickedEvent());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 40,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: myText(
                                    text: "Clear",
                                    size: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
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
                              width: MediaQuery.of(context).size.width / 2 - 40,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: myText(
                                    text: "Submit",
                                    size: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
