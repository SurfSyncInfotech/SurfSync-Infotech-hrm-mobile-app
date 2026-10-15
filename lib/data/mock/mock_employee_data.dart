import '../../features/employee/data/models/employee_model.dart';

/// Illustrative sample data only. Every person, number and e-mail here is fictional.
abstract class MockEmployeeData {
  MockEmployeeData._();

  static final Employee currentEmployee = Employee(
    id: 'EMP-1042',
    name: 'Aarav Sharma',
    loginEmail: 'aarav.sharma@surfsync.example',
    phone: '+91 98765 43210',
    personalEmail: 'aarav.sharma@mail.example',
    dateOfBirth: DateTime(1999, 4, 18),
    gender: 'Male',
    bloodGroup: 'B+',
    designation: 'Android Developer',
    department: 'Development',
    location: 'Noida',
    status: 'Active',
    employmentType: 'Full Time',
    joiningDate: DateTime(2026, 10, 12),
    reportingManager: 'Meera Kapoor',
    workShift: '10:00 AM – 7:00 PM',
    address: 'Mamura, Noida, Uttar Pradesh, 201316',
    emergencyContact: const EmergencyContact(
      name: 'Rakesh Sharma',
      relationship: 'Father',
      phone: '+91 98111 22334',
    ),
    bank: const BankDetails(
      bankName: 'Sample Bank',
      accountHolder: 'Aarav Sharma',
      accountNumber: '123456780042',
      ifsc: 'SMPL0001234',
      branch: 'Sector 62, Noida',
    ),
  );

  static final List<Employee> employees = [
    currentEmployee,
    _make('EMP-1001', 'Priya Nair', 'HR Manager', 'Human Resources', 'Noida', 'Active', DateTime(2023, 2, 6)),
    _make('EMP-1008', 'Rohan Mehta', 'Senior Developer', 'Development', 'Noida', 'Active', DateTime(2023, 8, 21)),
    _make('EMP-1015', 'Sneha Kapoor', 'UI/UX Designer', 'Design', 'Remote', 'On Leave', DateTime(2024, 1, 15)),
    _make('EMP-1023', 'Vikram Singh', 'QA Engineer', 'Quality', 'Noida', 'Active', DateTime(2024, 5, 2)),
    _make('EMP-1031', 'Ananya Iyer', 'Business Analyst', 'Operations', 'Gurugram', 'Probation', DateTime(2025, 11, 3)),
    _make('EMP-1036', 'Karan Malhotra', 'Sales Executive', 'Sales', 'Delhi', 'Active', DateTime(2025, 12, 1)),
    _make('EMP-1040', 'Neha Gupta', 'Accounts Associate', 'Finance', 'Noida', 'Inactive', DateTime(2022, 7, 18)),
  ];

  static Employee _make(
    String id,
    String name,
    String designation,
    String department,
    String location,
    String status,
    DateTime joined,
  ) {
    final slug = name.toLowerCase().replaceAll(' ', '.');
    return Employee(
      id: id,
      name: name,
      loginEmail: '$slug@surfsync.example',
      phone: '+91 90000 00000',
      personalEmail: '$slug@mail.example',
      dateOfBirth: DateTime(1995, 1, 1),
      gender: 'Not specified',
      bloodGroup: 'O+',
      designation: designation,
      department: department,
      location: location,
      status: status,
      employmentType: 'Full Time',
      joiningDate: joined,
      reportingManager: 'Meera Kapoor',
      workShift: '10:00 AM – 7:00 PM',
      address: '$location, India',
      emergencyContact: const EmergencyContact(
          name: 'Sample Contact', relationship: 'Family', phone: '+91 90000 00001'),
      bank: BankDetails(
        bankName: 'Sample Bank',
        accountHolder: name,
        accountNumber: '000011112222',
        ifsc: 'SMPL0000001',
        branch: 'Main Branch',
      ),
    );
  }
}
