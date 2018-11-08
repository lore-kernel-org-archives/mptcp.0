Content-Type: multipart/mixed; boundary="===============5493375568928752929=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 8th of November 2018
Date: Thu, 08 Nov 2018 19:34:20 +0100
Message-ID: <aec94ddb-87b1-c460-138f-3e2871a5a1ee@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 835

--===============5493375568928752929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 28th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian Westphal (Redhat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



packetdrill:
    - Peter: interested to contribute, need to check the legal stuff first.
    - Matthieu: interested too, OK for the legal stuff.
    - official fork: https://github.com/aschils/packetdrill_mptcp
    - but it needs to be improved
    - Neal Cardwell from Google agrees to support us (review, etc.)
integrating that in the Google repo when MPTCP is in net-next.



gerrit:
    - use cases have been shared by email on the ML
    - we need to experiment TopGit + Gerrit together.
    - Matth: check sync with Gerrithub, mptcp_net-next has been updated
(master branch)
    - Matth: if no comment on the mail, setup the rules and share the
info on the ML



topgit tree:
    - "net-next" branch as the base, new branch ("mptcp_net-next"?) as
the top
    - but should we not drop "master"? =E2=86=92 Mat & Peter are starting f=
rom
the net-next ; Christoph is starting from "master":
        - we don't want to drop this branch now. "master" and
"mptcp_net-next" should get closer and closer. When they will be
similar, we can drop "master".
        - "master" will then not be part of any Topgit tree.



Next steps:
    - Mat with Ossama: working on the userspace daemon
    - Christoph: was not able to work on the upstream this time
    - Peter is looking at packetdrill
    - Matthieu is still working on testing mptcp_trunk, then the
upstream of PM Netlink.
    - Florian is looking at the project (wiki, code, etc.)
    - As usual, update the wiki if there are new stuffs to put in!



Next meeting:
    - We propose to have it on Wednesday this time, the 14th of
November. Usual time: 9am PDT - 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181114



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

--===============5493375568928752929==--
