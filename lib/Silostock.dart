// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/loading.dart';
import 'package:plc_project/Constant/text.dart';
import 'package:theme_provider/theme_provider.dart';

class Silostockpage extends StatefulWidget {
  final String selectedPlant;
  const Silostockpage({super.key, required this.selectedPlant});

  @override
  State<Silostockpage> createState() => _SilostockpageState();
}

class _SilostockpageState extends State<Silostockpage> {
  bool isLoading = true;
  List<Map<String, dynamic>> siloStockData = [];

  @override
  void initState() {
    super.initState();
    fetchSiloStockData();
  }

  Future<void> fetchSiloStockData() async {
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/SAPStock_DetailsSet?\$filter=Werks eq '${widget.selectedPlant}'",
        ),
        headers: {'authorization': basicAuth, 'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());

        if (data['d'] != null && data['d']['results'] is List<dynamic>) {
          siloStockData = (data['d']['results'] as List<dynamic>)
              .map<Map<String, dynamic>>((entry) => {
                    'materialGroup': entry['MaterialGroup'] ?? '',
                    'werks': entry['Werks'] ?? '',
                    'matnr': entry['Matnr'] ?? '',
                    'maktx': entry['Maktx'] ?? '',
                    'silo': entry['Silo'] ?? '',
                    // 'godown': entry['Godown'] ?? '',
                    'uom': entry['Uom'] ?? '',
                  })
              .toList();
        } else {
          throw Exception("Unexpected data structure in response");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                        data: 'Silo Stock',
                        size: 16,
                        weight: FontWeight.w700,
                      ),
                      snap: false,
                      pinned: true,
                      floating: false,
                    ),
                  ];
                },
                body: isLoading
                    ? Center(child: SAPLoadingIndicator())
                    : siloStockData.isEmpty
                        ? Center(child: Text('No data available'))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  _buildDataTable(),
                                ],
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Silo Stock Report",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.resolveWith(
                  (states) => Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                columns: const [
                  DataColumn(label: Text("Material Group")),
                  DataColumn(label: Text("Plant Code")),
                  DataColumn(label: Text("Material Code")),
                  DataColumn(label: Text("Material Description")),
                  DataColumn(label: Text("Silo Qty.")),
                  // DataColumn(label: Text("Godown Qty.")),
                  DataColumn(label: Text("UOM")),
                ],
                rows: siloStockData.map((data) {
                  return _buildDataRow(
                    data['materialGroup'],
                    data['werks'],
                    data['matnr'],
                    data['maktx'],
                    data['silo'],
                    // data['godown'],
                    data['uom'],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(
    String materialGroup,
    String plantCode,
    String materialCode,
    String materialDescription,
    String silo,
    // String godown,
    String uom,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(materialGroup)),
        DataCell(Text(plantCode)),
        DataCell(Text(materialCode)),
        DataCell(Text(materialDescription)),
        DataCell(Text(silo)),
        // DataCell(Text(godown)),
        DataCell(Text(uom)),
      ],
    );
  }
}


// Widget _buildRow(String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//         ),
//         Text(
//           value,
//           style: TextStyle(fontSize: 14),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildTableHeader() {
//   return Container(
//     color: Colors.grey[300],
//     child: Row(
//       children: [
//         _buildCell('Plant', isHeader: true),
//         _buildCell('BIN', isHeader: true),
//         _buildCell('Material Code', isHeader: true),
//         _buildCell('Material Description', isHeader: true),
//       ],
//     ),
//   );
// }

// Widget _buildTableRow(Map<String, dynamic> data) {
//   return Row(
//     children: [
//       _buildCell(data['werks']),
//       _buildCell(data['bin']),
//       _buildCell(data['matnr']),
//       _buildCell(data['maktx']),
//     ],
//   );
// }

// Widget _buildCell(String value, {bool isHeader = false}) {
//   return Expanded(
//     child: Container(
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(
//         value,
//         style: TextStyle(
//           fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
//           fontSize: isHeader ? 14 : 12,
//         ),
//       ),
//     ),
//   );
// }
