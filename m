Content-Type: multipart/mixed; boundary="===============1393716982979634868=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 27th of February 2020
Date: Fri, 28 Feb 2020 16:49:52 +0100
Message-ID: <a4ca6a8e-03f0-bf0c-bacc-c50f98ad82dc@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3823

--===============1393716982979634868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 88th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     - Internal: (By Davide, Matthieu, Florian)

1243181  net: mptcp: rename MPTCP_SUBFLOW_* into MPTCP_SUBFLOW_ATTR_* in =

diag ...
1242406  [GIT] Sync with net-next on 20200222: 2 conflicts
1233392  subflow: place outgoing connections on the join list


     - net-next: (By Florian, Paolo)

1244410: New: [net-next,v2,1/7] mptcp: add and use mptcp_data_ready helper
1244411: New: [net-next,v2,2/7] mptcp: add work queue skeleton
1244412: New: [net-next,v2,3/7] mptcp: update mptcp ack sequence from =

work queue
1244413: New: [net-next,v2,4/7] mptcp: add rmem queue accounting
1244414: New: [net-next,v2,5/7] mptcp: remove mptcp_read_actor
1244415: New: [net-next,v2,6/7] mptcp: avoid work queue scheduling if =

possible
1244416: New: [net-next,v2,7/7] mptcp: defer work schedule until mptcp =

lock is released:
     - They have been applied on net-next
     - Florian prepared a branch with resolved conflicts
     - the TopGit tree will be reconstructed based on this branch


     - net: (By Paolo)

1244925: mptcp: add dummy icsk_sync_mss()



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Florian Westphal, Mat Martineau, Matthieu Baerts, Paolo Abeni, =

Peter Krystad

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - do we still have the bug?
     - Matth will check if we still have it
         - *After meeting note* : yes we still have it with export =

rebased on latest net-next.

1233648: Needs Review / ACK: [RFC,1/3] mptcp: Check connection state =

before attempting send
1233650: Needs Review / ACK: [RFC,2/3] mptcp: Use per-subflow storage =

for DATA_FIN sequence number
1233649: Needs Review / ACK: [RFC,3/3] mptcp: Only send DATA_FIN with =

final mapping:
     - need review
     - and rebase
         - *After meeting note* : done
     - 1 & 2 would go to net tree if OK
     - Paolo will try to look at it as soon as possible
         - *After meeting note* : done

1243276: New: [v4,1/9] Squash-to: "mptcp: Add ADD_ADDR handling"
1243281: New: [v4,2/9] Squash-to: "mptcp: Add path manager interface"
1243278: New: [v4,3/9] Squash-to: "mptcp: Add handling of incoming =

MP_JOIN requests"
1243277: New: [v4,4/9] Squash-to: "mptcp: Add handling of outgoing =

MP_JOIN requests"
1243279: New: [v4,5/9] Squash-to: "mptcp: Implement path manager =

interface commands"
1243280: New: [v4,6/9] Squash-to: subflow: place further subflows on new =

'join_list'
1243284: New: [v4,7/9] mptcp: add netlink based PM
1243282: New: [v4,8/9] selftests: add PM netlink functional tests
1243283: New: [v4,9/9] selftests: add test-cases for MPTCP MP_JOIN:
     - can be applied, fix (if needed) can come later

1243769: New: [v2,1/2] mptcp: Re-factor mptcp_crypto_hmac_sha()
1243771: New: [v2,2/2] mptcp: Make v1 changes for ADD_ADDR and RM_ADDR =

options:
     - *need review*
     - need to be rebased on top of PM patches

1245636: New: mptcp: re-check dsn before reading from subflow:
     - *need review*



FYI: Current Roadmap:
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
         - Full DATA_FIN support [WIP]:
             - could be nice to have it: if ready
         - Shared recv window (drop data received on other subflows) [TODO]:
             - could be nice to have
             - could be nice to share a prototype/RFC with TCP =

maintainers (Eric)
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)
         - ADD_ADDR for MPTCPv1 [TODO]
         - PM basic [WIP]
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
     - Could be good to send more patches in the current merge window but:
         - some fixes are needed:
             - PM
             - MP_JOIN
             - ADD_ADDRv1
         - we are at week 3
         - in two weeks, we should try to see what to send:
             - if some stuff are not ready on time, we can also extract =

some commits, e.g. diag and mibs

     - Review commit messages:
         - needed for the next merge window: not urgent

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - TODO

     - packetdrill:
         - Davide is working on that
         - adding more patches (infinite mapping, finding bugs)
         - some DSS tests need to be adapted after last modifications =

from Florian
         - TODO: have a branch with stable tests:
             - need to add "tolerance" parameter
             - + fixes in DSS (once it is merged in "export"
             - *after meeting note*: mptcp_net-next branch is used in =

multipath-tcp/packetdrill repo. It has the tolerance parameters but not =

the fixes for DSS yet. This is tested by the CI.

     - ADD_ADDR for MPTCPv1:
         - Peter is looking at that
         - the echo part needs to be added
         - we don't want to other host to keep retransmitting the ADD_ADDRv1
             - *after meeting note* : that's the current situation, it =

would not be worst.
         - v6 case (not enough space): strategy from Paolo would be not =

to support PORT for the moment (otherwise we need to strip the =

timestamps option) and add condition to send that in a pure ACK without DSS.
         - we will check next time if we can fully support ADD_ADDRv1

     - DATA_FIN:
         - Mat is looking at that
         - First we need to review + apply the 3 pending patches
         - If we use only one subflow at a time (needed for the shared =

received window), we should be safe there.
         - and the PM is not closing SF

     - Shared received windows:
         - Florian is looking at that indirectly
         - but Florian was busy on the workqueue work
         - and they are possibly other priorities (mss_sync)

     - mptcp_incoming_option:
         - should we use a dynamic pointer?
         - with alloc + unalloc
         - main advantage: the structure is included in TCP, we would =

not impact TCP structure even if MPTCP is not used
         - alloc would be done when creating the MPTCP socket =E2=86=92 in =
fact, =

store it in subflows
         - not really difficult to manage then
         - but nobody asked us to change



Extra tests:
     - news about Syzkaller? (see prev meeting):
         - we got a first bug reported by the official syzbot with MPTCP!

     - new about Intel's kbuild? (Mat):
         - they are looking at monitoring our branch
         - Mat will send a pull request (on undocumented code :) )
         - Goal would be to have results directly send to the ML
         - CI can also create a additional commit to always select MPTCP



Netdev 0x14:
     - it seems at the end, none of us will be able to go there :-/
     - Mat might join remotely or be on site, still unsure, depends on =

Intel policy
     - People from Italy might not be allowed everywhere, not only the =

ones from Milan
     - Matth's company prefers not to take the risk if this can be cancelled
     - don't eat bats



CI:
     - also run "mptcp_connect.sh -m mmap"?:
         - Florian found a warning when using this.
         - it would be nice to always do that
         - Matth can add the support when the bug will be fixed

     - now run with more debug kconfig:
         -e PREEMPT -e DEBUG_PREEMPT
         -e DEBUG_SLAVE -e DEBUG_PAGEALLOC -e DEBUG_MUTEXES
         -e DEBUG_SPINLOCK -e DEBUG_ATOMIC_SLEEP -e PROVE_RCU
         -e DEBUG_OBJECTS_RCU_HEAD
     - add packetdrill:
        - *after meeting note* : done
     - others?
        - not for the moment (Intel kbuilds is doing other generic stuffs)



Next meeting:
     - We propose to have the next meeting on Thursday, the 5th of March.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200305



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
--===============1393716982979634868==--
