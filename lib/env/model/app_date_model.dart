import 'package:equatable/equatable.dart';

class AppDateModel extends Equatable {
  final String day, date, month, year, hour, minute, second, numericMonth;

  const AppDateModel(
      {required this.day,
      required this.date,
      required this.month,
      required this.year,
      required this.hour,
      required this.minute,
      required this.second,
      required this.numericMonth});

  factory AppDateModel.fromDate(DateTime datetime) {
    List<String> days = [
      "Minggu",
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jum'at",
      "Sabtu",
      "Minggu"
    ];

    List<String> months = [
      "Desember",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    return AppDateModel(
        day: days[datetime.weekday],
        date: datetime.day.toString().padLeft(2, "0"),
        month: months[datetime.month],
        year: datetime.year.toString(),
        hour: datetime.hour.toString().padLeft(2, '0'),
        minute: datetime.minute.toString().padLeft(2, '0'),
        second: datetime.second.toString().padLeft(2, '0'),
        numericMonth: datetime.month.toString().padLeft(2, "0"));
  }

  @override
  List<Object?> get props => [
        "day: $day",
        "date: $date",
        "month: $month",
        "year: $year",
        "hour: $hour",
        "minute: $minute",
        "second: $second",
        "numeric_month: $numericMonth"
      ];
}
