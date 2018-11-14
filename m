Content-Type: multipart/mixed; boundary="===============1092594248865027067=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of November 2018
Date: Wed, 14 Nov 2018 19:02:32 +0100
Message-ID: <a0b2fdc0-16d0-62a1-02af-5ff2b4483852@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 839

--===============1092594248865027067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 29th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Netdev 0x13:
    - https://www.netdevconf.org/0x13/
    - March 20th to 22nd, 2019
    - Prague
    - Closing of CFS: Tue, January 15, 2019.
    - any ideas for a presentation?
    - that would also a good occasion to meet people and the group
    - Christoph might not be present
    - other occasions: Linux plumbers. Should be in Portugal next year.
(September 8-10, 2019 | Lisbon, Portugal)



Gerrit:
    - the two repo are sync now.
    - use gerrit for review
    - topgit: Matth can manage the tree to simplify the process: push
stuff for review, Matth apply them.
    - let's push stuff on gerrit
    - if gerrit is an issue, we can fallback to ML without issue
    - goal: improve process, not adding complexity

            git checkout -b <my_branch> master
            (...)
            git commit -s
            git review ## instead of git send-email

    - AP: Matth: document typical use cases with commands and put that
on the wiki
        - I have a new change for 'master' (full MPTCP on top of
mptcp_trunk)
        - I have a new change for 'mptcp_net-next' (new architecture)
        - I have a fix for an existing topic
        - I want to sync 'mptcp_net-next' with 'net-next'



Next steps:
    - same as last time
    - new AP for Matth, see [Gerrit] section.
    - As usual, update the wiki if there are new stuffs to put in!



Next meeting:
    - We propose to skip to one of next week, many people are off. The
next one would be on Thursday, the 29th of November. Usual time: 9am PDT
- 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181129



Feel free to comment on these points and propose new ones for the next
meeting!



Talk to you in two weeks,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1092594248865027067==--
