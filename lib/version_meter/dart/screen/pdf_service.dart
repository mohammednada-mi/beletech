import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class PdfService {
  static List<Map<String, dynamic>> rows = [];
  static void removeRow(int index) {
    if (index >= 0 && index < rows.length) {
      rows.removeAt(index);
    }
  }

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
    required double resultThread2,
    required int numThread2,
    required double resultWire2,
    required double resultPunching,
    required int numWindow,
    required String color,
    required String selectType,
    required String selectedWire,
    required String selectedWire2,
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
      'resultThread2': resultThread2,
      'numThread2': numThread2,
      'resultWire2': resultWire2,
      'resultPunching': resultPunching,
      'numWindow': numWindow,
      'color': color,
      'selectType': selectType,
      'selectedWire': selectedWire,
      'selectedWire2': selectedWire2,
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

    // كل صفحة تستوعب 6 شبابيك (عمودين × 3 صفوف)
    const itemsPerPage = 6;
    final pages = <List<Map<String, dynamic>>>[];
    for (int i = 0; i < rows.length; i += itemsPerPage) {
      final end = (i + itemsPerPage > rows.length)
          ? rows.length
          : i + itemsPerPage;
      pages.add(rows.sublist(i, end));
    }
    if (pages.isEmpty) pages.add([]);

    final clientName = rows.isNotEmpty
        ? rows.first['clientName'] as String
        : '';
    final today = DateTime.now();
    final dateStr = DateFormat('yyyy / MM / dd').format(today);

    for (int pageIndex = 0; pageIndex < pages.length; pageIndex++) {
      final pageRows = pages[pageIndex];

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          textDirection: pw.TextDirection.rtl,
          margin: const pw.EdgeInsets.all(5),
          build: (pw.Context context) {
            // نقسم الـ rows لصفوف، كل صف فيه عمودين
            final cardRows = <List<Map<String, dynamic>>>[];
            for (int i = 0; i < pageRows.length; i += 2) {
              final end = (i + 2 > pageRows.length) ? pageRows.length : i + 2;
              cardRows.add(pageRows.sublist(i, end));
            }

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _buildHeader(clientName, dateStr, ttf, ttfBold),
                pw.SizedBox(height: 5),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    children: cardRows.asMap().entries.map((rowEntry) {
                      final rowIndex = rowEntry.key;
                      final pair = rowEntry.value;
                      final globalBase =
                          pageIndex * itemsPerPage + rowIndex * 2;

                      return pw.Expanded(
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 8),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                            children: [
                              // العمود الأيمن
                              pw.Expanded(
                                child: _buildCard(
                                  pair[0],
                                  globalBase + 1,
                                  ttf,
                                  ttfBold,
                                ),
                              ),
                              pw.SizedBox(width: 8),
                              // العمود الأيسر (لو فيه شباك تاني)
                              pw.Expanded(
                                child: pair.length > 1
                                    ? _buildCard(
                                        pair[1],
                                        globalBase + 2,
                                        ttf,
                                        ttfBold,
                                      )
                                    : pw.SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    await Printing.sharePdf(bytes: await doc.save());
  }

  // ── Header ──
  static pw.Widget _buildHeader(
    String clientName,
    String date,
    pw.Font ttf,
    pw.Font ttfBold,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // يسار: التاريخ

            // يمين: اسم العميل
            pw.Row(
              children: [
                pw.Text(
                  'اسم العميل: ',
                  style: pw.TextStyle(font: ttfBold, fontSize: 10),
                ),
                pw.SizedBox(width: 4),
                pw.Text(
                  clientName.isEmpty
                      ? '..............................'
                      : clientName,
                  style: pw.TextStyle(font: ttfBold, fontSize: 10),
                ),
              ],
            ),

            pw.Row(
              children: [
                pw.Text(
                  'التاريخ: ',
                  style: pw.TextStyle(font: ttfBold, fontSize: 10),
                ),
                pw.SizedBox(width: 4),
                pw.Text(date, style: pw.TextStyle(font: ttfBold, fontSize: 10)),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 4),
        pw.Divider(color: PdfColors.black, thickness: 0.8),
      ],
    );
  }

  // ── Card لكل شباك ──
  static pw.Widget _buildCard(
    Map<String, dynamic> row,
    int index,
    pw.Font ttf,
    pw.Font ttfBold,
  ) {
    final width = (row['width'] as double).toStringAsFixed(3);
    final height = (row['height'] as double).toStringAsFixed(3);
    final type = row['typeOfBelesah'] as String;
    final color = row['color'] as String;
    final selectType = row['selectType'] as String;

    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      padding: const pw.EdgeInsets.all(5),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // ── صف العنوان ──
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                'الشباك $index',
                style: pw.TextStyle(font: ttfBold, fontSize: 10),
              ),
              // المقاس (يسار)
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
                  borderRadius: pw.BorderRadius.circular(3),
                ),

                child: pw.Text(
                  '$height X $width',
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'اللون:',
                style: pw.TextStyle(font: ttfBold, fontSize: 10),
              ),
              pw.SizedBox(width: 3),
              pw.Text(
                color.isEmpty ? '..................' : color,
                style: pw.TextStyle(
                  font: ttfBold,
                  fontSize: 10,
                  color: PdfColors.grey800,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 4),

          // ── النوع ──
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                'النوع: ',
                style: pw.TextStyle(font: ttfBold, fontSize: 10),
              ),
              pw.Text(
                type,
                style: pw.TextStyle(
                  font: ttfBold,
                  fontSize: 10,
                  color: PdfColors.grey800,
                ),
              ),
              pw.SizedBox(width: 3),
              pw.Spacer(),
              pw.Text(
                'نوع القطاع: ',
                style: pw.TextStyle(font: ttfBold, fontSize: 10),
              ),
              pw.Text(
                selectType,
                style: pw.TextStyle(
                  font: ttfBold,
                  fontSize: 10,
                  color: PdfColors.grey800,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 4),

          // ── منطقة التخصيمات ──
          pw.Container(
            width: double.infinity,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.grey500,
                width: 0.6,
                style: pw.BorderStyle.dashed,
              ),
              borderRadius: pw.BorderRadius.circular(3),
            ),
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      'تخصيمات ـ',
                      style: pw.TextStyle(
                        font: ttfBold,
                        fontSize: 8,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4),

                // ── التخصيمات في عمودين ──
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                        children: [
                          _detailItem(
                            'العرض',
                            '${(row['resultWidth'] as double).toStringAsFixed(3)}  متر × ${row['numWidth'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                          _detailItem(
                            'السلك ${row['selectedWire2']}',
                            '${(row['resultWire2'] as double).toStringAsFixed(0)}  كسرة × ${row['numWire'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                          _detailItem(
                            'الشريط الصغير',
                            '${(row['resultSash'] as double).toStringAsFixed(3)}  متر × ${row['numSash'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                        ],
                      ),
                    ),

                    pw.Container(
                      width: 0.5,
                      color: PdfColors.grey400,
                      margin: const pw.EdgeInsets.symmetric(horizontal: 4),
                    ),

                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                        children: [
                          _detailItem(
                            'الارتفاع',
                            '${(row['resultHeight'] as double).toStringAsFixed(3)}  متر × ${row['numHeight'] * row['numWindow']} ',
                            ttfBold,
                            ttfBold,
                          ),

                          _detailItem(
                            'الستارة ${row['selectedWire']}',
                            '${(row['resultWire'] as double).toStringAsFixed(0)}  كسرة × ${row['numWire'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),

                          _detailItem(
                            'الخيط',
                            '${(row['resultThread'] as double).toStringAsFixed(2)}  متر × ${row['numThread'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                          _detailItem(
                            'الثقوب',
                            'سم ${(row['resultPunching'] as double).toStringAsFixed(1)} ',
                            ttfBold,
                            ttfBold,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: 0.5,
                      color: PdfColors.grey400,
                      margin: const pw.EdgeInsets.symmetric(horizontal: 4),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                        children: [
                          _detailItem(
                            'الضلفة',
                            '${(row['resultSash'] as double).toStringAsFixed(3)}  متر × ${row['numSash'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                          _detailItem(
                            'الشريط',
                            '${(row['resultDoubleFace'] as double).toStringAsFixed(3)}  متر × ${row['numDoubleFace'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                          _detailItem(
                            'الخيط الأوسط',
                            '${(row['resultThread2'] as double).toStringAsFixed(2)}  متر × ${row['numThread2'] * row['numWindow']}',
                            ttfBold,
                            ttfBold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── عنصر تخصيم واحد ──
  static pw.Widget _detailItem(
    String label,
    String value,
    pw.Font ttf,
    pw.Font ttfBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 3),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              font: ttfBold,
              fontSize: 9,
              color: PdfColors.black,
            ),
            textAlign: pw.TextAlign.right,
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: ttfBold,
              fontSize: 9,
              color: PdfColors.black,
            ),
            textAlign: pw.TextAlign.right,
          ),
        ],
      ),
    );
  }
}
