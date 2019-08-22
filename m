Content-Type: multipart/mixed; boundary="===============8213540333470805569=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 22nd of August 2019
Date: Thu, 22 Aug 2019 20:59:29 +0200
Message-ID: <f2ed3658-6d6d-3641-08aa-8945bb56761b@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1680

--===============8213540333470805569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 63rd meeting with Mat, Peter (Intel OTC), Christoph
(Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - /



Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - Mat has sent a new version (2 August)
        - Waiting for reviews (especially regarding the new flags and
other modifications)

    - mptcp: Implement interim path manager:
        - by Peter
        - RFC
        - waiting for review / (or new version with sysctl?)

    - mptcp: sockopt: pass whitelisted setsockopt to subflows:
        - by Florian
        - v2 sent
        - Waiting for review

    - mptcp: implement retransmit infrastructure:
        - 8 patches
        - by Paolo
        - RFC v2
        - Florian gave some comments
        - Waiting for more comments
        - We can also apply a part of it

    - mptcp:pm: sysctl to announce an addr:
        - by Matth
        - RFC
        - to sit on top of "mptcp: Implement interim path manager" (or
to squash in?)

    - mptcp: extends interim path manager=E2=80=8B:
        - by Paolo
        - RFC
        - similar to the previous one but also create additional
subflows from the client side



Opened question by Paolo regarding the retransmissions / re-injections:
    - IIRC, the RFC mandate to always retransmit even on the failing
subflow (?!?)  why? Should we preserve the original subflow seq number,
so that  retransmission there will get the same mapping as the original
packet?

    - Matth (before meeting note): to avoid confusions, we should
certainly talk about "re-injections" when it is at the MPTCP level
(typically sending the same data (=3D=3D MPTCP seq) we already sent on one
subflow to another one (!=3D TCP seq)

    - for retransmissions, better for the middleboxes to keep regular
TCP retransmissions (data that are already sent with TCP seq num).

    - reinject is more: we keep the same MPTCP DSN but different TCP seq
num.

    - note: for firewall, we need to let TCP keep retransmitting (on the
problematic subflow) but if we think it is need, we can re-inject data
to another subflow.

    - note: because the new version of the RFC has not been accepted
yet, we can still ask to update the text to avoid confusion =E2=86=92 e.g.
section 3.3.6



Bug saw by Paolo:
    - when working on his patch-set, it seems that some MPTCP ACK are
not (re)transmit
    - maybe because of half-closed sockets.
    - It seems that after a FIN, we stop processing MPTCP ACK
    - It seems that nobody else saw that.
    - TODO Paolo: could be interesting to send a dedicated mail about
that on the mailing list.
    - Mat will try to look if it has this bug



Bug tracker:
    - that's not the first time we see bug, we might want to track them
    - seems that we don't have a lot for the moment, we can avoid the
overhead of a bug tracker
    - if needed, we can start opening issue on our Github repo



LPC:
    - Paper
    - Both Mat and Matth were busy this week, we can start working now
    - Still interesting to take time doing it as it prepares for the
presentation and questions.



Misc.:
    - SKB ext is restricted to a few services. But already accepted for
MPTCP: https://www.spinics.net/lists/netdev/msg594667.html
    - https://patchwork.ozlabs.org/patch/1150091/



Next meeting:
    - We propose to have it next Thursday, the 29th of August.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190829



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8213540333470805569==--
