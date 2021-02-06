Content-Type: multipart/mixed; boundary="===============5329926830437543286=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 4th of February 2021
Date: Sat, 06 Feb 2021 12:57:16 +0100
Message-ID: <d80aeb90-a16c-e031-6d50-a8ca94968a06@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7661

--===============5329926830437543286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 134th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     netdev (if mptcp ML is in cc) (Mat Martineau (author: Geliang)):

1434370  [net-next,v2,15/15] selftests: mptcp: add testcases for =

ADD_ADDR with...
1434369  [net-next,v2,14/15] mptcp: add the mibs for ADD_ADDR with port
1434367  [net-next,v2,13/15] selftests: mptcp: add port argument for =

pm_nl_ctl
1434368  [net-next,v2,12/15] mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in =

PM ne...
1434366  [net-next,v2,11/15] mptcp: enable use_port when invoke =

addresses_equal
1434364  [net-next,v2,10/15] mptcp: add port number check for MP_JOIN
1434365  [net-next,v2,09/15] mptcp: add a new helper =

subflow_req_create_thmac
1434361  [net-next,v2,08/15] mptcp: drop unused skb in =

subflow_token_join_requ...
1434362  [net-next,v2,07/15] mptcp: create the listening socket for new =

port
1434363  [net-next,v2,06/15] selftests: mptcp: add testcases for newly =

added a...
1434360  [net-next,v2,05/15] selftests: mptcp: use minus values for =

removing a...
1434359  [net-next,v2,04/15] mptcp: send ack for every add_addr
1434357  [net-next,v2,03/15] mptcp: create subflow or signal addr for =

newly ad...
1434355  [net-next,v2,02/15] mptcp: drop *_max fields in mptcp_pm_data
1434356  [net-next,v2,01/15] mptcp: use WRITE_ONCE for the pernet *_max

1432926  [net-next,v3] mptcp: fix length of MP_PRIO suboption:
     - @Davide, do not forget to add mptcp ML in cc ;-)


     our repo (by: Davide Caratti, Florian Westphal, Geliang Tang, Paolo =

Abeni):

1434862  [3/3] mptcp: move subflow close loop after sk close check
1434861  [2/3] mptcp: skip MPTCP_EVENT_SUB_CLOSED event when mptcp =

socket isn'...
1434860  [1/3] mptcp: schedule worker when subflow is closed

1434271  [mptcp-next,2/2] mptcp: fix poll after shutdown
1434268  [mptcp-next,1/2] mptcp: deliver ssk errors to msk

1433763  [mptcp-next] Squash to "mptcp: use WRITE_ONCE/READ_ONCE for the =

perne...

1432926  [net-next,v3] mptcp: fix length of MP_PRIO suboption



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - WIP

1431688: Changes Requested: [RFC,mptcp-next,1/6] mptcp: add tracepoints =

for data operations
1431689: Changes Requested: [RFC,mptcp-next,2/6] mptcp: add echo field =

in mptcp_out_options
1431690: Changes Requested: [RFC,mptcp-next,3/6] mptcp: add tracepoints =

for options operations
1431691: Changes Requested: [RFC,mptcp-next,4/6] mptcp: add =

mptcpi_local_addr_* in mptcp_info
1431692: Changes Requested: [RFC,mptcp-next,5/6] mptcp: add tracepoints =

for PM operations
1431693: Changes Requested: [RFC,mptcp-next,6/6] mptcp: add tracepoints =

for subflow operations:
     - looks good
     - we should remove the number of tracepoints
     - remove after some pr_debug (high freq)
     - and not modify the uAPI

1434486: New: [v3,mptcp-next,1/9] mptcp: use rm_ids array in =

mptcp_out_options
1434487: New: [v3,mptcp-next,2/9] mptcp: use rm_ids_tx array in =

mptcp_pm_data
1434488: New: [v3,mptcp-next,3/9] mptcp: use rm_ids array in =

mptcp_options_received
1434490: New: [v3,mptcp-next,4/9] mptcp: use rm_ids_rx array in =

mptcp_pm_data
1434489: New: [v3,mptcp-next,5/9] mptcp: remove multi addresses in PM
1434491: New: [v3,mptcp-next,6/9] mptcp: remove multi subflows in PM
1434493: New: [v3,mptcp-next,7/9] mptcp: remove multi addresses and =

subflows in PM
1434494: New: [v3,mptcp-next,8/9] mptcp: remove a list of addrs when =

flushing
1434495: New: [v3,mptcp-next,9/9] selftests: mptcp: add testcases for =

removing addrs:
     - RM_ADDR: remove a list of addrs
     - Mat is double-checking the modification in the locking base =

(patches 7 & 8)
     - Feel free to look at these patches
     - it is allowed to send a REMOVE_ADDR for id 0
     - the address of the initial subflow has by definition the id 0
     - in theory, we should check that the REMOVE_ADDR is "valid": we =

*should* (but not must) make sure the address is no longer reachable, =

just in case this RM_ADDR was injected.

1435084: New: [v3,mptcp-next] mptcp: add local addr info in mptcp_info:
     - TODO: Matth: to be applied =E2=86=92 Done

1435390: New: [mptcp-net,v2] mptcp: fix spurious retransmissions:
     - Coffee is getting cold
     - Syzkaller didn't repro the issue so far, looks good
     - linked to #126
     - Needs review =E2=86=92 Done

1435423: New: [mptcp-net] mptcp: init mptcp request socket earlier:
     - v2 is required to fix a compile warning
     - linked to #125 and maybe #130
     - Needs review =E2=86=92 Done

1435866: New: [mptcp-next,1/2] mptcp: move to next addr when subflow =

creation fail
1435867: New: [mptcp-next,2/2] selftests: mptcp: signal addresses testcases:
     - linked to #151
     - Needs review



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 146)

   151  Only 1 ADD_ADDR has been sent when signalling multi invalid =

addresses [enhancement] @geliangtang:
       - The first part is a bug. For the enhancement, this can be done =

in another ticket maybe?
       - should be fixed with "move to next addr and testcases" series =

from Geliang

   150  remove completely workqueue usage [enhancement]:
       - best to use the delegate action infrastructure
       - would be good to measure the connection rate before to see the =

evolution after

   149  iproute2: ss wrongly reports MPTCP sockets for kernel 5.7 =E2=86=92=
 5.9 =

[bug] [iproute2]:
       - TODO: Matth: check if we can use the protocol in the reply
           =E2=86=92 done: no proto in the reply (and would be on 8-bit)
       - Maybe we can check for something related to MPTCP in /proc
           =E2=86=92 done: nothing specific to MPTCP

   148  SYNRX: MPTCP -> MPTCP: expect x, got y [bug]:
       - if y > x, it's certainly OK =E2=86=92 retransmission?
       - We should certainly update the message (to say it can happen)
       - And print it on the next line
       - And mark the test as failed if it is lower
       - TODO: Matth: report that in the ticket =E2=86=92 Done

   147  copyfd_io_poll: poll timed out: race/bug with poll wakeup [bug]:
       - TODO: Matth: put somewhere we should print more info from ss in =

case of issue + nstat =E2=86=92 it was useful =E2=86=92 Done by Paolo
       - Paolo checked a bit: the sender doesn't react properly to a =

received ACK
       - To be investigated more to know why =E2=86=92 Paolo is going to lo=
ok at =

this one


     Bugs (opened, flagged as "bug" and assigned)

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - maybe it can help to use the "delegated action" feature, see #150

   126  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller] =

@dcaratti:
       - Paolo sent a patch for that

   112  sporadic failure of mptcp_join.sh selftest 13 [bug] @dcaratti
       - fixed in the other distro?


     Bugs (opened and flagged as "bug" and not assigned)

   149  iproute2: ss wrongly reports MPTCP sockets for kernel 5.7 =E2=86=92=
 5.9 =

[bug] [iproute2]:
       - TODO Assign Matth =E2=86=92 Done

   148  SYNRX: MPTCP -> MPTCP: expect x, got y [bug]:
       - TODO Assign Matth =E2=86=92 Done

   147  copyfd_io_poll: poll timed out: race/bug with poll wakeup [bug]:
       - TODO Assign Paolo =E2=86=92 Done

   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]

   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] =

[syzkaller]:
       - TODO Assign Paolo =E2=86=92 Done

   125  [syzkaller] KASAN: wild-memory-access Write in =

subflow_req_destructor [bug] [syzkaller]:
       - TODO Assign Paolo =E2=86=92 Done

   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   151  Only 1 ADD_ADDR has been sent when signalling multi invalid =

addresses [enhancement] @geliangtang
   142  packetdrill: support injecting ADD_ADDR echo bit [enhancement] =

[packetdrill] @dcaratti
   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang
   134  Checksum support [enhancement] @geliangtang
   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
    60  PM: netlink: events per connection [enhancement] @fw-strlen
    54  ADD_ADDR: ports support [enhancement] @geliangtang
    51  MP_PRIO support [enhancement] @geliangtang


     Recently closed (since last week)

   145  EADDRINUSE even if SO_REUSEADDR is set [bug] @pabeni
   135  [syzkaller] WARNING in __mptcp_destroy_sock [bug] [syzkaller]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.12): =

https://github.com/multipath-tcp/mptcp_net-next/projects/7
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - 3 groups:
             - refactor of mptcp_join.sh from Geliang: can be sent

             - Florian patches:
                 - best to wait for the validation with mptcpd
                 - Could be good to check the perf impact
                 - do we send events if there is no subscribers?
                 - on a busy server, we could have a lot of new =

connections and a lot of events, we might miss some of them if buffer is =

not big enough
                 - on mptcp.org, it is possible for the uspace to put a =

filter to only receive some events but it only works if there is one =

subscriber... =E2=86=92 "one to many" messages

             - fixes from Paolo

         - =E2=86=92 they can be sent in //, not conflicting apparently but=
 to =

be checked

         =E2=86=92 Mat is going to send mptcp_join.sh refactor + "mptcp: pm=
: add =

lockdep assertions" =E2=86=92 Done



Extra tests:
     - news about Syzkaller? (Christoph):
         - =E2=86=91 see GH

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - some issues but was not due to MPTCP and now running again
         - a few net selftests are failing
         - Mat will check if it is not related to our modifications (but =

not easy because there is no list for net-next)

     - packetdrill (Davide):
         - new alignment proposition:
             https://github.com/multipath-tcp/packetdrill/pull/40
             =E2=86=92 feel free to comment there if we should go in this d=
irection
         - New tests \o/
         - Smoke tests for MP_PRIO
         - TODO: Matth: create a dedicated ticket for "MP_PRIO support" =

for iproute

     - CI (Matth):
         - most public CI doesn't support KVM (nested VM)
         - Except cirrus-ci: https://cirrus-ci.org/faq/#are-there-any-limits
         - We could use this one for selftests (+packetdrill, kunit, =

etc.) only
         - And GH Action for the builds
         - https://patchew.org =E2=86=92 could be good to launch tests when=
 a =

patch is sent on the ML once the build + test infra is supported



Perf env:
     - Could be good to measure regressions regularly, like what is done =

with VPP project (and other DPDK related ones)
     - If we need to use VM:
         - Avoid "virtio"
         - "virtio-user" can be great but hard to configure properly
         - maybe "virtio-net" with SRIOV?
         - best (if possible) seems to be PCI passthrough
         - ideally VMs on different numa nodes, each with a dedicated =

NIC wired together (back-to-back)
     =E2=86=92 to discuss with Matth if you are interested to help :)



Next meeting:
     - On Thursday, the 11th of February.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210211



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5329926830437543286==--
