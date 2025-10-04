class LoginResponse {
  final bool? status;
  final String? message;
  final String? token;
  final bool? isSuperuser;
  final UserDetails? userDetails;

  LoginResponse({
    this.status,
    this.message,
    this.token,
    this.isSuperuser,
    this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      isSuperuser: json['is_superuser'] as bool?,
      userDetails: json['user_details'] != null
          ? UserDetails.fromJson(json['user_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
      'is_superuser': isSuperuser,
      'user_details': userDetails?.toJson(),
    };
  }
}

class UserDetails {
  final int? id;
  final String? lastLogin;
  final String? name;
  final String? phone;
  final String? address;
  final String? mail;
  final String? username;
  final String? password;
  final String? passwordText;
  final int? admin;
  final bool? isAdmin;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final dynamic branch;

  UserDetails({
    this.id,
    this.lastLogin,
    this.name,
    this.phone,
    this.address,
    this.mail,
    this.username,
    this.password,
    this.passwordText,
    this.admin,
    this.isAdmin,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.branch,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] as int?,
      lastLogin: json['last_login'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      mail: json['mail'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      passwordText: json['password_text'] as String?,
      admin: json['admin'] as int?,
      isAdmin: json['is_admin'] as bool?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_login': lastLogin,
      'name': name,
      'phone': phone,
      'address': address,
      'mail': mail,
      'username': username,
      'password': password,
      'password_text': passwordText,
      'admin': admin,
      'is_admin': isAdmin,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'branch': branch,
    };
  }
}
