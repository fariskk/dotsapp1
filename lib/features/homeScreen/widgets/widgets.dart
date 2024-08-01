import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';

import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:provider/provider.dart';

Container myTextField({
  required hintText,
  required TextEditingController controller,
  required BuildContext context,
  int? minLines,
  int? maxLines,
}) {
  return Container(
    height: 55,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Center(
      child: TextField(
        style: const TextStyle(fontSize: 18),
        controller: controller,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(),
            hintText: getText(hintText, context),
            labelText: getText(hintText, context),
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey)),
      ),
    ),
  );
}

void mySnackbar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: myText(text: text, size: 18),
      margin: const EdgeInsets.all(15)));
}

List<Widget> myTabs(BuildContext context) {
  final provider = Provider.of<HomeScreenProvider>(context);
  return [
    GestureDetector(
      onTap: () {
        if (provider.radioResult != "individual") {
          provider.clearForm();
        }
        provider.radioResult = "individual";

        provider.rebuild();
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            color: provider.radioResult == "individual"
                ? Colors.white
                : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: myText(
              text: getText("Individual", context),
              size: 18,
              color: provider.radioResult == "individual"
                  ? Theme.of(context).primaryColor
                  : Colors.white,
            )),
      ),
    ),
    GestureDetector(
      onTap: () {
        if (provider.radioResult != "on behalf") {
          provider.clearForm();
        }
        provider.radioResult = "on behalf";

        provider.rebuild();
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            color: provider.radioResult == "individual"
                ? Theme.of(context).primaryColor
                : Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: myText(
              text: getText("On Behalf Of", context),
              size: 18,
              color: provider.radioResult == "individual"
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            )),
      ),
    ),
  ];
}

PopupMenuButton<dynamic> myPopUpmenubutton(HomeScreenProvider provider) {
  return PopupMenuButton(
      icon: const Icon(
        Icons.language,
        color: Colors.white,
        size: 25,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: const Text("English"),
            onTap: () {
              provider.language = const Locale("en");
              provider.rebuild();
            },
          ),
          PopupMenuItem(
            child: const Text("عربي"),
            onTap: () {
              provider.language = const Locale("ar");
              provider.rebuild();
            },
          ),
          PopupMenuItem(
            child: const Text("हिंदी"),
            onTap: () {
              provider.language = const Locale("hi");
              provider.rebuild();
            },
          ),
        ];
      });
}

SizedBox myRequestTypeDropDown(
    HomeScreenProvider provider, BuildContext context) {
  return SizedBox(
    height: 55,
    child: DropDownSearchField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: provider.reQuestTypeController,
        decoration: InputDecoration(
            labelText: getText("Select Requset Type", context),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            border: const OutlineInputBorder(),
            hintText: getText("Select Requset Type", context),
            hintStyle: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.normal,
                color: Colors.grey)),
      ),
      displayAllSuggestionWhenTap: true,
      suggestionsCallback: (String pattern) {
        return provider.dropitems.where(
            (element) => element.toUpperCase().contains(pattern.toUpperCase()));
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
        provider.dropdownSerchFielHint = suggestion.toString();

        provider.reQuestTypeController.text = suggestion.toString();
        provider.requestType = suggestion.toString();
        provider.rebuild();
      },
    ),
  );
}

GestureDetector myDatePicker(
    BuildContext context, HomeScreenProvider provider) {
  return GestureDetector(
    onTap: () async {
      var res = await showCalendarDatePicker2Dialog(
          context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(
              firstDate: DateTime.now()),
          dialogSize: Size(MediaQuery.of(context).size.width - 80,
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
                      color: const Color.fromARGB(255, 117, 117, 117)),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText(
                      text: provider.date == null
                          ? getText("Select Required Date", context)
                          : "${provider.date!.day}/${provider.date!.month}/${provider.date!.year}",
                      size: 18,
                      color: provider.date == null
                          ? const Color.fromARGB(255, 182, 182, 182)
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
            child: Text(
              getText("Select Required Date", context),
              style: const TextStyle(fontSize: 13.5, color: Colors.grey),
            ),
          )
        ],
      ),
    ),
  );
}

Row myBottomButtons(HomeScreenProvider provider, BuildContext context) {
  return Row(
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
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: myText(
                text: getText("Clear", context), size: 20, color: Colors.white),
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
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: myText(
                text: getText("Submit", context),
                size: 20,
                color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
