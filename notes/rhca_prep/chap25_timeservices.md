# Chapter - 25 Time services

## The concept of stratum

- In order to decide which NTP server to use. The concept of stratum is used.
- Stratum defines the reliability of NTP server.
- Internet Timeserver uses stratum 1 or 2.
- You can use higher stratum to configure Local NTP. But this a mere a backup, while this server is only used when internet is not available.
- You can set stratum:5 for reliable time server in your datacenter Or Stratum 8 when the local NTP is not reliable.
- Similarly Stratum 10 can be used as local clock on every node.

```bash
# find the ntp server list (internet) configured on rocky
grep ^pool /etc/chrony.conf 
pool 2.rocky.pool.ntp.org iburst
----------------------------------
# Ubuntu/Debian chrony is not default installed.
# by default ntp server is active and it can be checked using

timedatectl 
               Local time: Thu 2023-12-28 18:19:59 UTC
           Universal time: Thu 2023-12-28 18:19:59 UTC
                 RTC time: Thu 2023-12-28 18:19:59
                Time zone: UTC (UTC, +0000)
System clock synchronized: yes
              NTP service: active # this suggest NTP is active or inactive
          RTC in local TZ: no # Real Time Clock = Hardware Clock

# in case NTP is inactive activated it using the following command 
sudo timedatectl set-ntp 1

# check the hardware clock using
sudo hwclock 
2023-12-28 18:21:40.106809+00:00

# convert epoch time to normal time
date --date '@1420987251'

```

## Date

```bash
Set the date 3 min fast.
date -s 16:03 # timedatectl makes is much easy, see below

# Note: This will not set the hwclock. To set hwclock you can do either
hwclock --systohc # system time to hardware clock sync
hwlock --hctosys # hardware clock to system time sync

# check 90 days from today, normally used to set the password expiry for the user
date -d +90days +%Y-%m-%d
2024-03-27
```

you can use timedatectl to configure various things as mentioned below

```bash
timedatectl

list-timezone -- list timezones
set-local-rtc  -- Control whether RTC is in local time e.g. set-ntp 0|1
set-ntp        -- Control whether NTP is enabled e.g. set-ntp 0|1, it takes to chronyd process. You do not provide ntp server name here
set-time       -- Set system time
set-timezone   -- Set system timezone
status         -- Show current time settings
```

There are three ways to set timezone in Redhat linux

1. timedatectl
2. tzselect
3. Bit different i.e. to create symlink to /usr/share/zoneinfo/Europe/Berlin to /etc/localtime using command ` ln -sf `

### Configure Chrony as NTP Server

Very basic guide.

```bash
###################### Server Side ###################

# Step:01  edit `/etc/chrony.conf` file and disable default ntp server 
# with your own internal ntp server as shown below
    grep ^pool /etc/chrony.conf
    pool ntp.uni-ulm.de # test ntp server based out of ulm and publicly available. ideally you will use internal NTP appliance

# Step:02 configure firewall to allow ntp service
    sudo firewall-cmd --add-service=ntp --permanent
    sudo firewall-cmd --reload

# Step:03 restart chronyd service
    sudo systemctl restart chronyd

# Step:04 Check the new source
    chronyc sources

MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^* ntp1.uni-ulm.de               2   8   377    76  -2562us[-2694us] +/-   35ms

####################### Client Side ###########################################
# Step:01
    # edit `/etc/chrony.conf` file and disable default ntp server 
    # with ntp server ip/fqdn you configured above
    e.g. # pool name|ipoftheserver
# Step:02 restart chronyd service
    sudo systemctl restart chronyd
# Step: 03 check the chronyc sources
    chronyc sources
```

## Do you know this ALREADY

1. When a system is started, where does it initially get the system time?
a. NTP
b. Software time
c. The hardware clock (MYCHOICE)
d. Network time

2. Which of the following statements is not true about local time?
a. Local time is the current time in the current time zone.
b. In local time, DST is considered.
c. System time typically should correspond to the current local time.
d. Hardware time typically corresponds to the current local time.

3. Which is the recommended command in RHEL 8 to set the local time zone?
a. hwclock
b. tz
c. date
d. timedatectl (MYCHOICE)

4. Which clock type would you recommend on a server that is not connected to any other
server but needs to be configured with the most accurate time possible?
a. RTC
b. UTC
c. An atomic clock
d. NTP (MYCHOICE) (WRONG)

5. Which configuration file contains the default list of NTP servers that should be
contacted on RHEL 8?
a. /etc/ntp/ntp.conf
b. /etc/ntp.conf
c. /etc/chrony/chronyd.conf
d. /etc/chrony.conf (MYCHOICE)

6. Which of the following shows correct syntax to set the current system time to 9:30
p.m.?
a. date 9:30
b. date --set 9.30 PM
c. date -s 21:30 (MYCHOICE)
d. date 2130

7. Which command correctly translates epoch time into human time?
a. date --date '@1420987251' (MYCHOICE)
b. time --date '$1420987251'
c. time --date '#1420987251'
d. time --date '1420987251'

8. Which command do you use to set the system time to the current hardware time?
a. hwclock --hctosys
b. hwclock --systohc (MYCHOICE) (WRONG)
c. date --set-hc
d. ntpdate

9. Which command enables you to show current information that includes the local time,
hardware time, and the time zone the system is in?
a. timedatectl --all
b. timedatectl --tz
c. timedatectl -ht
d. timedatectl (MYCHOICE)

10. Which command can you use to verify that a time client that is running the chrony
service has successfully synchronized?
a. timedatectl
b. chronyc sources (MYCHOICE)
c. systemctl chrony status
d. chronyc status
