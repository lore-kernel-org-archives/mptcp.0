Content-Type: multipart/mixed; boundary="===============3532745257203366010=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 29th of November 2018
Date: Thu, 29 Nov 2018 18:58:33 +0100
Message-ID: <4c375f47-44c4-1e88-8331-e2589d13f132@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 846

--===============3532745257203366010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 30th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (Redhat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



News from multipath-tcp.org:
    - A few patches have been applied (mptcp_trunk, v0.93 and v0.94)
    - Christoph updated mptcp_trunk to v4.19 (WIP)
        Note: v4.19 introduces batch processing of network packets but
it should be safe for MPTCP, done at the above layer
        https://lwn.net/Articles/763056/



skb extension:
    - See the discussion on the ML:
https://lists.01.org/pipermail/mptcp/2018-November/000840.html (and next
messages on the same thread)
    - Goal: Coalescing and extension data
    - MPTCP needs something like that for the receive side
    - patch by Florian, RFC, initially for ipsec/bridge
    - coalescing: some changes have been proposed on netdev but, to be
checked, only done if TCP options are all the same, not adapted for
MPTCP case then
        - note: with ktls, they disabled the coalescing
        - note: with MPTCP, you don't need the DSS in all packets
    - anyway, this RFC patch will also be very useful for MPTCP =E2=86=92 we
know we should go in this direction as well



Mat:
    - looking at sharing a new version without the use of err queue.
    - also rebase the work on Florian's patch-set.



Matthieu:
    - will send a new version of Netlink PM in the coming days/weeks:
the goal is to have it in the MPTCP version based on v4.19



Next meeting:
    - We propose to have the next one on Thursday, the 6th of December.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181206



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

--===============3532745257203366010==--
