Content-Type: multipart/mixed; boundary="===============3484922869241983130=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 13th of December 2018
Date: Thu, 13 Dec 2018 18:54:56 +0100
Message-ID: <c4885c82-ce14-f9eb-2a34-36246933b68f@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 900

--===============3484922869241983130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 32nd meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (Redhat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



indirect call optimization:
    - another approach by Paolo Abeni: https://lkml.org/lkml/2018/12/5/1206
    - mainly for the fast path



Mat & Peter's patch-set:
    - how the MP_JOIN will be done?
    - see the beginning of the discussion:
https://lists.01.org/pipermail/mptcp/2018-December/000892.html
    - by Christoph: what might help is: giving an example on how the
userspace will act.
    - =E2=86=92  goal: only one accept() is done by the userspace for the w=
hole
MPTCP connection
    - =E2=86=92 tricky bit: the kernel needs to listen + accept new subflow=
s and
link that to the MPTCP connection. In the current code (mptcp_trunk), we
have many "if (LISTEN && !is_meta(sk))" =E2=86=92 we want to avoid that.
    - =E2=86=92 also we want to correctly take into account the backlog (how
many connections per listening sk =E2=86=92 subflows should not be taken in=
to
account)
    - =E2=86=92 could be nice to share some code/pseudocode. @Peter will lo=
ok at
that



Christoph's patch-set:
    - Christoph identified a problem, a v2 is needed:
    - https://lists.01.org/pipermail/mptcp/2018-December/000889.html
    - or
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/436386/1
    - note: disabling some rps show some bugs in MPTCP, looking at that
    - other bugs seem linked to mptcp_trunk
    - feel free to review (gerrit/mail, see above)



netdev patchset by Florian:
    - lot of feedback from Eric, some concerns. Some make sense.
    - now making some tests to show that it is fine to have that, hoping
to share that next week.
    - no impact in IPSec perfs \o/
    - Mat already rebased his version on top on last Florian's patch,
will share that hopefully tomorrow, could be good to discuss about that
on the ML.
    - clone might be not needed. tests need to be done. But if it is
just for MPTCP it is not important to have the clone at this point.



mptcp_trunk:
    - alignment of TCP options: currently we can have:
        NOP NOP [Timestamps]  (2 + 10 bytes)
        NOP NOP [MPTCP]       (without checksum =E2=86=92 2 + 18 bytes).
        =E2=86=92 we could then avoid the NOP
      But MPTCP options are generated in MPTCP stack, supposing then
that everything before is already aligned. =E2=86=92 that would require more
changes in the TCP stack, that's why it was not done. Maybe for later if
a Generic TCP Options framework ( https://lwn.net/Articles/741859/ ) is
in place ;-)



Podcast from Monday:
    - more questions about the protocol, not a lot about upstreaming
    - should be released next year
    - Mat and Christoph will be notified anyway.



Next meeting:
    - We propose to have the next one on Thursday, the 20th of December.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181220



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

--===============3484922869241983130==--
