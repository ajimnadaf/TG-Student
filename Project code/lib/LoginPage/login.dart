// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_app/GlobalClasses/NetworkingIO.dart';
import 'package:student_app/GlobalClasses/Glb.dart' as Glb;
import 'package:student_app/LoginPage/Dashboard/HomePage.dart';
// Note: You'll likely need a package like 'shared_preferences' for the 'saveToSp' equivalent
// import 'package:shared_preferences/shared_preferences.dart';

// --- Global variables ---
bool isLoading = false;
String response = "";
String ips_fetched = "";

// --- Model for student login info (Expanded to hold all enrollment lists) ---
class StudentLoginInfoObj {
  final String userid;
  final String name;
  final String password;
  // Student enrollment lists (only a subset shown for brevity)
  final List<String> instIdList;
  final List<String> classIdList;
  // Institute details lists
  final List<String> instNameList;
  final List<String> instExpiryList;

  StudentLoginInfoObj({
    required this.userid,
    required this.name,
    required this.password,
    required this.instIdList,
    required this.classIdList,
    required this.instNameList,
    required this.instExpiryList,
  });
}

// --- Global Map to store login info ---
Map<String, StudentLoginInfoObj> studentLoginInfoMap = {};

List inst_id_lst = [];
String ip1 = "";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordSameAsLogin = false;
  bool _obscurePassword = true;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SocketService socketService = SocketService();
  String serverResponse = '';

  // Lists to hold institute names/details temporarily after fetching
  final List<String> _instNameList = [];
  final List<String> _instExpiryList = [];
  final List<String> _instStatusList = [];
  final List<String> _instAdtpList = [];
  final List<String> _custAdvUrlList = [];

  // Lists to hold sibling data
  List<String> Glb_sbusrid_lst = [];
  List<String> Glb_subusrname_lst = [];

  // Lists to hold advertisement data
  List<String> Glb_adid_lst = [];
  List<String> Glb_adtp_lst = [];

  @override
  void initState() {
    super.initState();

    // If user edits password manually, uncheck the checkbox
    _passwordController.addListener(() {
      if (_isPasswordSameAsLogin &&
          _passwordController.text != _loginController.text) {
        setState(() {
          _isPasswordSameAsLogin = false;
          _obscurePassword = true;
        });
      }
    });
  }

  // --- Helper: Convert raw string to structured map ---
  Map<String, List<String>> processRecords(String input) {
    List<String> records =
        input.split('record#').where((record) => record.isNotEmpty).toList();

    Map<String, List<String>> resultMap = {};

    for (var record in records) {
      List<String> items = record.split('&');
      for (var item in items) {
        List<String> parts = item.split('#');
        if (parts.length == 2) {
          String key = parts[0];
          String value = parts[1];
          resultMap.putIfAbsent(key, () => []);
          resultMap[key]!.add(value);
        }
      }
    }
    return resultMap;
  }

  // --- Fetch institute details (Now accumulates all results) ---
  Future<String> handleLoginGetInstituteNames() async {
    // Clear previous results before fetching new ones
    _instNameList.clear();
    _instExpiryList.clear();
    _instStatusList.clear();
    _instAdtpList.clear();
    _custAdvUrlList.clear();

    // Safety check: Glb.inst_id_lst must contain List<String>
    List<String> instIds = Glb.inst_id_lst.map((e) => e.toString()).toList();

    for (String instid_for_det in instIds) {
      String query =
          "select instname,expiry,status,ip1,adtp,custadurl from trueguide.pinsttbl where instid='$instid_for_det' and status='1'";
      print("query $query");

      response = await socketService.sendMessage(Glb.ip, Glb.port, query, 709, msg: '');
      print("response in handleLoginGetInstituteNames: $response");

      if (response != "0") {
        try {
          Map<String, List<String>> processedData = processRecords(response);

          // Append results from each institute query to the running lists
          _instNameList.addAll(processedData['X^1_1'] ?? []);
          _instExpiryList.addAll(processedData['X^2_2'] ?? []);
          _instStatusList.addAll(processedData['X^3_3'] ?? []);

          // Update ip1 logic (only uses the first returned ip1, typical for central connection)
          if ((processedData['X^4_4'] ?? []).isNotEmpty) {
            ip1 = processedData['X^4_4']![0];
            // You can implement the complex splitting logic here if required
          }

          _instAdtpList.addAll(processedData['X^5_5'] ?? []);
          _custAdvUrlList.addAll(processedData['X^6_6'] ?? []);
        } catch (e) {
          print("Error processing institute data: $e");
          return "INST_PROCESSING_ERROR";
        }
      }
      // Note: Original Java/Android logic often used the first successful response's IP (ip1) for subsequent connections.
    }
    return "Success";
  }

  // --- Main login function ---
  Future<String> loginFuture(String loginController, String password) async {
    try {
      // 1️⃣ First query - user validation
      String query =
          "select usrid,usrname,password,devid,fbmsgdevid,fbmsgtkn,devid2,fbmsgdevid2,fbmsgtkn2,devid3,fbmsgdevid3,fbmsgtkn3,userphotolink from trueguide.tusertbl where mobno='$loginController' and status='1'";
      print("Query is :$query");

      response = await socketService.sendMessage(Glb.ip, Glb.port, query, 709, msg: '');
      print("response in loginFuture async (User validation): $response");

      setState(() => serverResponse = response);

      if (serverResponse == "2") return "NOREG";
      if (serverResponse == "101") return "SERVER_ERROR";

      Map<String, List<String>> processedData = processRecords(serverResponse);

      // Store fetched user details into Glb
      Glb.userid = processedData['X^1_1']![0];
      Glb.student_name = processedData['X^2_2']![0];
      Glb.rcv_password = processedData['X^3_3']![0];
      Glb.devid = processedData['X^4_4']![0];
      Glb.fbmsgdevid = processedData['X^5_5']![0];
      Glb.fbmsgtkn = processedData['X^6_6']![0];
      Glb.batchid_lst = processedData['X^7_7'] ?? [0];
      Glb.ctype_lst = processedData['X^8_8'] ?? [0];
      Glb.year_lst = processedData['X^9_9'] ?? [0];
      Glb.subdiv_lst = processedData['X^10_10'] ?? [0];
      Glb.atttype_lst = processedData['X^11_11']! ?? [0];
      Glb.update_info_lst = processedData['X^12_12'] ?? [];
      Glb.dplink = processedData['X^13_13']![0]; // User photo link

      // 🔴 ANDROID LOGIC: Password Validation
      if (Glb.rcv_password != password) {
        return "PASSWORD_ERROR";
      }
    } catch (e) {
      print("Error in first query (User validation): $e");
      return "Login Error";
    }

    try {
      // 2️⃣ Second query - version control
      String query1 =
          "select version,link from trueguide.tversionctrltbl where module='${Glb.Module_ID}' and role='${Glb.Role_id}'";
      print("2nd Query: $query1");

      String response2 =
          await socketService.sendMessage(Glb.ip, Glb.port, query1, 709, msg: '');
      print("response in loginFuture async (Version control): $response2");

      setState(() => serverResponse = response2);

      Map<String, List<String>> processedData = processRecords(serverResponse);
      Glb.app_version_in_db = processedData['X^1_1']![0];
      Glb.app_link = processedData['X^2_2']![0];
    } catch (e) {
      print("Error in second query (Version control): $e");
      // This is often treated as a soft error, login continues
    }

    try {
      // 3️⃣ Third query - student enrollment info
      if (int.parse(Glb.userid) > 0) {
        String query3 =
            "select studid,tstudenttbl.instid,tstudenttbl.classid,secdesc,rollno,tstudenttbl.status,tstudenttbl.batchid,tstudenttbl.ctype,year,subdiv,atttype,updt from trueguide.tstudenttbl,trueguide.tinstclasstbl where usrid='${Glb.userid}' and tinstclasstbl.classid=tstudenttbl.classid and tstudenttbl.ctype='0' and tstudenttbl.instid=tinstclasstbl.instid and tstudenttbl.ctype=tinstclasstbl.ctype and tstudenttbl.batchid=tinstclasstbl.batchid and (status='1' or status='100')";
        print("Query3 is: $query3");

        String response3 =
            await socketService.sendMessage(Glb.ip, Glb.port, query3, 709, msg: '');
        print("response3 (Student Info): $response3");

        setState(() => serverResponse = response3);

        // 🔴 ANDROID LOGIC: Handle "Registered but not Enrolled"
        if (serverResponse == "ErrorCode#2") return "REG";

        if (serverResponse != 0) {
          //return "NO_ENROLLMENT_ERROR"; // More specific error

          Map<String, List<String>> processedData =
              processRecords(serverResponse);

          // Store all enrollment details into Glb lists (as simulated from Java)
          Glb.student_id_lst = processedData['X^1_1'] ?? [];
          Glb.inst_id = processedData['X^2_2']![0];
          Glb.classid = processedData['X^3_3']![0];
          Glb.sec_id = processedData['X^4_4']![0];
          Glb.roll_no_lst = processedData['X^5_5'] ?? [];
          Glb.Status_lst = processedData['X^6_6'] ?? [];
          Glb.batchid_lst = processedData['X^7_7'] ?? [];
          Glb.ctype_lst = processedData['X^8_8'] ?? [];
          Glb.year_lst = processedData['X^9_9'] ?? [];
          Glb.subdiv_lst = processedData['X^10_10'] ?? [];
          Glb.atttype_lst = processedData['X^11_11'] ?? [];
          Glb.update_info_lst = processedData['X^12_12'] ?? [];
        }

        if (Glb.inst_id_lst.isNotEmpty) {
          String instResponse = await handleLoginGetInstituteNames();
          if (instResponse != "Success") return "INST_ERROR";
        }

        // Save primary user/enrollment info to global map
        studentLoginInfoMap[Glb.userid] = StudentLoginInfoObj(
          userid: Glb.userid,
          name: Glb.student_name,
          password: Glb.rcv_password,
          instIdList: Glb.inst_id_lst.map((e) => e.toString()).toList(),
          classIdList: Glb.classid_lst.map((e) => e.toString()).toList(),
          instNameList:
              _instNameList, // Use the lists populated by handleLoginGetInstituteNames
          instExpiryList: _instExpiryList,
        );

        // 4️⃣ Fourth Query - Fetch Sibling IDs
        String query4 =
            "select sbusrid,usrname from trueguide.tsiblingtbl,trueguide.tusertbl where tsiblingtbl.usrid='${Glb.userid}' and sbusrid=tusertbl.usrid and tusertbl.status='1'";
        String response4 =
            await socketService.sendMessage(Glb.ip, Glb.port, query4, 709, msg: '');
        setState(() {
          serverResponse = response4;
        });
        print("response4 (Sibling IDs): $response4");

        if (response4 != "0" && response4 != "2" && response4 != "101") {
          Map<String, List<String>> siblingData = processRecords(response4);
          Glb_sbusrid_lst = siblingData['X^1_1'] ?? [];
          Glb_subusrname_lst = siblingData['X^2_2'] ?? [];

          // 5️⃣ Fifth Query - Fetch Sibling Student Details
          if (Glb_sbusrid_lst.isNotEmpty) {
            // 🔴 ANDROID LOGIC: Construct complex 'IN' clause
            String siblingIdListStr =
                Glb_sbusrid_lst.map((id) => "'$id'").join(',');
            String query5 =
                "select studid,tstudenttbl.instid,tstudenttbl.classid,secdesc,rollno,tstudenttbl.status,tstudenttbl.batchid,tstudenttbl.ctype,year,subdiv,atttype,updt from trueguide.tstudenttbl,trueguide.tinstclasstbl where usrid IN ($siblingIdListStr) and tinstclasstbl.classid=tstudenttbl.classid and tstudenttbl.ctype='0' and tstudenttbl.instid=tinstclasstbl.instid and tstudenttbl.ctype=tinstclasstbl.ctype and tstudenttbl.batchid=tinstclasstbl.batchid and (status='1' or status='100')";

            String response5 =
                await socketService.sendMessage(Glb.ip, Glb.port, query5, 709, msg: '');
            setState(() {
              serverResponse = response5;
            });
            print("response5 (Sibling Details): $response5");

            // 🔴 ANDROID LOGIC: Process this response and map details for each sibling
            // This typically involves creating and adding new StudentLoginInfoObj entries to studentLoginInfoMap
          }
        }

        // 6️⃣ Sixth Query - Fetch Advertisement IDs
        String query6 =
            "select adid,adtp from trueguide.tadidtbl where role='student'";
        String response6 =
            await socketService.sendMessage(Glb.ip, Glb.port, query6, 709, msg: '');
        setState(() {
          serverResponse = response6;
        });
        print("response6 (Ads): $response6");

        if (response6 != "0" && response6 != "2" && response6 != "101") {
          Map<String, List<String>> adData = processRecords(response6);
          Glb_adid_lst = adData['X^1_1'] ?? [];
          Glb_adtp_lst = adData['X^2_2'] ?? [];

          // 🔴 ANDROID LOGIC: saveToSp() equivalent
          // This part requires importing 'package:shared_preferences/shared_preferences.dart'
          // await saveAdvertisementData();
        }
      }
    } catch (e) {
      print("Error in third query (Student Info/Siblings/Ads): $e");
    }

    return "SUCCESS";
  }

  // Placeholder for Shared Preferences logic
  // Future<void> saveAdvertisementData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('adid_lst', Glb_adid_lst);
  //   await prefs.setStringList('adtp_lst', Glb_adtp_lst);
  // }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.green,
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'STUDENT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // --- Login UI ---
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/logo1.png',
                                height: 100,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Log into your account',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          // Login ID Field
                          TextFormField(
                            controller: _loginController,
                            decoration: const InputDecoration(
                              labelText: 'Login ID:',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              if (_isPasswordSameAsLogin) {
                                _passwordController.text = value;
                              }
                            },
                          ),
                          const SizedBox(height: 8),

                          // Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _isPasswordSameAsLogin,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isPasswordSameAsLogin = value ?? false;
                                    if (_isPasswordSameAsLogin) {
                                      _passwordController.text =
                                          _loginController.text;
                                      _obscurePassword = true;
                                    } else {
                                      _passwordController.clear();
                                    }
                                  });
                                },
                                activeColor: Colors.orange,
                              ),
                              const SizedBox(width: 6),
                              const Flexible(
                                child: Text(
                                  'Keep Password Same As Login ID',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password:',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Login Button
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(255, 121, 68, 1),
                                  Color.fromARGB(255, 245, 189, 58)
                                ],
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = false;
                                });

                                String loginResponse = await loginFuture(
                                  _loginController.text,
                                  _passwordController.text,
                                );

                                print('login response: $loginResponse');

                                if (loginResponse == 101) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Something went wrong! $loginResponse')),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }

                                if (loginResponse == 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'No User Found $loginResponse')),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }

                                if (loginResponse == "ErrorCode#2") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Server Responce $loginResponse'),
                                    ),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }

                                if (loginResponse == "SUCCESS") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentDashboard1(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Login failed: $loginResponse'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // QR Note
                          const Column(
                            children: [
                              Icon(Icons.qr_code_scanner,
                                  size: 60, color: Colors.black),
                              SizedBox(height: 10),
                              Text(
                                'Click scan icon to register if guided by institution,\notherwise enter Login-ID and Password',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading) Glb.showLoadingIndicator(context),
        ],
      ),
    );
  }

 // void
}
