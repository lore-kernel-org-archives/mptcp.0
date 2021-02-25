Content-Type: multipart/mixed; boundary="===============4807912042910304844=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 25th of February 2021
Date: Thu, 25 Feb 2021 18:45:35 +0100
Message-ID: <afc45e93-4c92-f3ad-9fc0-1c9bcccf9775@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7957

--===============4807912042910304844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 137th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Davide and Florian (RedHat), Geliang (Xiaomi) and =

myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     netdev (if mptcp ML is in cc) (Paolo Abeni):

1442383  [net,4/4] mptcp: do not wakeup listener for MPJ subflows
1442382  [net,3/4] mptcp: provide subflow aware release function
1442381  [net,2/4] mptcp: fix DATA_FIN generation on early shutdown
1442380  [net,1/4] mptcp: fix DATA_FIN processing for orphaned sockets


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1443944  [v2,mptcp-net] mptcp: fix missing wakeup

1443895  [v2] mptcp: add mptcp reset option support

1443698  [v3,mptcp-next,5/5] selftests: mptcp: timeout testcases for =

multi add...
1443697  [v3,mptcp-next,4/5] selftests: mptcp: add cfg_do_w for cfg_remove
1443696  [v3,mptcp-next,3/5] mptcp: move to next addr when timeout
1443695  [v3,mptcp-next,2/5] mptcp: skip connecting the connected address
1443694  [v3,mptcp-next,1/5] mptcp: drop argument port from =

mptcp_pm_announce_...

1443206  [mptcp-next,3/3] mptcp: remove unneeded check on first subflow
1443203  [mptcp-next,2/3] mptcp: add active MPC mibs
1443205  [mptcp-next,1/3] mptcp: add mib for token creation fallback

1443197  [v2] mptcp: reset 'first' and ack_hint on subflow close

1442415  [mptcp-net] mptcp: fix memory accounting on allocation error

1441980  [v5,mptcp-next,3/3] selftests: mptcp: signal addresses testcases
1441979  [v5,mptcp-next,2/3] mptcp: move to next addr when subflow =

creation fa...
1441978  [v5,mptcp-next,1/3] mptcp: export lookup_anno_list_by_saddr

1441703  [iproute2-next] mptcp: add support for port based endpoint:
     - we don't maintain a local iproute2 fork.

1441645  [mptcp-net] mptcp: do not wakeup listener for MPJ subflows

1441518  [v2,mptcp-next] mptcp: free resources when the port number is =

mismatc...

1441510  [v2,mptcp-next] Squash to "mptcp: add rm_list_tx in mptcp_pm_data"

1441262  mptcp: put subflow sock on connect error




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*


     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1442446  [iproute2-next] mptcp: add support for port based endpoint


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - one less: "mptcp: add mptcp reset option support" :-)
     - WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - WIP

1442954: New: [mptcp-next,1/3] mptcp: add tracepoint for =

mptcp_subflow_get_send
1442956: New: [mptcp-next,2/3] mptcp: add tracepoint for get_mapping_status
1442957: New: [mptcp-next,3/3] mptcp: add tracepoint for =

subflow_check_data_avail:
     - v1 (after RFC): Review needed
     - *@Paolo* : by chance, do you have some time to look at this one? :)


1443422: New: [v2,mptcp-next,1/3] mptcp: unify RM_ADDR and RM_SUBFLOW =

receiving
1443423: New: [v2,mptcp-next,2/3] mptcp: skip closing the initial subsocket
1443424: New: [v2,mptcp-next,3/3] DO-NOT-MERGE: mptcp: remove id 0 test:
     - v2: Review needed
     - to remove id 0 address: if we receive ID 0
     - but not to send RM_ADDR with ID 0
     - *@Mat* would like to do some experiments

1443967: New: [mptcp-next,1/3] selftests: mptcp: launch mptcp_connect =

with timeout
1443970: New: [mptcp-next,2/3] selftests: mptcp: init nstat history
1443968: New: [mptcp-next,3/3] selftests: mptcp: dump more info on =

mpjoin errors:
     - v1: Review needed



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 166)

   169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a =

different port [enhancement] [packetdrill]:
       - linked to #54 =E2=86=92 just to split kernel dev and packetdrill v=
alidation

   168  [syzkaller] WARNING in dst_release [bug] [syzkaller]:
       - no repro yet

   167  packetdrill: add coverage for RM_ADDR [enhancement] =

[packetdrill] @dcaratti:
       - also to split kernel dev and packetdrill validation


     Bugs (opened, flagged as "bug" and assigned)

   160  `./mptcp_connect.sh -m mmap` test blocks [bug] @matttbe:
       - can be closed because dup of  #146
       - we can wait for "selftests: mptcp: launch mptcp_connect with =

timeout"

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - Mat is working on it


     Bugs (opened and flagged as "bug" and not assigned)

   168  [syzkaller] WARNING in dst_release [bug] [syzkaller]
   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is =

provided [bug]
   156  [syzkaller] WARNING: refcount bug in __tcp_transmit_skb [bug] =

[syzkaller]
   153  [syzkaller] WARNING: refcount bug in mptcp_incoming_options =

[bug] [syzkaller]
   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]

   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]:
       - Maybe move these 3 in "features"?
       - WDYT?


     In Progress (opened and assigned)

   167  packetdrill: add coverage for RM_ADDR [enhancement] =

[packetdrill] @dcaratti:
       - see above

   166  iproute2: ADD_ADDR: ports support [enhancement] [iproute2] @pabeni
       - patch has been sent, should we close?

   158  iproute2: change backup mode (MP_PRIO) for active connections =

[enhancement] [iproute2] @dcaratti
   142  packetdrill: support injecting ADD_ADDR echo bit [enhancement] =

[packetdrill] @dcaratti

   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang:
       - remaining bit: remove addr with ID 0 (+ packetdrill, see #167)

   134  Checksum support [enhancement] @geliangtang:
       - good progress from Geliang!

   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
       - See patches avove

    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe

    53  MP_TCPRST support [enhancement] @fw-strlen:
        - kernel code in the tree!
        - packetdrill almost merged =E2=86=92 see below
        - iproute2 support needed? =E2=86=92 no except for Netlink events? =
yes, =

needs 4 lines patch, will send it soon
        - Wireshark / TCPDump doesn't understand option subtype 8

    52  MP_FAIL support [enhancement] @geliangtang


     Recently closed (since last week)

   165  Intermittent copyfd_io_poll: poll timed out in mptcp_join.sh =

[bug] @pabeni
   164  unexpected poll() wakeup on incoming MP_JOIN [bug] @pabeni
   151  Only 1 ADD_ADDR has been sent when signalling multi invalid =

addresses [bug] @geliangtang
   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
    54  ADD_ADDR: ports support [enhancement] @geliangtang




FYI: Current Roadmap:
     - Has been updated!

     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): =

https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Wiki pages have been updated:
     - Updated Changelog: =

https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog
     - Reworked: https://github.com/multipath-tcp/mptcp_net-next/wiki/Status
     - old part of "Status" has been archived: =

https://github.com/multipath-tcp/mptcp_net-next/wiki/%5Barchived%5D-Status



Patches to send to netdev:
     - net:
         - some patches had conflicts when Paolo tried to send them last =

week
         - but now, -net has been sync with net-next, they should apply =

without conflicts
         - note: a few patches from our tree are already in -net but not =

in net-next yet.
         - Maybe easier to wait for net-next to sync with -net and then =

send the patches we have in our tree that are for -net

     - net-next:
         - net-next is closed for the moment


Extra tests:
     - news about Syzkaller? (Christoph):
         - no other news that what was shared on github
         - syzkaller still running

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - no update but tests are still running and more stable!
         - all good then

     - packetdrill (Davide):
         - https://github.com/multipath-tcp/packetdrill/pull/44 :
             - @Paolo: OK for you?

         - https://github.com/multipath-tcp/packetdrill/pull/45 =E2=86=92 t=
o be =

validated with last kernel:
             - just merged

         - https://github.com/multipath-tcp/packetdrill/pull/46 =E2=86=92 i=
s it =

OK to receive a ADD_ADDR+echo before "fully established":
             - @Christoph if you can look at the question please? :)
             - Link: =

https://github.com/multipath-tcp/packetdrill/pull/46/files/4eeb961b47a2f2bc=
70ad24016c7df78fd356bf8d..45baee8a3ea66a8042eb2747ae0a34fc17770265#r5821823=
14

     - CI (Matth):
         - more stable
         - still looking at using GH Action
         - + cirrus-ci
         - + patchew
         - + kernelci
         - :)



Development statistics for the 5.11 kernel:
     - https://lwn.net/Articles/845831/
     - 2 members are cited!
     - "Paolo Abeni and Florian Westphal both worked on the mostly =

under-the-radar upstreaming of the multipath TCP code, which has been =

long in coming."
     - Nice work guys!



TopGit tree:
     - proposition to add dedicated topics (commits) to structure the tree:
         - [DO-NOT-MERGE] net-next =E2=86=92 "below" is net-next
         - [DO-NOT-MERGE] fixes-for-net =E2=86=92 "below" is commits for -n=
et
         - [DO-NOT-MERGE] fixes-for-net-next =E2=86=92 "below" is commits f=
ixing =

issues in net-next (but not in -net)
         - [DO-NOT-MERGE] features-for-net-next =E2=86=92 "below" is commit=
s =

adding new features (or small fixes) for net-next only
     - sounds good and helpful!
     - best to wait for net-next to sync with net before doing that!



BPF patches:
     - Maybe best to park them?
     - WDYT?
     - not really had to keep them there, not impacting MPTCP code, will =

see if they cause more issues



Next meeting:
     - On Thursday, the 4th of March.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210304



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4807912042910304844==--
