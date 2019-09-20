Content-Type: multipart/mixed; boundary="===============2111859788238555413=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 19th of September 2019
Date: Fri, 20 Sep 2019 17:09:37 +0200
Message-ID: <4189ea3b-b81d-009a-44aa-9829b3f74ff1@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1891

--===============2111859788238555413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 67th meeting with Mat and Ossama (Intel OTC),
Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: remove token_release:
        - by Florian
        - Waiting for application
        - Reviewed by Paolo



Pending patches:
    - mptcp: Implement interim path manager:
        - by Peter
        - v2 sent
        - Waiting for accept

    - mptcp: implement retransmit infrastructure:
        - 7 patches
        - by Paolo
        - RFC =E2=86=92 v1 =E2=86=92 v2
        - Waiting for application

    - net/mptcp: rcu-ify the subflow context:
        - by Davide
        - v1 (no more an RFC) should arrive soon

    - mptcp_poll rework preview:
        - by Florian
        - RFC
        - should be rebased on top of the recvmsg refactor commits
(should be applied today)

    - mptcp sparse "fixes":
        - by Florian
        - accepted by Peter
        - Waiting for application

    - mptcp: allow dumping subflow context to userspace:
        - by Davide
        - RFC (with questions about what to expose + "sensitive" info)
        - commented by Florian and Matt
        - currently all these info are linked to the subflow, not the
MPTCP socket. And everything needs CAP_NET_ADMIN (ss -i)

    - mptcp: partial recvmsg() refactor:
        - by Paolo
        - v2 sent
        - accepted by Mat
        - Waiting for application

    - selftests: prepare for mptcp ipv6 support:
        - by Florian
        - commented by Paolo and Peter (+ who can do what) and Alexander

    - mptcp: Remove all traces of checksum support:
        - by Peter
        - mptcp_write_options() needs to be updated, v2 needed
        - Reviewed by Paolo and Mat



Prepare RFC for next week:
    - we should do that yes
    - with everything we have next week
    - idea is to get real feedback with real code
    - RFCv2 with explanation about what is missing (IPv6, DATA_FIN,
MPTCPv1, etc.)
    - we can send it after next week meeting



Remaining tasks (not including bug-fix) for the initial patch set:
    - IPv6 support:
        - Peter is interested by looking at that.
        - simple implementation should be preferred
        - we can force the userspace not to do some stuff but we can
have a subflow using v4, another v6, that's quite common in fact.
        - but for the initial submission, let's keep it simple.

    - And MPTCP v1 support:
        - note that there is a patent on that
        - would it be a problem?
        - the code on mptcp.org is published under GPLv2
        - Maybe Christoph can help? If you have idea :)
        - ref to the patent
https://patents.google.com/patent/US20160261722A1/en

    - DATA_FIN:
        - Mat started the work, the base
        - Needs to continue

    - Shared recv window:
        - be careful that it is the recv side, our "server" can receive
from multiple SF
        - should we implement the full support (code change in TCP code)?
        - Or should we try to avoid severe consequences?:
            - maybe more interesting to go that way for the initial
submission
            - but we should consider that as a temporary situation:
                - scheduler might avoid bad consequences
                - if there is no more space at MPTCP level (because the
application is blocked), TCP SF might announce space but that will be
drop between TCP and MPTCP
                - BUT we don't have windows at the MPTCP level
                - It should be fine with the current recvmsg() implem (?)
                - we can have "out-of-order" when we have reinjection at
MPTCP level (even retransmission on the same SF triggered by MPTCP timer)
                - Idea from Paolo: when moving the data from the SF to
the MPTCP socket (recv side), we might want to keep a ref (still
charged/accounted into) on the subflow =E2=86=92 *less invasive solution*

    - Active backup support:
        - We use the backup subflow only if no other no other non backup
SF are up
        - The idea would be to stop using the 2nd address.
        - Could be simulated by nftables?
        - But then we need a "scheduler" that starts looking at what's
happening on 1 SF, etc.
        - sysctl for the PM might be easier
        - (we will not upstream the "interim" PM but the code to allow
the switch will be)



Next meeting:
    - We propose to have it next Thursday, the 26th of September.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190926



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

--===============2111859788238555413==--
