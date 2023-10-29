module main

import term
import time
import strconv
import strings

struct CalendarInfo {
	month int
	long_month string
	year int
	days int
	first_day int
	current_day int
}

fn get_current_time_data() time.Time {
	return time.now()
}

fn construct_calendar_info(t time.Time) CalendarInfo {
	month_name := time.long_months[t.month - 1]
	month_days := time.days_in_month(t.month, t.year) or {
		panic(err)
	}
	month_first_day := time.day_of_week(t.year, t.month, t.day)
	return CalendarInfo{
		month: t.month
		long_month: month_name
		year: t.year
		days: month_days
		first_day: month_first_day
		current_day: t.day
	}
}

fn print_month_header(cal CalendarInfo) {
	header := '${cal.long_month} ${cal.year}'
	print(term.header_left(header, '='))
}

fn print_days_header() {
	println(' Mo Tu We Th Fr Sa Su ')
}

fn pad_day_no(day u64) string {
	digits := strconv.dec_digits(day)
	spaces := 3 - digits
	padding := strings.repeat_string(' ', spaces)
	return '${padding}${day}'
}

fn print_calendar(cal CalendarInfo) {
	mut print_day := u64(1)
	for line in 1..7 {
		for date in 1..8 {
			if line == 1 && date < cal.first_day {
				print('   ')
			} else if print_day <= cal.days {
				print(pad_day_no(print_day))
				print_day++
			}
			if print_day > cal.days {
				print('\n')
				return
			}
		}
		print('\n')
	}
}

fn print_footer() {
	print(term.h_divider('='))
}

fn main() {
	time_data := get_current_time_data()
	cal_data := construct_calendar_info(time_data)
	print_month_header(cal_data)
	print_days_header()
	print_calendar(cal_data)
	print_footer()
}
