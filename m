Content-Type: multipart/mixed; boundary="===============6707468315314091125=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 11th of April 2019
Date: Thu, 11 Apr 2019 18:53:07 +0200
Message-ID: <d9c9e2e4-9ed8-01f1-c788-81b611542c00@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1065

--===============6707468315314091125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 46th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Mat and Peter's patch-set:

    - We had some discussions, mainly about ULP:
      https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/450099/1

    - Mat is looking at the warning reported by Paolo last week.

    - Mat is concerned about the fact the userspace can currently open a
"subflow" ULP via setsockopt. It should be possible to revert the removal:
       - ULP bits that restricted some ULP types to kernel-space-only
were removed in 1243a51f6c05ecbb2c5c9e02fdcc1e7a06f76f26
       -
https://github.com/torvalds/linux/commit/1243a51f6c05ecbb2c5c9e02fdcc1e7a06=
f76f26
       - except if there is another way?

    - Mat is moving code from tcp options to mptcp options file. Also
cleaning the two-phases parsing.

    - Peter looked at the different comments, addressing all of them
except to have a private header file which might require more work, can
be done later.

    - thanks for the answers! and rework!



Paolo's new patch-set:

    - https://lists.01.org/pipermail/mptcp/2019-April/001044.html

    - A new patch-set has been shared to refactor the xmit path

    - Use better page allocation for MPTCP. But hard part is the
collapsing / data going from one to another subflows, etc. MPTCP
specific problem.

    - good to make it more clear, already think about how to handle
retransmissions/reinjections, etc. thanks!

    - Paolo is traveling now but it seems he will be able to continue
working on that next week.



Florian's new patch-set:

    - https://lists.01.org/pipermail/mptcp/2019-April/001061.html

    - goal 1st patch: no impact if CONFIG_MPTCP=3Dn

    - goal 2nd patch: closing a hole (memory related of course...)

    - good to think about that, thanks!



MPTCP.org:

    - new version 0.94.4

    - new branch mptcp_v0.95

    - mptcp_trunk: rfc for MPTCPv1 (RFC6824bis):
https://sympa-2.sipr.ucl.ac.be/sympa/arc/mptcp-dev/2019-04/msg00003.html

    - for the upstream, the idea is to support only the v1



Next meeting:
    - We propose to have it next Thursday, the 18th of April.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190418



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

--===============6707468315314091125==--
