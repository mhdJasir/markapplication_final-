class Validations {

  String validateName(String value) {
    if (value.isEmpty) return 'Name is required!!!';
    return null;
  }
  String validateFirstName(String value) {
    if (value.isEmpty) return 'First Name is required!!!';
    return null;
  }
  String validateLastName(String value) {
    if (value.isEmpty) return 'Last Name is required!!!';
    return null;
  }

  String validatecombnay(String value) {
    if (value.isEmpty) return 'Combany Name is required!!!';
    return null;
  }



  String validateLogin(String value) {
    if (value.isEmpty) return 'Field is required!!!';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Password is required!!!';
    if (value.length <=4)
      return 'Minimum 5 characters needed !!!';
    else
      return null;

  }


  String validateMobile(String value) {
    if (value.isEmpty) return 'Mobile Number is required!!!';
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit !!!';
    else
      return null;
  }

  String validateOtp(String value) {
    if (value.isEmpty) return 'OTP is required!!!';
    if (value.length != 5)
      return 'OTP must be of 5 digit !!!';
    else
      return null;
  }



  String validateMail(String value) {
    if (value.isEmpty) return 'Mail is required!!!';
    return null;
  }
  String validateDesript(String value) {
    if (value.isEmpty) return 'Description is required!!!';
    return null;
  }
  String validateSalary(String value) {
    if (value.isEmpty) return 'Salary is required!!!';
    return null;
  }
  String validateProjcost(String value) {
    if (value.isEmpty) return 'ProjectCost is required!!!';
    return null;
  }
  String validatEmpId(String value) {
    if (value.isEmpty) return 'Employee Id is required!!!';
    return null;
  }










}
