import 'dart:io';
import 'package:http/http.dart' as http;

final baseUrl = 'http://markbuilders.in/admin/api';

class NetworkUtils {
  static String token;
  static final login = baseUrl + "/login";
  static final adtask = baseUrl + "/admin_task";
  static final adviewattndce = baseUrl + "/admin_view_attendance";
  static final viewemplyees = baseUrl + "/admin_view_employees";
  static final getdeprtmnt = baseUrl + "/get_departments";
  static final viewproject = baseUrl + "/admin_view_projects";
  static final viewclient = baseUrl + "/admin_view_clients";
  static final viewleave = baseUrl + "/admin_view_leave";
  static final addemployeee = baseUrl + "/admin_add_employees";
  static final getdesignation = baseUrl + "/get_designation";
  static final adminaddclients = baseUrl + "/admin_add_clients";
  static final adminaddprojects = baseUrl + "/admin_add_projects";
  static final adminviewholiday = baseUrl + "/admin_view_holiday";
  static final adminviewcalendar = baseUrl + "/admin_view_calendar";
  static final adminaddcalendar = baseUrl + "/admin_add_calendar";
  static final adminaddholiday = baseUrl + "/admin_add_holiday";
  static final adminaddAttendance = baseUrl + "/admin_add_attendance";
  static final clientid = baseUrl + "/get_client_id";
  static final getemployeeid = baseUrl + "/get_employee_id";
  static final dailysta = baseUrl + "/daily_status";
  static final getinvo = baseUrl + "/get_invoices";
  static final admingetmatrilrqs = baseUrl + "/material_requests";
  static final adminpurchaseord = baseUrl + "/purchase_orders";
  static final adminupdteleavsts = baseUrl + "/update_leavestatuses";
  static final getproje = baseUrl + "/get_projects";
  static final getemployees = baseUrl + "/get_employees";
  static final getvendor = baseUrl + "/vendors";
  static final getitems = baseUrl + "/items";
  static final addmatreq = baseUrl + "/add_materialrequest";
  static final getunemloyees = baseUrl + "/get_unemployees";
  static final moneytrnsfrview = baseUrl + "/money_transfer";
  static final addmoneytrnsfr = baseUrl + "/add_moneytransfer";
  static final adupdatematreqq = baseUrl + "/update_materialrequest";
  static final adpurchseupdtion = baseUrl + "/update_admin_materialpurchase";
  static final addailyexpanseview = baseUrl + "/admin_daily_expanse";
  static final adminupdatedailyexpncee =
      baseUrl + "/admin_update_daily_expanse";
  static final adminviewemploytask = baseUrl + "/admin_view_task";

  /// Stafff
  static final staffviewholiday = baseUrl + "/staff/staff_view_holiday";
  static final staffviewtask = baseUrl + "/staff/staff_task";
  static final staffaddleave = baseUrl + "/staff/staff_add_leave";
  static final staffviewleave = baseUrl + "/staff/staff_view_leave";
  static final staffviewdailystatus = baseUrl + "/staff/staff_view_dailystatus";
  static final staffaddatttendence = baseUrl + "/staff/staff_add_attendance";
  static final staffadddailystats = baseUrl + "/staff/staff_add_dailystatus";
  static final staffAddMatreq = baseUrl + "/staff/staff_add_materialrequest";
  static final stffviewmatreq = baseUrl + "/staff/staff_material_requests";
  static final stffviewmoneyonhand = baseUrl + "/staff/money_onhand";
  static final stffviewdailyexpance = baseUrl + "/staff/staff_daily_expanse";
  static final staffupdatedailyexpance =
      baseUrl + "/staff/staff_update_daily_expanse";
  static final staffdailytaskview = baseUrl + "/staff/staff_view_task";
  static final staffadddailytask = baseUrl + "/staff/staff_add_task";

  static Future<http.Response> httpget(String url,
      {Map<String, dynamic> headers}) async {
    final res = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token,
    });
    return res;
  }

  static Future<http.Response> httppost(String url,
      {Map<String, dynamic> headers, Map<String, dynamic> body}) async {
    final res = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer " + token,
        },
        body: body);
    return res;
  }
}
