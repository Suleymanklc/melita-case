#!/usr/bin/env sh

csvHandler()
{   
    srcpath=$1
    transferPath="/mnt/transfer"
    archivepath="/mnt/archive/"
    day=$2
    retval=''
    archivepath=/mnt/archive
    filecount= $(find $srcpath -type f  -mtime +$day -maxdepth 1 | wc -l)

    if (( $filecount > 0 || $day == 1 )); then
       
        find $srcpath -type f  -mtime +$day  -maxdepth 1 -exec cp "{}" $transferPath \;

    elif (( $filecount > 0 || $day == 7 )); then

        find $srcpath -type f  -mtime +$day  -maxdepth 1 -exec tar -czvf {}.tar.gz {}  \;
        
        mkdir -p $archivepath
        mv $srcpath/*.tar.gz $archivepath
    fi
 
}

checkArgCouunt()

{
    if (( $# == 2 )); then
        
        csvHandler $1 $2 
        exit 0
    else
         echo "Arhument count lower than 2, please enter source path and day count to run"
         exit 1
    
    fi
    
}

checkArgCouunt


