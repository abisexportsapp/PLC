// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:plc_project/Constant/buttons.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dropdown.dart';
import 'package:plc_project/Constant/loading.dart';

import 'package:plc_project/Constant/text.dart';
// import 'package:plc_project/Constant/textfields.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BinstockrhmsPage extends StatefulWidget {
  final String selectedPlant;

  const BinstockrhmsPage({super.key, required this.selectedPlant});

  @override
  State<BinstockrhmsPage> createState() => _BinstockrhmsPageState();
}

class _BinstockrhmsPageState extends State<BinstockrhmsPage> {
  bool isLoading = true;
  bool isLoadingsubmit = false;
  bool binSelected = false;
  List<Map<String, String>> binList = [];
  List<Map<String, String>> materialList = [];
  List<Map<String, String>> transferfromList = [];

  String selectedBin = '';
  String selectedBinSize = ''; // To store the bin size of the selected bin
  String selectedMaterial = '';
  String selectedMaterialCode = '';
  // String? selectedTransferFrom;
  String selectedtransferfrom = '';
  String selectedtransferfromCode = '';
  String selectedtransferfromType = '';
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the page is loaded
  }

  Future<void> fetchData() async {
    // Make API calls to fetch bin details and material details
    await Future.wait([bindetail(), materialdetail(), transferfromdetail()]);
  }

  Future<void> bindetail() async {
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';

    final response = await http.get(
      Uri.parse(
        "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/BinDetailsSet?\$filter= Werks eq '${widget.selectedPlant}'",
      ),
      headers: {'authorization': basicAuth, 'accept': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      var binData = data['d']['results'][0]['BinName'];

      List<dynamic> rawBinList = List.from(json.decode(binData));
      setState(() {
        binList = rawBinList.map((e) {
          return {
            "binName": e['binName'].toString(),
            "binSize": e['binSize'].toString(),
          };
        }).toList();

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> transferfromdetail() async {
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';

    final response = await http.get(
      Uri.parse(
        "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/StorageLocation_DetailsSet?\$filter= Plant eq '${widget.selectedPlant}'",
      ),
      headers: {'authorization': basicAuth, 'accept': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      var transferfromData = data['d']['results'][0]['StorageLoc'];

      List<dynamic> rawTransferFromList =
          List.from(json.decode(transferfromData));
      setState(() {
        transferfromList = rawTransferFromList.map((e) {
          return {
            "lgort": e['lgort'].toString(),
            "lgobe": e['lgobe'].toString(),
            "storageType": e['storageType'].toString(),
          };
        }).toList();

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> materialdetail() async {
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';

    final response = await http.get(
      Uri.parse(
        "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/MaterialDetailsSet?\$filter= Werks eq '${widget.selectedPlant}'",
      ),
      headers: {'authorization': basicAuth, 'accept': 'application/json'},
    );
    print(response.body);
    print(widget.selectedPlant);

    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      var materialData = data['d']['results'][0]['MaterialValue'];

      List<dynamic> rawMaterialList = List.from(json.decode(materialData));
      setState(() {
        materialList = rawMaterialList.map((e) {
          return {
            "maktx": e['maktx'].toString(),
            "matnr": e['matnr'].toString(),
          };
        }).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onBinSelected(String binName, String binSize) {
    setState(() {
      selectedBin = binName;
      selectedBinSize = binSize;
      binSelected = true; // Show rest of the UI after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .appBarBackgroundColor,
      ),
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
                        data: 'Bin Stock',
                        size: 16,
                        weight: FontWeight.w700,
                      ),
                      snap: false,
                      pinned: true,
                      floating: false,
                    ),
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDateTimeHeader(),
                      const SizedBox(height: 16),
                      Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SAPText(
                                data: "Selected Plant :",
                                size: 14,
                                weight: FontWeight.bold,
                              ),
                              SAPText(
                                data: widget.selectedPlant,
                                size: 14,
                                weight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      isLoading
                          ? Center(child: SAPLoadingIndicator())
                          : Column(
                              children: [
                                if (!binSelected)
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                if (!binSelected)
                                  Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SAPText(
                                            data: "Please Select Bin :",
                                            size: 14,
                                            weight: FontWeight.bold,
                                          ),
                                          SAPText(
                                            data: "",
                                            size: 14,
                                            weight: FontWeight.normal,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (!binSelected)
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                if (!binSelected)
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 30,
                                      ),
                                      itemCount: binList.length,
                                      itemBuilder: (context, index) {
                                        final bin = binList[index];
                                        return SAPCardButton(
                                          icon: "silo",
                                          name: bin['binName']!,
                                          height: 100,
                                          width: 100,
                                          onPressed: () => onBinSelected(
                                            bin['binName']!,
                                            bin['binSize']!,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                if (binSelected)
                                  Column(
                                    children: [
                                      // SizedBox(height: 10),
                                      Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SAPText(
                                                data: "Selected Bin :",
                                                size: 14,
                                                weight: FontWeight.bold,
                                              ),
                                              SAPText(
                                                data: selectedBin,
                                                size: 14,
                                                weight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SAPText(
                                                data: "Bin Capacity (TON)  :",
                                                size: 14,
                                                weight: FontWeight.bold,
                                              ),
                                              SAPText(
                                                data: selectedBinSize,
                                                size: 14,
                                                weight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SAPDropdownButton(
                                        hintText: "Select Material",
                                        name: "Material Name",
                                        items: materialList
                                            .map((e) => e['maktx']!)
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedMaterial = value!;
                                            selectedMaterialCode =
                                                materialList.firstWhere(
                                              (material) =>
                                                  material['maktx'] == value,
                                            )['matnr']!;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SAPText(
                                                data: "Material Code :",
                                                size: 14,
                                                weight: FontWeight.bold,
                                              ),
                                              SAPText(
                                                data: selectedMaterialCode,
                                                size: 14,
                                                weight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Material dropdown using SAPDropdownButton
                                      SAPDropdownButton(
                                        hintText: "Select transfer from",
                                        name: "Transfer From",
                                        items: transferfromList
                                            .map((e) => e['lgobe']!)
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedtransferfrom = value!;
                                            selectedtransferfromCode =
                                                transferfromList.firstWhere(
                                              (transferfrom) =>
                                                  transferfrom['lgobe'] ==
                                                  value,
                                            )['lgort']!;
                                            selectedtransferfromType =
                                                transferfromList.firstWhere(
                                              (transferfrom) =>
                                                  transferfrom['lgobe'] ==
                                                  value,
                                            )['storageType']!;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SAPText(
                                                data: "Transferfrom Code :",
                                                size: 14,
                                                weight: FontWeight.bold,
                                              ),
                                              SAPText(
                                                data: selectedtransferfromCode,
                                                size: 14,
                                                weight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SAPText(
                                                data: "Storage Type :",
                                                size: 14,
                                                weight: FontWeight.bold,
                                              ),
                                              SAPText(
                                                data: selectedtransferfromType,
                                                size: 14,
                                                weight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // SAPDropdownButton(
                                      //   hintText: "Select Stock Transfer From",
                                      //   name: "Transfer From ",
                                      //   items: ["Silo", "Feed Godown"],
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       selectedTransferFrom = value!;
                                      //     });
                                      //   },
                                      // ),
                                      // const SizedBox(height: 10),
                                      // SAPTextfieldWithHeader(
                                      //   name: "Quantity",
                                      //   hintText: "Enter Quantity",
                                      //   controller: quantityController,
                                      //   keyboardType: TextInputType
                                      //       .number, // Only allow numeric input
                                      //   onChanged: (value) {
                                      //     // Handle quantity changes
                                      //     print("Quantity entered: $value");
                                      //   },
                                      // ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: SAPPrimaryButton(
                                              name: "Back",
                                              onPress: () {
                                                setState(() {
                                                  binSelected = false;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  16), // Add spacing between the buttons
                                          Flexible(
                                            child: SAPPrimaryButton(
                                              name: "Submit",
                                              onPress: binpost,
                                              isLoading: isLoadingsubmit,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SAPText(
                data: label,
                size: 14,
                weight: FontWeight.bold,
              ),
              SAPText(data: value, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeHeader() {
    final currentDateTime = DateFormat('d-MMM-yyyy hh:mm a')
        .format(DateTime.now()); // Format current date and time
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SAPText(
              data: "Current Date & Time :",
              size: 14,
              weight: FontWeight.bold,
            ),
            SAPText(
              data: currentDateTime,
              size: 14,
              weight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<dynamic> items,
    String? value,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label),
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            value: item['binName'] ?? item['matnr'],
            child: Text(item['binName'] ?? item['maktx'] ?? ''),
          );
        }).toList(),
      ),
    );
  }

  Future<void> binpost() async {
    setState(() {
      isLoadingsubmit = true;
    });

    // Prepare data to send
    var payload = {
      "Werks": widget.selectedPlant,
      "BinName": selectedBin,
      "BinCapacity": selectedBinSize,
      "Matnr": selectedMaterialCode,
      "Labst": quantityController.text,
      "Uom": "TO",
      // "TrasferForm": selectedTransferFrom == "Silo" ? "S" : "G",
      "TrasferForm": selectedtransferfromType,
    };
    var jsonPayload = json.encode(payload);

    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final response = await http.post(
      Uri.parse(
          "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/BinStock_DetailsSet"),
      // ""),
      headers: {
        'authorization': basicAuth,
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      body: jsonPayload,
    );
    print(selectedBin);
    print(selectedBinSize);
    print(selectedMaterialCode);
    print(quantityController.text);

    if (response.statusCode == 201 || response.statusCode == 202) {
      // Successful response
      print("Data posted successfully: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data submitted successfully!")),
      );
      setState(() {
        isLoadingsubmit = false;
      });
    } else {
      // Handle errors
      print("Error response: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.statusCode}")),
      );
      setState(() {
        isLoadingsubmit = false;
      });
    }
  }

  // catch (e) {
  //   print("Exception occurred: $e");
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("An error occurred: $e")),
  //   );
  // } finally {

  // }
}
