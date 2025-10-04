// pdf_service.dart
import 'package:ayurvedic_centre/domain/model/branch_model/branch_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> generateBookingPdf({
    required Uint8List logoImage,
    required Uint8List signImage,
    required BranchModel branchModel,
    required String patientName,
    required String address,
    required String whatsappNumber,
    required String bookedOn,
    required String treatmentDate,
    required String treatmentTime,
    required List<Map<String, dynamic>> treatments,
    required double totalAmount,
    required double discount,
    required double advance,
    required double balance,
  }) async {
    try {
      final pdf = pw.Document();

      // Load unicode fonts so currency and other characters render
      final ttfRegular = await PdfGoogleFonts.openSansRegular();
      final ttfBold = await PdfGoogleFonts.openSansBold();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (context) {
            // Use a top-level container with max width so children have bounded constraints
            return pw.Container(
              width: double.infinity,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header Section
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Logo placeholder
                      pw.Container(
                        width: 80,
                        height: 80,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.green,
                            width: 2,
                          ),
                          shape: pw.BoxShape.circle,
                        ),
                        child: pw.ClipOval(
                          // to make the image circular
                          child: pw.Image(
                            pw.MemoryImage(logoImage),
                            fit: pw.BoxFit.cover, // fit the image nicely
                          ),
                        ),
                      ),

                      // Branch Info (bounded by a container so column has constraints)
                      pw.Container(
                        width: 260,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              branchModel.name.toUpperCase(),
                              style: pw.TextStyle(
                                font: ttfBold,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              branchModel.address,
                              style: pw.TextStyle(
                                font: ttfRegular,
                                fontSize: 11,
                                color: PdfColors.grey700,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              'e-mail: ${branchModel.mail}',
                              style: pw.TextStyle(
                                font: ttfRegular,
                                fontSize: 11,
                                color: PdfColors.grey700,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              'Mob: ${branchModel.phone}',
                              style: pw.TextStyle(
                                font: ttfRegular,
                                fontSize: 11,
                                color: PdfColors.grey700,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              'GST No: 32AABCU9603R1ZW',
                              style: pw.TextStyle(font: ttfBold, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 20),
                  pw.Divider(color: PdfColors.grey300),
                  pw.SizedBox(height: 20),

                  // Patient Details Section
                  pw.Text(
                    'Patient Details',
                    style: pw.TextStyle(
                      font: ttfBold,
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green,
                    ),
                  ),
                  pw.SizedBox(height: 10),

                  // Wrap the details inside a container with width to make Row bounded
                  pw.Container(
                    width: double.infinity,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Left details
                        pw.Flexible(
                          flex: 2,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                'Name',
                                patientName,
                                ttfRegular,
                                ttfBold,
                              ),
                              pw.SizedBox(height: 8),
                              _buildDetailRow(
                                'Address',
                                address,
                                ttfRegular,
                                ttfBold,
                              ),
                              pw.SizedBox(height: 8),
                              _buildDetailRow(
                                'WhatsApp Number',
                                whatsappNumber,
                                ttfRegular,
                                ttfBold,
                              ),
                            ],
                          ),
                        ),

                        // spacing
                        pw.SizedBox(width: 40),

                        // Right details
                        pw.Flexible(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                children: [
                                  pw.Text(
                                    'Booked On',
                                    style: pw.TextStyle(
                                      font: ttfBold,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Text(
                                    bookedOn,
                                    style: pw.TextStyle(
                                      font: ttfRegular,
                                      fontSize: 10,
                                      color: PdfColors.grey700,
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              _buildDetailRow(
                                'Treatment Date',
                                treatmentDate,
                                ttfRegular,
                                ttfBold,
                              ),
                              pw.SizedBox(height: 8),
                              _buildDetailRow(
                                'Treatment Time',
                                treatmentTime,
                                ttfRegular,
                                ttfBold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(height: 15),
                  pw.Divider(color: PdfColors.grey300),
                  pw.SizedBox(height: 15),
                  // Treatment Table
                  _buildTreatmentTable(
                    treatments,
                    totalAmount,
                    discount,
                    advance,
                    balance,
                    ttfRegular,
                    ttfBold,
                  ),

                  pw.Spacer(),

                  // Thank You Section with Signature
                  pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Thank you for choosing us',
                          style: pw.TextStyle(
                            font: ttfBold,
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green,
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Text(
                          "Your well-being is our commitment, and we're honored",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            font: ttfRegular,
                            fontSize: 9,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text(
                          "you've entrusted us with your health journey",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            font: ttfRegular,
                            fontSize: 9,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 12),
                        // Signature Image
                        pw.Container(
                          width: 120,
                          height: 50,
                          child: pw.Image(
                            pw.MemoryImage(signImage),
                            fit: pw.BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(height: 10),

                  // Footer
                  pw.Divider(color: PdfColors.grey300),
                  pw.SizedBox(height: 8),
                  pw.Center(
                    child: pw.Text(
                      '"Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment"',
                      style: pw.TextStyle(
                        font: ttfRegular,
                        fontSize: 9,
                        color: PdfColors.grey500,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      // Save PDF
      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    } catch (e, st) {
      // Print stack trace in debug mode for easier diagnosis
      if (kDebugMode) {
        print('Error generating PDF: $e');
        print(st);
      }
      rethrow;
    }
  }

  // Detail row: use Flexible for the value so it won't try to expand with unbounded constraints
  static pw.Widget _buildDetailRow(
    String label,
    String value,
    pw.Font regular,
    pw.Font bold,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 100,
          child: pw.Text(
            label,
            style: pw.TextStyle(
              font: bold,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Flexible(
          child: pw.Text(
            value,
            style: pw.TextStyle(
              font: regular,
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
        ),
      ],
    );
  }

  // Treatment table: avoid Expanded; use Flexible and explicit widths
  static pw.Widget _buildTreatmentTable(
    List<Map<String, dynamic>> treatments,
    double totalAmount,
    double discount,
    double advance,
    double balance,
    pw.Font regular,
    pw.Font bold,
  ) {
    // Header row
    final header = pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Row(
        children: [
          pw.Container(
            width: 180,
            child: pw.Text(
              'Treatment',
              style: pw.TextStyle(
                font: bold,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green,
              ),
            ),
          ),
          pw.SizedBox(width: 30),
          pw.Container(
            width: 60,
            child: pw.Text(
              'Price',
              style: pw.TextStyle(
                font: bold,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green,
              ),
            ),
          ),
          pw.SizedBox(width: 30),
          pw.Container(
            width: 60,
            child: pw.Text(
              'Male',
              style: pw.TextStyle(
                font: bold,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green,
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.SizedBox(width: 30),
          pw.Container(
            width: 60,
            child: pw.Text(
              'Female',
              style: pw.TextStyle(
                font: bold,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green,
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Total',
                style: pw.TextStyle(
                  font: bold,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green,
                ),
                textAlign: pw.TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );

    // Rows
    final rows = treatments.map((treatment) {
      final name = treatment['name']?.toString() ?? '';
      final priceStr = treatment['price']?.toString() ?? '0';
      final priceVal = double.tryParse(priceStr.replaceAll(',', '')) ?? 0;
      final male = treatment['male'] ?? 0;
      final female = treatment['female'] ?? 0;
      final total = (treatment['total'] is num)
          ? (treatment['total'] as num).toDouble()
          : (double.tryParse(treatment['total']?.toString() ?? '0') ?? 0);

      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 8),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 180,
              child: pw.Text(
                name,
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Container(
              width: 60,
              child: pw.Text(
                _formatCurrency(priceVal),
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Container(
              width: 60,
              child: pw.Text(
                '$male',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Container(
              width: 60,
              child: pw.Text(
                '$female',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  _formatCurrency(total),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    font: regular,
                    fontSize: 11,
                    color: PdfColors.grey700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
    // Amount summary on the right — keep it bounded by a container to avoid flex issues
    final amountSummary = pw.Container(
      width: 260,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          _buildAmountRow('Total Amount', totalAmount, bold, isBold: true),
          pw.SizedBox(height: 4),
          _buildAmountRow('Discount', discount, regular),
          pw.SizedBox(height: 4),
          _buildAmountRow('Advance', advance, regular),
          pw.SizedBox(height: 6),
          pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
            ),
            padding: const pw.EdgeInsets.only(top: 6),
            child: _buildAmountRow('Balance', balance, bold, isBold: true),
          ),
        ],
      ),
    );

    return pw.Column(
      children: [
        header,
        ...rows,
        pw.SizedBox(height: 8),
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [amountSummary],
        ),
      ],
    );
  }

  static pw.Widget _buildAmountRow(
    String label,
    double amount,
    pw.Font font, {
    bool isBold = false,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.SizedBox(
          width: 120,
          child: pw.Text(
            label,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              font: font,
              fontSize: isBold ? 13 : 11,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
        pw.SizedBox(width: 20),
        pw.SizedBox(
          width: 80,
          child: pw.Text(
            _formatCurrency(amount),
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              font: font,
              fontSize: isBold ? 13 : 11,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to format currency with commas
  static String _formatCurrency(double amount) {
    final intAmount = amount.toInt();
    final str = intAmount.toString();
    final length = str.length;
    
    if (length <= 3) return str;
    
    String result = '';
    int count = 0;
    
    for (int i = length - 1; i >= 0; i--) {
      if (count == 3) {
        result = ',$result';
        count = 0;
      }
      result = str[i] + result;
      count++;
    }
    
    return result;
  }
}