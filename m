Content-Type: multipart/mixed; boundary="===============5178866012184137297=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 26th of September 2019
Date: Fri, 27 Sep 2019 14:05:54 +0200
Message-ID: <327f259d-c279-4a18-7424-f2d646cfdc39@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1936

--===============5178866012184137297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 68th meeting with Mat, Peter and Ossama (Intel
OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself
(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: implement retransmit infrastructure:
        - 7 patches
        - by Paolo
        - 1 squashed, the rest at the end
        - as mentioned by Paolo and confirmed by Mat, there were a few
failed tests after having applied this
        - another follow-up is needed, seen by Mat, see "mptcp: fix
retransmit timer update"

    - mptcp: sendmsg: fix stream corrution:
        - by Paolo
        - accepted by Mat
        - as mentioned by Mat, there were still a few failed tests after
having applied this

    - mptcp: partial recvmsg() refactor:
        - by Paolo
        - v2 sent
        - accepted by Mat
        - this fixed all the errors in the tests (thx Paolo for the good
work there!)

    - mptcp sparse "fixes":
        - by Florian
        - squashed in 4 different commits
        - accepted by Peter

    - net/mptcp: rcu-ify the subflow context:
        - by Davide
        - accepted by Paolo
        - diff is slightly different after having applied the patch, see ML
        - but that's OK



Pending patches:
    - mptcp: Implement interim path manager:
        - by Peter
        - v2 sent
        - Waiting for accept

    - mptcp_poll rework preview:
        - by Florian
        - RFC
        - should be rebased on top of the recvmsg refactor commits
(should be applied tomorrow)

    - mptcp: allow dumping subflow context to userspace:
        - by Davide
        - RFC (with questions about what to expose + "sensitive" info)
        - by Davide: I will also remove checksum-related stuff, correct?
        - =E2=86=92 Yes please
        - commented by Florian and Matt
        - currently all these info are linked to the subflow, not the
MPTCP socket. And everything needs CAP_NET_ADMIN (ss -i)

    - selftests: prepare for mptcp ipv6 support:
        - by Florian
        - commented by Paolo and Peter (+ who can do what) and Alexander
        - waiting for accept

    - mptcp: Remove all traces of checksum support:
        - by Peter
        - v2 sent
        - Waiting for accept

    - mptcp: Prefix crypto routines with mptcp_:
        - by Peter
        - Waiting for review: do we want to add it at the end causing
conflicts with other squashes? We might need to split that in different
commits

    - mptcp: fix retransmit timer update:
        - by Paolo
        - follow up for "mptcp: implement retransmit infrastructure"
        - Accept by Mat
        - Waiting for *APPLY*

    - mptcp: add MIB counter infrastructure:
        - by Florian
        - reviewed by Mat
        - v2 is expected
        - should we reduce the list? (Question by Christoph) =E2=86=92 yes,=
 only
what we need
        - should we add counters for the whole NS like
TCP_MIB_CURRESTAB? (Question by Christoph) =E2=86=92 shouldn't be too hard

    - mptcp: allow MPTCP sockets by default:
        - by Matth
        - v2 sent
        - needs to update the commit message



some squashing/rebasing needed?:
    - Question by Paolo
    - Florian and Paolo are working on it

    - Current iteration:
https://github.com/pabeni/mptcp/commits/export_squash_09_more_nit :
        - see ML for the details
        - idea is to do multiple iterations before the initial submission
        - goal is to have something easier to review by upstream

    - There were also some ideas requiring changes in many commits:
        - prefix mptcp_ for all exposed functions: in fact, only the
ones only used in net/mptcp needs to be updated. =E2=86=92 maybe good to
integrate Peter's patch now

        - Split protocol.h and have an header file for each .c file we
have in net/mptcp =E2=86=92 we can still do that later except, even after t=
he
initial submission, except if it is required by upstream before

        - Move some code out of protocol.c in different files: e.g.
input.c / output.c =E2=86=92 we can still do that later except, even after =
the
initial submission, except if it is required by upstream before

        - IPv6 support? Can we also do that in commits at the end? Maybe
yes.

    - We don't have to propose everything now, maybe everything we have
now up to the introduction of the kselftests

    - In other words, without:
        mptcp: implement and use MPTCP-level retransmission
        mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
        mptcp: implement memory accounting for mptcp rtx queue
        mptcp: introduce MPTCP retransmission timer
        mptcp: queue data for mptcp level retransmission
        mptcp: update per unacked sequence on pkt reception
        mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue =E2=
=86=92
could be squashed earlier? (or moved?)
        mptcp: Implement path manager interface commands
        mptcp: Add handling of outgoing MP_JOIN requests

    - One question by Mat: maybe "Make MPTCP socket block/wakeup ignore
sk_receive_queue" should be part of the initial submission?

    - The idea would then be to push this "soon", try to have it
upstream and come with the rest later:

        - But we need IPv6 support

        - Would be easier for later discussion to have this first part
upstream ASAP

        - RFC: we can send all of them, at least to show what we have

        - in the coverletter, we can mention our plan =E2=86=92 first part:
everything up to kselftests + IPv6 support

    - Do you want Matth to temporary stop the CI job which recreates the
"export" branch each night?:
        - no we can keep it, doesn't hurt
        - but we cannot modify the TopGit tree.

    - only diff in pr_debug() messages and string (for checkpatch)

    - Paolo has shared just after the meeting the HASH used to do the
rebase to be able to see this diff + the diff.

    - After we can re-create a new tree, drop the previous one.



RFC for net-dev:
    - can we send it? Better to send it while net-next is "closed"
    - Mat can have a look at that and will share a draft of the cover letter



Protocol questions (DSS):
    - what do we need to support?:
        - missing DSS in some segments
        - duplicated DSS in some segments
        - kill the TCP-subflow for early mappings
    - seems middleboxes will not be that nasty (aggregate stuff TCP data
+ move mapping options in other segments, etc.). We can deal with that
later if we see issues.



Remaining items for the initial submission:
    - IPv6 support:
        =E2=86=92 needed for the first part as well, even in the "first par=
t"

    - And MPTCP v1 support:
        =E2=86=92 needed for the first part as well, even in the "first par=
t" to
avoid having to support both

        - patches for mptcp-dev
https://sympa-2.sipr.ucl.ac.be/sympa/arc/mptcp-dev/2019-04/msg00003.html

        - might be good to only support v1 to work on our side as other
people cannot test it with other implementations

        - for mptcp.org, the idea would be to support it for the next
LTS we will support (5.4)

        - sounds OK to support only v1

        - we expect other devices which might interop with us to support
v1 too

    - DATA_FIN: WIP by Mat

    - Shared recv window: WIP?

    - Active backup support:
        - needs additional recvmsg refactors
        - Paolo can have a look on that later



Patent questions:
    - https://lists.01.org/pipermail/mptcp/2019-September/001892.html
    - is it OK?
    - Mat will look at that on his side next week
    - maybe this could be dropped? would be easier!



Drop Gerrit:
    - for the moment the code is pushed only to
https://review.gerrithub.io/admin/projects/multipath-tcp/mptcp_net-next
    - then sync to Github (done by gerrithub)
    - That's a mirror but a slow one
    - sounds good to drop it, only keep Github (+ local mirrors)!



Next meeting:
    - We propose to have it next Thursday, the 3rd of October.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20191003



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

--===============5178866012184137297==--
