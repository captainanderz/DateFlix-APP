
//6.2.1
int bdayToAge(DateTime bday) {
  int age = 0;
  var now = new DateTime.now();
  age = now.year - bday.year;
  if (now.month - bday.month < 0) {
    return age - 1;
  } else if ((now.month == bday.month) && (now.day - bday.day < 0)) {
    return age - 1;
  }
  return age;
}
//6.2.2
DateTime stringToDateTime(String bdayString) {
  print('year: ' + bdayString.substring(0,4));
  print('month: ' + bdayString.substring(5,7));
  print('day: ' + bdayString.substring(8,10));
  int year = int.parse(bdayString.substring(0,4));
  int month  = int.parse(bdayString.substring(5,7));
  int day = int.parse(bdayString.substring(8,10));
  return DateTime(year, month, day);
}