#/bin/bash
#-----------------------------------------------------------------------#
# Copyright 2006-2016 by Kevin Buehl <kevin@buehl.biz>                  #
#-----------------------------------------------------------------------#
#  __          __    _____________    __          __    ______________  #
# |  |  2006  |  |  |   _______   \  |  |        |  |  |___________   | #
# |  |  2016  |  |  |  |       \  |  |  |        |  |              |  | #
# |  |___ ____|  |  |  |_______/  /  |  |___ ____|  |   ___________|  | #
# |______ ____   |  |   _______  |   |______ ____   |  |   ___________| #
#  by         |  |  |  |       \  \  Server      |  |  |  |             #
#    Kevin    |  |  |  |_______/  |   Management |  |  |  |___________  #
#      Buehl  |__|  |_____________/     System   |__|  |______________| #
#                                                                       #
# No part of this website or any of its contents may be reproduced,     #
# copied, modified or adapted, without the prior written consent of     #
# the author, unless otherwise indicated for stand-alone materials.     #
# For more Information visit www.4b42.com.                              #
# This notice must be untouched at all times.                           #
#-----------------------------------------------------------------------#

#-----------------------------------------------------------------------#
# 2016-05-14	Kevin Buehl	created
#-----------------------------------------------------------------------#
#apt install ftp

# take picture
raspistill -o /tmp/current.jpg -w 800 -h 600 -vf -hf -q 100
# check if image exist
if [ -f /tmp/current.jpg ]; then
   # upload image to ftp server
   ftp -inv ${HOST} <<End-Of-Session
user "${USER}" "${PASS}"
lcd /tmp
put current.jpg
mkdir $(date +"%Y")
cd $(date +"%Y")
mkdir $(date +"%m")
cd $(date +"%m")
mkdir $(date +"%d")
cd $(date +"%d")
mkdir $(date +"%H")
cd $(date +"%H")
put current.jpg $(date +"%M").jpg
bye
End-Of-Session
else
   echo "not exsist!"
fi
