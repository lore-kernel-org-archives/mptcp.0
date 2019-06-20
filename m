Content-Type: multipart/mixed; boundary="===============1100297584539931252=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of June 2019
Date: Thu, 20 Jun 2019 19:05:33 +0200
Message-ID: <424a56b9-fbc0-adfa-d4b6-98bc016fe169@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1436

--===============1100297584539931252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 55th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - remove atomic64_read():
        -  by Paolo
        - accepted by Mat
        - "squashed" in "mptcp: Implement MPTCP receive path"

    - Move MPTCP #defines to internal header:
        - by Peter
        - accepted by Paolo
        - "squashed" in "mptcp: Handle MPTCP TCP options" (2), "mptcp:
Write MPTCP DSS headers to outgoing data packets" and  "mptcp: Implement
MPTCP receive path"

    - Change IPPROTO_MPTCP :
        - by Mat
        - accepted by Matth
        - "squashed" in "tcp: Define IPPROTO_MPTCP" and  "mptcp: add
basic kselftest program"

    -  MP_JOIN handling (v2):
        - by Peter
        - accepted by Paolo
        - added at the end (3 commits)

    - mptcp: fix checkpatch issues:
        - by Matth
        - accepted by Florian
        - "squashed" in multiple topics (16)
        - including "mptcp: proto_ops cannot be const" fix
        - no signed-off added

    - MP_JOIN handling: v3 from Peter:
        - by Peter, extracted by Matth from v3 (v2 was already included
in the repo)
        - "squashed" in the last 3 topics
        - no signed-off added



Pending patches:
    - mptcp: simplify crypto.c:
        - by Davide
        - reviewed by Mat and Florian
        - some discussions have been started around crypto_v4_get_key():
            - use tcp_cookie_time()?
            - or net_hash_mix()?
            - or get_random_bytes()
            - or prandom_u32() as additional input key instead of
increment++.

            =E2=86=92 we might need to be able to regenerate it to support =
MPTCP
Syn cookies.

            =E2=86=92 Indeed - in mptcp.org: we don't check the key on  the
third ACK when SYN_COOKIES are being used:

                =E2=86=92 we could check it to add an extra layer but with =
there
is already a security from TCP SYN_COOKIES

                =E2=86=92 Nothing specified in the RFC

    - mptcp: fix remaining checkpatch issue:
        - by Matth
        - review should be quick (lenght =E2=86=92 length)
        - no signed-off to be added for this fix

    - mptcp: move MPTCP option bits to internal header:
        - by Matth



Git:
    - Sync with net-next:
        - got 1 conflict
        - nothing important
        - see ML for more details



RFC patch sent to netdev:
    - https://patchwork.ozlabs.org/cover/1117531/

    - no feedback (yet)



Netconf in Boston:
    - Paolo and Florian are there

    - Working hard:
https://twitter.com/davem_dokebi/status/1141501500063195136

    - Florian will talk about "Multipath TCP upstreaming: current state,
work-in-progress items and near-future roadmap"



IPPROTO_MPTCP:
    - which number? (continuing discussions from last time)

    - Paolo and Florian will ask the question at netconf

    - IANA manages 8 bits, >255 should be OK to use without doing any
request to IANA (Alan Ford)

    - But can we use higher number? (libc, etc.):
        - if they use only 8 bits, we will fallback to TCP
        - but we will also need to maintain the exact same API...

    - Maybe something related to POSIX (socket api)... (Michael Scharf)
        - anybody knows who to contact? (if needed)

    - we could ask IETF's TCPM people but they are not supposed to
control the implementation. More what is visible on the wire.



LPC:
    - anything to change in the draft?:
        - maybe interesting to get feedback from Netconf to know what to
modify
        - we can then add there the core ideas.
        - we can send something next week

    - who would be able to join?:
        - at least one person from Intel, maybe more
        - next batch of people that can participate is the 29th of June
        - Matthieu should be able to join, especially if there is a talk

    - live meeting in Portugal?:
        - could be nice to have face to face meeting there



mptcp.org:
    - new v0.94.6 release
    - it includes TCP SACK crash fix



RFC 6824:
    - not clear what need to be done when there are "issues" with data-fin
    - Here is what we do in mptcp.org:
        /* If it's an empty skb with DATA_FIN, sub_seq must get fixed.
         * The draft sets it to 0, but we really would like to have the
         * real value, to have an easy handling afterwards here in this
         * function.
         */
        if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
                sub_seq =3D TCP_SKB_CB(skb)->seq;



MPTCP:
    - MPTCP v1 patches (from April): can be reviewed and applied if
compilation and tests are ok

    - when MPTCP will be upstream, goal would be to reuse a maximum in
mptcp.org but continue while MPTCP perf are better and main features are
not supported upstream



Next meeting:
    - We propose to have it next Thursday, the 27th of June.

    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190627



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

--===============1100297584539931252==--
