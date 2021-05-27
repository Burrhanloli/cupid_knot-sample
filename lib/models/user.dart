class CupidKnotUser {
  CupidKnotUser({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.dob,
    this.religion,
    this.income,
    this.gender = 'male',
    this.isPrivacyPrivate = true,
  });

  factory CupidKnotUser.empty() {
    return CupidKnotUser(dob: DOB.empty());
  }

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final DOB? dob;
  final String? religion;
  final String? income;
  final String? gender;
  final bool? isPrivacyPrivate;

  CupidKnotUser copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DOB? dob,
    String? religion,
    String? income,
    String? gender,
    bool? isPrivacyPrivate,
  }) {
    return CupidKnotUser(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      religion: religion ?? this.religion,
      income: income ?? this.income,
      gender: gender ?? this.gender,
      isPrivacyPrivate: isPrivacyPrivate ?? this.isPrivacyPrivate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'dob': dob!.toMap(),
      'religion': religion,
      'income': income,
      'gender': gender,
      'isPrivacyPrivate': isPrivacyPrivate,
    };
  }

  factory CupidKnotUser.fromMap(Map<String, dynamic> map) {
    return CupidKnotUser(
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      dob: DOB.fromMap(map['dob']),
      religion: map['religion'],
      income: map['income'],
      gender: map['gender'],
      isPrivacyPrivate: map['isPrivacyPrivate'],
    );
  }

  @override
  String toString() {
    return 'CupidKnotUser(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, dob: $dob, religion: $religion, income: $income, gender: $gender, isPrivacyPrivate: $isPrivacyPrivate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CupidKnotUser &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.dob == dob &&
        other.religion == religion &&
        other.income == income &&
        other.gender == gender &&
        other.isPrivacyPrivate == isPrivacyPrivate;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        dob.hashCode ^
        religion.hashCode ^
        income.hashCode ^
        gender.hashCode ^
        isPrivacyPrivate.hashCode;
  }
}

class DOB {
  DOB({
    this.month,
    this.year,
    this.day,
  });

  factory DOB.empty() {
    return DOB();
  }

  final String? month;
  final String? year;
  final String? day;

  DOB copyWith({
    String? month,
    String? year,
    String? day,
  }) {
    return DOB(
      month: month ?? this.month,
      year: year ?? this.year,
      day: day ?? this.day,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'year': year,
      'day': day,
    };
  }

  factory DOB.fromMap(Map<String, dynamic> map) {
    return DOB(
      month: map['month'],
      year: map['year'],
      day: map['day'],
    );
  }

  @override
  String toString() => 'DOB(month: $month, year: $year, day: $day)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DOB &&
        other.month == month &&
        other.year == year &&
        other.day == day;
  }

  @override
  int get hashCode => month.hashCode ^ year.hashCode ^ day.hashCode;
}
