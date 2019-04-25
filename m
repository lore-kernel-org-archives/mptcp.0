Content-Type: multipart/mixed; boundary="===============0318195359806683027=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 25th of April 2019
Date: Thu, 25 Apr 2019 18:28:07 +0200
Message-ID: <f8109a66-d67f-a292-e9e5-1e9473002861@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1089

--===============0318195359806683027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 47th meeting with Mat and Peter (Intel OTC),
Christoph (Apple), Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Initial architecture:
    - Paolo will do a new iteration of his fixes/improvement we
discussed last week

    - new patch set:
https://lists.01.org/pipermail/mptcp/2019-April/001080.html =E2=86=92 mptcp
option len must be skb independent (in progress)

    - Mat & Peter and Paolo (problem with the receive destination cache
expired) might not look at the same bug.

    - Mat & Peter are working on a new version with some
refactoring/cleanup already discussed on Gerrit (new internal header, no
more magic numbers, etc.)

    - Mat is finishing his use-after-free issue (on the ULP listening
socket)

    - Mat & Peter hope to push to Gerrit soon!



Next steps:
    - Mat & Peter: share the new version
    - Review of =E2=86=91
    - Integrate bug fixes/improvements from Paolo
    - discuss next week about what to do with the shared received windows
    - merge stuff in our repo
    - prepare something to share with Eric



mptcp.org:
    - MPTCP v1 still in RFC, no comment so far.
    - we can use it to test the upstream version with this v1 (the goal
is for us to only support the v1)



Next meeting:
    - We propose to have it next Thursday, the 2nd of May.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190502



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

--===============0318195359806683027==--
