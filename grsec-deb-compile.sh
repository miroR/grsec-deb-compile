#!/bin/bash
#
# This is grsec_debian_compile_v015.sh
#
# copyright  Miroslav Rovis, Zagreb, Croatia, www.CroatiaFidelis.hr
# (the above needs to be cited if the script is modified/further developed,
# even if my NGO Croatia Fidelis were to be shut down by my country's regime,
# as well as if the script is used as basis for later kernel versions
# patching and compilations)
#
# licenced under GNU v3.0 or later, at your choice
#
# How to use this script?
# =======================
# In case of issues, the user needs to consult official Debian documentation,
# such as Debian Kernel Handbook, as well as Grsecurity documentation, and
# other documentation and manuals, wikis and forums.
# 'chmod 755 grsec_debian_compile_v015.sh' once you downloaded this script, place
# it, best, in your homedir, and follow instructions as you run it. If you
# encounter problems, modify for your needs. Also, pls. report errors on Debian
# Forums where I made the Tips page:
# "Grsecurity/Pax installation on Debian GNU Linux"
# but pls. if you will be waiting for my replies, it could take days and longer
# sometimes. Thank you!
#
echo
echo "  Caveat emptor! " 
echo
echo "  Do not use this script if you do not understand  " 
echo " what you are doing. You are responsible if anything "
echo " breaks in your system (possible!) "
echo
echo " OTOH, maybe you could open it in another terminal for "
echo " perusing each next step before hitting Enter to run "
echo " that next step, one by one in this terminal."
echo " Of course you should be checking yourself how the script is"
echo " faring, are the commands doing the intended and all."
echo " This is GNU Linux after all."
echo
echo "The script contains some code which is clumsy, but does the work; the"
echo "following: it is populated with 'read FAKE ;' lines. That is just"
echo "someone's (mine, who knows no better yet), way to tell you to decide"
echo "to continue running the script hitting Enter or issue Ctrl-C to kill it."
echo
        read FAKE ;
echo
echo "Tell this script what your username is, so we can create the workspace."
read user ;
echo "If you are user $user and your homedir is /home/$user/ then this"
echo "script should work for you. If not, modify the script to suit you."
        read FAKE ;
echo "We create next two directories in your homedir, 'dLo' for the downloads,"
echo "and 'src' for the compilation. Will not create them if they exist,"
echo "but pls. you make sure that nothing in them obstructs this script,"
echo "meaning, we'll run command: 'mkdir -pv /home/$user/dLo/ /home/$user/src/'"
echo "A note is due here. If you don't have at least 12GB free in your homedir,"
echo "you need to modify the script or arrange in some other way such as to"
echo "make the /home/$user/src a symlink to somewhere with enough room for the"
echo "compilation"
        read FAKE ;
mkdir -pv /home/$user/dLo/ /home/$user/src/
echo ; echo ls -l /home/$user/dLo/ /home/$user/src/ ;
ls -l /home/$user/dLo/ /home/$user/src/
echo ; echo cd /home/$user/dLo/ ;
        read FAKE ;
cd /home/$user/dLo/ ; pwd ;
echo "Next the script will ask you to input the no-extension names of grsec"
echo "patch, linux kernel, and config file."
echo "The grsec patch just without the literal '.patch'"
echo "Give the name of the grsecurity patch (that we need to get) without"
echo "extension, such as grsecurity-3.0-3.13.6-201403122116 (as is found on"
echo "download page on www.grsecurity.net :"
read grsec ;
echo "Give the name of the kernel (that we need to get) such as linux-3.13.6"
echo "as is found for download (or can be guessed from grsecurity patch's"
echo "name: it is the part of the name after grsecurity-3.0- and before the"
echo "timestamp in the name, with linux- added in front,in the example name"
echo "above it is linux-3.13.6, but compare with www.kernel.org :"
read kernel ;
echo "Give the name of the (old) config file (that we need to get) usually the"
echo "from last compile, from www.croatiafidelis.hr/gnu/deb/, no extension, such"
echo "as: config-3.13.3-grsec140219-03 (if no more talk on my Debian Grsec tips"
echo "page on this, then just try and choose the latest available)"
read config
echo ; echo "We download next the kernel, the patch, the config to use."
echo "In case you already did, you'll see info and/or innocuous errors."
echo "I only want the script to work, can't polish it. Sorry!"
        read FAKE ;
wget -nc https://www.kernel.org/pub/linux/kernel/v3.x/$kernel.tar.sign
wget -nc https://www.kernel.org/pub/linux/kernel/v3.x/$kernel.tar.xz
wget -nc https://www.grsecurity.net/test/$grsec.patch
wget -nc https://www.grsecurity.net/test/$grsec.patch.sig
wget -nc http://www.croatiafidelis.hr/gnu/deb/$config.sig
wget -nc http://www.croatiafidelis.hr/gnu/deb/$config.gz

echo ; echo "Import the necessary keys:"
echo  "gpg --recv-key 0x2525FE49"
        read FAKE ;
gpg --recv-key 0x2525FE49
echo  "gpg --recv-key 0x6092693E"
        read FAKE ;
gpg --recv-key 0x6092693E

echo ; echo "Import my key:"
echo  "gpg --recv-key 0x4FBAF0AE"
        read FAKE ;
gpg --recv-key 0x4FBAF0AE

echo "You can go offline now, internet not needed while compiling."
echo "I, myself, unplug the connection physically."

echo ; echo "Next, copy all downloads to /home/$user/src/"
        read FAKE ;
cp -iav $kernel.tar.* /home/$user/src/
cp -iav $grsec.patch* /home/$user/src/
cp -iav $config* /home/$user/src/
cd /home/$user/src/ ; pwd
ls -l $kernel*
        read FAKE ;
echo ; echo unxz $kernel.tar.xz ;
        read FAKE ; 
 unxz $kernel.tar.xz ;
echo ; echo gpg --verify $kernel.tar.sign ;
        read FAKE ; 
 gpg --verify $kernel.tar.sign ;
echo ; echo gpg --verify $grsec.patch.sig;
        read FAKE ; 
 gpg --verify $grsec.patch.sig;
echo ; echo gunzip $config.gz;
        read FAKE ; 
 gunzip $config.gz;
echo ; echo gpg --verify $config.sig ;
        read FAKE ; 
 gpg --verify $config.sig ;
echo ; echo tar xvf $kernel.tar ;
        read FAKE ; 
 tar xvf $kernel.tar ;
echo ; echo cd $kernel;
        read FAKE ; 
 cd $kernel; pwd
echo ; echo "patch -p1 < ../$grsec.patch";
        read FAKE ; 
 patch -p1 < ../$grsec.patch
echo ; echo "BTW, this is the exact stage at which you can possibly apply"
echo "other patches to this kernel, as well";
echo ; echo cd ../;
 cd ../ ; pwd
        read FAKE ; 
echo ; echo cp -iav $config $kernel/.config;
        read FAKE ; 
 cp -iav $config $kernel/.config
echo ; echo cd $kernel;
        read FAKE ; 
 cd $kernel
pwd
echo ; echo "Here we modify the LOCALVERSION variable to be -YYMMDD-HH"
locver=`date +%y%m%d-%H`
echo $locver
read FAKE ;
oldloc=`grep CONFIG_LOCALVERSION= .config|cut -d'"' -f2`
echo sed -i.bak "s/$oldloc/$locver/" .config
read FAKE ;
sed -i.bak "s/$oldloc/$locver/" .config
echo ; echo "And we need to check that we did what we meant:"
echo ; 
grep LOCALVERSION .config
echo ; echo "And we can also move the backup out of way if it went well."
mv -vi .config.bak ../ ;
echo ; echo make menuconfig;
        read FAKE ; 
echo "If here you will see the script complaining:"
echo "./grsec_debian_compile_v015.sh: line 125: make: command not found"
echo "then you need to install the development tools. Don't worry,"
echo "nothing much. Pls. find instructions in some of my previous/later"
echo "posts in this Tip, or read the script itself at this point."
# Huh? You found it? Probably these commands would get you all you're missing at
# this point:
# # apt-get install build-essential fakeroot ;
# # apt-get build-dep linux ;
# #  apt-get install libncurses5-dev ;
# that's not an error '# #'. Run as root. If run as user I would write '# $'
# instead, where the first # is necessary to make those lines comments
# in both cases.
# And there's more, essential for Grsecurity/Pax install:
# # apt-get install gcc-4.8-plugin-dev
# The lines above I won't be checking, since I have dev tools installed.
# Reports are welcome.

 make menuconfig
echo ; echo "The diff .config below will only show differences if you edited"
echo "the config through the ncurses menuconfig interface. You may not and"
echo "you may need to, in case, say, you have some exotic hardware and"
echo "functionality is later found missing for you."
echo diff .config*;
 diff .config*
        echo
        echo ; echo "Now this, the next one, can be a longer one step \
              in the process..."
        echo
echo ; echo fakeroot make deb-pkg;
        read FAKE ; 
 fakeroot make deb-pkg


        echo ; echo "Here, the deb packages ought to be there..."
        read FAKE ; 
echo ; echo cd ../ ;
cd ../ ; pwd ;
        read FAKE ; 
ls -l *.deb
        echo ; echo "If you see the packages named linux-XXXXXX-grsec-XXX.deb ,"
        echo "above and if you already used paxctl on grub binaries as"
        echo "I took care to explain in detail in my Tips (above or linked"
        echo "somewhere), you're at your last step."
        echo ; echo "But, that step you need to execute as root, so it"
        echo "is not part of this script executed entire as user."
        read FAKE ; 
pwd
msgbeforeroot1="As root in directory /home/$user/src/ issue this command"
msgbeforeroot2="dpkg -i *.deb"
echo ; echo $msgbeforeroot1
echo ; echo "$msgbeforeroot2"

echo "And then, if no errors there, you can reboot."
echo "Upon rebooting, you too should get something like I did below:"
echo "Pls. look up the rest of the script, for that and for a message"
echo "to users of Debian GNU Linux"
# $ uname -a
# 
# $

# But I despise so much the fact that the best GNU Linux security is blocked
# and probably artificial, fabricated, manufactured issues introduced to arise
# in the Debian system once it is installed and Grsec kernel started and the
# system connects online, as I might be able to demonstrate that those issues I
# had since some old installations quite some weeks ago now (just go to
# forums.grsecurity.net in case you doubt my words). Reasons for my suspicion:
# no issues in the system until only offline, freshly cloned, as I do them,
# from other same hardware of my systems, safely offline, and strange issues
# arising solely after the system has connected to internet... And again, no
# issues with sysresccd booting and accessing internet from the same box.
#
# But, I was saying, I despise so much the fact that the best GNU Linux
# security is blocked from official Debian GNU Linux, that I intend to use my
# slow connection, a fraction speed of what I pay for, being myself a homeland
# living dissident whom the traitors in power in my Croatia try to keep under
# control through censorship like that and worse.. Illegally they do so, but
# those are a bunch of criminals, most of them, anyways... That exactly is what
# my friend Marko Francišković said to some of their servants, police officers,
# and is now paying for such words with being tortured, through being
# administered to him forcefully very hazardous medicaments like Zyprex (if I
# got the brand name of that sh*t correctly), and his life is in real danger.
#
# You can actually see Marko Francišković's brutal arrest by the police longer
# ago yet in a video that I linked to from the topic on Grsecurity Forums:
# "grsec: halting the system... kernel crash, the Debian side",
# just search for 'Marko Francišković'.
# 
# But here the link, for convenience:
# Al Jazeera, Clashes on the Eve of EU Referendum, Francišković et. Al HRVATSKI
# https://www.youtube.com/watch?v=_dX-ek2mPaU
# 
# EDIT Wed Apr 30 11:23:14 CEST 2014
# No, you probably won't see any video. But see somewhere on
# www.CroatiaFidelis.hr my reply to Google who removed it.
#
# Also, what follows here is my text written, and little edited, months ago,
# when I ventured into this. Not anymore rewriting nor changing it in any way.
# EDIT END
#
# But I was saying that I so much despise the fact that the best GNU Linux
# security is blocked from official Debian GNU Linux, that I intend to use my
# slow connection, a fraction of what I pay for, to try and upload these
# Grsecurity patched Debian GNU Linux packages I compiled, on
# www.CroatiaFidelis.hr . And that task might take me quite a few hours or more
# hours time. I hope to do that with the new packages that I just made, as I am
# giving a final revision to this script for Grsec patched kernel 3.13.6 for
# Debian, as I successfully uploaded them for 3.12.8 .
# 
# That's the measure of my disgust of the Debian GNU Linux leaders having
# practically and effectively, and for all intents and puposes, banned
# Grsecurity from anything official in Debian GNU Linux, and throwing in, or
# facilitating such actions but someone else, fake errors to confuse new
# Grsecurity users, as I might be able to demonstrate, had I had the time.
# That behavior, suc hhostile action or arrangements, are, apart from being
# severe moral degradation in itself, against Debian declared social contract,
# isn't it?  Debian social contract forbids discrimination, and this is
# discrimination.
#
# Hey leaders of Debian, who behave like a bunch of crooks, you have a piece of
# commons, you have a property of, for short explanation, all good users in the
# world, a property which is there for all of us to benefit, and not for you to
# sell users with, through shady dealings with spy agencies and their
# associates like Google, your great friend...
# 
# Hey leaders of Debian, you have a piece of commons which you are not allowed
# to do anything against us users with, and you are doing that!
#
# But I already said, in the script for the 3.12.8, and was to repeat it now,
# and yet it is such a small effort to compile Grsecurity/Pax patched GNU Linux
# kernel for Debian GNU Linux, that a user who may only be considered somewhat
# advanced and never really a developer, can do it.
#
# It is, however, not a minor effort to demonstrate how new Grsecurity attempts
# at installing and using Grsecurity are deterred, or facilitated to be
# deterred, purposefully, so go and study my work so far to decide for yourself
# whether my bare words with no proofs as yet are to be, or not, taken with,
# and with how much, serious consideration, and whether my accusations against
# Debian leaders might be or are probably not at all baseless. Because efforts
# I will make to prove the above suspicion, but it is really huge effort that
# is needed, and my machines and my SOHO are under attack...  So I am not at
# all certain to succeed in doing so. Looking all the more unlikely to have the
# time to do so, is my later musing, as I revisit what I wrote, for the current
# version of the script...
# 
# Pls. let me know if this works for you, dear Debian GNU Linux user! Those who
# know how to compile, and those who hopefully learn how to compile through my
# Tips pages on Debian Forums, pls. get active. We have to get a branch in the
# Official Debian GNU Linux repositories, this way, some other way or in yet
# other fashion, shape or form, this huge injustice against us the users and
# against shiny honest developers Spender and Pax Team and other developers
# from their circle has to be reversed!
# 
# Miroslav Rovis, Zagreb, Croatia, Vankina 4, +385(0)16602633, +385(0)912660202
# (but you could only reach me if secret services here allow your call through,
# censorship in Croatia heavy and getting heavier yet)
# 
# miro.rovis@croatiafidelis.hr (but you have to be patient awaiting my replies,
# really!, and, sure, only if those evildoers let it through)
# 
# So the safest places to post a message to me, is on Debian Forums, and on
# Grsecurity Forums, the latter especially if you have private messages for me.
# But again, be patient awaiting for my replies!
# 
# Alternative sites, if www.CroatiaFidelis.hr "disappeared": www.exDeo.com and
# www.vankina2-10.com
# 
