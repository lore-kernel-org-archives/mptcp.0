Content-Type: multipart/mixed; boundary="===============1314349002404211098=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 28th of February 2019
Date: Thu, 21 Feb 2019 18:34:01 +0100
Message-ID: <1c4b96a3-2265-4eaa-8e00-d39b78fb67c2@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1012

--===============1314349002404211098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 40th meeting with Mat and Ossama (Intel OTC), and myself
(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Packetdrill:
    - now available: https://github.com/multipath-tcp/packetdrill_mptcp
    - as said last week, there are some limitations (multi connections,
etc.) but a good start for the first validations!
    - there are examples in the same repo ;-)



IETF RFC6824bis:
    - v13 available:
https://github.com/multipath-tcp/draft-ietf-mptcp-rfc6824bis/commit/a197ed9=
35ef5570c70432e8b372ebc208d40ed64



CI job to update TopGit tree:
    - update the topgit tree and export it if no conflicts and
validation (only the compilation with CONFIG_MPTCP=3Dy for the moment) is OK
    - in review:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445591
    - already running:
https://github.com/multipath-tcp/mptcp_net-next/tree/export
    - next steps:
        - add topics in TG tree:
            tcp: Add MPTCP option number =E2=86=92 +2
            tcp: Define IPPROTO_MPTCP =E2=86=92 +2
            mptcp: Add MPTCP socket stubs =E2=86=92 +1
            mptcp: Handle MPTCP TCP options =E2=86=92 +1
            =E2=86=92 Matth: will integrate the two first 2 patches in topg=
it
(and more once +2 will be given) next week (off tomorrow)
        - add more validations:
            kselftests once merged?
            packetdrill, etc.



Mat:
    - will update the patches on Gerrit with Florian fixes and other
changes.
    - in the next version after =E2=86=91, there will be changes related to
subflows (patch number 5 will be rewritten).



Ossama:
    - continuing on the reviews



(Physical) meeting:
    - Could be nice to meet each others at LPC 2019 (September 9-11,
Lisbon, Portugal)



multipath-tcp:
    - we should have soon (no ETA) a new sync with upstream for v0.94
    - a new branch v0.95 based on v4.19.x
    - mptcp_trunk sync with last kernel



Next meeting:
    - We propose to have the next one on Thursday, the 28th of February.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190228



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

--===============1314349002404211098==--
