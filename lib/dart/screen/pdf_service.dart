import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static List<Map<String, dynamic>> rows = [];

  static void addRow({
    required String clientName,
    required double width,
    required double height,
    required String typeOfBelesah,
    required double resultWidth,
    required int numWidth,
    required double resultHeight,
    required int numHeight,
    required double resultSash,
    required int numSash,
    required double resultWire,
    required int numWire,
    required double resultDoubleFace,
    required int numDoubleFace,
    required double resultThread,
    required int numThread,
  }) {
    rows.add({
      'clientName': clientName,
      'width': width,
      'height': height,
      'typeOfBelesah': typeOfBelesah,
      'resultWidth': resultWidth,
      'numWidth': numWidth,
      'resultHeight': resultHeight,
      'numHeight': numHeight,
      'resultSash': resultSash,
      'numSash': numSash,
      'resultWire': resultWire,
      'numWire': numWire,
      'resultDoubleFace': resultDoubleFace,
      'numDoubleFace': numDoubleFace,
      'resultThread': resultThread,
      'numThread': numThread,
    });
  }

  static void clearRows() {
    rows = [];
  }

  static Future<void> generatePdf() async {
    final font = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    final boldFont = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
    final ttf = pw.Font.ttf(font);
    final ttfBold = pw.Font.ttf(boldFont);

    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Table(
            border: pw.TableBorder.all(),
            children: [
              // الهيدر
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.pink),
                children: [
                  _headerCell('عدد الخيط', ttfBold),
                  _headerCell('الخيط', ttfBold),
                  _headerCell('عدد دبل فيس', ttfBold),
                  _headerCell('دبل فيس', ttfBold),
                  _headerCell('عدد السلك', ttfBold),
                  _headerCell('السلك', ttfBold),
                  _headerCell('عدد الضلف', ttfBold),
                  _headerCell('الضلفة', ttfBold),
                  _headerCell('عدد الارتفاع', ttfBold),
                  _headerCell('ارتفاع بعد التخصيم', ttfBold),
                  _headerCell('عدد العرض', ttfBold),
                  _headerCell('عرض بعد التخصيم', ttfBold),
                  _headerCell('نوع الشباك', ttfBold),
                  _headerCell('الارتفاع', ttfBold),
                  _headerCell('العرض', ttfBold),
                  _headerCell('اسم العميل', ttfBold),
                ],
              ),
              // الصفوف
              ...rows.map(
                (row) => pw.TableRow(
                  children: [
                    _cell(row['numThread'].toString(), ttf),
                    _cell(row['resultThread'].toStringAsFixed(2), ttf),
                    _cell(row['numDoubleFace'].toString(), ttf),
                    _cell(row['resultDoubleFace'].toStringAsFixed(3), ttf),
                    _cell(row['numWire'].toString(), ttf),
                    _cell(row['resultWire'].toStringAsFixed(0), ttf),
                    _cell(row['numSash'].toString(), ttf),
                    _cell(row['resultSash'].toStringAsFixed(3), ttf),
                    _cell(row['numHeight'].toString(), ttf),
                    _cell(row['resultHeight'].toStringAsFixed(3), ttf),
                    _cell(row['numWidth'].toString(), ttf),
                    _cell(row['resultWidth'].toStringAsFixed(3), ttf),
                    _cell(row['typeOfBelesah'], ttf),
                    _cell(row['height'].toStringAsFixed(3), ttf),
                    _cell(row['width'].toStringAsFixed(3), ttf),
                    _cell(row['clientName'], ttf),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await doc.save());
  }

  static pw.Widget _headerCell(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: font, color: PdfColors.white, fontSize: 8),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _cell(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: 8),
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}
