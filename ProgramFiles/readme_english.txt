DropboxPortableAHK.exe 1.1
by Nick (agathecur / against the current)


Description:
I tried many of the portable dropbox version out there, but none of them has made me happy.
So I started to create my own DropboxPortableAHK, here it is.

Instructions:
***DO NOT CLOSE DROPBOX.EXE BY YOURSELF, THIS IS HANDLED BY DROPBOXPORTABLEAHK AUTOMATICALLY***
1. start DropboxPortableAHK.exe
2. set up your configuration in the installation window
3. -go through the normal setup steps of dropbox (which is launched by DropboxPortableAHK.exe)
	-it does not matter, if you change the dropbox path through the advanced setup, because DropboxPortableAHK will ignore it.
4. after finishing the setup steps, DropboxPortableAHK closes dropbox
5. DropboxPortableAHK runs dropbox again -> Happy syncin'!

From now on, simply start DropboxPortableAHK.exe and you are done.
Even if you move from Vista/7 to XP (usb-stick) dropbox does not have to be set up again.


Problems:
My context menu on my Dropbox items does not work anymore:
If you want to use the context menu, go to .dbfiles\profile\AppData\Roaming\dropbox\bin (for Vista/7)
or .dbfiles\profile\ApplicationData\dropbox\bin (for XP) and rename the DropboxExt*.dll.notavailable
to DropboxExt*.dll
Be aware, that this dll creates several files in your %Appdata% directory. This is why I have renamed the
dll by default, so the Dropbox is fully portable.



If you get an error message, please report this bug on the forum thread
http://forums.dropbox.com/topic.php?id=33387
or at the website
http://dropportable.ho.am/






-------------------Changelog------------------
		~ : changed 					+ : added
		- : removed 					# : fixed
***********************************************************
1.1.0.0 (03.04.2011):
	-unused libraries
	+proxy support (set up in .dbfiles\config.ini)
	+check for internet connection after server error
	~unit at download progress bar
	+block environment changes until other DropboxPortableAHK instances have started up
	+change global environment only if appdata is not a subfolder of userprofile
	#flickering of download progress bar in Windows Vista / 7
	+restore registry only if a value has changed
	+removing of desktop shortcuts created by the dropbox installation on Windows XP
	#moving of dropbox application files
	+another method of moving dropbox application files
	-temporary vbscript file
	#closing of dropbox if protection is disabled
***********************************************************
1.0.5.0 (24.03.2011):
	#proper fix for 64-bit systems
***********************************************************
1.0.4.0 (24.03.2011):
	+additional debug values
	#temporarily fix for 64-bit systems
***********************************************************
1.0.3.0 (24.03.2011):
	+beta version checked at installation if chosen on first start
	~detection of successfully running dropbox -> no more startup failures
	+removing of staying dropbox icon in tray
	+closing of dropbox after closing of DropboxPortableAHK
	+timestamp to debug entries
	+option to disable error message after dropbox folder protection
***********************************************************
1.0.2.0 (19.03.2011):
	#moving of dropbox application files
	#probably: proxy errors
	+support of network drives
	+choice to download beta files on first start
	+removing of empty dropbox folder created by setup
***********************************************************
1.0.1.0 (14.03.2011):
	#unzipping error on some systems
***********************************************************
1.0.0.0 (13.03.2011):
	+opportunity to copy complete old data
	+set up configuration in setup
	+moved instructions from config file to readme
	+progress bar for moving / copying dropbox folder
	+integrated necessary files into executable
	+update dropbox as well
	+do not provide dropbox in zip -> download if missing
	+progress bar for download
	~removed option for debug mode -> always enabled
	#probably fixed EXEC error on installation
	#error at running update
	~made errors from sqlite easier to read
***********************************************************
0.5.0.0 (04.03.2011):
	~resorted code
	+additional debugging messages
	+check for enough free space
	+live preview of resulting path at setup
	+option to choose whether to copy dropbox folder or to move
	+check for downloads
	#issue with a damaged config after missing updates
	~configuration of dropbox path (see .dbfiles\config.ini)
	-AppData variable of configuration file
***********************************************************
0.4.1.0 (28.02.2011):
	+option for creation of an autorun configuration for usb-sticks (see .dbfiles\config.ini)
***********************************************************
0.4.0.0 (24.02.2011):
	+dropbox folder protection
	+extended autoupdater to update the configuration file as well
	+new ways of declaring the dropbox folder path
***********************************************************
0.3.0.0 (22.02.2011):
	+autoupdate
***********************************************************
0.2.4.0:
	#detection of closed dropbox process -> no locked dropbox folder anymore
***********************************************************
0.2.3.0:
	#moving folder from one partition to an other
***********************************************************
0.2.2.0:
	+check if existing dropbox folder matches currently dropbox folder
	~more accurate detection of finished dropbox setup
	+check for already existing new dropbox folder
***********************************************************
0.2.1.0:
	~detection of finished dropbox setup
***********************************************************
0.2.0.0:
	+installation routine
	+possibility to move your existing dropbox folder to the the portable directory
	+recovery of old dropbox_path entry in database if something went wrong
	~dialog boxes
	+debug mode
***********************************************************
0.1.1.0:
	+check for configuration file and dropbox application folder
***********************************************************
0.1.0.0:
	initial release
***********************************************************