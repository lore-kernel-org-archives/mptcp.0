Content-Type: multipart/mixed; boundary="===============6792043391456779874=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 13th of June 2019
Date: Thu, 13 Jun 2019 19:14:53 +0200
Message-ID: <8a6ba56e-c5be-a116-79ee-dbaa46c5773e@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1363

--===============6792043391456779874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 54th meeting with Mat, Peter and Ossama (Intel OTC),
Paolo, Davide and Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - Minor patches [5 out of 7]
        - by Peter
        - accepted by Paolo
        - squashed in existing commits

    - mptcp: selftests: increase timeout and return error on ping failure:
        - by Florian
        - accepted by Paolo
        - squashed in "mptcp: selftests: switch to netns+veth based tests"

    - Minor patches [Remaining two]:
        - by Peter
        - v1 and v2 reviewed by Paolo and Mat
        - patch 1 had an issue, v3 sent and applied

    - MPTCP debug print is an unnecessary change to common TCP code:
        - by Mat
        - accepted by Matth
        - squashed in "mptcp: Implement MPTCP receive path"



Pending patches:
    -  MP_JOIN handling (v2):
        - by Peter
        - got some new reviews (Paolo)
        - discussions, see below

    - Change IPPROTO_MPTCP :
        - by Mat
        - discussions, see below

    - net: extend INET_DIAG_INFO with information specific to TCP ULP:
        - by Davide
        - proposed to net-next (RFC)
        - got some reviews from Mellanox and Netronome people
        - no need to wait for MPTCP patches, it should be accepted in
net-next before (except the specific MPTCP patches of course)
        - WIP, look at how kTLS is working.

    - remove atomic64_read():
        - by Paolo
        - waiting for review
        - usage of an atomic type for such field does not really protect
vs concurrent read/modify/update cycles, and makes the code less
readable, move to plain u64.



MP_JOIN support:
    - some questions by Paolo about the checks that have been added,
maybe some looks useless or wrong interpretation

    - Sounds good to apply them like that

    - will be applied tomorrow, a v3 is possible if needed

    - we can improve/fix stuff later on



RFC patches to Eric:
    - Cover Letter:
        - https://lists.01.org/pipermail/mptcp/2019-May/001233.html
        - or see below
        - we removed the fact that MP_JOIN was missing
        - we could mention that MP_JOIN work is still in progress
        - we should explain why coupled recv win are needed (RFC)

    - To who?
        - also add net-next in cc
        - except if we don't want to have too much various comments for
the moment? And we could send it to net-next a bit after?

    - What to send?
        - everything including MP_JOIN + checkpatch

    - When?
        - Monday evening in EU

    - by who?
        - *@Mat* will send them
        - with our ML (or our emails) in cc


    Cover letter draft for Eric:

        The MPTCP upstreaming community has prepared a net-next RFC
patch set for review:

        https://github.com/multipath-tcp/mptcp_net-next/tree/export

        With CONFIG_MPTCP=3Dy, a socket created with IPPROTO_MPTCP will
attempt to create an MPTCP connection but remains compatible with
regular TCP. IPPROTO_TCP socket behavior is unchanged.

        This implementation makes use of ULP between the
userspace-facing MPTCP socket and the set of in-kernel TCP sockets it
controls. ULP has been extended for use with listening sockets. skb_ext
is used to carry MPTCP metadata.

        The patch set includes a self-test to exercise MPTCP in various
connection and routing scenarios.

        We have more work to do to reach the initial feature set for
merging, notably:
         * Finish MP_JOIN work
         * Coupling receive windows across sibling subflow TCP socket =E2=
=86=92
we should mention that this is part of RFC 6824, not just a fancy
feature we want to add :)
         * IPv6
         * Not exposing the subflow ULP type to userspace

        Thank you for your review. You can find us at mptcp(a)lists.01.org
and https://is.gd/mptcp_upstream



LPC:
    - Draft sent:
        - https://lists.01.org/pipermail/mptcp/2019-June/001313.html
        - see below

    - What to send? =E2=86=92 Waiting for review:
        - that should certainly be a different presentation than the one
from Netdev 0x12
        - could be nice to say that modifications we do are also
interesting to others (skb ext, ULP, etc.)
        - possible that in presentation we stop to ask questions to the
audience =E2=86=92 might be interesting for us (architectural decisions) =
=E2=86=92
*@Paolo* can look at examples from last LPC

    - When?
        =E2=86=92 might be better not to wait the last moment.
        =E2=86=92 max in 2 weeks?
        =E2=86=92 *@all* : please review and improve what has been sent on =
the ML

    - Who? To be defined in less than 2 weeks

    Multipath TCP (MPTCP) is more and more popular these days but it is
not in the upstream Linux kernel yet. A fork is still being maintained
on the side and has been since March 2009. But it cannot be upstreamed
as it is because this implementation is designed for MPTCP and the TCP
stack is too heavily impacted in term of maintainability but also a bit
regarding the performances.

    In this presentation, we would like to present the challenges we are
facing. Some are introduced by this MPTCP protocol, others by objectives
we defined: limit at the maximum the impact on the existing TCP stack.
We would like to have no performance regression, a maintainable and
configurable solution and an MPTCP implementation that can be used in a
variety of deployments.

    The MPTCP upstreaming community is working on a RFC patch set for
net-next. We should be able to send it before the next LPC in September.
In the current situation, a socket can be created with IPPROTO_MPTCP to
initiate and accept an MPTCP connection. This socket remains compatible
with regular TCP and IPPROTO_TCP socket behavior is unchanged. This
implementation makes use of ULP between the userspace-facing MPTCP
socket and the set of in-kernel TCP sockets it controls to limit the
minimum impact on the current TCP stack. ULP has been extended for use
with listening sockets. skb_ext is used to carry MPTCP metadata.

    Both the communication and the code are public and opened. You can
find us at mptcp(a)lists.01.org and https://is.gd/mptcp_upstream




MPTCP-API:
    - https://lists.01.org/pipermail/mptcp/2019-June/001339.html

    - being able, from userspace and without kernel headers, to identify:
        - which MPTCP implementation it is (mptcp.org vs upstream)
        - which MPTCP API version it is (for the future)

    - iana number:
https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

    - can we ask to reserve a number even if it will not be visible on
the field? We could have something unified by OS and something official
for libc.

    - What we can do:
        - apply Mat's patch =E2=86=92 *@Matth*
        - ask at netconf *@Paolo* / *@Florian*
        - ask IETF group =E2=86=92 discussions with IANA/IESG maybe? *@Matt=
h*



mptcpd:
    - mptcpd 0.2a: Alpha release!
    - https://github.com/intel/mptcpd/releases/tag/v0.2a
    =E2=86=92 mainly support for NL PM from mptcp.org
    =E2=86=92 more work in progress



Misc:
    - MPTCP at WWDC: https://developer.apple.com/videos/play/wwdc2019/712/
        - more MPTCP traffic

    - SIGCOMM Networking Systems Award 2019, congratulations!

    - https://lwn.net/Articles/790235/ =E2=86=92 KUnit is coming, new frame=
work
of test



DataFin:
    - we can re-use FIN-WAITx TCP status for MPTCP socket



Next meeting:
    - We propose to have it next Thursday, the 20th of June.

    - Florian and Paolo will not be able to join but will talk about
MPTCP at Netconf

    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190620



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

--===============6792043391456779874==--
