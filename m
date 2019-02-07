Content-Type: multipart/mixed; boundary="===============3068510166544615842=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 7th of February 2019
Date: Thu, 07 Feb 2019 19:10:22 +0100
Message-ID: <56f662c4-023c-edef-7e4b-19cc1985cb66@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 994

--===============3068510166544615842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 38th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (RedHat), Hoang (UCLouvain) and myself
(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



What's next (already discussed last time but without Peter and Florian)?

    - focus on the first patch-set and try to upstream this base? What
need to be done:
        - handling data-fin
        - sharing TCP windows across subflows
        - IPv6 (or for later?):
            =E2=86=92 could it be a problem for a RFC (keeping attraction on
that instead of the rest)
            =E2=86=92 on the other hand, it should not be that difficult / =
lot
of differences between v4 and v6
            =E2=86=92 but not really blocking as long as it is written in t=
he
cover letter
        - mptcp_sendmsg has some limitations for the moment (in case of
buffer/memory pressure)


    - integrate Mat and Peter's patch-set in our topgit tree? (or at
least what we agreed on) not to have a lot of pending changes?
        =E2=86=92 yes, can be done for the first accepted Changes.


    - removing feature on mptcp_net-next/master?
        =E2=86=92 can be done in parallel
        =E2=86=92 we can check what we can take from there and adapt to the=
 new
architecture


    - testing? (packetdrill?)
        =E2=86=92 can still be interesting to have functional tests
        =E2=86=92 we should be able to use the open-source version for the =
first
basic tests but it should be able to test specific code paths
        =E2=86=92 https://github.com/ArnaudSchils/packetdrill_mptcp
        =E2=86=92 Peter: quite some work to do to have an upstream-able ver=
sion
        =E2=86=92 Matthieu: Tessares did a few bug fixes that they can publ=
ish,
at least to be able to use it with more recent version (of the kernel)



KSelfTest + fixes by Florian:
    - https://lists.01.org/pipermail/mptcp/2019-February/thread.html#988
    - create MPTCP connections
    - a few minor fixes are also provided in this patch-set
    - Mat: will have a look at that



Matth, TODO:
    - CI job to update TopGit tree
    - CI job to export TopGit tree into a dedicated branch
    - look at PacketDrill fixes



Next meeting:
    - We propose to have the next one on Thursday, the 14th of February.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190214



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

--===============3068510166544615842==--
