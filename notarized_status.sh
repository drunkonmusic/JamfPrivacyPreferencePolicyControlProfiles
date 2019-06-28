#!/bin/bash

####################################################################################################
#
# Copyright (c) 2018, JAMF Software, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################
#
# Description
#  This script was designed to allow Admins the ability to scan every application installed under /Applications and return which Apps  
#  are not notarized and the corresponding error with the status
#
# If ran via a Jamf policy the output is echoed into the policy log and sent back to the Jamf Pro server.  
# If ran locally the results are displayed in terminal
#
####################################################################################################
# 
# HISTORY
#
#	-Created by Mike Paul on June 24th 2019 (All was borrowed and tweaked from Adam Sippl's CodeGather.sh script)
#
####################################################################################################
#
echo ""
echo This will display all apps that dont have a notarized status of ACCEPTED
echo ""

## This will search through all Apps recursively in the Applications directory

IFS=$'\n'

#Only searching 1 directory down to avoid apps nested within other apps
apps=$(find /Applications -iname "*.app" -maxdepth 2)

for app in $apps; do
	notarizedStatus=$(spctl -a -v "$app" 2>&1 | awk -F ':' '{print $2}')

	if [[ "$notarizedStatus" != " accepted" ]]; then
	echo App: "$app"
	echo Notarization Status: "$notarizedStatus"		
			echo ""
		fi
done
