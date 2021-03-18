Content-Type: multipart/mixed; boundary="===============0195868231289441811=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 18th of March 2021
Date: Thu, 18 Mar 2021 18:22:46 +0100
Message-ID: <3781fd70-ab60-529b-a877-adc0b41c87fb@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8210

--===============0195868231289441811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 140th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Florian (RedHat), Geliang (Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     netdev (if mptcp ML is in cc) (Dan Carpenter, Jakub Kicinski, Mat =

Martineau (commits from Geliang)):

1454873  [net] ipv6: weaken the v4mapped source check

1452443  [net-next,11/11] selftests: mptcp: add testcases for removing =

addrs
1452442  [net-next,10/11] selftests: mptcp: set addr id for removing =

testcases
1452440  [net-next,09/11] selftests: mptcp: add invert argument for =

chk_rm_nr
1452441  [net-next,08/11] mptcp: remove a list of addrs when flushing
1452439  [net-next,07/11] mptcp: remove multi addresses and subflows in PM
1452437  [net-next,06/11] mptcp: remove multi subflows in PM
1452438  [net-next,05/11] mptcp: remove multi addresses in PM
1452432  [net-next,04/11] mptcp: add rm_list_rx in mptcp_pm_data
1452434  [net-next,03/11] mptcp: add rm_list in mptcp_options_received
1452433  [net-next,02/11] mptcp: add rm_list_tx in mptcp_pm_data
1452436  [net-next,01/11] mptcp: add rm_list in mptcp_out_options

1452414  [net] selftests: mptcp: Restore packet capture option in join =

tests

1451745  [net] mptcp: fix bit MPTCP_PUSH_PENDING tests
   - Accepted: =

https://patchwork.kernel.org/project/netdevbpf/patch/YEsbGCmx4Jh3fApi(a)mwa=
nda/

1451662  [RFC,mptcp-backport] mptcp: fix DATA_FIN generation on early =

shutdown


     our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):

1453677  [v2,mptcp-next,3/3] mptcp: rename mptcp_pm_nl_add_addr_send_ack
1453676  [v2,mptcp-next,2/3] mptcp: send ack for rm_addr
1453674  [v2,mptcp-next,1/3] mptcp: drop useless addr_signal clear

1453673  [v2,mptcp-next] Squash to "mptcp: remove id 0 address"

1452398  [net] mptcp: fix ADD_ADDR HMAC in case port is specified

1452131  [mptcp-next] selftests: mptcp: avoid calling pm_nl_ctl with bad IDs

1451760  [mptcp-next] Squash to "mptcp: clean-up the rtx path"




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*


     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - WIP

1442954: Needs Review / ACK: [mptcp-next,1/3] mptcp: add tracepoint for =

mptcp_subflow_get_send
1442956: Needs Review / ACK: [mptcp-next,2/3] mptcp: add tracepoint for =

get_mapping_status
1442957: Needs Review / ACK: [mptcp-next,3/3] mptcp: add tracepoint for =

subflow_check_data_avail:
     - Needs review
     - *@Paolo* : would you have a chance to look at them please? :)
     - Geliang has some modifications on his side, a v2 is in preparation

1450494: RFC: [RFC,1/2] mptcp: DSS checksum support
1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support:
     - Mat has already commented the first one
     - It is on *Mat* 's TODO list for the 2nd one

1454533: New: [v3,mptcp-next,1/7] mptcp: move flags and ifindex out of =

mptcp_addr_info
1454534: New: [v3,mptcp-next,2/7] mptcp: use mptcp_addr_info in =

mptcp_out_options
1454535: New: [v3,mptcp-next,3/7] mptcp: drop OPTION_MPTCP_ADD_ADDR6
1454536: New: [v3,mptcp-next,4/7] mptcp: use mptcp_addr_info in =

mptcp_options_received
1454537: New: [v3,mptcp-next,5/7] mptcp: drop MPTCP_ADDR_IPVERSION_4/6
1454538: New: [v3,mptcp-next,6/7] mptcp: unify add_addr(6)_generate_hmac
1454539: New: [v3,mptcp-next,7/7] selftests: mptcp: add the net device =

name testcase:
     - series: "refactor mptcp_addr_info and cleanups"
     - *Mat* is looking at v3

1454857: New: [mptcp-next,1/9] mptcp: add skeleton to sync msk socket =

options to subflows
1454858: New: [mptcp-next,2/9] mptcp: setsockopt: handle SO_KEEPALIVE =

and SO_PRIORITY
1454859: New: [mptcp-next,3/9] mptcp: setsockopt: handle receive/send =

buffer and device bind
1454860: New: [mptcp-next,4/9] mptcp: setsockopt: support SO_LINGER
1454861: New: [mptcp-next,5/9] mptcp: setsockopt: add SO_MARK support
1454862: New: [mptcp-next,6/9] mptcp: setsockopt: add SO_INCOMING_CPU
1454863: New: [mptcp-next,7/9] mptcp: setsockopt: SO_DEBUG and no-op =

options
1454864: New: [mptcp-next,8/9] mptcp: sockopt: add TCP_CONGESTION
1454865: New: [mptcp-next,9/9] mptcp: sockopt: handle TCP_INFO:
     - series: "initial SOL_SOCKET support"
     - the sync part might be a bit complex but it is complex :)

1455059: New: [v2,mptcp-next] Squash to "bpf:selftests: add MPTCP test =

base":
     - *Matt* will have a look at the v2




Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 171)

   174  [syzkaller] memory leak in tcp_md5_do_add [bug] [syzkaller]:
       - Christoph is trying  to reproduce it again with the latest =

export branch

   173  "remove invalid addresses" testcase fail [bug] @geliangtang:
       - Fixed, can be closed =E2=86=92 TODO Matth =E2=86=92 Done

   172  WARNING in sk_stream_kill_queues [bug]:
       - Different from a previous one (#136) even if the title is the same


     Bugs (opened, flagged as "bug" and assigned)

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau


     Bugs (opened and flagged as "bug" and not assigned)

   174  [syzkaller] memory leak in tcp_md5_do_add [bug] [syzkaller]:
       - see above

   172  WARNING in sk_stream_kill_queues [bug]
   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is =

provided [bug]
   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]

   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
       - can be closed =E2=86=92 Done

   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   167  packetdrill: add coverage for RM_ADDR [enhancement] =

[packetdrill] @dcaratti
   158  iproute2: change backup mode (MP_PRIO) for active connections =

[enhancement] [iproute2] @dcaratti
   134  Checksum support [enhancement] @geliangtang
   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    53  MP_TCPRST support [enhancement] @fw-strlen
    52  MP_FAIL support [enhancement] @geliangtang


     Recently closed (since last week)

   170  possible deadlock in ipv6_sock_mc_close [bug] [syzkaller] @pabeni



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): =

https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - nothing to send

     - net-next:
         - Maybe sockopt allowance list by Paolo?:
             - Or do we want to wait to have syzkaller exercising them more?
             - Or better to expose it to netdev ASAP?
             - *@Paolo* : what do you think? :)

         - If not, there are more patches in the tree: "mptcp: clean-up =

the rtx path" + patches from Geliang related to ADD/REM_ADDR



Backports:
     - [5.11] mptcp: fix missing wakeup
     - [5.10-5.11] mptcp: reset last_snd on subflow close



sockopt allowance list:
     - What to do for -net and maybe stable branches?
     - Should we send the 3 patches to -net to have something close to =

net-next and ease future backports/maintenance?
     - Or only blacklist the MCast sockopts?
     - *@Paolo* : what do you think? :)



Extra tests:
     - news about Syzkaller? (Christoph):
         - re-running on latest export branch
         - now with debug kernel options =E2=86=92 we can close ticket #119

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Some incidents this WE not related to us
         - Builds are running but not all selftests are validated, not =

sure why :)

     - packetdrill (Davide):
         - Davide added coverage for `ADD_ADDR` with port support
         - Might be difficult to add support for MP_JOIN on another port =

than the default one =E2=86=92 to be checked

     - CI (Matth):
         - automated the resolution of conflicts when a bunch of commits =

from the tree have been accepted upstream
         - (resolution was easy to deal with but doing that manually can =

be a source of issue + delay, etc.)



ML:
     - Switch to lists.linux.dev?
     - https://www.kernel.org/lists-linux-dev.html
     - we could have archives located at lore (some tools depends on it)
     - maybe good to switch for:
         - the visibility
         - spam
         - lists.01.org is not heavily maintained
         - maybe we can move subscribers to it?
     - Mat is going to send an email to the current ML

     - We could have some auto-replies on the lists.01.org for people =

using a version having the previous address.

     - maybe we might switch to patchwork.kernel.org as well?
     - We don't really need to switch to patchwork.kernel.org but if it =

is easier/preferred, why not.



Netdev:
     - 0x15 next summer (July): =

https://netdevconf.info/0x15/submit-proposal.html
     - Might be a remote conf only



Next meeting:
     - On Thursday, the 25th of March.
     - /!\ *New* usual UTC time: 15:00 UTC (8am PDT, 4pm CET, 11pm CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210325



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0195868231289441811==--
