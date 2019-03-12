

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
