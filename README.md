# RTCW Empty Server Killer

This is a simple process that waits on a cron timer, then kills (using rcon
exit) a RTCW gameserver once it empties.

This probably works on other Quake3 based games, but remains untested.


## Why?

To auto restart a gameserver when it is empty.
RTCW OSP seems to be leaky to some extent, this just ensures performance.
