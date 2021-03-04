Content-Type: multipart/mixed; boundary="===============2498742322693551013=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 4th of March 2021
Date: Thu, 04 Mar 2021 18:40:19 +0100
Message-ID: <8a568102-5ff5-f7c1-e234-46f523d5cafc@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8026

--===============2498742322693551013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 138th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     netdev (if mptcp ML is in cc) (Paolo Abeni):

1442446  [iproute2-next] mptcp: add support for port based endpoint


     our repo (by: Matthieu Baerts):

1443968  [mptcp-next,3/3] selftests: mptcp: dump more info on mpjoin errors
1443970  [mptcp-next,2/3] selftests: mptcp: init nstat history
1443967  [mptcp-next,1/3] selftests: mptcp: launch mptcp_connect with timeou



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*


     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Davide Caratti, Florian Westphal, Geliang Tang, Mat =

Martineau, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h:
     - WIP

1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1426554: Changes Requested: [PATCH,iproute2] mptcp: add support for =

event monitoring:
     - WIP

1442954: Needs Review / ACK: [mptcp-next,1/3] mptcp: add tracepoint for =

mptcp_subflow_get_send
1442956: Needs Review / ACK: [mptcp-next,2/3] mptcp: add tracepoint for =

get_mapping_status
1442957: Needs Review / ACK: [mptcp-next,3/3] mptcp: add tracepoint for =

subflow_check_data_avail:
     - *Paolo* will have a look at this series (probably not this week)

1446805: RFC: [RFC,v2,1/2] mptcp: only admit explicitly supported sockopt
1446803: RFC: [RFC,v2,2/2] mptcp: revert "mptcp: provide subflow aware =

release function"$ ....$:
     - (mainly for patch 1)
     - For the moment we allow sockopt that does not crash the system
     - Some are NOOP for TCP, we imitate that
     - For some (e.g. buf related) makes sense on subflows but not the =

MPTCP socket
     - Should we start with this long(ish) list or a shorter one?

     - Florian:
         - was looking at supporting sockopt for subflows coming later but
         - but not obvious, sockopt can come from userspace and kernel, =

we cannot deal with them the same way
         - maybe best to move this to a new file not to have a huge list =

in protocol.c which is already (too) big

     - About copying data to new outgoing/incoming subflows:
         - having a new helper
         - keeping a list
         - not using a workqueue?:
             - to avoid "out of sync". Is it possible to avoid? We need =

sync here or it would have an impact on TCP code (to allow reading =

without locks) + complexity
             - perf impact?
             - process context needed to copy data from userspace
         - *Paolo* will start a new thread of discussion

1446833: Changes Requested: [net] mptcp: fix length of ADD_ADDR with =

port suboption:
     - v2 in preparation =E2=86=92 just sent
     - affecting all ADD_ADDR with ports (with and without echo bit)

1446930: Awaiting Upstream: [mptcp-net] selftests: mptcp: Restore packet =

capture option in join tests:
     - TODO: to be applied (once *Matth* has finished modifying the tree)
     - reviewed by Geliang

1447130: New: [mptcp-next,1/6] Squash to "mptcp: add rm_list in =

mptcp_out_options"
1447132: New: [mptcp-next,2/6] Squash to "mptcp: add rm_list_tx in =

mptcp_pm_data"
1447133: New: [mptcp-next,3/6] Squash to "mptcp: add rm_list in =

mptcp_options_received"
1447134: New: [mptcp-next,4/6] Squash to "mptcp: add rm_list_rx in =

mptcp_pm_data"
1447135: New: [mptcp-next,5/6] Squash to "mptcp: remove multi subflows =

in PM"
1447136: New: [mptcp-next,6/6] Squash to "mptcp: remove multi addresses =

and subflows in PM":
     - was a patch in the v5 of the following series
     - to avoid passing a structure but just a pointer
     - better to squash than creating a new commit on top to fix =

previous patches

1447188: New: [v6,mptcp-next,1/5] mptcp: remove all subflows involving =

id 0 address
1447190: New: [v6,mptcp-next,2/5] mptcp: unify RM_ADDR and RM_SUBFLOW =

receiving
1447191: New: [v6,mptcp-next,3/5] mptcp: remove id 0 address
1447192: New: [v6,mptcp-next,4/5] selftests: mptcp: add addr argument =

for del_addr
1447193: New: [v6,mptcp-next,5/5] selftests: mptcp: remove id 0 address =

testcases:
     - new v6
     - *Mat* is going to test the whole series first.
     - We will need to modify the IPRoute code too to delete the ID 0: =

we need to specify the ADDR:
         - for ID0, we can have different addresses (it depends on the =

interface)
         - it is different from the other IDs
         - we then need a special case
         - which is done with pm utility in the selftests but not in =

IPRoute2 yet
         - *Geliang* : do you plan to do it? Should we create a new =

ticket for this part?



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 169)

   170  possible deadlock in ipv6_sock_mc_close [bug] [syzkaller] @pabeni:
       - See the discussion with the RFC patches here above


     Bugs (opened, flagged as "bug" and assigned)

   170  possible deadlock in ipv6_sock_mc_close [bug] [syzkaller] @pabeni:
       - See above

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau :
       - packetdrill should help here.
       - *Paolo* can share a packetdrill script
       - (in theory, removing the replied injected (<) by Packetdrill =

and add a new expected (>) packetdrill sent by the kernel after a few ms)

       - Note: for the moment we don't use the TIME_WAIT socket for =

MPTCP. If the very last DATA_FIN ack is lost, it is not retransmitted =

even if the other DATA_FIN is retransmitted:
           > DATA_FIN
           < X lost DATA_FIN ack
           > DATA_FIN
           / =E2=86=92 nothing
       - =E2=86=92 should be handled separately


     Bugs (opened and flagged as "bug" and not assigned)

   168  [syzkaller] WARNING in dst_release [bug] [syzkaller]:
       - Not happening for at least a week
       - Should be fixed thanks to a patch from Florian
       - TODO: can be closed then =E2=86=92 Done

   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is =

provided [bug]

   156  [syzkaller] WARNING: refcount bug in __tcp_transmit_skb [bug] =

[syzkaller]
       - Not happening for at least a week
       - Should be fixed thanks to a patch from Florian
       - TODO: can be closed then =E2=86=92 Done

   153  [syzkaller] WARNING: refcount bug in mptcp_incoming_options =

[bug] [syzkaller]
       - Not happening for at least a week
       - Should be fixed thanks to a patch from Florian
       - TODO: can be closed then =E2=86=92 Done

   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]

   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]:
       - Was not seen because kmemleak had been temp disabled
       - *Christoph* can re-enable it to check if it is still there

   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   167  packetdrill: add coverage for RM_ADDR [enhancement] =

[packetdrill] @dcaratti

   166  iproute2: ADD_ADDR: ports support [enhancement] [iproute2] @pabeni:
       - TODO: Can be closed =E2=86=92 Done

   158  iproute2: change backup mode (MP_PRIO) for active connections =

[enhancement] [iproute2] @dcaratti
   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang
   134  Checksum support [enhancement] @geliangtang
   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    53  MP_TCPRST support [enhancement] @fw-strlen
    52  MP_FAIL support [enhancement] @geliangtang


     Recently closed (since last week)

   165  Intermittent copyfd_io_poll: poll timed out in mptcp_join.sh =

[bug] @pabeni
   160  `./mptcp_connect.sh -m mmap` test blocks [bug] @matttbe
   151  Only 1 ADD_ADDR has been sent when signalling multi invalid =

addresses [bug] @geliangtang
   142  packetdrill: support injecting ADD_ADDR echo bit [enhancement] =

[packetdrill] @dcaratti
    54  ADD_ADDR: ports support [enhancement] @geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): =

https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - 1ba62b635bbd mptcp: free resources when the port number is =

mismatched
         - a6357ff02125 mptcp: fix missing wakeup
         - 94dda66a8653 mptcp: fix race in release_cb
         - 1318d54d7d3b mptcp: factor out __mptcp_retrans helper()
         - 2686750409a2 mptcp: reset 'first' and ack_hint on subflow close
         - 5c4c3a378e76 mptcp: dispose initial struct socket when its =

subflow is closed
         - 92498a4f2073 mptcp: fix memory accounting on allocation error
         - 78ef8ee57c8a mptcp: put subflow sock on connect error
         - 193adf5acf56 mptcp: reset last_snd on subflow close:

         - *Mat* is going to send them now that netdev ML (vger) seems =

working fine again

     - net-next:
         - /



Issues with vger:
     - Any idea how to know when there are issues with =

http://vger.kernel.org/ ?
     - Any other channel to follow to know when it is broken? (apart =

from looking at non received emails :) )



Extra tests:
     - news about Syzkaller? (Christoph):
         - See above (Github section)

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Build steps are going OK
         - There was an internal issue with archiving but on MPTCP side, =

everything seems OK

     - packetdrill (Davide):
         - Davide working on ADD_ADDR+port and RM_ADDR
         - Davide added support for injecting ADD_ADDR echo (with =

explicit "addr_echo" keyword)

     - CI (Matth):
         - Is it OK to sync with net-next and push without compiling the =

tree if there is no conflict?
         - Goal: to decouple CI tasks:
             - sync with upstream (or export in case of changes in the =

tree) =E2=86=92 re-create "export"
             - validate build (+ sparse) of each commit of the export branch
             - validate build (+ sparse) of any branch ("PR")
         - Reason: We can only have 2 cores per job but have multiple =

jobs in parallel
         - Seems OK: devs can use previous tags if the last version is =

broken
         - If really it is an issue: deal with a temporary task and =

publish at the end. (increasing a bit the total time if we need to =

re-clone a full repo again)
         - GH Action in progress
         - Next: KVM tests
         - Next: patchew (or start that in parallel once we are really =

to validate one commit/series with GH Action?)


Checksum support:
     - enabled by default?
     - NIC offload?:
         - check with NIC vendors? (Intel, Mellanox, Broadcom, =

Netronome, etc.?)
     - checksum cover the whole data and could be split in different =

packets (linked to DSS coverage)
     - maybe difficult to offload that if it is on multiple packets...
     - maybe we could have a mix: some done by NIC, some by kernel?
     - *Mat* can contact people at Intel



net stable:
     - FYI: Netdev maintainers are no longer selecting patches for stable.
     - We can cc stable if needed
     - =

https://patchwork.kernel.org/project/netdevbpf/patch/20210303024643.1076846=
-1-kuba(a)kernel.org/



One patch didn't apply on stable:
     - Only Mat and Paolo were in cc (+stable ML)
     - "mptcp: fix DATA_FIN generation on early shutdown" patch
     - *Mat* / *Paolo* : check what to do



mptcpd:
     - Paolo was looking at 0.6 version
     - Maybe an issue with "endpoint": they are created any flags =

(MPTCP_PM_ADDR_ATTR_FLAGS):
         - MPTCP_PM_ADDR_FLAG_SIGNAL
         - MPTCP_PM_ADDR_FLAG_SUBFLOW
         - MPTCP_PM_ADDR_FLAG_BACKUP
     - Endpoints are created and are visible but will not be used to =

create and accept new subflows
     - From Ossama to *Paolo* : were you referring to the two existing =

plugins passing a dummy zero flags value to the add_addr command? =

Assuming that is the case, you're indeed correct.  Both plugins need =

some work.



Next meeting:
     - On Thursday, the 11th of March.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210311



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2498742322693551013==--
