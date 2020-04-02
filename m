Content-Type: multipart/mixed; boundary="===============0158981024418860620=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 2nd of April 2020
Date: Thu, 02 Apr 2020 18:50:57 +0200
Message-ID: <89b4788f-0348-097a-85f6-95dc44d6e130@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4130

--===============0158981024418860620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 93rd meeting with Mat (Intel OTC), Peter (), Davide and =

Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Florian, Matthieu):

1263970  [net-next,1/1] selftests:mptcp: fix failure due to whitespace d
mptcp: fix tcp fallback crash
mptcp: subflow: check parent mptcp socket on subflow state change
mptcp: re-check dsn before reading from subflow
mptcp: fix "fn parameter not described" warnings

     our repo (by: Florian Westphal, Mat Martineau, Matthieu Baerts):

1264688  mptcp: fix tcp fallback crash
1262978  squashto: mptcp: allow dumping subflow context to userspace
1262846  [6/6] topmsg: mptcp: add and use MIB counter infrastructure
1262847  [5/6] Squash-to: "mptcp: add and use MIB counter infrastructure
1262843  [4/6] topmsg: mptcp: rework mptcp_sendmsg_frag to accept option
1262845  [3/6] Squash-to: "mptcp: rework mptcp_sendmsg_frag to accept op
1262844  [2/6] topmsg: mptcp: queue data for mptcp level retransmission
1262841  [1/6] Squash-to: "mptcp: queue data for mptcp level retransmiss
1258245  [mptcp-next,v2] tcp: mptcp: use mptcp receive buffer space to s



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Davide Caratti, Florian Westphal, Matthieu Baerts, =

Paolo Abeni):

1253668: Changes Requested: mptcp: propagate sendbuf setting to subflow =

on fallback
1253672: Changes Requested: mptcp: copy mptcp receive buffer setting to =

subflow:
     - to be archived

1262061: RFC: [RFC,1/2] uapi: update linux/mptcp.h
1262063: RFC: [RFC,2/2] add support for mptcp netlink interface.:
     - Davide will continue the work
     - Mat did a first review

1263271: RFC: [RFC,iproute2-next] ss: allow dumping MPTCP subflow =

information:
     - To be reviewed

1264726: Rejected: Re: [PATCH] mptcp: fix tcp fallback crash:
     - to be archived too

1265469: New: selftests:mptcp:pm: rm the right tmp file:
     - to be reviewed



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



Part 3: planned fixes:
     - Florian sent patches from the export branch

     - what's left after that:
         - mptcp:sendmsg: truncate source buffer if mptcp sndbuf size =

was set from userspace:
             - Florian plans to re-check if there is no other solution =

for that
         - tcp: mptcp: use mptcp receive buffer space to select rcv window:
             - for net-next when it will re-open



Part 4: new features:
     - Mat plans to continue to work on the DATA FIN for net-next when =

it will be re-opened

     - Peter plans to look at the ADD_ADDR echo bit

     - don't hesitate to look at the roadmap and Github issues



general protection fault in __mptcp_flush_join_list:
     - From Florian: No idea yet how to fix this other than hooking into =

inet_accept()

     - the code is certainly fine but lack of comments linked with the RFC:
         - in which conditions we fallback or reset
         - Florian will try to look at that



Extra tests:
     - news about Syzkaller? (Christoph):
         - Shared on ML
         - Also https://github.com/multipath-tcp/mptcp_net-next/issues/12

     - new about Intel's kbuild? (Mat):
         - last week, there was a note from them about BPF selftests issues
         - but no news from them
         - we might have more feedback soon
         - it seems they also test MPTCP kselftests from Linus' branch

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - (now only testing at the end of the export branch because =

part 3 has been applied upstream)



Congratulations for all the work to have part 3 applied upstream:
     - when can we celebrate that?
     - we all voted no to have a face-to-face meeting next week :'(



Next meeting:
     - We propose to have the next meeting on Thursday, the 9th of April.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200409



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
--===============0158981024418860620==--
