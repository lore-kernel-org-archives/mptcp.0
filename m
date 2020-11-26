Content-Type: multipart/mixed; boundary="===============7535691819493392739=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 26th of November 2020
Date: Thu, 26 Nov 2020 18:55:03 +0100
Message-ID: <01d5bd79-76a3-2853-b518-475b08c47e33@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6958

--===============7535691819493392739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 126th meeting with Davide, Paolo and Florian =

(RedHat) and myself (Tessares).


Christoph, Mat and Ossama were not able to join, still trying to handle =

Maradona's loss... Be brave guys! (and turkeys too!)


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Florian Westphal, Mat Martineau, =

Paolo Abeni):

1405745  [net-next,v2] mptcp: be careful on MPTCP-level ack.
1405649  [net-next] mptcp: put reference in mptcp timeout timer
1405488  [net-next] mptcp: be careful on MPTCP-level ack.
1403243  [net-next,10/10] mptcp: refine MPTCP-level ack scheduling
1403242  [net-next,09/10] mptcp: track window announced to peer
1403241  [net-next,08/10] selftests: mptcp: add ADD_ADDR IPv6 test cases
1403240  [net-next,07/10] mptcp: send out dedicated ADD_ADDR packet
1403239  [net-next,06/10] mptcp: change add_addr_signal type
1403238  [net-next,05/10] mptcp: keep unaccepted MPC subflow into join list
1403237  [net-next,04/10] selftests: mptcp: add link failure test case
1403233  [net-next,03/10] mptcp: skip to next candidate if subflow has =

unacked...
1403234  [net-next,02/10] mptcp: fix state tracking for fallback socket
1403236  [net-next,01/10] mptcp: drop WORKER_RUNNING status bit


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1406513  [net] mptcp: fix NULL ptr dereference on bad MPJ
1406183  [mptcp-next,3/3] mptcp: parse and act on incoming FASTCLOSE option
1406182  [mptcp-next,2/3] tcp: parse mptcp options contained in reset =

packets
1406180  [mptcp-next,1/3] mptcp: hold mptcp socket before calling tcp_done
1405424  [net-next,v2] mptcp: be careful on MPTCP-level ack.
1404620  [net-next] mptcp: use the variable sk instead of open-coding
1404614  [mptcp-next] Squash to "mptcp: protect the rx path with the msk =

socke...
1403573  [v4,mptcp-next,2/2] mptcp: rename add_addr_signal and =

mptcp_add_addr_...
1403572  [v4,mptcp-next,1/2] mptcp: drop rm_addr_signal flag
1403526  [net-next] Squash-to: "mptcp: use mptcp release_cb for delayed =

tasks"
1403370  squashto: mptcp: protect the rx path with the msk socket spinlock
1403303  [net-next] Squash-to: "mptcp: protect the rx path with the msk =

socket...
1403300  [net-next] Squash-to: "mptcp: open code mptcp variant for =

lock_sock"



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1406703  [net] mptcp: fix NULL ptr dereference on bad MPJ


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets
1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - Parked

1395128: Changes Requested: [1/5] tcp: make two mptcp helpers available =

to tcp stack
1395131: Changes Requested: [3/5] mptcp: add mptcp reset option support
1395133: Changes Requested: [5/5] mptcp: send fastclose if userspace =

closes socket with unread data:
     - Can be switched to RFC

1403495: Changes Requested: [mptcp-next,1/5] mptcp: add the outgoing =

MP_PRIO support
1403497: Changes Requested: [mptcp-next,2/5] mptcp: add the incoming =

MP_PRIO support
1403498: Changes Requested: [mptcp-next,3/5] mptcp: deal with =

MPTCP_PM_ADDR_FLAG_BACKUP in PM netlink
1403499: Changes Requested: [mptcp-next,4/5] mptcp: add the mibs for MP_PRIO
1403500: Changes Requested: [mptcp-next,5/5] selftests: mptcp: add the =

MP_PRIO testcases:
     - Mat did a review, new version needed (or reply?)

1405799: Changes Requested: [v6,mptcp-next,1/9] mptcp: create the =

listening socket for new port
1405800: Changes Requested: [v6,mptcp-next,2/9] mptcp: set the listening =

socket's subflow
1405801: Changes Requested: [v6,mptcp-next,3/9] mptcp: release the =

listening socket
1405802: Changes Requested: [v6,mptcp-next,4/9] mptcp: add port number =

check for MP_JOIN
1405803: Changes Requested: [v6,mptcp-next,5/9] mptcp: add port number =

announced check
1405804: Changes Requested: [v6,mptcp-next,6/9] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1405805: Changes Requested: [v6,mptcp-next,7/9] selftests: mptcp: add =

port argument for pm_nl_ctl
1405806: Changes Requested: [v6,mptcp-next,8/9] mptcp: add the mibs for =

ADD_ADDR with port
1405807: Changes Requested: [v6,mptcp-next,9/9] selftests: mptcp: add =

testcases for ADD_ADDR with port
1405894: Changes Requested: [mptcp-next] Squash to "mptcp: add port =

number announced check":
     - Paolo did a review, new version needed
     - some architectural changes might be needed, see patch 2/9.
     - we can continue the discussion by email

1406217: New: [net-next] mptcp: be careful on subflows shutdown:
     - Applied by Matth just before the meeting

1406751: New: [v3] mptcp: let MPTCP create max size skbs:
     - Paolo was sad nobody did a review for his patch sent 2 minutes =

before the meeting :-/



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 113)

   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]:
       - Maybe a fix from Paolo, see:
           1406217: mptcp: be careful on subflows shutdown
           - now in the export branch
       - @Christoph: may you try this please?

   114  packetdrill: dss tolerance issue to emit the FIN+ACK [bug] =

[packetdrill]:
       - Maybe due to something else done in //?


     Bugs (opened, flagged as "bug" and assigned)

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti:
        - WIP

    85  Packetdrill: multiple timeout reported by the CI [bug] =

[packetdrill] @matttbe:
        - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
   114  packetdrill: dss tolerance issue to emit the FIN+ACK [bug] =

[packetdrill]
   112  sporadic failure of mptcp_join.sh selftest 13 [bug]

   111  [syzkaller] divide error in __tcp_select_window [bug] [syzkaller]:
       - closed by Paolo

   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   108  [syzkaller] memory leak in sk_clone_lock [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]

   105  warning in `mptcp_reset_timer()` with `mptcp_connect.sh -m mmap` =

[bug]:
       - we should check if we can closed
       - TODO: Matth

   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller]
   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller]
    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]
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

   116  [syzkaller] WARNING in corrupted [bug] [syzkaller]
   113  selftests: mptcp_connect MPTCP =E2=86=92 TCP: file received by clie=
nt =

does not match [bug]
   109  [syzkaller] memory leak in skb_ext_add [bug] [syzkaller]
    70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patch prefix:
     - When looking at patchwork, it is no always clear to distinct if =

the patch is for MPTCP tree ("internal review") or netdev.

     - Proposition of using tags:
         - mptcp-next =E2=86=92 for net-next (now or later):
             - If it has a "Fixes" tag, applied at the bottom of the tree
             - If not, new feature, at the end (or add instructions in =

the comments)
         - mptcp-net =E2=86=92 for net (ASAP):
             - to be applied at the bottom of the tree
         - net-next =E2=86=92 sent to netdev for net-next and mptcp ML is i=
n CC
         - net =E2=86=92 sent to netdev for -net and mptcp ML is in CC

     - not mandatory, just to help filtering patches :)



Address ID assignment in netlink PM:
     - linked to Ossama's email
     - idea was to keep the kernel side management simple
     - we could let the userspace setting an ID but we need to be =

careful if it sets a duplicated one, etc.
     - but work needs to be done in the kernel side



Patches to send to netdev:
     - net:
         - Paolo's has some fixes

     - net-next:
         - workqueue removal thing

     mptcp: use mptcp release_cb for delayed tasks
     mptcp: avoid a few atomic ops in the rx path
     mptcp: allocate TX skbs in msk context
     mptcp: protect the rx path with the msk socket spinlock
     mptcp: implement wmem reservation
     mptcp: open code mptcp variant for lock_sock

         - Paolo is going to send them
         - some reports on top of net-next mention issues with some =

selftests =E2=86=92 this should be fixed by this rework. Maybe better to ap=
ply =

these patches then.



Malformed MP_JOIN:
     - Florian is looking at sending the RST directly instead of SYN+ACK =

then RST later
     - (also looking at the path taken in TCP code)



Extra tests:
     - news about Syzkaller? (Christoph):
         - See Github #115
         - @Christoph: may you try to repro #115 please?

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - /

     - packetdrill (Davide):
         - Davide's daughter is going to review Florian's patches

     - CI (Matth):
         - =E2=86=93


Github Action:
     - new IRC notif when a tag is published (e.g. CI has updated the =

export branch)
     - TODO: notif when issues are created or closed but not the comments
     - TODO: notif for the builds
     - TODO: port what is done by Tessares' CI to GH Actions.


Perf:
     - Paolo was looking at removing an extra spinlock but didn't see diff

     - the lack of tput improvement and the wide gap vs TCP is likely a =

test artifact:

         - MPTCP does not acquire the msk socket lock to enter the RX =

path: each sendmsg over loopback ends-up enqueuing data to msk, doing =

most of receiver work inside the sender process context. The sender is =

the bottle-neck, while we have much free CPU time in the receiver =

process, not used.

         - TCP acquires the socket lock to enter the rx path, sendmsg =

may find that held by the receiver and defer the rx processing to the =

backlog. The processing is split among the sender and the receiver =

process. The lookback tput is higher, but also the cumulative CPU =

utilization.

     - using two different VMs - one for the sender and one for the =

receiver - should avoid the above artifact



mptcpd:
     - https://bugzilla.redhat.com/show_bug.cgi?id=3D1899884
     - Davide did a good job from start, already got some reviews so we =

expect to have it included mid of December



Next meeting:
     - We propose to have the next meeting on Thursday, the 3rd of December.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201203



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7535691819493392739==--
