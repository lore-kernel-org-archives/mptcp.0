Content-Type: multipart/mixed; boundary="===============2257608548405956570=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 19th of November 2020
Date: Thu, 19 Nov 2020 18:50:23 +0100
Message-ID: <073679fc-de30-2526-559e-32aa4195f888@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6836

--===============2257608548405956570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 125th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Davide, Paolo and Florian (RedHat), Geliang (Xiaomi) =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     netdev (if mptcp ML is in cc) (Paolo Abeni):

1400786  [net-next,v3,13/13] mptcp: send explicit ack on delayed ack_seq =

incr
1400780  [net-next,v3,12/13] mptcp: keep track of advertised windows =

right edge
1400772  [net-next,v3,11/13] mptcp: rework poll+nospace handling
1400769  [net-next,v3,10/13] mptcp: try to push pending data on snd una =

updates
1400768  [net-next,v3,09/13] mptcp: move page frag allocation in =

mptcp_sendmsg...
1400767  [net-next,v3,08/13] mptcp: refactor shutdown and close
1400766  [net-next,v3,07/13] mptcp: introduce MPTCP snd_nxt
1400765  [net-next,v3,06/13] mptcp: add accounting for pending data
1400764  [net-next,v3,05/13] mptcp: reduce the arguments of =

mptcp_sendmsg_frag
1400763  [net-next,v3,04/13] mptcp: introduce mptcp_schedule_work
1400762  [net-next,v3,03/13] tcp: factor out __tcp_close() helper
1400759  [net-next,v3,02/13] mptcp: use tcp_build_frag()
1400761  [net-next,v3,01/13] tcp: factor out tcp_build_frag()


     our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

1403001  [v5,6/6] mptcp: use mptcp release_cb for delayed tasks.
1403000  [v5,5/6] mptcp: avoid a few atomic ops in the rx path
1402999  [v5,4/6] mptcp: allocate TX skbs in msk context.
1402996  [v5,3/6] mptcp: protect the rx path with the msk socket spinlock
1402997  [v5,2/6] mptcp: implement wmem reservation.
1402995  [v5,1/6] mptcp: open code mptcp variant for lock_sock

1402403  [net-next] mptcp: drop CANCEL_WORK status bit

1401751  [v2] mptcp: fix state tracking for fallback socket

1400239  [mptcp-next] bpf: move bpf_mptcp_sock_ fn out of CONFIG_INET

1400026  [v2] Squash-to: "mptcp: refactor shutdown and close" again

1399910  [net-next] Squash-to: "mptcp: refactor shutdown and close" again

1397534  [v2] mptcp: refine MPTCP-level ack scheduling

1397303  [v4,mptcp-next,08/13] mptcp: print out port and ahmac when =

receiving ...
1397302  [v4,mptcp-next,07/13] mptcp: add port parameter for =

mptcp_pm_announce...
1397301  [v4,mptcp-next,06/13] mptcp: send out dedicated packet for =

ADD_ADDR u...
1397300  [v4,mptcp-next,05/13] mptcp: add the outgoing ADD_ADDR port support
1397299  [v4,mptcp-next,04/13] mptcp: use adding up size to get ADD_ADDR =

length
1397298  [v4,mptcp-next,03/13] mptcp: add port support for ADD_ADDR =

suboption ...
1397297  [v4,mptcp-next,02/13] mptcp: unify ADD_ADDR and ADD_ADDR6 =

suboptions ...
1397295  [v4,mptcp-next,01/13] mptcp: unify ADD_ADDR and echo suboptions =

writi...



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*


     netdev (if mptcp ML is in cc) (Paolo Abeni):

1402577  [net-next] mptcp: update rtx timeout only if required.


     our repo (by: Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP

1394896: Changes Requested: [RFC,mptcp-next,1/6] mptcp: add the outgoing =

MP_PRIO support
1394898: Changes Requested: [RFC,mptcp-next,2/6] mptcp: add the incoming =

MP_PRIO support
1394899: Changes Requested: [RFC,mptcp-next,3/6] mptcp: add prio_changed =

flag
1394900: Changes Requested: [RFC,mptcp-next,4/6] mptcp: send out MP_PRIO =

before RM_ADDR
1394901: Changes Requested: [RFC,mptcp-next,5/6] mptcp: add the mib for =

MP_PRIO
1394902: Changes Requested: [RFC,mptcp-next,6/6] selftests: mptcp: add =

MP_PRIO check in chk_rm_nr:
     - WIP (Focus is probably on the ADDR_ADDR + port support)

1395128: Changes Requested: [1/5] tcp: make two mptcp helpers available =

to tcp stack
1395130: Changes Requested: [2/5] tcp: parse mptcp options contained in =

reset packets
1395131: Changes Requested: [3/5] mptcp: add mptcp reset option support
1395132: Changes Requested: [4/5] mptcp: parse and act on incoming =

FASTCLOSE option
1395133: Changes Requested: [5/5] mptcp: send fastclose if userspace =

closes socket with unread data:
1401794: RFC: Fastclose packetdrill test cases:
     - Validation in progress with Packetdrill, see below

1402869: New: [v5,mptcp-next,01/10] mptcp: create the listening socket
1402871: New: [v5,mptcp-next,02/10] mptcp: add the pernet listening =

socket operations
1402872: New: [v5,mptcp-next,03/10] mptcp: bind and listen for the new port
1402873: New: [v5,mptcp-next,04/10] mptcp: add port number check for MP_JOIN
1402874: New: [v5,mptcp-next,05/10] mptcp: add port number announced check
1402875: New: [v5,mptcp-next,06/10] mptcp: add port number listened in =

kernel check
1402876: New: [v5,mptcp-next,07/10] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1402877: New: [v5,mptcp-next,08/10] selftests: mptcp: add port argument =

for pm_nl_ctl
1402878: New: [v5,mptcp-next,09/10] mptcp: add the mibs for ADD_ADDR =

with port
1402879: New: [v5,mptcp-next,10/10] selftests: mptcp: add testcases for =

ADD_ADDR with port:
     - Should address last recommendations from Mat and Paolo
     - Looks like it is the right direction!
     - but still reviews have not been done yet

1402896: New: [v2,mptcp-next,1/2] mptcp: drop rm_addr_signal flag
1402897: New: [v2,mptcp-next,2/2] mptcp: rename add_addr_signal and =

mptcp_add_addr_status:
     - Needs review


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 107)

   113  selftests: mptcp_connect MPTCP =E2=86=92 TCP: file received by clie=
nt =

does not match [bug]:
       - Should be fixed with the last series from Paolo
       - TODO: Matth: check and close the ticket

   112  sporadic failure of mptcp_join.sh selftest 13 [bug] =

[enhancement] [question]:
       - echo-addr is sometimes not transmitted because there is no pure =

ACK available
       - sometimes the ADD_ADDR is in the ACK after the DATA_FIN but no =

longer processed by the stack
       - Two possibilities found:
           - modifying tcp_rcv_state_process() but maybe not compliant =

by the RFC
           - force ping/pong
           - schedule sending a pure ACK

   111  [syzkaller] divide error in __tcp_select_window:
       - no repro yet

   110  [syzkaller] memory leak in __ip_mc_join_group:
       - no repro yet

   109  [syzkaller] memory leak in skb_ext_add [bug] [syzkaller]:
       - looks similar to 104
       - should be fixed on the last export branch
       - we no longer have the skb extension cache

   108  [syzkaller] memory leak in sk_clone_lock [bug] [syzkaller]:


     Bugs (opened, flagged as "bug" and assigned)

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti
    85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe


     Bugs (opened and flagged as "bug" and not assigned)

   113  selftests: mptcp_connect MPTCP =E2=86=92 TCP: file received by clie=
nt =

does not match [bug]
   112  sporadic failure of mptcp_join.sh selftest 13 [bug] =

[enhancement] [question]
   109  [syzkaller] memory leak in skb_ext_add [bug] [syzkaller]
   108  [syzkaller] memory leak in sk_clone_lock [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]

   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]:
       - might be similar to 104

   105  warning in `mptcp_reset_timer()` with `mptcp_connect.sh -m mmap` =

[bug]:
       - hopefully fixed on the export branch
       - TODO: Matth: close ticket

   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller]:
       - might be similar to 106

   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller]
    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]

    70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]:
       - hopefully fixed on the export branch
       - TODO: Matth: close ticket

    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
    54  ADD_ADDR: ports support [enhancement] @geliangtang
    51  MP_PRIO support [enhancement] @geliangtang
    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

None.



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - See above
         - Would be great to to launch syzkaller with the latest export =

branch (after yet another refactoring from Paolo)
         - And check the different repro
         - Note that it was already validating PM Netlink but it took =

time to make it way there

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - last report had no MPTCP failure
         - a warning from a static analysis tool in net/mptcp/options.c:
             - because we modify a variable inside a function which is =

local? If yes, we can ignore

     - packetdrill (Davide):
         - Florian will send a PR once the kernel patches have been applied
         - other patches non related to MP FC will also be shared, we =

can discuss about that on GH (or ML if related to MPTCP RFC/kernel)

     - CI (Matth):
         - /



Perf tests (comparing MPTCP and TCP in stream test over loopback):
     - Since push_pending merge and up to "mptcp: refine MPTCP-level ack =

scheduling" MPTCP stream performances were low and unstable: ~4Gbps +-2

     - after "mptcp: refine MPTCP-level ack scheduling" export branch =

was around ~22Gbps, quite stable

     - Now at 24-25Gbps, but still far from TCP (39-40 Gbps)

     - It looks like with TCP we aggregate more, up to 64KB per packet, =

while MPTCP sends ~32KB packets.

     - it looks like the issue is more on the send side, analysis are in =

progress



more patches to send to net-next:
     - "refine MPTCP-level ack scheduling" and earlier, except for BPF =

patches?
     mptcp: refine MPTCP-level ack scheduling
     mptcp: track window announced to peer
     selftests: mptcp: add ADD_ADDR IPv6 test cases
     mptcp: send out dedicated ADD_ADDR packet
     mptcp: change add_addr_signal type
     mptcp: keep unaccepted MPC subflow into join list
     selftests: mptcp: add link failure test case
     mptcp: skip to next candidate if subflow has unacked data
     + 2 new ones

     - Mat has shareed the list on IRC
     - we can send Paolo's series after that



Next meeting:
     - We propose to have the next meeting on Thursday, the 26th of =

November.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201126



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2257608548405956570==--
