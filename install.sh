# Complete count tracking
completeCount=0

# Copy a program to /usr/bin/
if sudo cp logcal.pl /usr/bin/logcal;
then 
	echo "Copied logcal to /usr/bin"
	completeCount=$((completeCount+1))
fi

# Change its permission to executable
if sudo chmod 755 /usr/bin/logcal;
then
	echo "Change its executable permission"
	completeCount=$((completeCount+1))
fi

if [ "$completeCount" == 2 ];
then
	echo "Complete installation of logcal."
	echo "--OKAY--"
else
	echo "Failed installation of logcal."
	echo "--Failed--"
fi
