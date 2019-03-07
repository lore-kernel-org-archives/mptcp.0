Content-Type: multipart/mixed; boundary="===============8993424619810859552=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 7th of March 2019
Date: Thu, 07 Mar 2019 19:50:25 +0100
Message-ID: <df1590b4-7d07-44f4-0f60-c8b3fd571a15@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1026

--===============8993424619810859552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 42th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian, Paolo Abeni and Davide Caratti (Red Hat) and
myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Because there were new people on the call, we summarized what has been
done (architecture, talk, discussions, skb ext, netlink API, gerrit,
code), where is the code (gerrithub/github), the workflow (gerrit/ML)
and others topics.



Paolo Abeni:
    - Red Hat would like to participate in the upstream project
    - Questions about workflows, test (some kselftests have been started
by Florian)



Davide:
    - looking at the possibility to add socket diag for MPTCP



Some links:
    https://github.com/multipath-tcp/mptcp_net-next/commits/export
    =E2=86=92 accepted code

https://review.gerrithub.io/q/project:multipath-tcp/mptcp_net-next+status:o=
pen
    =E2=86=92 in review code
    last email about that in the archives:
https://lists.01.org/pipermail/mptcp/2019-March/001022.html

https://www.netdevconf.org/0x12/session.html?how-hard-can-it-be-adding-mult=
ipath-tcp-to-the-upstream-kernel
    =E2=86=92 from netdev last year

https://github.com/multipath-tcp/mptcp/commit/4ea5dee9786aea30fad9fa9fa32f6=
ac1e5300623
    =E2=86=92 to have a userspace PM using netlink
    https://github.com/multipath-tcp/mptcp_net-next/wiki/Gerrit
    =E2=86=92 How to contribute: via Gerrit or ML

https://github.com/multipath-tcp/mptcp_net-next/wiki/Gerrit#different-branc=
hes-on-mptcp_net-next-repo
    =E2=86=92 about the branches we have on Github
    https://github.com/multipath-tcp/mptcp_net-next/wiki/Design
    =E2=86=92 design
    https://github.com/multipath-tcp/mptcp_net-next/wiki/Status
    =E2=86=92 status (end of 2018)



Mat and Peter's patch-set:
    - still focus on the server side for the moment, minimum support of
the RFC
    - goal would be to all align on the architecture (current patch-set)
    - don't hesitate to ask questions on the ML and/or Gerrit if it is
specific to a patch-set
    - some comments have been sent the reviews on Gerrit, mainly
detail/cleaning
    -
https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open
    - will share a version with ULP as soon as possible when it is ready
to be shared



Wiki:
    - we would need to think about what can be done in parallel:
        - monitoring: is a good idea with socket diag
        - monitoring: is MPTCP working? =E2=86=92 ss could answer that
        - monitoring: also an entry in /proc/net/mptcp_net/mptcp (like
the mptcp.org implem)
        - tests with kselftests + packetdrill
        - scheduling (via eBPF)
        - path-management (via Netlink)
    - we need to maintain a list in the wiki
    - @Mat: I just added this:
https://github.com/multipath-tcp/mptcp_net-next/wiki/Status#future-work



Net/TCP Maintainers:
    - Paolo had a discussion with Eric
    - they prefer to have small patches to give early feedback
    - less impact as possible in the current TCP implementation
    - they like the ULP architecture =E2=86=92 Peter is looking at that, but
very good to have that but change code a bit everywhere
    - we don't need to have something fully functional before posting to
netdev



Ossama:
    - his work is in internal review process
    - WIP to support the API posted on mptcp-dev



Github:
    - default branch is now "export":
https://github.com/multipath-tcp/mptcp_net-next
    - use export if you want to test and read (this branch is rebase on
top of net-next once per day)
    - use for-review if you want to contribute



multipath-tcp.org:
    - new scheduler (BLEST)
    - many fixes from Christoph and detected by syzkaller + other fixes
related to MPTCP retransmissions



IETF:
    - Christoph will be there
    - no one else from people here



Next meeting:
    - We propose to have the next one on Thursday, the 14th of March.
    - NOT the usual time if you are in Europe: 16:00 UTC (9am PDT, 5pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190314



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8993424619810859552==--
