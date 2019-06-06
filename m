Content-Type: multipart/mixed; boundary="===============2091919409006982348=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 6th of June 2019
Date: Thu, 06 Jun 2019 18:58:07 +0200
Message-ID: <3d4e8caf-abf6-3be8-4278-3b8dd6d8b52c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1307

--===============2091919409006982348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 53rd meeting with Mat, Peter and Ossama (Intel OTC),
Davide and Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: do not warn when replacing an identical mapping:
        - by Paolo
        - accepted by Mat and Matth
        - squashed in "mptcp: Implement MPTCP receive path"

    - mptcp:init: panic in case of error:
        - by Matth
        - accepted by Peter
        - squashed in 3 different commits



Pending patches:
    -  MP_JOIN handling WIP:
        - by Peter
        - got some reviews (Paolo)
        - he is working on a v2

    - mptcp: selftests: increase timeout and return error on ping failure:
        - by Florian
        - can it be squashed? Florian: yes
        - waiting for review

    - net: extend INET_DIAG_INFO with information specific to TCP ULP:
        - by Davide
        - proposed to net-next (RFC)
        - got some reviews from Mellanox and Netronome people
        - no need to wait for MPTCP patches, it should be accepted in
net-next before (except the specific MPTCP patches of course)

    - Minor patches (7):
        - by Peter
        - got some reviews (Paolo)
        - can be already applied except the first and last one (see below)



Long patch-series: accept first one(s) if OK:
    - (Paolo): can we consider, when the patches are independent one
from each other, accepting some patches from a series, excluding those
that need an additional revision? e.g. Peter "Minor patches" series.
Would that simplify the work for reviewer and submitter? would be too
burdensome from git maintenance perspective ?

    - fine to accept those which are ready and not dependent on another

    - Matth: I will then accept these patches (2-6) tomorrow except if a
v2 has been sent today.



ci:
    - now testing with and without KASAN and PROVE_LOCKING



KSelftests warnings: Replaced mapping before it was done:
    - Mat found that TSO & GSO duplicate the headers for large sends, so
the same TCP options get sent on all the segments.

    - Paolo has published a patch (mptcp: do not warn when replacing an
identical mapping)

    - already merged!



TCP subflow to MPTCP level:
    - By Christoph: The receiver has to wait until the full mapping has
been received on the subflow before pushing it higher up to MPTCP. [Not
waiting] would break when DSS-checksums are being used, as the full
mapping is needed to verify the checksum of the mapping. When there is
no DSS-checksum, I think it should be fine. On the multipath-tcp.org
implementation we are currently waiting for the full mapping before
pushing up higher. Is it easier to be implemented by not waiting for the
full mapping?

    - for a full implement, we can ignore DSS-checksum

    - would be easier to have only one way (with/without DSS-checksum)

    - we had discussions about that: having a separated queue to handle
that or let the subflow wait for the data to be ready to flush them

    - certainly better to continue doing the "simple" way for the moment
and change it later as an optimisation. It will become more complex but
more people will understand why we have to do this change. If we do this
right now, it might be harder to understand.



LPC networking track:
    - CFP is open

    - The submission deadline is 2019-08-02 (maybe better not to wait
for the deadline)

    - "Any kind of advanced networking-related topic will be
considered." =E2=86=92 good for us!

    - 40 minutes in length (including Q & A)

    - "*optionally* accompanied by papers of 2 to 10 pages in length"
*BUT* " The papers, while not required, are very strongly encouraged by
the committee.  The submitters intention to provide a paper will be
taken into consideration as a criteria when deciding which proposals to
accept."

    - might be interesting to say that we will not modify a lot TCP

    - we should explain why we have to do some changes (intro) and what
we did, what has to be done

    - Matth: I can start preparing a text.



Christoph is at the WWDC:
    - you should be able to find him at the networking session I guess



MP_JOIN:
    - might be interesting to integrate that now as it is an important
release

    - Peter can send a v2 at the end of the week

    - we can do fixes later on



Next week:
    - could be good to have a summary of what needs to be discussed with
other net-next devs
    - if Paolo and/or Florian can join the meeting next week.



Next meeting:
    - We propose to have it next Thursday, the 13th of June.

    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190613



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

--===============2091919409006982348==--
