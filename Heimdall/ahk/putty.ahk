;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;//////// Putty Shortcut keys///////////////////;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

F9::
send, ngiCnct{ENTER}
sleep 12000
send, etwall{ENTER}
sleep 2000
send, su{ENTER}
sleep 2000 
send, {!}uP&2tH{U+20AC}{>}{!}{ENTER} 
return

::screenoff::echo 0 > /sys/class/backlight/rear_left_screen-backlight/brightness {Enter} echo 0 > /sys/class/backlight/rear_right_screen-backlight/brightness{ENTER}


::mnt::mount -w -o remount,rw /{Enter} mount -w -o remount,rw /opt/{ENTER} mount -w -o remount,rw /var/psa{ENTER}

::mnts:: mount -w -o remount,rw /var/navdata
::sf::systemctl --failed

::rs::rpm -qa | grep ngi- | sort{ENTER}

::rq::rpm -qa | grep 

::ro::rpm -Uvh --oldpackage *.rpm

::ru::rpm -Uvh *.rpm --nodeps

::ri::rpm -ivh *.rpm

::re::rpm -e --nodeps

::cn::ngiCnct

::ew::etwall

::amp::ping 192.168.103.21

::uml::umount /media/local/u{TAB}

::ml::cd /media/local/u{TAB}

::cl::vi /opt/ias/etc/ngi_component_launcher_static_startup.xml{ENTER}/RAH{ENTER}

::vol::/opt/jlr/bin/polar/volset_ip_103 -v 450

::cpldpath::export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/jlr/lib/cpld;{ENTER}./opt/jlr/bin/cpld/cpld_flash_app{ENTER}

::dbs:: rm -f /var/lib/rpm/__db*{ENTER}rpm --rebuilddb

::rt::root

::la::{!}uP&2tH{U+20AC}{>}{!}

::na::{U+20AC}

 

 

#p::Run mspaint
#q::Run \\Whj100d6cd8r1\Ram_share

;;;create new folder;;;

!y:: ;press Alt+y

Run, cmd /c md "Rename_me",, Hide

Send, {F5}

Return




