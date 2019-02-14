Content-Type: multipart/mixed; boundary="===============0278865508029285877=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of February 2019
Date: Thu, 14 Feb 2019 18:33:25 +0100
Message-ID: <17c14e21-1c7f-e15e-9527-17bd6f9053a3@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 997

--===============0278865508029285877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 39th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



MPTCP architecture proposal - RFCv6 changes pushed:
    - addressed issues saw in reviews (gerrit & ml)
    -
https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open
    - There is a "Download" button on Gerrit (on the right, just above
the list of modified files) telling you can do a git fetch easily, e.g.:

        git fetch
"https://review.gerrithub.io/multipath-tcp/mptcp_net-next"
refs/changes/04/437404/7

    -
https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal
    - not many (functional) things are different
    - Note: OK to push on a repo and/or gerrithub (as long as it is easy
to pull from)



packetdrill:
    - there is an old version but still functional
    - there are known limitations but more an issue for advanced usage
    - so it is usable for us for the RFC
    - Christoph will create a fork of Arnaud's version on multipath-tcp
github repo =E2=86=92 https://github.com/aschils/packetdrill_mptcp
    - we can add the two commits from Tessares:
https://github.com/cpaasch/packetdrill_mptcp/pull/1



Peter:
    - looking at using ULP to extent TCP sock for the subflows in the
RFC patch.



Florian:
    - extent kselftests to use NS but also use them with delay, etc. (netem)



Next meeting:
    - We propose to have the next one on Thursday, the 21st of February.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190221



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

--===============0278865508029285877==--
