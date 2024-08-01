import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return Localizations.override(
            context: context,
            locale: provider.language,
            child: Builder(builder: (context) {
              var language = AppLocalizations.of(context)!;

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    color: Colors.white,
                  ),
                  title: myText(
                      text: language.hrRequestForm,
                      size: 20,
                      color: Colors.white),
                  actions: [
                    // popup menu button
                    myPopUpmenubutton(provider),
                    const SizedBox(
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
                body: Stack(
                  children: [
                    SafeArea(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: SingleChildScrollView(
                            child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // on behalf section
                              myEmployeeDropDown(provider, context),
                              mySpacer(height: 20),
                              // dropdown section
                              myRequestTypeDropDown(provider, context),

                              mySpacer(height: 20),

                              Builder(builder: (context) {
                                switch (provider.requestType) {
                                  case "Docment Request":
                                    return Column(
                                      children: [
                                        myTextField(
                                            hintText: "Document Name",
                                            controller:
                                                provider.subFeild1Controller,
                                            context: context),
                                        mySpacer(height: 20),
                                      ],
                                    );
                                  case "Accound Opening-Bank Letter":
                                    return Column(
                                      children: [
                                        myTextField(
                                            hintText:
                                                "Name of the Institustion",
                                            controller:
                                                provider.subFeild1Controller,
                                            context: context),
                                        mySpacer(height: 20),
                                        myTextField(
                                            hintText:
                                                "Address of the Institustion",
                                            controller:
                                                provider.subFeild2Controller,
                                            context: context),
                                        mySpacer(height: 20),
                                      ],
                                    );
                                  default:
                                    const Text("no data");
                                }
                                return const SizedBox();
                              }),
                              // datepicker section
                              myDatePicker(context, provider),
                              mySpacer(height: 20),
                              // textarea 3
                              myTextField(
                                  hintText: "Purpose",
                                  controller: provider.purposeController,
                                  context: context),
                              mySpacer(height: 20),
                              //attach file text
                              Row(
                                children: [
                                  myText(
                                      text: getText("Attach files", context),
                                      size: 20,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),

                              mySpacer(height: 20),

                              //file picker section
                              if (provider.file == null ||
                                  provider.file!.files.isEmpty)
                                GestureDetector(
                                  onTap: () async {
                                    var res = await FilePicker.platform
                                        .pickFiles(allowMultiple: true);
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
                                          text: getText("Browse File", context),
                                          size: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 50.0 * provider.file!.count,
                                      child: ListView.builder(
                                        itemCount: provider.file!.count,
                                        itemBuilder: (context, index) =>
                                            SizedBox(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                child: myText(
                                                    text: provider.file!
                                                        .files[index].name,
                                                    size: 18),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    provider.file!.files
                                                        .removeAt(index);
                                                    provider.rebuild();
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    size: 23,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var res = await FilePicker.platform
                                            .pickFiles(allowMultiple: true);
                                        if (res != null) {
                                          for (var resFile in res.files) {
                                            bool exist = false;
                                            for (var file
                                                in provider.file!.files) {
                                              if (file.name == resFile.name) {
                                                exist = true;
                                              }
                                            }
                                            if (!exist) {
                                              provider.file!.files.add(resFile);
                                              provider.rebuild();
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Center(
                                          child: myText(
                                              text:
                                                  getText("Add File", context),
                                              size: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    mySpacer(height: 20),
                                  ],
                                ),
                              mySpacer(height: 20),
                              myTextField(
                                  hintText: "Remarks",
                                  controller: provider.remarksController,
                                  context: context,
                                  minLines: 2,
                                  maxLines: 3),

                              mySpacer(height: 20),
                              // submit section
                              myBottomButtons(provider, context),
                            ],
                          ),
                        )),
                      ),
                    ),
                    Visibility(
                      visible: provider.isLoading,
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Visibility myEmployeeDropDown(
      HomeScreenProvider provider, BuildContext context) {
    return Visibility(
      visible: provider.radioResult == "on behalf" ? true : false,
      child: Column(
        children: [
          mySpacer(height: 20),
          SizedBox(
            height: 55,
            child: DropDownSearchField(
              textFieldConfiguration: TextFieldConfiguration(
                controller:
                    TextEditingController(text: provider.selectedEmployees),
                decoration: InputDecoration(
                    labelText: getText("Select Employee", context),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle:
                        const TextStyle(fontSize: 18, color: Colors.grey),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    border: const OutlineInputBorder(),
                    hintText: getText("Select Employee", context),
                    hintStyle: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ),
              displayAllSuggestionWhenTap: true,
              suggestionsCallback: (String pattern) {
                provider.employees.remove(provider.myName);
                return provider.employees.where((element) =>
                    element.toUpperCase().contains(pattern.toUpperCase()));
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
                provider.selectedEmployees = suggestion.toString();
                provider.rebuild();
              },
            ),
          ),
        ],
      ),
    );
  }
}
