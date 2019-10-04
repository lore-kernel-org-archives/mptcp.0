Content-Type: multipart/mixed; boundary="===============3459771220515223965=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 3rd of October 2019
Date: Fri, 04 Oct 2019 10:29:10 +0200
Message-ID: <c813e222-dff2-76b7-8fe9-ddc85cff0439@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2013

--===============3459771220515223965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 69th meeting with Mat, Peter and Ossama (Intel
OTC), Christoph (Apple), Paolo and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: Prefix crypto routines with mptcp_:
        - by Peter
        - applied by Florian
        - squashed

    - mptcp: fix retransmit timer update:
        - by Paolo
        - follow up for "mptcp: implement retransmit infrastructure"
        - Accept by Mat
        - squashed

    - mptcp: prefix subflow routines with mptcp_:
        - by Matth
        - accepted by Florian
        - squashed (no signed-off added)

    - mptcp: Remove all traces of checksum support:
        - by Peter
        - v2 sent
        - Split in 6 patches, all squashed
        - applied patch is slightly different, see ML ("unused" field +
changes in pm.c)

    - mptcp: removed unused fields in structures:
        - by Matth
        - applied without review :-O =E2=86=92 no, Peter said OK (after)

    - mptcp: prefix pm routines with mptcp_:
        - by Matth
        - (also applied without review O:-) )

    - mptcp: allow dumping subflow context to userspace:
        - by Davide
        - accepted by Paolo

    - mptcp: add MIB counter infrastructure:
        - by Florian
        - v2 sent

    - mptcp: allow MPTCP sockets by default:
        - by Matth
        - v2 sent
        - needs to update the commit message



Pending patches:
    - mptcp: Interim Path Manager:
        - by Peter
        - v2 sent
        - Waiting for accept

    - mptcp_poll should not block on each subflow:
        - by Florian
        - no longer an RFC
        - waiting for review/accept

    - selftests: prepare for mptcp ipv6 support:
        - by Florian
        - commented by Paolo and Peter (+ who can do what) and Alexander
        - Waiting for a last review

    - mptcp:options: merge two holes in one:
        - by Matth
        - Commented by Peter
        - we can drop it if we clean up the structure

    - mptcp:diag: prefix exposed items:
        - by Matth
        - Commented by Davide
        - to conform with the rest



RFCv2 sent to netdev:
    - Feedback: Dave M says 40-some patches is way too many, and to
repost series with no more than 12-20 patches
https://lore.kernel.org/netdev/20191002.171229.1495727500341484392.davem(a)=
davemloft.net/

    - Mat regrets accidentally posting an older snapshot to netdev. It
was export/20191001T075519 plus Florian's IPv6 selftest series. Given
Dave's feedback, he did not continue with reposting the correct 43
patches as RFCv3.

    - We could squash more aggressively to reduce in-series code churn
and the patch count

    - Or we send less (less at a time)

    - Or we do both (squash + send less at a time)

    - Maybe easier to send a first subset and then squash other patches
later?

    - Idea from Florian and Paolo would be to only include:
          net: Make sock protocol value checks more specific
          sock: Make sk_protocol a 16-bit value
          tcp: Define IPPROTO_MPTCP
          # new # tcp: Add MPTCP option number
          tcp, ulp: Add clone operation to tcp_ulp_ops
          # new # mptcp: Add MPTCP to skb extensions
          tcp: Prevent coalesce/collapse when skb has MPTCP extensions
(requires MPTCP skb extensions)
          tcp: Export low-level TCP functions
          tcp: Check for filled TCP option space before SACK
          tcp: clean ext on tx recycle
          tcp: Expose tcp struct and routine for MPTCP

    - and regarding:  "tcp: clean ext on tx recycle" =E2=86=92
https://github.com/multipath-tcp/mptcp_net-next/commit/bd623dbb9c27d4399662=
2660e479f2e349d23cb2
        - it does have some minimal MPTCP dependencies that can't be
removed without making such patch a no-op, so perhaps we should also
include some very minimal MPTCP stub definitions:

            - mptcp: Add MPTCP to skb extensions
            - tcp: Add MPTCP option number

    - Or we rework the patches above not to include them now (first
patch set). But easier for us if they are there

    =E2=86=92 decision: we take the list we have above and if there is an i=
ssue
with upstream, we drop and rework patches

    =E2=86=92 *@Florian*: may you comment this please? (linked to the discu=
ssion
we had on "RFCv2 for netdev: what's missing?" mail thread.

    - We can send a first set (=E2=86=91), then up to kselftests (with poss=
ible
re-ordered/squashed patches like refactoring of recv/sendmsg) as a
second batch, then other chunks later

    - It looks like a good idea to send the first set "now" / very soon.

    - Matth can re-order the commits and check that each commit can be
compiled without issues

    - planning:
        - Wait for Florian comment about that (there was a new comment
by Florian linked to that on the ML after the meeting)
        - Matth does the rebase
        - We let half to one day for the review
        - Paolo sends coffee to Mat
        - Mat sends that to Netdev as a non RFC
        - (maybe: Mat, may you already send a new draft for the
cover-letter for this first batch?)



Second part of the "initial" submission:
    - Squash "mptcp: Make MPTCP socket block/wakeup ignore
sk_receive_queue" earlier in the series? (Question by Mat)

    -
https://github.com/multipath-tcp/mptcp_net-next/commit/de814755d1e5f7fe5e56=
c5240fcbe255361d0ad0

    - We can squash it, maybe in MPTCP receive path.

    - *@Mat*: To be confirmed by Mat after the meeting



mptcp_recvmsg():
    - Paolo is working on another refactoring of mptcp_recvmsg()
    - Ideally, we should squash it with the previous one
    - Paolo hopes having something to share next week



Another idea of squash:
    - the ones related to sendmsg():
        - mptcp: use sk_page_frag() in sendmsg
        - mptcp: sendmsg() do spool all the provided data
        - mptcp: allow collapsing consecutive sendpages on the same
substream

    - they modified incrementally the code made by the previous one
    - It might be easier for the reviewers to have everything in one
    - Maybe we can rework them in 1, 2 patches: one introducing helpers
    - Paolo can look at that (in the near future)


Rebase:
    - If someone wants to do some rebases, please notify the list,
mainly Matth, to pause the work on the "main" branch (TopGit tree)



MPTCPv1:
    - because Apple is reserving some rights, it might be an issue.
    - MPTCPv1 (RFC6824bis) should be published soon so that's good:
Apple will reserve less rights but still a few (protection)
    - we should explain in the commit message what it means and point
reviewers/maintainers to the patent and what Apple said in IETF documents.
    - still would be better without this patent (another track in progress)



Remaining items for the initial submission:
    - IPv6 support:
        - Peter is working on it

    - MPTCP v1 support:
        - question about complexity: might be more complex to implement
the new MP_CAPABLE way of working (delayed client's "key")
        - Paolo is pointing us to a URL in the ML:

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/IEL4AEXZZZ=
B4T7OJUP5MW5BJ2QW3AQNX/

    - DATA_FIN:
        - Mat is working on it
        - Working on having the correct state machine
        - Florian might be interesting to help on that

    - Shared recv window:
        - Do we need this for the initial submission? Will be needed
only with multiple concurrent flows
        - If we accept multiple subflows, the other end might send data
over multiple flows (concurrently), even if the backup flag is set
        - (this backup flag is more a way to inform the other side the
subflow should be used "as a backup" or "with a lower priority")
        - we at least need protection again "deadlocks", see
recommendations sent by Christoph previously.
        - =E2=86=92 Work to be done

    - Active backup support:
        - Paolo is looking at that, the mptcp_recvmsg() refactoring is
part of it
        - It also means we need a basic scheduler for the xmit side

    - Limit subflow ULP visibility to kernel space:
        - there used to be a way to limit them
        - we should have a similar way again
        - to avoid the userspace to attach subflow to MPTCP flow
        - Davide can look at it

    - optimisation of options in TCP "struct mptcp_options_received":
        - idea would be to add unions for options that cannot be used
together
        - e.g. MP_CAPABLE and MP_JOIN cannot live together
        - but ADD/RM_ADDR can be present with DSS

    - MP_FAST_CLOSE, seems not implemented:
        - Do we want to add it now?
        - We might be able to live without it *for the moment*
        - implementation is easier with MPTCPv1
        - We can continue discussing about that next week (running out
of time)



New ML interface:
    - https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/
    - Old archive links no longer work
    - previous subscribers are still subscribed
    - *@Mat* can fix the links in the meetings in the wiki



Next meeting:
    - We propose to have it next Thursday, the 10rd of October.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20191010



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
--===============3459771220515223965==--
