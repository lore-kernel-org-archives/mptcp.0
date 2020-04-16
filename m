Content-Type: multipart/mixed; boundary="===============4417669360909821985=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 16th of April 2020
Date: Thu, 16 Apr 2020 18:45:36 +0200
Message-ID: <278687e3-d103-b173-9da8-541fbe00c405@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4193

--===============4417669360909821985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 95th meeting with Mat and Ossama (Intel OTC), Christoph =

(Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Florian Westphal):

1269367: Deferred: [net] mptcp: fix double-unlock in mptcp_poll

     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Hillf Danton):

1269397: Rejected: Re: WARNING: bad unlock balance in mptcp_shutdown

     our repo (by: Davide Caratti, Florian Westphal, Matthieu Baerts, =

Paolo Abeni):

1265469: Needs Review / ACK: selftests:mptcp:pm: rm the right tmp file:
     - To be reviewed (one line)

1266897: Under Review: mptcp:pm netlink: fix variable scope:
     - Drop? Yes!

1271115: Changes Requested: [v2,1/4] uapi: update linux/mptcp.h
1271117: Changes Requested: [v2,2/4] add support for mptcp netlink =

interface.
1271119: Changes Requested: [v2,3/4] ss: allow dumping MPTCP subflow =

information
1271118: Changes Requested: [v2,4/4] man: mptcp man page:
     - v3 in preparation

1271341: New: [1/7] mptcp: fix splat when incoming connection is never =

accepted before exit/close
1271343: New: [2/7] mptcp: fix 'Attempt to release TCP socket in state' =

warnings
1271344: New: [3/7] mptcp: handle mptcp listener destruction via rcu
1271345: New: [4/7] mptcp: avoid callback invocation when mptcp parent =

socket doesn't exist
1271346: New: [5/7] mptcp: use rcu helpers to fetch ulp subflow context
1271347: New: [6/7] mptcp: reverse order of sk_state_change and is_mptcp =

check
1271348: New: [7/7] mptcp: prevent null deref crash on normal tcp sockets:
     - The 4th and 7th should go together
     - Raise condition regarding the 3rd ACK
     - Still investigating because the cause is still unclear, maybe =

there is another issue we would hide there
     - the first 3 patches can be applied, ACK from Paolo.
     - Matth can applied them at the end of the export branch
     - Florian can also send them directly to netdev (-net)



Bugs on Github:
    2: reduce hooking in TCP code =E2=86=92 could go upstream before part 4
    4: keep a single work struct in mptcp socket =E2=86=92 could go upstrea=
m =

before part 4
    5: Allow ss/netstat etc. to show program name for client and =

listener MPTCP subflows =E2=86=92 could go upstream before part 4
    7: cleanup sendmsg_frag allocation
    8: fix possible race in subflow_finish_connect()
    9: fix "IPv4: Attempt to release TCP socket in state 1 "... on shutdown
   10: reduce mptcp options space usage
   11: fix fallback to TCP... @dcaratti
    3: fix 'mmap' related race
    6: loss and delay without reordering causes very slow transfer
   13: [syzkaller] WARNING in mptcp_incoming_options
   12: [syzkaller] INFO: task hung in lock_sock_nested



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - Full DATA_FIN support [WIP by Mat]:
             - could be nice to have it: if ready
         - Active backup support
         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]
         - Opti in TCP option structures (unions) [to be rebased]

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink
         - PM bpf
         - Scheduler bpf
         - syncookies
         - [gs]etsockopt per subflow
         - notify the userspace when a subflow is added/removed =E2=86=92 c=
msg



Extra tests:
     - news about Syzkaller? (Christoph):
         - syzbot reported new issues on netdev, all already addressed
         - "WARNING in mptcp_incoming_options": but no reproducer

     - new about Intel's kbuild? (Mat):
         - there was a report this week but unclear if the errors were =

due to our modifications
         - =

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/TLP3WL3AFX=
NXKORIT7JKQMSTNYBGIX2C/
         - Mat will follow-up

     - packetdrill (Davide):
         - could be nice to use this new version with the out-of-tree =

kernel!

     - CI (Matth):
         - /



Next meeting:
     - We propose to have the next meeting on Thursday, the 23rd of April.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200423



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4417669360909821985==--
