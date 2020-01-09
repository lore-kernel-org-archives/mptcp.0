Content-Type: multipart/mixed; boundary="===============7287101233601159730=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 9th of January 2020
Date: Thu, 09 Jan 2020 19:11:47 +0100
Message-ID: <a1ec0492-40c0-97bf-f4c2-860db5199c1f@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3335

--===============7287101233601159730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 81st meeting with Mat, Peter and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:


Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3
     - By Florian Westphal, Mat Martineau, Matthieu Baerts, Paolo Abeni

1220414  [2/2] protocol: fix list corruption
1220413  [1/2] protocol: pm callback must be done after msk state is set
1219998  Squash-to: "tcp, ulp: Add clone operation to tcp_ulp_ops"
1219492  Re: Rebase request
1218978  [v2] Squash-to: "sock: Make sk_protocol a 16-bit value"



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Matthieu Baerts, Paolo Abeni, Peter Krystad

1194592: Changes Requested: [RFC,1/1] mptcp: Optimize struct mptcp_recei
1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec
1220535: New: [v2,1/7] Squash-to: "mptcp: Handle MP_CAPABLE options for
1220536: New: [v2,2/7] Squash-to "mptcp: Create SUBFLOW socket for incom
1220534: New: [v2,3/7] Squash-to: "mptcp: Add key generation and token t
1220537: New: [v2,4/7] Squash-to: "mptcp: Write MPTCP DSS headers to out
1220541: New: [v2,5/7] Squash-to: "mptcp: Implement MPTCP receive path"
1220540: New: [v2,6/7] Squash-to: "mptcp: cope with later TCP fallback"
1220539: New: [v2,7/7] Squash-to: "mptcp: Add handling of incoming MP_JO



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - Sent to Netdev, in review
     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - Sent to Netdev, in review, waiting for part 1 to be merged
     - Part 3 (MPTCPv1):
         - Ready to be sent to Netdev, waiting for part 2 to be merged
         - we propose to merge part 2 and 3, see below
     - Part 4 (to be sent before the end of the merge window or more =

probably at the next one)
         - Full DATA_FIN support [WIP]
         - Shared recv window (drop data received on other subflows) [TODO]
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)
     - Part 5 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
     - Part 6 (extra needed for prod):
         - opti/perfs
         - TFO



Initial submission to net-next:
     - Part 1:
         - v6 has been sent at the beginning of this week
         - v7 has been sent just before this meeting
         - we might have to send a v8 at the end of the week

     - Part 2:
         - v3 will be sent when part 1 is merged, not even as an RFC =

except if asked

     - Part 3:
         - we propose to merge part 2 and 3, see below



Merge window:
     - the v5.6 kernel predictions: merge window closes on Sunday, =

2020-02-23 (and release on Sunday, 2020-04-12)

     - But net-next should close when v5.5 is released, around the 2nd =

of February (Sunday, 2020-02-02).

     - We don't want to have part 2 merged if part 3 is not merged in =

the same window (not to have MPTCPv0 in one release and v1 later)

     - Can we merge part 2 and 3 together? Part 2 is composed of 16 =

patches, part 3 has 4 patches but Christoph has to send them.

     - Can we ask not to merge part 2 without part 3?

     - Decision:
         - Christoph will send part 2 and 3 together
         - =E2=86=92 TODO: *Matth* adapt Signed-off
         - =E2=86=92 TODO: *Matth* adapt part 2/3 in the notes



Other WIP items:
     - Active backup support:
         - Florian is working on it, patches have been shared

     - DATA_FIN:
         - Mat is working on it

     - Paolo is looking at TCP fallback (patches have been shared)

     - Some TODOs:
         - reviewing and comment about memory barriers in part 2 =E2=86=92 =
we =

need to improve comment around them (would be nice to squash that in =

patches from part 2):
             - Florian can help looking at that

         - memleak if a request comes after a socket is closed:
             - Florian plans to look at that

         - reduce locks when mptcp_stream_accept (currently 3 locks) but =

we might need to add an helper in inet API



Should we have a kind of "retrospective" at some points?:=10
     - to focus on stuff we could improve, remove, what's working well, etc.
     - We did it quickly:
         - Patchwork:
             - helpful
             - don't hesitate to update status

         - CI:
             - we should run BPF selftests (not at each run)
             - we should run other network selftests
             - could be good to have syzcaller (another server?)
             - =E2=86=92 having the builds from Intel's kbuild? =E2=86=92 T=
ODO *Mat*
             - =E2=86=92 could be good if we don't need to run all these te=
sts =

all each time we modify our git repo

         - TopGit tree:
             - good to be able to change commit messages with patch
             - good to review (no squash)
             - we can continue to re-create the tree using a rebased =

branch (review is harder but quicker to do in some cases)

         - reviews:
             - seems working well

         - meetings:
             - once per week for max one hour seems OK

             - listing accepted/pending patches: summary for the =

accepted one, ask for questions in pending ones?

             - face-to-face meeting? could be good

         - bug tracking: not needed? (not discussed)

         - "roadmap": seems ok? (not discussed)

         - testing:
             - more to launch by the CI

             - packetdrill:
                 - looking good so far (on Davide's github =

https://github.com/dcaratti/packetdrill )
                 - would be good to upstream that
                 - before we have it upstreamed, we can use Davide's version
                 - we can also move this repo under multipath-tcp group =

on Github
                 - basic tests will be part of Davide's github
                 - others can be added "somewhere" (new repo/new branch)



Netdev 0x14:
     - Submission deadline 15-Jan-2020. =

https://netdevconf.info/0x14/submit-proposal.html
     - Conference 17-20 March
     - Recycled talks not accepted
     - Ideas?:
         - Practical MPTCP - interoperability and effects of v1 protocol =

choice, userspace API (converting apps, socket option =

limitations/details), current upstream feature set
         - Selftest & MPTCP
         - mptcpd (part of userspace API?)
     - Mat and Peter are not "far", they might go
     - harder for people in Europe



Next meeting:
     - We propose to have the next meeting on Thursday, the 16th of January.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200116



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
--===============7287101233601159730==--
