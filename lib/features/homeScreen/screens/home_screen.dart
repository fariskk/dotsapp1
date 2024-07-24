import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common_widgets.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  tabs: myTabs(context)),
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
                        visible:
                            provider.radioResult == "on behalf" ? true : false,
                        child: Column(
                          children: [
                            mySpacer(height: 20),
                            myTextField(
                                hintText: "Behalf of",
                                controller: provider.behalfController),
                          ],
                        ),
                      ),
                      mySpacer(height: 20),
                      SizedBox(
                        height: 55,
                        child: DropDownSearchField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: provider.reQuestTypeController,
                            decoration: InputDecoration(
                                labelText: "Select Requset Type",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                                suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                border: const OutlineInputBorder(),
                                hintText: provider.dropdownSerchFielHint,
                                hintStyle: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: provider.dropdownSerchFielHint ==
                                            "-Select Requset Type-"
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                          displayAllSuggestionWhenTap: true,
                          suggestionsCallback: (String pattern) {
                            return provider.dropitems.where((element) => element
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
                            provider.dropdownSerchFielHint =
                                suggestion.toString();

                            provider.reQuestTypeController.text =
                                suggestion.toString();
                            provider.requestType = suggestion.toString();
                            provider.rebuild();
                          },
                        ),
                      ),
                      // dropdown section

                      mySpacer(height: 20),

                      Builder(builder: (context) {
                        switch (provider.requestType) {
                          case "Docment Request":
                            return Column(
                              children: [
                                myTextField(
                                    hintText: "Document Name",
                                    controller: provider.subFeild1Controller),
                                mySpacer(height: 20),
                              ],
                            );
                          case "Accound Opening-Bank Letter":
                            return Column(
                              children: [
                                myTextField(
                                    hintText: "Name of the Institustion",
                                    controller: provider.subFeild1Controller),
                                mySpacer(height: 20),
                                myTextField(
                                    hintText: "Address of the Institustion",
                                    controller: provider.subFeild2Controller),
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
                            provider.date = res[0];

                            provider.rebuild();
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
                                          text: provider.date == null
                                              ? "-Select Required Date-"
                                              : "${provider.date!.day}/${provider.date!.month}/${provider.date!.year}",
                                          size: 18,
                                          color: provider.date == null
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
                          hintText: "Purpose",
                          controller: provider.purposeController),
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
                      provider.file == null
                          ? GestureDetector(
                              onTap: () async {
                                var res = await FilePicker.platform.pickFiles();
                                if (res != null) {
                                  provider.file = res;
                                  provider.rebuild();
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: myText(
                                        text: provider.file!.files[0].name,
                                        size: 18),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        provider.file = null;
                                        provider.rebuild();
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
                      TextField(
                        controller: provider.remarksController,
                        minLines: 2,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Remarks",
                            labelText: "Remarks",
                            labelStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            border: OutlineInputBorder(),
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey)),
                      ),
                      mySpacer(height: 20),
                      // submit section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.clearForm();
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
                              provider.submit(context);
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
