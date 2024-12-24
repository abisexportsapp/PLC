// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_project/BinStockRHMS.dart';
import 'package:plc_project/Components/AlertBox.dart';
import 'package:plc_project/Components/ListTiles.dart';
import 'package:plc_project/Components/Navigation.dart';
import 'package:plc_project/Components/Settings.dart';
import 'package:plc_project/Components/Snackbars.dart';
import 'package:plc_project/Constant/buttons.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/dropdown.dart';
import 'package:plc_project/Constant/loading.dart';
import 'package:plc_project/Constant/text.dart';
import 'package:plc_project/Login.dart';
import 'package:plc_project/Report.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;

class HomepageScreen extends StatefulWidget {
  final String employeeName;
  final String roleText;
  final String employeeID;
  final String department;

  const HomepageScreen({
    super.key,
    required this.employeeName,
    required this.roleText,
    required this.employeeID,
    required this.department,
  });

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool isLogOut = false;
  List<Map<String, String>>? plants; // To store plants (key-value pairs)
  String? selectedPlant;
  bool isLoading = true;

  Future<void> logOut() async {
    setState(() {
      isLogOut = true; // Optionally set a loading state here if needed
    });
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    // Make the API call for logout
    final response = await http.get(
      Uri.parse(
        "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/EmpLogin_DetailsSet?\$filter=EmployeeEmailID eq '${widget.employeeID}' and AppActivity eq 'LOGOUT' and AppID eq 'PLT-PLC-PR' and UUID eq '1234253656tdgd' and DeviceModel eq 'f2344adas' and OSVersion eq 'fcaf77y' and AppVersion eq '0.1'",
      ),
      headers: {'authorization': basicAuth, 'accept': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      dynamic result = data['d']['results'][0]['Result'];

      if (result == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Show an error message if the logout fails
        final remarks = data['d']['results'][0]['Remarks'];
        SAPSnackBar.alert(
          context: context,
          message: remarks,
          icon: Icons.error_outline,
        );
      }
    } else {
      // Handle non-200 status codes, like network errors or server issues
      SAPSnackBar.alert(
        context: context,
        message: 'Logout failed. Please try again.',
        icon: Icons.error_outline,
      );
    }

    setState(() {
      isLogOut = false;
    });
  }

  void logOutAlert() {
    SAPAlertBox(
        context: context,
        title: "Do you want to Logout ?",
        subTitle: "",
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SAPTextButton(
                  padding: SAPDimensions.componentLeftPadding,
                  onPress: () {
                    SAPPageNavigation.back(context: context);
                    logOut();
                  },
                  name: "Yes"),
              SAPTextButton(
                  padding: SAPDimensions.componentRightPadding,
                  onPress: () => SAPPageNavigation.back(context: context),
                  name: "No")
            ],
          )
        ]);
  }

  Future<void> plantselect() async {
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      Uri.parse(
        "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/PlantMaster_DetailsSet?\$filter=EmpId eq '${widget.employeeID}'",
      ),
      headers: {'authorization': basicAuth, 'accept': 'application/json'},
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      dynamic result = data['d']['results'][0]['Result'];

      if (result == true) {
        String werksJson = data['d']['results'][0]['Werks'];
        List<dynamic> werksList =
            json.decode(werksJson); // Decode JSON string to List<dynamic>

        if (werksList.isEmpty) {
          // Show error if no plant is mapped
          SAPSnackBar.alert(
            context: context,
            message: "Employee is not mapped to any plant.",
            icon: Icons.error_outline,
          );
        } else if (werksList.length == 1) {
          // Single plant, no dropdown
          setState(() {
            plants = [
              {
                "pernr": werksList[0]['pernr'].toString(),
                "orgValue": werksList[0]['orgValue']
              }
            ];
            selectedPlant = plants![0]['orgValue'];
          });
        } else {
          // Multiple plants, show dropdown
          setState(() {
            plants = werksList.map((e) {
              return {
                "pernr": e['pernr'].toString(), // Convert pernr to String
                "orgValue":
                    e['orgValue'].toString(), // Convert orgValue to String
              };
            }).toList();
          });
        }
      } else {
        // Handle API failure case
        final remarks = data['d']['results'][0]['Remark'];
        SAPSnackBar.alert(
          context: context,
          message: remarks,
          icon: Icons.error_outline,
        );
      }
    } else {
      // Handle non-200 response
      SAPSnackBar.alert(
        context: context,
        message: "Failed to fetch plant details. Please try again.",
        icon: Icons.error_outline,
      );
    }
    setState(() {
      isLoading = false; // Stop loading indicator after the data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    plantselect(); // Call plantselect on init
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .appBarBackgroundColor),
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: ThemeProvider.themeOf(context)
                  .data
                  .extension<SAPTheme>()!
                  .appBarBackgroundColor,
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      scrolledUnderElevation: 0,
                      backgroundColor: ThemeProvider.themeOf(context)
                          .data
                          .extension<SAPTheme>()!
                          .appBarBackgroundColor,
                      title: SAPText(
                        data: 'Homepage',
                        size: 16,
                        weight: FontWeight.w700,
                      ),
                      snap: false,
                      pinned: true,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SAPListTile(
                                isUnderline: false,
                                icon: Icons.person,
                                title: widget.employeeName,
                                subtitle: 'Employee Id - ${widget.employeeID}',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: SAPText(
                                  data: 'Employee Role - ${widget.roleText}',
                                  size: 12,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      expandedHeight: 150,
                      automaticallyImplyLeading: false,
                      actions: <Widget>[
                        SAPIconButton(
                          icon: Icons.settings,
                          onPress: () {
                            SAPPageNavigation.next(
                                page: const Settings(), context: context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SAPIconButton(
                            onPress: () async {
                              logOutAlert();
                            },
                            icon: Icons.power_settings_new_rounded,
                          ),
                        ),
                      ],
                    ),
                  ];
                },
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (plants != null && plants!.length > 1)
                            SAPDropdownButton(
                              name: "Plant",
                              hintText: "Select a Plant",
                              items: plants!
                                  .map((plant) => plant['orgValue']!)
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedPlant = value; // Update selectedPlant
                                });
                              },
                            ),
                          if (plants != null && plants!.length == 1)
                            Padding(
                              padding: const EdgeInsets.only(left: 70, top: 0),
                              child: Text(
                                "Mapped Plant: ${plants![0]['orgValue']}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        padding: SAPDimensions.componentAllPadding,
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        children: [
                          // SAPCardButton.navigate(
                          //   icon: "silo",
                          //   name: "SILO Stock",
                          //   height: 120,
                          //   width: 120,
                          //   navigateTo: Silostockpage(),
                          // ),
                          // SAPCardButton.navigate(
                          //   icon: "warehouse",
                          //   name: "Feed Godown Stock",
                          //   height: 120,
                          //   width: 120,
                          //   navigateTo: Feedgodownpage(),
                          // ),
                          SAPCardButton.navigate(
                            icon: "twosilos",
                            name: "Bin Stock",
                            height: 120,
                            width: 120,
                            navigateTo: BinstockrhmsPage(
                              selectedPlant: selectedPlant ??
                                  'Please select plant', // Fallback value
                            ),
                          ),
                          SAPCardButton.navigate(
                            icon: "dayEntry",
                            name: "Report",
                            height: 120,
                            width: 120,
                            navigateTo: Reportpage(
                              selectedPlant: selectedPlant ??
                                  'Please select plant', // Fallback value
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading) SAPLoadingIndicator(),
            if (isLogOut) SAPLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
