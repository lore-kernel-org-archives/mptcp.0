Content-Type: multipart/mixed; boundary="===============7723744917320793640=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 26th of March 2020
Date: Thu, 26 Mar 2020 18:04:23 +0100
Message-ID: <26ec1bbf-d791-95d3-a2fc-173d25096c2d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4084

--===============7723744917320793640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 92nd meeting with Mat, Peter and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by Davide):

1258480  [net-next] net: mptcp: don't hang in mptcp_sendmsg() after TCP =

fallba...


     our repo: (Mat Martineau, Matthieu Baerts, Paolo Abeni, Peter Krystad)

1261955  [net-next,v3] Squash-to: "mptcp: add netlink-based PM"
1261703  squash-to: selftests: add PM netlink functional tests
1260815  [3/3] mptcp: fix "fn parameter not described" warning
1260813  [2/3] mptcp: fix "fn parameter not described" warnings
1260812  [1/3] mptcp: fix "fn parameter not described" warning
1260233  mptcp:netlink: fix compilation warning
1259160  [v1,5/5] Squash-to: "mptcp: update per unacked sequence on pkt
1259159  [v1,4/5] Squash-to: "mptcp: Add handling of outgoing MP_JOIN re
1259162  [v1,3/5] Squash-to: "mptcp: Add handling of incoming MP_JOIN re
1259156  [v1,2/5] Squash-to: "mptcp: Add path manager interface"
1259157  [v1,1/5] Squash-to: "mptcp: Add ADD_ADDR handling"
1259137  [2/2] mptcp: Include ADD_ADDR port value for path manager
1259136  [1/2] mptcp: Parse optional port field of ADD_ADDR
1258564  [v1,4/4] Squash-to: "subflow: place further subflows on new 'jo
1258562  [v1,3/4] Squash-to: "mptcp: Add handling of incoming MP_JOIN re
1258566  [v1,2/4] Squash-to: "mptcp: Add path manager interface"
1258565  [v1,1/4] Squash-to: "mptcp: Add ADD_ADDR handling"
1258550  squash-to: mptcp: Add path manager interface
1258547  topmsg: mptcp: add netlink based PM
1258546  topmsg: mptcp: implement and use MPTCP-level retransmission
1258548  topmsg: mptcp: update per unacked sequence on pkt reception
1258549  topmsg: mptcp: Implement path manager interface commands
1258545  topmsg: mptcp: Add path manager interface
1258046  [2/2] mptcp: fix compilation warning without IPV6
1258047  [1/2] mptcp: fix compilation error without IPV6
1255551  [v1,3/3] Squash-to: "selftests: add test-cases for MPTCP MP_JOI
1255552  [v1,2/3] Squash-to: "mptcp: add netlink based PM"
1255550  [v1,1/3] Squash-to: "mptcp: Implement path manager interface co


Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev: (Florian)

1258245  [mptcp-next,v2] tcp: mptcp: use mptcp receive buffer space to s


     our repo: (Florian, Paolo)

1253668: Changes Requested: mptcp: propagate sendbuf setting to subflow
1253672: Changes Requested: mptcp: copy mptcp receive buffer setting to:
     - wait to know what we do here (setsockopt, etc.)
     - so no new version planned here

1262061: New: [RFC,1/2] uapi: update linux/mptcp.h
1262063: New: [RFC,2/2] add support for mptcp netlink interface.:
     - iproute2 modifications
     - Paolo is asking for help for the man page
     - any review welcome
     - especially with the syntax, see patch 2 =E2=86=92 usage()
         https://patchwork.ozlabs.org/patch/1262063/
     - related changes:
         - Davide has some patches to extract data from subflow (ss)
         - can be queued with netlink patches



FYI: Current Roadmap:
     - Part 3 (this merge window):
         - PM: [Done]
             - locking [Done]
             - basic =E2=86=92 netlink support [Done]
         - MP_JOIN [Done]
         - ADD_ADDR for MPTCP v1 [DONE]
         - clean the current patches [DONE]
         - squash the current patches [DONE]:
             - "subflow: place further subflows on new 'join_list'"
         - PM basic [Done]
         - fix sender ID in MP_JOIN [Done]
     - Part 4 (to fully support MPTCP):
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



Part 3 remaining stuff:
     - Review commit messages:
         - DONE

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - DONE

     - ADD_ADDR for MPTCPv1:
         - DONE (without the echo)

     - v1:
         - sent on Monday

     - v2 in preparation:
         - rebase on latest net-next (with resolved conflicts)
         - small fixes:
             - one comment in token.c
             - netlink:
                 - add spinlock
                 - relax admin constraint on 'getters'
                 - let user space set a single limit at once
                 - fix reported error message
         - nothing else
         - tag =E2=86=92 netdev-for-5.7-part3-v2
         - 2a6d194b94e7...c8cb6ce85550 netdev-for-5.7-part3-v2 -> =

netdev-for-5.7-part3-v2 (forced update)



Shared received windows:
     - is "tcp: mptcp: use mptcp receive buffer space to select rcv =

window" patch enough?
     - can be sent to netdev when part 3 is applied
     - can be queued at the end of the export branch
     - Matth: TODO



Extra tests:
     - news about Syzkaller? (Christoph):
         - 2 new issues:
             - one is a known issue, already on Github =E2=86=92 like =

"mptcp_connect.sh -m mmap"
             - a new one but a nasty one:
                 - Paolo looked at it and he is trying to collect data
                 - Looks quite bad. Paolo will send an email about that.

         - when ran without KASAN, DEBUG, more issues are found!

     - new about Intel's kbuild? (Mat):
         - They said they found an issue in BPF selftests, we are =

waiting for more news about that

     - packetdrill (Davide):
         - Can we merge: =

https://github.com/multipath-tcp/packetdrill/pull/3 :
             - yes we can

         - now validating: DACK4 + DSN4. But also MP_JOIN

     - CI (Matth):
         - Now testing W=3D1 for files in net/mptcp/
         - and testing commits at the end of "selftests: add test-cases =

for MPTCP MP_JOIN" as well



Filed some small buglet as github issues:
     - https://github.com/multipath-tcp/mptcp_net-next/issues
     - feel free to add new ones
     - feel free to pick any of them

    2: reduce hooking in TCP code
    3: fix 'mmap' related race
    4: keep a single work struct in mptcp socket
    5: Allow ss/netstat etc. to show program name for client and =

listener MPTCP subflows
    6: loss and delay without reordering causes very slow transfer 2:
        - https://github.com/multipath-tcp/mptcp_net-next/issues/6
        -
    7: cleanup sendmsg_frag allocation
    8: fix possible race in subflow_finish_connect()
    9: fix "IPv4: Attempt to release TCP socket in state 1 "... on shutdown
   10: reduce mptcp options space usage
   11: fix fallback to TCP... @dcaratti



TODO for next meeting:
     - Paolo: Use MPTCP with multiple paths not to be disconnected if =

one fails.



Next meeting:
     - We propose to have the next meeting on Thursday, the 2nd of April.
     - /!\ *BACK* to the usual time: 16:00 UTC (9am PDT, 8pm CEST) /!\
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200402



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
--===============7723744917320793640==--
