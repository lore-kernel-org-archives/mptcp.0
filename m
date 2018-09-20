Content-Type: multipart/mixed; boundary="===============6290874237602152148=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of September 2018
Date: Thu, 20 Sep 2018 19:15:59 +0200
Message-ID: <30b013e5-10ad-5642-30c6-e7973363454c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 755

--===============6290874237602152148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 22th meeting with Mat and Peter (Intel OTC), Christoph
(Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



mptcp_net-next: lockless sf patch-set proposed:
    - there were some confusions in the comments (see next point to
resolve this issue)
    - but going to be merged and need to be tested
    - now we are aligned with mptcp_trunk



big changes on mptcp-dev:
    - if also for mptcp_net-next: should we involve upstream ML for the
discussions?
    - the decision is to at least put Mat in CC.



More cleanup in mptcp-net-next:
    - removing features/optimisations =E2=86=92 Christoph is looking at tha=
t:
the goal is to remove features to simplify the code, patch will follow.
    - but these features/optimisations will continue to be maintained in
mptcp_trunk.
    - Note in recent kernels: GSO + SG are now enabled by default
    - rethinking scatter-gather support.
        - @Christoph / @Mat: may you re-share your point of views about
that here please?
    - it could be nice to have a nice split between MPTCP and TCP for
the send part (it then means we don't need the re-injection for the
first version, some static values, etc.)



New test suite/environment for mptcp_net-next:
    - Matth is working on testing mptcp_trunk, can be nice to have
mptcp_net-next but if we remove features, that will become difficult to test
    - same for Christoph's test suite
    - there is packetdrill but support for MPTCP in Open-Source is not
very nice (would be amazing to have people working on that)
    - we don't see any (open-source) test suites for the kernel with
MPTCP support. Feel free to share if you have new ideas!
    - maybe "re-using" the old testing suite for MPTCP: KVM hosts and
doing some tests in bash
    - Matth: looking at alternatives for next time



How is Google Meet:
    - Works good, quality is good, no disconnection
    - last alternative is Jitsy (webrtc + phone) but seems not needed
    - We will then continue to use Meet
    - Please ask me (Matt) to share the Google calendar invitation with you.



Next steps:
    - same as last week.



Next meeting:
    - We propose to have it on Wednesday this time, the 26th of
September. Usual time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180926



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

--===============6290874237602152148==--
