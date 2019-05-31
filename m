Content-Type: multipart/mixed; boundary="===============2946207500836561244=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 31st of May 2019
Date: Fri, 31 May 2019 19:20:38 +0200
Message-ID: <85f3c2a9-915e-8d0a-d902-92aea49e5412@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1276

--===============2946207500836561244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 52nd meeting with Mat and Ossama (Intel OTC), Christoph
(Apple), Paolo, Davide and Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - net: mptcp: don't leak 'slab' and 'slab_name' on exit:
        - by Davide
        - accepted by Mat
        - squashed in "mptcp: Create SUBFLOW socket for incoming
connections"

    - Typo in mptcp_connect.sh:
        - by Florian
        - accepted by Matth
        - squashed in "mptcp: selftests: switch to netns+veth based tests"

    - mptcp: switch sublist to mptcp socket lock protection:
        - by Florian
        - v4 accepted by Mat
        - added at the end

    - mptcp: Make mptcp initialization part of tcp initialization:
        - by Peter
        - v2 accepted by Florian
        - squashed in 3 different commits
        - small notifications done when applying the patch, see ML for
more details
        -  https://lists.01.org/pipermail/mptcp/2019-May/001272.html



Pending patches:
    - RFC by Peter:
        - he is working on a v2
        (+ a rebase after last changes made by Florian)

    - mptcp:init: panic in case of error:
        - by Matthieu



Sync with net-next:
    - no sync last night because of an error: net-next doesn't compile
when IPV6 not compiled:

        ./include/linux/netfilter_ipv6.h: In function 'nf_ipv6_br_defrag':
        ./include/linux/netfilter_ipv6.h:110:9: error: implicit
declaration of function 'nf_ct_frag6_gather'; did you mean
'nf_ct_attach'? [-Werror=3Dimplicit-function-declaration]

        - fix:
https://lore.kernel.org/netdev/20190531081143.21446-1-pablo(a)netfilter.org=
/T/#u

        - fix v2: https://patchwork.ozlabs.org/patch/1108255/

        - should we always compile with IPV6 support?
             =E2=86=92 We can do that later when we will have MPTCP IPv6 su=
pport



How to handle sk_state on the mptcp socket:
    - FastClose: better to take the option B: send reset and clear
resources, no need to have an extra state (WAIT_FOR_RST)

    - when creating the new MPTCP connection, we maintain our own state
(using TCP state)

    - after, we are linked to the data connection =E2=86=92 MPTCP connectio=
n.

    =E2=86=92 if one sf established and one connecting, we are still in
established state

    =E2=86=92 we can be in a situation where there is no more subflow:
        =E2=86=92 until we get a DATA_FIN

        =E2=86=92 for a first version, we can also stop the MPTCP connectio=
n if
there is no more subflows if it is easier in the code

        =E2=86=92 we can have a timeout when there is no more subflow (and =
no
DATA_FIN)

        =E2=86=92 Break-before-make:
            =E2=86=92 Mat will add note in the wiki

            =E2=86=92 we will need to support that, can be done later:

            =E2=86=92
https://tools.ietf.org/id/draft-defoy-mptcp-considerations-for-5g-00.html#r=
fc.section.2.2



(MP)TFO:
    - do we need to support it now?:
        =E2=86=92 Not for a first step

    - if no, what to do?:
        - we should not break TFO without MPTCP

        - ignore TFO with MPTCP for the moment

        - be sure that TFO doesn't break MPTCP! (that was the comment
from Paolo on Peter's RFC)

        - add some comments (TODO) if we are thinking we would need an
adaptation in the future (not to forget them)



locks:
    - (on the ML) Mat: At an earlier point we thought there would be a
need to read the list without holding a lock, but I don't remember what
that case was and looking at the current code the socket lock works well.

    - (on the ML) Christoph: I think, that was to support lockless
subflow establishment, similar to the way Linux supports lockless
(meaning, without taking the listener's lock) connection establishment
on the server-side.

    - we need to take the lock when we want to add stuff to the list. To
support lock-less establishment, we don't want to take MPTCP lock on the
server side. To avoid taking the lock when anything want to walk through
to list of sf, we need an RCU list. (racing against a 3rd ACK that
confirms the SF establishment). We would only need to access the list
lock when we modify the list, not when we walk through the RCU list.

    - Paolo: RCU adds latency overhead, especially when there are
syscalls (sync needed)

    - difficult to know the cost of the contention we would have with a
lock instead of RCU.

    - we don't have to support the lock-less establishment but TCP was
going on this direction (lock-less)

    - when Christoph did that in mptcp.org, he saw a great improvement
with Apache benchmark.

    - we can also improve this later: best design first and
optimisations later.

    - currently some syscall can modify shared stuff: if run in //, they
could create memleaks or deref pointers:
        - Paolo has a patch to fix some problems there

        - the idea would be sent them as RFC and postpone their
application for after MP_JOIN support

    - no being able to walk through the list can be an issue for the
stats, e.g.: if we want to list the MPTCP and show the number of
subflows, we would like to avoid taking locks there



KSelftests:
    - warnings: "Replaced mapping before it was done"

    - some were fixed by a fix from Paolo.

    - reproducible using:
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci

    - running on a single CPU

    - but tests are successful

    - with and without KASAN and PROVE_LOCKING config.



CI:
    - now testing KSelftests

    - scripts are available in the 'scripts' branch

    - https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci
(virtme)

    - Suggestions for the future:
        - by Mat: enable debug features like CONFIG_KASAN and
CONFIG_PROVE_LOCKING in the test kernel and then check the console
output for KASAN/locking issues. There is a tradeoff in speed, but it
could alert us to problems the selftests alone don't catch.

        - done =E2=86=92 now always running with them

        - But might be interesting to run without and with =E2=86=91

        - TODO: Matth can update the scripts (feel free to propose
changes for these scripts too!)



netdev 0x14:
    - will be next year in March in Canada (west coast, Vancouver)



LPC 2019:
    - nothing new



Next meeting:
    - We propose to have it next Thursday, the 6th of June.

    - Christoph will not be able to join.

    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190606



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

--===============2946207500836561244==--
