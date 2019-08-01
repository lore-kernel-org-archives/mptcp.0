Content-Type: multipart/mixed; boundary="===============4396197962961046642=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 1st of August 2019
Date: Thu, 01 Aug 2019 18:56:53 +0200
Message-ID: <96d513db-eb6b-a070-64c0-28d31db21a0a@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1573

--===============4396197962961046642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 60th meeting with Mat and Peter (Intel OTC), Christoph
(Apple), Paolo and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - / (due to holidays)


Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - commented by Paolo
        - Mat tried adding spinlock but it still triggered deadlocks
warnings
        - Mat will try with barriers

    - mptcp: new sysctl to control the activation per NS:
        - by Matthieu
        - still some open questions
        - reviewed by Ossama, Peter, needs to send a v2 for two small
fixes (rename a function and add a comment + maybe rename ctrl.c to
something else)

    - Implement outgoing MP_JOIN:
        - patch-set (10 patches) by Peter
        - Peter has sent a v2
        - waiting for review
        - Paolo will have a look at it

    - Remove unused variables, causes compile warnings:
        - by Peter, 2 patches
        - they need to be reviewed



Feedback from netdev:
    - nobody at the meeting receives any feedback



Feedback from LPC:
    - any feedback? No: should arrive next week:
        > Proposals must be submitted by August 2nd, and submitters will
be notified of acceptance by August 9th.



roadmap proposal/discussion:
    - see: https://lists.01.org/pipermail/mptcp/2019-July/001505.html

    - seems that Peter is not working on the mentioned topics

    - Mat commented that on the list:
https://lists.01.org/pipermail/mptcp/2019-July/001566.html

    - some comments about using a RB tree for the retransmission. We
might not need it for some SACK features but we might have it later. But
some security issues found in TCP were due to linked lists, consuming
resources to find segments. In mptcp.org, we send only a part of the
segments in some cases. On the other hand, it is not a big overhead to
use a RB tree.



Next meeting:
    - We propose to have it next Thursday, the 8th of August.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190808



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

--===============4396197962961046642==--
