Content-Type: multipart/mixed; boundary="===============1546197729923607061=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 25th of July 2019
Date: Thu, 25 Jul 2019 19:09:53 +0200
Message-ID: <d5883fb2-631a-b0ed-8b99-9bd5c7649b2c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1554

--===============1546197729923607061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 59th meeting with Mat, Peter and Ossama (Intel OTC) and
myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: harmonize locking on all socket operations:
        - by Paolo
        - accepted by Mat and Peter
        - added at the end of the patch series

    - mptcp: simplify crypto.c:
        - by Davide
        - v2 accepted by Matt (after a v1 reviewed by Mat and us at the
last meeting)
        - "squashed" in "mptcp: Add key generation and token tree" and
"mptcp: Add handling of incoming MP_JOIN requests"

    - mptcp: avoid validating MP_CAPABLE keys on 3way HS handling:
        - by Paolo
        - accepted by Peter, Mat, Christoph
        - "squashed" in "mptcp: Create SUBFLOW socket for incoming
connections"
        - should fix instability in the kselftests
        - *Note*: Mat ran the kselftests in a loop for one hour and he
didn't see any issue!



Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - commented by Paolo
        - *Note*: Mat is looking at adding spinlock, he will check if it
could trigger deadlocks, more for a long term solution

    - mptcp: new sysctl to control the activation per NS:
        - by Matthieu
        - Note*: still some open questions, feel free to comment ;-)
        - Note*: if there is no comment, Matth will send a new version
tomorrow with two small changes (one comment, one renamed function)

    - Implement outgoing MP_JOIN:
        - patch-set (9 patches) by Peter
        - *Note*: for the addition of the sysctl for the IP to announce,
this patch could be based on top of "mptcp: new sysctl to control the
activation per NS". Other solution is to temporary set a kernel module
option but because it is not set as a module, it will have to be set at
startup :)
        - Note*: Peter will send a v2 soon, applying Paolo's
recommendations (it includes a split of the PM patch to have one patch
we will remove later on)



Feedback from netdev:
    - nobody at the meeting receives any feedback



Feedback from LPC:
    - any feedback? Should arrive next week or the week after:
        > Proposals must be submitted by August 2nd, and submitters will
be notified of acceptance by August 9th.



Testing MPTCP Upstream with Sparse:
    - anybody did that?
    - Davide did some tests, not big issues. See:
https://paste.fedoraproject.org/paste/boVPC8dzVYZzxfLWDJ~T~g



roadmap proposal/discussion:
    - see: https://lists.01.org/pipermail/mptcp/2019-July/001505.html
    - seems that Peter is not working on the mentioned topics, maybe Mat is
    - Mat will comment on the list
    - Could be good to discuss about that in the meeting with Paolo next
time.



Next meeting:
    - We propose to have it next Thursday, the 1st of August.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190801



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

--===============1546197729923607061==--
