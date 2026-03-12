import 'dart:core';

import 'package:flutter/material.dart';

String ip = "101.53.149.18";
int port = 3337;

List main_stud_usrid_lst = [];
List noti_nid_lst = [];
List noti_count_lst = [];
List info_lst = [];
List nfrom_lst = [];
List noti_type_lst = [];
List nfrome_name_lst = [];
List nfrom_uid_lst = [];
List pbgroup_lst = [];

String app_version_in_db = "";
String app_link = "";

String student_name = "";
String stu_id = "";
String father_name = "";
String mother_name = "";
String student_contact = "";
String fcontact = "";
String mcontact = "";
String date_of_birth = "";
String aadhar_no = "";
String present_address = "";
String permanant_addr = "";
String email_id = "";
String gender = "";
String blood_group = "";
String admission_no = "";
String stsno = "";
String usnno = "";
String caste = "";
String category = "";
String religion = "";
String height = "";
String weight = "";


String rcv_password = "";
String devid = "";
String fbmsgdevid = "";
String fbmsgtkn = "";
String dplink = "";

List distinct_date_noti = [];

String total_trans_of_year = "";

String amount_trans = "";
String trans_email = "";
String trans_contact_no = "";
String pgtwtype_cur = "";
String rzkey_cur = "";
String rzpass_cur = "";
String sbpsclientcode_cur = "";
String sbpsusrname_cur = "";
String sbpspasswd_cur = "";
String sbpsauthkey_cur = "";
String svpsauthiv_cur = "";
List<String> update_info_lst = [];

int tot_concepts = 0;
int tot_materials = 0;
int concept_counter = 0;
int concept_material_counter = 0;

List syldatadesc_lst = [], main_stud_usrname_lst = [];
List auto_id_lst = [];
List qconcept_id_lst = [];
List file_exist_lst = [];
List islink = [];
List qconcept_name_lst = [];
List conceptid_lst = [];
List concept_lst = [];
List sdtid_lst = [];

List autoId_lst = [];
List filenames_lst = [];
List file_type = [];
List filter_id_lst = [];
List filter_subindexid_lst = [];
List filter_indexid_lst = [];
List filter_conceptid_lst = [];

String fname_cur = "";
String mobno = "";
String cnfrmpass = "";
String hw_subid = "";
String fw_dt = "";
String shwid_cur = "";
String edit_image = "";
String qconid = "";
String hwid_cur = "";
String hw_fname = "";
String filter_query = "";
String reg_instid = "";
String false_ttid_cur = "";
String atttype_cur = "";
String View_todayTT_subtype_cur = "";
String division_cur = "";
String question_str_cur = "";
String false_dt = "";
String auto_id_cur = "";
String ToteachFilename_q = "";
String screen = "";
String uid = "";
String ToteachFilename_op1 = "";
String ToteachFilename_op2 = "";
String ToteachFilename_op3 = "";
String hw_desc = "";
String ToteachFilename_op4 = "";
String Link_Lids = "";

String selected_online_exmid = "";
String subtypelst_cur = "";
String exam_end_time = "";
String selected_online_exmname = "";
String selected_online_exmdate = "";
String exam_start_time = "";
String tot_questions_str = "";
String tot_exm_marks_str = "";
String fpath = "";
String niti_from_uid = "";
String noti_info = "";
String notitype_cur = "";
String insttype_cur = "";
String notiinfo_cur = "";
String noti_from = "";
String noti_from_name = "";
String nepoch = "";
String rep_nrid_cur = "";
String tlvStr2 = "";
String doc = "";
String notiid_cur = "";
String sub_index_id_cur = "";
String index_id_cur = "";
String index_name_curr = "";
String contact_no = "";
String instname_ref = "";
String attend_type = "";
String batchid_cur = "";
String active_batchid = "";
String logo_name = "";

List concept_files_to_download = [];
List embedinapp_lst = [];
List conf_ttid_lst = [];
List subtype_lst = [];
List subdiv_lst = [];
List conf_link_lst = [];
List false_ttid_lst = [];
List false_subindexid_lst_new = [];
List false_indexid_lst_new = [];
List exm_qid_lst = [];
List exametime_eme = [];
List examid_eme_lst_opt = [];
List examname_eme = [];
List examdate_eme = [];
List examstime_eme = [];
List total_exam_ques = [];
List tot_exam_marks = [];
List att_subid_lst = [];
List batchid_lst = [];
List sub_index_id_lst = [];
List sub_index_name_lst = [];
List active_batch_name = [];
List index_id_lst = [];
List index_name_lst = [];
List View_todayTT_status = [];
List View_tomTimeTblStatus = [];
List teacherdcssid_lst = [];
List ctype_lst = [];
List year_lst = [];
List atttype_lst = [];
bool epoch_taken = false;
List consent_teacher_name = [];
List consent_subject = [];
List consent_ttid_count = [];
List concession_lst = [];
List balance_lst = [];
List paid_fees_lst = [];
List total_fees_lst = [];
List last_trans_lst = [];
List trans_date_lst = [];
List fees_paid_lst = [];
List mode_lst = [];
List scholarship_lst = [];
List checkno_lst = [];
List checkdate_lst = [];
List bankname_lst = [];
List ddno_lst = [];
List dddate_lst = [];
List scholtype_lst = [];
List scholid_lst = [];
List remark_lst = [];
List sftransid_lst = [];
List lm_due_date_lst = [];
List lm_issue_date_lst = [];
List lm_bstatus_lst = [];
List lm_publishr_lst = [];
List lm_edition_lst = [];
String Module_ID = "";
String Role_id = "";
String sftransid_cur = "";
String rep_role = "";
String examname = "";
String examsylid_cur = "";
String lm_catid_cur = "";
String question_cur = "";
String optid_cur = "";
String sysDate = "";
String leave_day = "";
String long_lst = "";
String lat_lst = "";
String driverid_lst_cur = "";
String routid_lst_cur = "";
String routeid = "";
String tripfrom_cur = "";
String tripto_cur = "";
String sfid_lst = "";
List date_lst = [];
List driverid_lst = [];
List routid_lst = [];
List fther_occid_lst = [];
List caste_nameid_lst = [];

List pinstids = [];
List psubids = [];
List pclassids = [];
List exid_perf_lst_opt = [];
List inst_expiry_lst = [];
List inst_status_lst = [];
String pinstids_cur = "";
String psubids_cur = "";
String pclassids_cur = "";
String examid_cur = "";
String sub_indexid_cur = "";
String pic_type = "";
String qid_str = "";
String inst_expiry_cur = "";
String inst_status_cur = "";
String server_epoch = "";
String server_date = "";
String Toteachid = "";
List location_lst = [];
List duration_lst = [];
List distance_lst = [];
List origin_lst = [];
List tripfrom_lst = [];
List tripto_lst = [];
List time_lst = [];
String address = "";
String duration = "";
String distance = "";
String origin_addresses = "";
String feedback_role = "";
List nfromlst = [];
List nfromuid_lst = [];
List ntype_lst = [];
List ninfo_lst = [];
int pic_count = -1;
int cur_q_ind = 0;
String ndate_cur = "";
String nepoch_cur = "";
String nfromuid_cur = "";
String nfrom_cur = "";
String ntouid_cur = "";
String ntorole_cur = "";
String ntype_cur = "";
String ninfo_cur = "";
List db_ntype_lst = [];
List db_nclassid_lst = [];
List db_nsecdesc_lst = [];
List db_ninfo_lst = [];
List db_nfromuid_lst = [];
List db_nfrom_lst = [];
List db_nid_lst = [];
String perf_since = "";
String notification_date = "";
String nid_cur = "";
String smsquota_lst_cur = "";
List nid_lst = [];
List epoch_lst = [];
List adv_lst = [];
List smsquota_lst = [];
List index_lst = [];
List sub_index_lst = [];

String SubIds_cur = "";
String main_index = "";
String sub_index_cur = "";
String cur_subject_index = "";
List issubindx_lst = [];
List topic_lst = [];

List sub_topic_lst = [];
String View_todayTT_subname_cur = "";
String ex_sub_name_cur = "";
String adv_cur = "";
String country_code = "";
String full_path = "";
String state_code = "";
String dist_code = "";
String city_code = "";
String TeacherID_Cur = "";
bool new_reg = true;
String tlvStr = "";
String mobileno = "";
String userid = "";
String hw_teacherid_cur = "";
String classid = "";
String sec_id = "";
String otp = "";
String student_id = "";
String sub_id_cur = "";
String inst_id = "";
String classid_cur = "";
String sub_id_count = "";
String class_name = "";
String roll_cur = "";
String studid_cur = "";
String sec_id_cur = "";
String reg_instname = "";
String sec_name = "";
String roll_no = "";
String classid_prof_cur = "";
List<String> sub_id = [];
List<String> sub_name = [];
List<String> inst_name = [];
List<String> instid = [];
List<String> secnamesList = [];
List<String> classid_prof = [];
List<String> class_names_prof = [];
List<String> sec_id_prof = [];
List<String> inst_type = [];
List<String> roll_list = [];
List<String> studid_list = [];

String class_name_cur = "";
String main_feature = "";
String inst_name_cur = "";
String student_instname_cur = "";
String student_insttype_cur = "";
String inst_id_reg = "";
String class_names_cur = "";
String check_opt_gen = "";
String ExamId_for_img = "";
String instid_for_det = "";

List student_id_lst = [];
List inst_id_lst = [];
List classid_lst = [];
List sec_id_lst = [];
List roll_no_lst = [];
List Status_lst = [];
List stud_insttype_cur_lst = [];
List instname_lst = [];
int approved_inst_count = -1;
int unapp_inst_count = -1;
String Status = "";
String rollno = "";
String imagePath = "";
String sysTime = "";
String profilepicname = "";
String day = "";
List sect_lst = [];
String sec_lst_cur = "";
List jobdid = [];
List title_lst = [];
List jd_lst = [];
List pakage_lst = [];
List dt_lst = [];
List opp_lst = [];
List inst_lst = [];
int shift = -1;
int tilt = -1;
List View_todayTT_timetblid = [];
String View_todayTT_timetblid_cur = "";
List View_todayTT_teacherID = [];
String View_todayTT_teacherID_cur = "";
List Check_mockStatus = [];
List View_tomTime_timetblId_lst_opt = [];
List View_fullTime_timetblId_lst_opt = [];
String Check_mockStatus_cur = "";
String Check_mockClassid_cur = "";
String Check_mockSec_cur = "";
String Check_mockRoll_cur = "";
String Check_mockInstid_cur = "";
String Check_mockUsrid_cur = "";
List Check_mockStudid = [];
List Check_mockInstid_lst = [];
String Check_mockStudid_cur = "";
String class_sub_id_count = "";
int inst_created = 1;
List View_todayTT_subid = [];
String View_todayTT_subid_cur = "";
List View_todayTT_starttime = [];
String View_todayTT_starttime_cur = "";
List CheckJoinedSub = [];
String CheckJoinedSub_cur = "";
List sectorname_lst = [];
List instid_lst = [];
List corpid_lst = [];
List sectorid_lst = [];
List coubt_lst = [];
List View_todayTT_endtime = [];
String View_todayTT_endtime_cur = "";
List View_todayTT_roomno = [];
String View_todayTT_roomno_cur = "";
List View_todayTT_Username = [];
String Faculty_tt_cur = "";
List View_todayTT_Lastname = [];
List View_todayTT_MobileNo = [];
List View_todayTT_userid = [];
String View_todayTT_userid_cur = "";
String date = "";
List FileNamesToTeach = [];
String FileNamesToTeach_cur = "";
String total_classes_taken = "";
String total_attended_classes = "";
String percentage = "";
List FileNamesclassnotes = [];
String FileNamesclassnotes_cur = "";
List FileNamesclassTask = [];
String FileNamesclassTask_cur = "";
String nextdayTom = "";
List View_tomTimeTblId = [];
String View_tomTimeTblId_cur = "";
List View_tomTimeTblTeacherId = [];
String View_tomTimeTblTeacherId_cur = "";
List View_tomTimeTblStartTime = [];
String View_tomTimeTblStartTime_cur = "";
List View_tomTimeTblSubids = [];
String View_tomTimeTblSubids_cur = "";
List View_tomTimeTblEndTime = [];
String View_tomTimeTblEndTime_cur = "";
List View_tomTimeTblRoomno = [];
String View_tomTimeTblRoomno_cur = "";
String selected_day = "";
List ExamId_MyPerf = [];
String ExamId_MyPerf_cur = "";
List Examname_MyPerf = [];
String Examname_MyPerf_cur = "";
List Marksobt_MyPerf = [];
String Marksobt_MyPerf_cur = "";
List totalMrks_MyPerf = [];
String totalMrks_MyPerf_cur = "";
List My_atend_perf_StartTime = [];
String My_atend_perf_StartTime_cur = "";
List My_atend_perf_EndTime = [];
String My_atend_perf_EndTime_cur = "";
List My_atend_perf_TimetblId = [];
String My_atend_perf_TimetblId_cur = "";
String todays_date = "";
List upcmng_perf_ExmId = [];
String upcmng_perf_ExmId_cur = "";
List upcmng_perf_SubId = [];
String upcmng_perf_SubId_cur = "";
List upcmng_perf_Exmname = [];
String upcmng_perf_Exmname_cur = "";
List psubid_lst = [];
List psubname_lst = [];
List psubtype_lst = [];
int sub_ind = 0;
List upcmng_perf_ExmDate = [];
String upcmng_perf_ExmDate_cur = "";
List upcmng_perf_startime = [];
String upcmng_perf_startime_cur = "";
List upcmng_perf_endtime = [];
String upcmng_perf_endtime_cur = "";
String calculatedweekday = "";
List My_atende_perf_attendid = [];
String My_atende_perf_attendid_cur = "";
List My_atende_perf_status = [];
String My_atende_perf_status_cur = "";
String claculatemonthday = "";
List View_exm_TT_TeacherID = [];
String View_exm_TT_TeacherID_cur = "";
List View_exm_TT_UserID = [];
String View_exm_TT_UserID_cur = "";
List View_exm_TT_username = [];
String View_exm_TT_username_cur = "";
List View_exm_TT_Filename = [];
String View_exm_TT_Filename_cur = "";
String View_exm_TT_ExamnotesFilename_cur = "";
List View_exm_TT_ExamnotesFilename = [];
String password = "";
String status = "";
List View_tomTT_userid = [];
String View_tomTT_userid_cur = "";
List View_tomTT_Username = [];
List View_tomTT_Lastname = [];
List View_tomTT_MobileNo = [];
List View_FullweekTT_userid = [];
String View_FullweekTT_userid_cur = "";
List View_FullweekTT_username = [];
List My_atende_perf_timetblid = [];
String My_atende_perf_timetblid_cur = "";
List My_atende_perf_attdate = [];
String My_atende_perf_attdate_cur = "";
List View_todaysTime_timetblId_lst_opt = [];
String ttid_cur = "";
String classAssign_count_lst = "";
String classnotes_count_lst = "";
String classtask_count_lst = "";
String toteach_count_lst = "";
List upcoming_exid_lst_opt = [];
String up_ex_id = "";
List teacherid_view_up_exms_lst_opt = [];
String teacherid_up_coming_exm = "";
String examid_perf_cur = "";
String sub_name_cur = "";
String total_classes_count_atend_perf = "";
String status_sum_atend_perf = "";
String selected_att_since = "";
String reg_cur_inst_type = "";
String toteach_pic_count = "";
String classnotes_pic_count = "";
String classtask_pic_count = "";
String classassign_pic_count = "";
String sub_feature = "";
String Syllabus_count = "";
String assignmet_text_count = "";
String notes_text_count = "";
String class_task_text_count = "";
String toteach_text_count = "";
String pic_feature = "";

// Place this inside Glb.dart or a utility class
String replaceSpecial(String input) {
  // Replicates Java: input.replaceAll("_", "").replaceAll("&", "")...
  return input.replaceAll(RegExp(r"[_&.@#?+'$=+]"), "");
}

showLoadingIndicator(BuildContext context) {
  return Positioned.fill(
    child: Container(
      color: Colors.black.withOpacity(0.5), // Faint the background
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 200, // Control the width of the loading box
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 15),
              Text(
                'Loading....',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class updateStudentDetailsToSocket {
  updateStudentDetailsToSocket(Map<String, dynamic> updatedData);
}

class fetchStudentDetailsFromSocket {}

class updateStudentField {
  updateStudentField(String field, String value);
}

class get_generic_ex {
  get_generic_ex(String questionQuery);
}

class Glb {
}
