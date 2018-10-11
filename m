Content-Type: multipart/mixed; boundary="===============5342967033251679773=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 11th of October 2018
Date: Thu, 11 Oct 2018 19:21:39 +0200
Message-ID: <e9040ab0-a7d0-a677-c675-1582f92e9813@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 825

--===============5342967033251679773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 25th (\o/) meeting with Mat, Peter and Ossama (Intel
OTC), Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Review of Mat & Peter's patches:
    - IPPROTO_MPTCP vs AF_MULTIPATH:
        - We should document the advantages/disadvantages of each (*Mat*
will try to have a look at that)
        - Not an issue to switch from one to another if needed later.

    - get rid of SKB's priv_copy()
        - we can remove it, it depends who will need it
        - difficult what other might need. Maybe better to start simple
with not too much flexibility.
        - we will then remove the priv_copy() but we need to keep the
destructor()

    - receiving part: DSS mapping: error_queue =E2=86=92 dedicated queue? or
only for the signalling?
        - Christoph: maybe difficult to manage that in queue.
        - maybe using tcp_read_sock()
        - we will always need an ofo_queue
        - DSS ACK not driven by the app in theory (like TCP) but we
could ignore that for the moment?
        - we can manage optimisation later
        - what is important is something easy to maintain and understand
for the moment, keep it simple by using the right available structures.
        - we can read data from one subflow as long as it is in order
and then switch to the other subflows.
        - we need to be careful with the windows: the new window is
checked at every ACK but we need to know when to increase it. First
solution could be to stall the window, close it, then increase it.
        - MPTCP: windows are shared between SF, if we share the memory
equally between subflows, that's not the best when a SF contains crap.
        - decision: take the error_queue out

    - receiving part: bypass coalesce/collapse for MPTCP OR do
coalescing that takes DSS-mappings into account =E2=86=92 priv_used is the
perfect infrastructure for that.
        - linked to the previous point.
        - smart coalesce can be useful for kTLS

    - trigger the closing in the right sequence =E2=86=92 First, we need to
close the MPTCP-layer and then the subflows.
        - optimisation can be done later to close both at the same time
        - it is for the last data that need to be sent if you close the
subflows first but still some data coming.
        - Christoph will try to find an article to give more details
about that =E2=86=92
https://tools.ietf.org/html/draft-ietf-mptcp-rfc6824bis-12#section-3.3.3
            "Essentially, a host MUST NOT close all functioning subflows
unless it is safe to do so, i.e., until all outstanding data has been
DATA_ACKed, or until the segment with the DATA_FIN flag set is the only
outstanding segment."

    - prepend MPTCP_ / mptcp_ everywhere =E2=86=92 subflow, token, crypto, =
etc.?
       - everything visible should be prepended.

    - subflow socket type:
        - we could keep a TCP proto but modify the pointers where
needed. We should check how it is done with kTLS.
        - we don't want to have the userspace creating a subflow
directly =E2=86=92 by using IPPROTO_SUBFLOW
        - So overriding pointers would make sense. It is a special proto
for MPTCP, kernel side only.



testing MPTCP:
    - packetdrill: no more news from Neil (see the discussions we had
last week)
    - netdevsim?
        - Seems oriented for drivers devs:
https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DLinux-4.16-Networki=
ng
        - we need to check if it can be useful for us =E2=86=92 Matt will d=
o that



tools: start using TopGit?
   - maybe too soon for our repo
   - would be nice to already do some experiments with that:
     https://github.com/mackyle/topgit
   - once Mat and Peter's patches are accepted maybe
   - we can do that later



tools: use Gerrit for the reviews?
    - http://gerrithub.io/
    - can be helpful, easier to keep track on stuff than with a ML
because there might be a lot of discussions around patches for this project.
    - Matth will have a look at this
    - (still possible to keep both, we can quickly experiment)



Next meeting:
    - We propose to have it on Thursday, the 18th of October. Usual
time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181018



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

--===============5342967033251679773==--
