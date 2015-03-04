#!/usr/bin/perl -w

# Created by haxpor
# Connect with me on Twitter (@haxpor)

use strict;
use POSIX;
use Scalar::Util qw(looks_like_number);

# Calculate the working hours from 'start' to 'end' time express in 24-hours format, and convert into [0.0, 1.0].
my $num_args = $#ARGV + 1;
# Accept only 2 or 3 parameters, otherwise immediately exit.
if($num_args < 2 || $num_args > 3)
{
	print "Usage: logcal.pl start_time end_time <hour_rate>\n";
	exit;
}

# Meta
my $isHourRateAvailable = 0;

# Get start-time and end-time
my $start_time = $ARGV[0];
if(!looks_like_number($start_time))
{
	print "start_time is not number.\n";
	exit;
}

#print "start_time : $start_time\n";
my $end_time = $ARGV[1];
if(!looks_like_number($end_time))
{
	print "end_time is not number.\n";
	exit;
}

#print "end_time : $end_time\n";
my $hour_rate = 0;
if($num_args == 3)
{
	$hour_rate = $ARGV[2];
	$isHourRateAvailable = 1;
}

# Convert end-time, and start-time to minutes
my @tempEndTimeElements = split('\.', $end_time);
#print "split: @tempEndTimeElements\n";
my $endTimeHours = $tempEndTimeElements[0];
#print "end-time-hours : $endTimeHours\n";
my $endTimeMinutes = $tempEndTimeElements[1];
my $endTimeMinutesCal = $endTimeHours * 60 + $endTimeMinutes;

#print "[end-time minutes] $endTimeMinutesCal\n";

my @tempStartTimeElements = split('\.', $start_time);
#print "split: @tempStartTimeElements\n";
my $startTimeHours = $tempStartTimeElements[0];
my $startTimeMinutes = $tempStartTimeElements[1];
my $startTimeMinutesCal = $startTimeHours * 60 + $startTimeMinutes;

#print "[start-time minutes] $startTimeMinutesCal\n";

# Calculate diff time in minutes-based
my $diff_time_raw = $endTimeMinutesCal - $startTimeMinutesCal;

#print "diff_time_raw : $diff_time_raw\n";

#print "[debug] diff_time_raw: $diff_time_raw\n";

if($diff_time_raw < 0)
{
	$diff_time_raw = $diff_time_raw + 1440;
}

# Convert into hours
my $logHours = $diff_time_raw / 60.0;

my $income = -1;

if($isHourRateAvailable)
{
	$income = $logHours * $hour_rate;
}

# Print out
printf "hours: %.3f\n", $logHours;

if($isHourRateAvailable)
{
	printf "income: %.3f\n", $logHours * $hour_rate;
}
