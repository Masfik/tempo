class CheckInDetails {
  String userEmail;
  String qrHash;

  CheckInDetails(this.userEmail, this.qrHash);

  factory CheckInDetails.fromJson(Map<String, dynamic> json) => CheckInDetails(
    json['userEmail'],
    json['qrHash']
  );

  Map<String, dynamic> toJson() => {
    'userEmail': userEmail,
    'qrHash': qrHash
  };
}