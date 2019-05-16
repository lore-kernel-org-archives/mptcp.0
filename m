Content-Type: multipart/mixed; boundary="===============2069555745477613698=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 16th of May 2019
Date: Thu, 16 May 2019 18:39:26 +0200
Message-ID: <80e3f7a0-c46f-135c-dbfb-8da89b896d27@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1192

--===============2069555745477613698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 50th (\o/) meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Paolo, Davide, Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: fix state update on accept():
        =E2=86=92 by Paolo
        =E2=86=92 accepted by Mat
        =E2=86=92 squashed in "mptcp: Implement MPTCP receive path" + signe=
d-off

    - mptcp: refactor xmit path (3 patches, v3):
        =E2=86=92 by Paolo
        =E2=86=92 accepted by Mat
        =E2=86=92 Added at the end

    - mptcp: refactor shutdown/close and conn_list handling:
        =E2=86=92 by Paolo
        =E2=86=92 accepted by Mat
        =E2=86=92 Squashed in "mptcp: Make connection_list a real list of
subflows" + signed-off + update commit message

    - net: mptcp: fix memory leak in case slab allocation fails:
        =E2=86=92 by Davide
        =E2=86=92 accepted by Mat
        =E2=86=92 squashed in "mptcp: Create SUBFLOW socket for incoming
connections" + signed-off

    - tcp: Check for filled TCP option space before SACK:
        =E2=86=92 suggested by Florian
        =E2=86=92 commit by Mat
        =E2=86=92 added at the end

    - mptcp: DSS map overrun in recvmsg():
        =E2=86=92 by Paolo
        =E2=86=92 accepted by Mat
        =E2=86=92 squashed in "mptcp: Implement MPTCP receive path"

    - tcp: clean ext on tx recycle:
        =E2=86=92 by Paolo
        =E2=86=92 accepted by Florian
        =E2=86=92 added before "mptcp: Add MPTCP to skb extensions"
        =E2=86=92 note: in mptcp_sendmsg_frag(), skb_ext_add() could return=
 NULL
            By Paolo: The problem with the current code is that it can
possibly fail after the data already traversed the TCP stack, and AFAICS
we should roll-back some internal status, not easily accessible.



KSelftests:
    - After all these patches =E2=86=91, it seems OK now! Thanks for having
fixed that!



Pending patches:
    - mptcp: plug mptcp_accept memory leaks (3 patches):
        =E2=86=92 by Florian
        =E2=86=92 v1 reviewed by Peter
        =E2=86=92 v2 reviewed by Mat
        =E2=86=92 v3 waiting for review

    - preliminary support for 'ss' (2 patches - RFC):
        =E2=86=92 by Davide
        =E2=86=92 waiting for comments
        =E2=86=92 and suggestions for the attributes that would be dumped (=
they
can also be added later but good to think about that)

    - mptcp: switch sublist to mptcp socket lock protection:
        =E2=86=92 by Florian
        =E2=86=92 waiting for review
        Florian expects a v2 early next week



Future points:
    - In the tests, Paolo would like to introduce drops and re-orders
    - Peter has work in progress for the MP_JOIN.
    - Peter will try to share a RFC next week, also with ADD_ADDR handling.
    - Mat looking at the DATA-FIN handling.



Sending patches for review:
    - MP_JOIN is an important layer, maybe better to have an initial
implementation (for Mat)
    - for the Data fin, we could wait, less important than =E2=86=91
    - Mat can work on this cover letter, first version to have some feedback
    - Paolo: keep the cover letter short for Eric (from experience)



Rebase frequency (and validation):
    - Every day? Less frequent? =E2=86=92 No, keep it like that
    - proposition from Mat: add a tag before destroying the export
branch (with the date). At least commit are not lost.
    =E2=86=92 Matth can do that



Rebase strategy:
    - it is the author (and the reviewer) who decide(s)
    - generally: small fixes clearly linked to one commit and not needed
to explicitly get the fix out in a separated commit  are squashed if the
ref (commit) is indicated
    - seems working well so far!



mptcp.org:
    - new patches to add BPF tracepoints


Misc:
    - don't forget that middleboxes can do crazy stuff with TCP options!
    - thanks for all these patches and reviews!



Next meeting:
    - We propose to have it next Thursday, the 23th of May.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190523



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

--===============2069555745477613698==--
