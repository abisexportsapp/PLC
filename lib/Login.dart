// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_project/Components/Navigation.dart';
import 'package:plc_project/Components/Settings.dart';
import 'package:plc_project/Components/Snackbars.dart';
import 'package:plc_project/Constant/buttons.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/text.dart';
import 'package:plc_project/Constant/textfields.dart';
import 'package:plc_project/Homepage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Track password visibility
  bool _isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      _isLoading = true; // Set loading state to true when login is in progress
    });
    String username = 'abhinav.verma@ibgroup.co.in';
    String password = 'Reset@123';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      Uri.parse(
          "https://ibg-bi-subaccount-cf-dev-com-plt-bi-farms-manager.cfapps.ap11.hana.ondemand.com/Plc_Automation/EmpLogin_DetailsSet?\$filter=EmployeeEmailID eq '${_userIdController.text}' and AppActivity eq 'LOGIN' and AppID eq 'PLT-PLC-PR' and UUID eq '1234253656tdgd' and DeviceModel eq 'f2344adas' and OSVersion eq 'fcaf77y' and AppVersion eq '0.1'"),
      headers: {'authorization': basicAuth, 'accept': 'application/json'},
    );
    print(response.body);
    var data = json.decode(response.body.toString());
    setState(() {
      _isLoading =
          false; // Set loading state to false after response is received
    });

    if (response.statusCode == 200) {
      dynamic result = data['d']['results'][0]['Result'];
      if (result == true) {
        final employeeID = data['d']['results'][0]['EmployeeID'];
        final employeeName = data['d']['results'][0]['EmployeeName'];
        // final role = jsonResponse['d']['Role'];
        final roleText = data['d']['results'][0]['RoleText'];
        final department = data['d']['results'][0]['EmployeeEmailID'];

        // Navigate to the next page with the extracted data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomepageScreen(
              employeeID: employeeID,
              employeeName: employeeName,
              // role: role,
              roleText: roleText,
              department: department,
            ),
          ),
        );
        print(_userIdController.text);
        print(employeeID);
        print(employeeName);
        print(roleText);
        print(department);
      } else {
        // Show error if login fails
        final remarks = result = data['d']['results'][0]['Remarks'];
        SAPSnackBar.alert(
            context: context, message: remarks, icon: Icons.error_outline);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .appBarBackgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SAPIconButton(
                    icon: Icons.settings,
                    onPress: () {
                      SAPPageNavigation.next(
                          page: const Settings(), context: context);
                    },
                  ),
                ],
              ),
              Image.asset(
                'assets/loginIcon.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const SizedBox(height: 20),
              SAPText(
                data: 'Welcome to',
                size: 20,
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 10),
              SAPText(
                textAlign: TextAlign.center,
                data: 'ABIS Feed Production',
                weight: FontWeight.w700,
                size: 20,
              ),
              const SizedBox(height: 40),
              Transform.translate(
                offset: Offset(-140, 0),
                child: SAPText(
                  data: 'LOGIN',
                  size: 17,
                  weight: FontWeight.w600,
                ),
              ),
              Divider(
                thickness: 1.3,
                color: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .dividerColor,
              ),
              SAPTextfieldWithHeader(
                hintText: 'Enter your Employee ID',
                name: 'Employee ID',
                keyboardType: TextInputType.number,
                controller: _userIdController,
                textInputAction: TextInputAction.next,
                inputFormatters: [LengthLimitingTextInputFormatter(8)],
              ),
              SAPTextfieldWithHeader(
                hintText: 'Enter your Password',
                name: 'Password',
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                hide: !_isPasswordVisible,
                suffix: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible =
                          !_isPasswordVisible; // Toggle visibility
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              SAPPrimaryButton(
                onPress: () {
                  if (_userIdController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    SAPSnackBar.alert(
                        context: context,
                        message: "Please fill all the fields",
                        icon: Icons.dangerous_outlined);
                  } else {
                    loginUser(); // Trigger login process
                  }
                },
                name: 'LOGIN',
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
