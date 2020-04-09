Content-Type: multipart/mixed; boundary="===============6211614748901741873=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 9th of April 2020
Date: Thu, 09 Apr 2020 18:30:50 +0200
Message-ID: <e517a0a5-e328-1c04-92d5-148544a48055@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4148

--===============6211614748901741873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 94th meeting with Mat and Ossama (Intel OTC), Christoph =

(Apple), Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: /)

/

     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Davide Caratti, Matthieu Baerts, Paolo Abeni):

1262061: RFC: [RFC,1/2] uapi: update linux/mptcp.h
1262063: RFC: [RFC,2/2] add support for mptcp netlink interface:
     - on going discussions with ADD_ADDR management

1263271: RFC: [RFC,iproute2-next] ss: allow dumping MPTCP subflow =

information:
     - to be reviewed

1265469: Needs Review / ACK: selftests:mptcp:pm: rm the right tmp file:
     - to be reviewed

1266897: Under Review: mptcp:pm netlink: fix variable scope:
     - reviewed by Mat (thx)
     - do we need this fix just to silence cppcheck while not bringing =

anything else?
     - not really: we can keep it for later or drop it



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - Full DATA_FIN support [WIP]:
             - could be nice to have it: if ready
         - Active backup support [WIP]
         - ADD_ADDR for MPTCPv1: echo bit
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



In progress fixes for -net:
     - subflow ctx usage is broken (discussion started on IRC and it =

seems I missed that :) ):
         - it's more complex than expected.
         - Some bugs appears after a few hours
         - Florian is looking at that



Extra tests:
     - news about Syzkaller? (Christoph):
         - no new crash
         - will push descriptions for the netlink PM once available

     - new about Intel's kbuild? (Mat):
         - Mat got news about the issue with BPF:
             - seems not related to MPTCP but issues in kselftests
             - Mat is looking at reproduce the issue and follow-up with =

these guys
             - will notify us if it is related to MPTCP
         - we didn't get any email:
             - could be good to force sending an email in case of =

success just to be sure everything is OK
             - note that net-next is only updated once a week for the =

moment so "export" is not modified a lot

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - do we need to run cppcheck?:
             - Matth was not able to reproduce the warnings reporting by =

kbuild
             - there are other false positive, see ML
             - seems OK not to have it



Next meeting:
     - We propose to have the next meeting on Thursday, the 16th of April.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200416



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
--===============6211614748901741873==--
