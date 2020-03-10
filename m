Content-Type: multipart/mixed; boundary="===============4513347354960638779=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 5th of March 2020
Date: Tue, 10 Mar 2020 18:36:08 +0100
Message-ID: <7ed6823b-86ad-dc45-0520-4ceb21454de7@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3901

--===============4513347354960638779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last Thursday, we had our 89th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     net-next: (by Mat)
1246924  mptcp: Check connection state before attempting send
1246926  mptcp: Use per-subflow storage for DATA_FIN sequence number
1246925  mptcp: Only send DATA_FIN with final mapping

     our repo: (by Paolo, Matth)
1247727  mptcp: disable two unstable mptcp_join tests
1247721  [v2,2/2] mptcp: fix compilation warning without IPv6
1247534  mptcp: fix wrong merge resolution
1247522  [1/2] mptcp: fix compilation error without IPv6
1243283  [v4,9/9] selftests: add test-cases for MPTCP MP_JOIN
1243282  [v4,8/9] selftests: add PM netlink functional tests
1243284  [v4,7/9] mptcp: add netlink based PM
1243280  [v4,6/9] Squash-to: subflow: place further subflows on new =

'join_list'
1243279  [v4,5/9] Squash-to: "mptcp: Implement path manager interface =

commands"
1243277  [v4,4/9] Squash-to: "mptcp: Add handling of outgoing MP_JOIN =

requests"
1243278  [v4,3/9] Squash-to: "mptcp: Add handling of incoming MP_JOIN =

requests"
1243281  [v4,2/9] Squash-to: "mptcp: Add path manager interface"
1243276  [v4,1/9] Squash-to: "mptcp: Add ADD_ADDR handling"


Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Matthieu, Peter, Florian, Paolo

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - we still have the bug

1243769: Needs Review / ACK: [v2,1/2] mptcp: Re-factor =

mptcp_crypto_hmac_sha()
1243771: Needs Review / ACK: [v2,2/2] mptcp: Make v1 changes for =

ADD_ADDR and RM_ADDR options:
     - waiting for rebase
     - rebase not needed for the first patch but needed for the second patch

1245636: Needs Review / ACK: mptcp: re-check dsn before reading from =

subflow:

1248498: Deferred: [net] mptcp: always include dack if possible.:
     - not accepted yet, for -net

1249577: New: [RFC,1/3] selftests: add mptcp ip set/getsockopt test program
1249580: New: [RFC,2/3] mptcp: propagate mptcp-socket level ip options =

to the subflows
1249579: New: [RFC,3/3] testing only: allow IP_OPTIONS set/getsockopt:
     - to be removed from patchwork

1249649: New: [v2,1/12] mptcp: rename fourth ack field
1249652: New: [v2,2/12] Squash-to: "mptcp: Add ADD_ADDR handling"
1249638: New: [v2,3/12] Squash-to: "mptcp: Add handling of incoming =

MP_JOIN requests"
1249651: New: [v2,4/12] Squash-to: "mptcp: Add handling of outgoing =

MP_JOIN requests"
1249655: New: [v2,5/12] Squash-to: "mptcp: Implement path manager =

interface commands"
1249647: New: [v2,6/12] Squash-to: "mptcp: allow dumping subflow context =

to userspace"
1249650: New: [v2,7/12] Squash-to: "mptcp: add MIB counter infrastructure"
1249657: New: [v2,8/12] Squash-to: "mptcp: increment MIB counters in a =

few places"
1249656: New: [v2,9/12] Squash-to: "subflow: place further subflows on =

new 'join_list'"
1249648: New: [v2,10/12] Squash-to: "mptcp: add netlink based PM"
1249654: New: [v2,11/12] Squash-to: "selftests: add PM netlink =

functional tests"
1249653: New: [v2,12/12] Squash-to: "selftests: add test-cases for MPTCP =

MP_JOIN":
     - v1 reviewed by Mat
     - waiting for review
     - looks big (because of the split) but not a lot of code change
     - fixes for PM (see the discussion on the previous PM patches) + =

fixes for the selftests
     - cover letter indicates there is a race linked to association of a =

subflow with the master socket
     - this can cause sporadic failures in the selftests
     - idea: do the allocation earlier, Paolo is looking a sharing RFC soon
     - idea: deferring the answer but it might cause changes in TCP



FYI: Current Roadmap: (updated)
     - Part 3 (next merge window):
         - PM:
             - locking
             - basic =E2=86=92 netlink support
         - MP_JOIN
         - ADD_ADDR for MPTCP v1
         - clean the current patches
         - need to make sure we continue to support the protocol =E2=86=92 =

workaround for shared received windows
      - other items:
         - Shared recv window (drop data received on other subflows) [TODO]:
             - could be nice to have
             - could be nice to share a prototype/RFC with TCP =

maintainers (Eric)
         - PM basic [Done]
         - fix sender ID in MP_JOIN

     - Part 4 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - reduce locks when mptcp_stream_accept (currently 3 locks) but =

we might need to add an helper in inet API
         - Full DATA_FIN support [WIP]:
             - could be nice to have it: if ready
         - Active backup support [WIP]
         - ADD_ADDR for MPTCPv1: echo bit
         - Opti in TCP option structures (unions) [to be rebased]

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink
         - PM bpf
         - Scheduler bpf
         - syncookies
         - [gs]etsockopt per subflow
         - notify the userspace when a subflow is added/removed =E2=86=92 c=
msg



Part 3 remaining stuff:
     - Review commit messages:
         - TODO: not urgent

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - TODO: not urgent

     - ADD_ADDR for MPTCPv1:
         - Peter is looking at that
         - doesn't seem easy/quick to implement the "echo" part
         - for the moment there is no other implementation sending the =

echo part or retransmitting the ADD_ADDR
         - Peter's patches implement ADD_ADDRv1 without the echo part, =

this part can come later
         - regarding the RFC and retransmitting the ADD_ADDR, there is =

nothing forcing the way the retransmissions have to be done (each ACK? =

RTO? stop when we receive an MP_JOIN, etc.)
         - conclusion: we can send the ADD_ADDRv1 without the echo part =

support
         - TODO: add the echo part in the roadmap =E2=86=92 Done

     - DATA_FIN:
         - Mat is looking at that
         - but we don't block this series

     - Shared received windows:
         - Florian is looking at that indirectly
         - looking at packetdrill tests first
         - will look at the RFC and check what can be done: hoping to =

have a "simple" workaround first before a more complex implementation
         - could it be a problem not to respect windows?:
             - yes and no: if there is room for the sender to send data, =

that's fine: we should avoid having one subflow filling the window with =

out-of-order data not letting another subflow sending/retransmitting the =

missing data.
             - in term of perfs, it's bad.



Extra tests:
     - news about Syzkaller? (see prev meeting):
         - no news
         - running on top of export branch
         - syzbot is testing -net (and more?) with MPTCP support
         - Christoph is looking at testing the PM part, testing the =

netlink communication
         - there is a typo: mptcp_pm_addr_addrs -> mptcp_pm_addr_attrs . =

*Paolo* will fix it

     - new about Intel's kbuild? (Mat):
         - https://github.com/intel/lkp-tests/pull/58
         - they should test the "export" branch but we didn't see =

anything from them
         - Mat: will send "export" branch to his repo for a (hopefully) =

last manual test

     - packetdrill:
         - Davide is working on that



CI:
     - now testing and validating new MPTCP selftests (join+pm)
     - now testing packetdrill: DSS and mp_capable
     - mptcp_connect.sh -m mmap =E2=86=92 not yet (still the bug)



Next meeting:
     - We propose to have the next meeting on Thursday, the 12th of March.
     - /!\ *NOT* the Usual time: 16:00 UTC (9am PDT, 5pm CET) /!\
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200312



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
--===============4513347354960638779==--
