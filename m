Content-Type: multipart/mixed; boundary="===============6367221135134072121=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 23rd of May 2019
Date: Thu, 23 May 2019 19:17:54 +0200
Message-ID: <ba21353d-402b-a267-0310-94a408505280@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1234

--===============6367221135134072121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 51st meeting with Mat, Peter and Ossama (Intel OTC),
Paolo, Davide, Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: plug mptcp_accept memory leaks (3 patches):
        =E2=86=92 by Florian
        =E2=86=92 accepted by Peter & Mat
        =E2=86=92 2 patches have been squashed, one added at the end

    - mptcp: selftests: exercise GSO, retransmission and reorder code path:
        =E2=86=92 by Paolo
        =E2=86=92 accepted by Florian
        =E2=86=92 "squashed" into "mptcp: selftests: switch to netns+veth b=
ased
tests"
        =E2=86=92 one note by Mat:
            the packet reordering is only affecting TCP reassembly, and
does not exercise reassembly at the MPTCP layer differently. The stream
is still delivered to the MPTCP layer in-order.
            MPTCP-level reassembly in the prototype implementation does
not yet handle out-of-order mappings. That will get built in when
updating mptcp_recvmsg() for multiple subflows.
            =E2=86=92 Still a good thing to test.
            =E2=86=92 We will want to test with multiple subflows, different
(and variable) delay

    - mptcp: Add explicit check for protocol version:
        =E2=86=92 by Peter
        =E2=86=92 accepted by Mat
        =E2=86=92 "squashed" into "mptcp: Handle MPTCP TCP options"



Pending patches:
    - preliminary support for 'ss' (2 patches - RFC):
        =E2=86=92 by Davide
        =E2=86=92 are you waiting for more comments? =E2=86=92 seems OK for=
 the first RFC
        =E2=86=92 RFC patch v2 in preparation
        =E2=86=92 will propose that to net-next to have comments from ULP
community and maybe already have it in net-next (useful only for kTLS
for the moment)

    - mptcp: switch sublist to mptcp socket lock protection:
        =E2=86=92 by Florian
        =E2=86=92 Paolo did an internal review, will comment on the ML
        =E2=86=92 Peter will comment as well
        =E2=86=92 waiting for review (v2 available)

    - net: mptcp: don't leak 'slab' and 'slab_name' on exit:
        =E2=86=92 by Davide
        =E2=86=92 v1 reviewed by Mat
        =E2=86=92 v2 expected

    - MP_JOIN handling WIP:
        =E2=86=92 by Peter
        =E2=86=92 quickly reviewed by Paolo
        =E2=86=92 Paolo suggests to apply it quickly
        =E2=86=92 we might need to make sure Selftests are still passing.
        =E2=86=92 note that since we are adding some delay/losses/reording,=
 we
might have "random" failures.



netconf:
    - planned for next month in Boston (20th of June)

    - Paolo and Florian will join

    - that will be the opportunity to talk with other net-next devs



Sync with net-next:
    - got the first conflict, easy to resolve, more details on the ML



Automatic rebase:
    - proposition from Mat from last week: add a tag before destroying
the export branch (with the date). At least commit are not lost.
    - Matth: done
    - A tag is now generated after each "rebase":
        export/<date>
        export/20190517T115519



Future points (from last time):
    - In the tests, Paolo would like to introduce drops and re-order =E2=86=
=92 done

    - Peter has work in progress for the MP_JOIN. =E2=86=92 shared

    - Peter will try to share a RFC next week, also with ADD_ADDR
handling. =E2=86=92 shared

    - Mat looking at the DATA-FIN handling. =E2=86=92 WIP



Cover letter draft for Eric:

    The MPTCP upstreaming community has prepared a pre-net-next RFC
patch set for review:

    https://github.com/multipath-tcp/mptcp_net-next/tree/<TBD> =E2=86=92 ca=
n be
export, an export tag or a dedicated branch

    With CONFIG_MPTCP=3Dy, a socket created with IPPROTO_MPTCP will
attempt to create an MPTCP connection but remains compatible with
regular TCP. IPPROTO_TCP socket behavior is unchanged.

    This implementation makes use of ULP between the userspace-facing
MPTCP socket and the set of in-kernel TCP sockets it controls. ULP has
been extended for use with listening sockets. skb_ext is used to carry
MPTCP metadata.


    The patch set includes a self-test to exercise MPTCP in various
connection and routing scenarios.

    We have more work to do to reach the initial feature set for
merging, notably:

     * Handling MP_JOIN requests to accept multiple subflows =E2=86=92 it s=
hould
be part of it
     * Coupling receive windows across sibling subflow TCP socket =E2=86=92=
 we
should mention that this is part of RFC 6824, not just a fancy feature
we want to add :)
     * IPv6
     * Not exposing the subflow ULP type to userspace

    Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream



Questions related to maintainer review:
    - CONFIG_MPTCP is a bool, but we have some module infrastructure in
net/mptcp/. Should we remove the module code to make this consistent?

    - at least to be removed before sending this to Netdev ML (not to
have people stopping after the first inconsistency)

    - same for checkpatch.pl

    - maybe some commits would need to be squashed as well



When to send this to Eric:
    - MP_JOIN is changing a bit TCP code (original socket doesn't get
the new subflow)

    - maybe OK to have the netconf as a limit minus 1 week: first half
of June



mptcpd (Netlink daemon for MPTCP):
    - Migrate to multipath-tcp.org generic netlink API. (#15) =E2=86=92 mer=
ged
in master

    - A few things are missing (netlink attributes missing) but it is on
the good way!

    - Ossama has some questions, will send them to the ML



mptcp.org:
    - new sync v4.19.36 =E2=86=92 .44

    - new fixes coming for TFO



LPC 2019:
    - CfP for Networking sessions should open later.

    - confirmed on netdev ML

    - would be very nice to participate



Next meeting:
    - We propose to have it next Friday, the 31st of May.

    - /!\ not on Thursday but on Friday /!\

    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190531



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

--===============6367221135134072121==--
