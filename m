Content-Type: multipart/mixed; boundary="===============3988403217000483560=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 27th of June 2019
Date: Thu, 27 Jun 2019 18:47:02 +0200
Message-ID: <587ab98c-a5e5-9c2c-c160-5737d50ef470@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1451

--===============3988403217000483560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 56th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Davide and Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: fix remaining checkpatch issue:
        - by Matth
        - reviewed by Mat
        - "squashed" in "mptcp: Write MPTCP DSS headers to outgoing data
packets"
        - no signed-off added for this fix

    - mptcp: move MPTCP option bits to internal header:
        - by Matth
        - reviewed by Mat
        - "squashed" in 3 different commits, no signed-off

    - mptcp: Re-factor mptcp_create_subflow():
        - by Peter
        - reviewed by Matth
        - "squashed" in "mptcp: Associate MPTCP context with TCP socket"



Pending patches:
    - mptcp: simplify crypto.c:
        - by Davide
        - reviewed by Mat, Florian and Christoph
        - we can have something just random
        - maybe later we can switch to a hash as an optimisation

    - Change sock->sk_protocol to a 16-bit value:
        - by Mat
        - for the discussions with IPPROTO_MPTCP, see below
        - decision: we apply this

    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue:
        - by Mat
        - linked to Mat's work on the Data FIN.
        - it was blocked while it should not be.
        - we cannot simply check the end of the received queue with
MPTCP. That's why the behaviour needs to be different with MPTCP
        - feel free to review
        - can be squashed or added at the end:
            - if it is a fix for a bug introduced in a previous commit,
better to squash (except if it is to explicitly show something
particular to MPTCP of course)
            - we can squash



IPPROTO_MPTCP:
    - Mat: sock->sk_protocol to a 16-bit value (increases a handful of
array sizes)

    - Hoang: #define SOL_X25 262

    - Mat: we might want to set SOL_MPTCP at some points:
        - could be good to avoid collisions.
        - Maybe good to merge the patch and wait for feedback later.



Feedback from netconf:
    - slides at http://vger.kernel.org/netconf2019.html

    - no show stopper foreseen by anyone

    - got one question wrt. using kTLS with MPTCP (both use ULP
infrastructure), we should have a look at this but not a major issue for
now (stacked ulp...?)

    - Eric asked about diag support, Davide already working on this

    - diag ulp infra should be upstreamed independently (for ktls)

    - one question was about path management, no objections to us adding
something very simple plus the genetlink based one to place decision
making in userspace

    - one concern is wrt. local security holes, we can ask syzkaller
people to start also running on the mptcp tree once we get ready to
upstream, or initially restrict IPPROTO_MPTCP to init_user root to limit
impact (or both).

    - no need to implement mptcp-level (coupled) congestion control on
top of subflows (i.e., its fine to use more bandwidth than one standard
tcp flow)



Send LPC proposal:
    - maybe going more in initial feature and roadmap, comparison with
mptcp.org, client/server view, etc.

    - could be good to send it early next week.

    - Mat will look at the draft



mptcp.org:
    - support MPTCP v1 seems problematic (when using v0, default
behaviour) but almost there



Next meeting:
    - We propose to *skip* the next one (4th of July). Next one would
then be the 11th of July.

    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190711



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

--===============3988403217000483560==--
