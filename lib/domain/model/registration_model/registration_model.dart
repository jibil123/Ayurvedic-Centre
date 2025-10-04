class RegistrationModel {
  final String? name;
  final String? executive;
  final String? payment;
  final String? phone;
  final String? address;
  final double? totalAmount;
  final double? discountAmount;
  final double? advanceAmount;
  final double? balanceAmount;
  final String? dateAndTime; // format: dd/MM/yyyy-hh:mm a
  final String? id; // always empty string initially
  final List<int>? male;
  final List<int>? female;
  final String? branch;
  final List<int>? treatments;

  RegistrationModel({
    this.name,
    this.executive,
    this.payment,
    this.phone,
    this.address,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateAndTime,
    this.id,
    this.male,
    this.female,
    this.branch,
    this.treatments,
  });

  /// Convert model into Map for API request
  Map<String, dynamic> toJson() {
    return {
      "name": name ?? "",
      "excecutive": executive ?? "",
      "payment": payment ?? "",
      "phone": phone ?? "",
      "address": address ?? "",
      "total_amount": totalAmount?.toString() ?? "0",
      "discount_amount": discountAmount?.toString() ?? "0",
      "advance_amount": advanceAmount?.toString() ?? "0",
      "balance_amount": balanceAmount?.toString() ?? "0",
      "date_nd_time": dateAndTime ?? "",
      "id": id ?? "",
      "male": male?.join(",") ?? "",
      "female": female?.join(",") ?? "",
      "branch": branch ?? "",
      "treatments": treatments?.join(",") ?? "",
    };
  }
}
