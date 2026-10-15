class EmergencyContact {
  const EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phone,
  });

  final String name;
  final String relationship;
  final String phone;
}

class BankDetails {
  const BankDetails({
    required this.bankName,
    required this.accountHolder,
    required this.accountNumber,
    required this.ifsc,
    required this.branch,
  });

  final String bankName;
  final String accountHolder;
  final String accountNumber;
  final String ifsc;
  final String branch;

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    return '•••• ${accountNumber.substring(accountNumber.length - 4)}';
  }
}

class Employee {
  const Employee({
    required this.id,
    required this.name,
    required this.loginEmail,
    required this.phone,
    required this.personalEmail,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.designation,
    required this.department,
    required this.location,
    required this.status,
    required this.employmentType,
    required this.joiningDate,
    required this.reportingManager,
    required this.workShift,
    required this.emergencyContact,
    required this.bank,
    this.address = '',
    this.profileComplete = true,
  });

  final String id;
  final String name;
  final String loginEmail;
  final String phone;
  final String personalEmail;
  final DateTime dateOfBirth;
  final String gender;
  final String bloodGroup;
  final String designation;
  final String department;
  final String location;
  final String status;
  final String employmentType;
  final DateTime joiningDate;
  final String reportingManager;
  final String workShift;
  final EmergencyContact emergencyContact;
  final BankDetails bank;
  final String address;
  final bool profileComplete;

  Employee copyWith({
    String? name,
    String? phone,
    String? personalEmail,
    String? designation,
    String? department,
    String? location,
    String? status,
    String? address,
    bool? profileComplete,
  }) {
    return Employee(
      id: id,
      name: name ?? this.name,
      loginEmail: loginEmail,
      phone: phone ?? this.phone,
      personalEmail: personalEmail ?? this.personalEmail,
      dateOfBirth: dateOfBirth,
      gender: gender,
      bloodGroup: bloodGroup,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      location: location ?? this.location,
      status: status ?? this.status,
      employmentType: employmentType,
      joiningDate: joiningDate,
      reportingManager: reportingManager,
      workShift: workShift,
      emergencyContact: emergencyContact,
      bank: bank,
      address: address ?? this.address,
      profileComplete: profileComplete ?? this.profileComplete,
    );
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first[0] + parts[1][0]).toUpperCase();
  }
}
