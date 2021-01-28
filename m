Content-Type: multipart/mixed; boundary="===============0844016165110400211=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 28th of January 2021
Date: Thu, 28 Jan 2021 18:41:37 +0100
Message-ID: <6e010414-a1f2-8179-1019-b0be2daff867@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7504

--===============0844016165110400211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 133rd meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau (commits from Geliang =

and Matthieu)):

1431345  [net-next,5/5] selftests: increase timeout to 10 min
1431343  [net-next,4/5] selftests: mptcp: add IPv4-mapped IPv6 testcases
1431340  [net-next,3/5] mptcp: pm nl: reduce variable scope
1431341  [net-next,2/5] mptcp: pm nl: support IPv4 mapped in v6 addresses
1431344  [net-next,1/5] mptcp: support MPJoin with IPv4 mapped in v6 sk


     our repo (by: Florian Westphal, Geliang Tang):

1430293  [v3,mptcp-next] mptcp: send ack for every add_addr:
     - changing a bit the behaviour, normal.

1429292  [v2,mptcp-next,5/5] mptcp: add netlink event support
1429320  [v2,mptcp-next,4/5] genetlink: add CAP_NET_ADMIN test for =

multicast b...
1429291  [v2,mptcp-next,3/5] mptcp: avoid lock_fast usage in accept path
1429290  [v2,mptcp-next,2/5] mptcp: pass subflow socket to a few helpers
1429289  [v2,mptcp-next,1/5] mptcp: split __mptcp_close_ssk helper:
     - *Ossama and Mat* are validating it.




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Davide Caratti, Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - Depending on the kernel patches that are being validated by =

Ossama and Mat

1431688: New: [RFC,mptcp-next,1/6] mptcp: add tracepoints for data =

operations
1431689: New: [RFC,mptcp-next,2/6] mptcp: add echo field in =

mptcp_out_options
1431690: New: [RFC,mptcp-next,3/6] mptcp: add tracepoints for options =

operations
1431691: New: [RFC,mptcp-next,4/6] mptcp: add mptcpi_local_addr_* in =

mptcp_info
1431692: New: [RFC,mptcp-next,5/6] mptcp: add tracepoints for PM operations
1431693: New: [RFC,mptcp-next,6/6] mptcp: add tracepoints for subflow =

operations:
     - Tracepoints have been added, we need to double check if they are =

at the right place with the right args as it is difficult to modify
     - Waiting for review (it might take some time to review it because =

of what is said at the previous line)

1432790: Changes Requested: [net-next,v2] net: mptcp: fix length of =

MP_PRIO sub-option:
     - for net-next only
     - small idea of modification sent
     - v3 will be sent later



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 141)

   146  DATA_FIN is not retransmitted on timeout [bug]:
       - Could be reproduced with packetdrill

   145  EADDRINUSE even if SO_REUSEADDR is set [bug]:
       - With the data-fin state machine, we have an issue there
       - Paolo is trying to reproduce the issue with Packetdrill to =

avoid regression

   143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6 =

addresses [enhancement] [packetdrill]:
       - For the moment, some tests are executed in v4 and v4-mapped =

only (suffixed with "v4.pkt")
       - because they are not compatible with v6 only: Packetdrill =

expect to see a v4 address in the ADD_ADDR

   142  packetdrill: support injecting ADD_ADDR echo bit [enhancement] =

[packetdrill] @dcaratti:
       - There are some TODO in the packetdrill scripts: we cannot =

inject ADD_ADDR with echo bit for the moment
       - Davide is looking at that


     Bugs (opened, flagged as "bug" and assigned)

/


     Bugs (opened and flagged as "bug" and not assigned)

   146  DATA_FIN is not retransmitted on timeout [bug]:
       -  assigned to *Mat*

   145  EADDRINUSE even if SO_REUSEADDR is set [bug]:
       - assigned to *Paolo*

   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]:
       - still unstable from time to time

   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]:
       - KFENCE enabled? =E2=86=92 seems not
       - *@Christoph* could you retry with the patch even if KFence is =

not enabled

   135  [syzkaller] WARNING in __mptcp_destroy_sock [bug] [syzkaller]

   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] =

[syzkaller]:
       - Not happening anymore
       - TODO: can be closed =E2=86=92 done

   125  [syzkaller] KASAN: wild-memory-access Write in =

subflow_req_destructor [bug] [syzkaller]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]

   112  sporadic failure of mptcp_join.sh selftest 13 [bug]:
       - *@Davide* may you retry now that we have "mptcp: send ack for =

every add_addr" in our tree?
       - Probably we can close this one!
       - TODO: assign ticket to Davide =E2=86=92 Done

   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

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

   144  Packetdrill: ADD_ADDR are now sent sooner [bug] [packetdrill] =

@matttbe:
       - Due to "mptcp: send ack for every add_addr" but that's normal

   139  selftests: mptcp_join.sh: ADD_ADDR timeout issue [bug] @geliangtang:
       - Thanks to "mptcp: send ack for every add_addr"

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti
       - Not able to repro



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.12): =

https://github.com/multipath-tcp/mptcp_net-next/projects/7
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - All patches related to ADD_ADDR (including accepting MP_JOIN =

on another port)
         - *@Mat* is going to send them



Extra tests:
     - news about Syzkaller? (Christoph):
         - Status has been updated on Github
         - Will look at them again and close the obsolete ones

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - code building fine but automation problems there, not our fault

     - packetdrill (Davide):
         - *Davide* is working on issue 51: adding MP_PRIO support in =

packetdrill

     - covscan:
         - reporting a possible division by 0 on the code that has been =

fixed
         - probably a false positive because it is not a simple "if !=3D =

0" just before but in the path, we make sure it doesn't come with that.

     - CI (Matth):
         - Working on having the tests on GH Actions



Benchmarking:
     - net-next, TCP vs MPTCP
     - much better! ~10% gap compared to plain TCP
     - we scale quite well with multiple subflows, quite linearly =

without CPU bounded
     - with CPU bounded (without zero copy stuff, etc.), adding multiple =

subflows improve perf a bit because the load is spread on multiple =

subflows =E2=86=92 better than plain TCP!
     =E2=86=92 was on baremetal, with loopback and different peers and a co=
uple =

of NICs (=3D=3D 2)

     =E2=86=92 Nice work team! (kudos to *Paolo* for the optimizations and =
the =

very few refactoring changes!)

     - With VM: on virtio xmit/receive is much more costly with MPTCP

     - reducing the lock might help even more! But doesn't seem urgent.
     - could be good to have perf regression tests



mptcpd:
     - New version 0.6 released by Ossama!

     - ChangeLog:
         - Mptcpd now supports versions of the Embedded Linux Library =

(ELL) greater than 0.33.
         - Plugins should use the new MPTCPD_PLUGIN_DEFINE() =

preprocessor macro instead of L_PLUGIN_DEFINE().
         - A pointer to the mptcpd path manager object, i.e. struct =

mptcpd *pm, is now passed to the plugin init and exit functions. This =

allows plugins to potentially perform mptcpd path manager related =

operations during initialization and finalization.
         - Support for the MPTCP netlink path manager in the upstream =

Linux kernel is now available. A new set of path management command =

functions corresponding to those available in the kernel netlink path =

management API has been added to the <mptcpd/path_manager.h> header. The =

new functions allow plugins to retrieve IP address information, flush =

addresses, and modify MPTCP resource limits.
         - The mptcpd_pm_add_addr() (formerly mptcpd_pm_send_addr()) and =

mptcpd_pm_remove_addr() function parameters have been modified in order =

to support both the upstream and multipath-tcp.org kernels.
         - Mptcpd path management command functions declared in =

<mptcpd/path_manager.h> now return zero on success and -1 or an errno on =

failure instead of a bool.
         - A MPTCP address ID manager mptcpd_idm interface was =

introduced that mptcpd plugins may leverage to map an IP address to a =

MPTCP address ID, as well as to track used and unused IDs. The interface =

is defined in the new <mptcpd/id_manager.h> header.
         - A new address advertising plugin, addr_adv, has been added. =

It simply triggers a MPTCP ADD_ADDR when a new IP address is detected by =

the mptcpd network monitor. Similarly, a MPTCP REMOVE_ADDR is triggered =

when an IP address is no longer available.
         - MPTCP netlink command error message logging was improved to =

be more descriptive when possible.

     - Not supporting Netlink events from the upstream kernel (export =

branch only)

     - 0.5.1 will be part of Fedora 34!
     - Hopefully, the update to 0.6.0 would be easier

     - Interaction with Network Manager?:
         - Should be technically possible, ideally with DBus, but not =

planned now



Next meeting:
     - We propose to have the next meeting on Thursday, the 4th of February.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210204



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0844016165110400211==--
