Content-Type: multipart/mixed; boundary="===============1029004212855748789=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 7th of January 2021
Date: Mon, 11 Jan 2021 17:01:32 +0100
Message-ID: <6fab1fe8-5762-78f9-d50e-94376d3d700a@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7311

--===============1029004212855748789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 130th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Davide, Paolo and Florian (RedHat), Geliang (Xiaomi) =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Davide Caratti):

1419214  [net] net: mptcp: cap forward allocation to 1M

     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1418612: RFC: Re: [MPTCP][PATCH v8 mptcp-next 1/8] mptcp: create the =

listening socket for new port:
     - TODO: superseded =E2=86=92 Done

1418702: Changes Requested: [mptcp-next,v4,1/3] mptcp: support MPJoin =

with IPv4 mapped in v6 sk
1418705: Changes Requested: [mptcp-next,v4,2/3] mptcp: pm nl: support =

IPv4 mapped in v6 addresses
1418704: Changes Requested: [mptcp-next,v4,3/3] selftests: mptcp: add =

IPv4-mapped IPv6 testcases:
     - v5 in progress

1419299: Awaiting Upstream: [mptcp-net,1/2] mptcp: more strict state =

checking for acks
1419300: Awaiting Upstream: [mptcp-net,2/2] mptcp: better msk-level =

shutdown.:
     - related to issue 121
     - to be applied

1422350: New: [v9,mptcp-next,1/9] mptcp: create the listening socket for =

new port
1422351: New: [v9,mptcp-next,2/9] mptcp: drop unused skb in =

subflow_token_join_request
1422352: New: [v9,mptcp-next,3/9] mptcp: add a new helper =

subflow_req_create_thmac
1422353: New: [v9,mptcp-next,4/9] mptcp: add port number check for MP_JOIN
1422354: New: [v9,mptcp-next,5/9] mptcp: enable use_port when invoke =

addresses_equal
1422355: New: [v9,mptcp-next,6/9] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1422356: New: [v9,mptcp-next,7/9] selftests: mptcp: add port argument =

for pm_nl_ctl
1422357: New: [v9,mptcp-next,8/9] mptcp: add the mibs for ADD_ADDR with port
1422358: New: [v9,mptcp-next,9/9] selftests: mptcp: add testcases for =

ADD_ADDR with port:
     - *Mat* will have a look

1422370: New: [mptcp-next] selftests: mptcp: add command line arguments =

for mptcp_join.sh:
     - Waiting for reviews

1422827: New: [v4,mptcp-next,1/5] mptcp: use WRITE_ONCE/READ_ONCE for =

the pernet *_max
1422829: New: [v4,mptcp-next,2/5] mptcp: drop *_max fields in mptcp_pm_data
1422830: New: [v4,mptcp-next,3/5] mptcp: create subflow or signal addr =

for newly added address
1422831: New: [v4,mptcp-next,4/5] selftests: mptcp: use minus values for =

removing address numbers
1422832: New: [v4,mptcp-next,5/5] selftests: mptcp: add testcases for =

newly added addresses:
     - New patch 1/5
     - *Mat* will have a look

1422878: New: [mptcp-next,1/5] mptcp: add =

mptcp_pm_should_add_signal_send_ack helper
1422879: New: [mptcp-next,2/5] mptcp: simplify =

mptcp_pm_nl_add_addr_send_ack debug log
1422880: New: [mptcp-next,3/5] mptcp: add a new sysctl add_addr_urgent
1422881: New: [mptcp-next,4/5] mptcp: add urgent status for ADD_ADDR
1422882: New: [mptcp-next,5/5] selftests: mptcp: add add_addr_urgent =

testcases:
     - Waiting for reviews



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last meeting: 129)

   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] =

[syzkaller]:
       - no reproducer

   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang:
       - Geliang is working on it, will share a v1 when it is ready
       - When looking at sendmsg autotuning, a lot of data had to be =

retrieved, not possible with printk(). With the printk(), it was too =

slow and were not able to repro anymore
       - We should also be careful about tracepoint:
           - not too many
           - at the right place
           - changing them in the future is not a good idea so it has to =

be picked wisely
           - with bpftrace, perf, etc. we might not be able to retrieve =

local variables
           - so we should add these tracepoints where these are =

preferred over eBPF/Perf.


     Bugs (opened, flagged as "bug" and assigned)

   126  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller] @dcaratti
   123  sndmsg autotuning is disable [bug] @pabeni
   122  PM doesn't create subflow with IPv4 mapped IPv6 socket [bug] =

@geliangtang
    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti


     Bugs (opened and flagged as "bug" and not assigned)

   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] [syzkaller]
   129  set subflow socket consistently [bug] [enhancement]
   127  [syzkaller] WARNING in corrupted [bug] [syzkaller]
   125  [syzkaller] KASAN: wild-memory-access Write in =

subflow_req_destructor [bug] [syzkaller]
   121  [syzkaller] divide error in __tcp_select_window [bug] [syzkaller]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]

   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]:
       - does this still happen after capping forward allocations to 1M?
       - *Christoph* will test it

   112  sporadic failure of mptcp_join.sh selftest 13 [bug]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe

    60  PM: netlink: events per connection [enhancement] @fw-strlen:
        - =

https://git.breakpoint.cc/cgit/fw/mptcp_net-next.git/commit/?h=3Dnetlink_ev=
ents_02&id=3Dcb5bd8f413dc2f0f95d96896f596e9ef630f3ce9
        - =

https://git.breakpoint.cc/cgit/fw/iproute2.git/commit/?h=3Dmptcp_event_01&i=
d=3D05061ea9abe221e6f8dced11adc532096086415e

    54  ADD_ADDR: ports support [enhancement] @geliangtang
    51  MP_PRIO support [enhancement] @geliangtang
    19  let PM netlink update live sockets on local addresses list =

change [enhancement] @geliangtang

     Recently closed (since last week)

None.



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
     - TODO Matt: support future 5.12 =E2=86=92 Done



Patches to send to netdev:
     - net:
         - Paolo's patches (waiting to be added in our tree)

     - net-next:
         - MP_PRIO: can be sent by Mat



Extra tests:
     - news about Syzkaller? (Christoph):
         - No new crashers during the break!
         - Will run with latest export branch

     - news about interop with mptcp.org? (Christoph):
         - Last bug was one in mptcp.org
         - mptcp.org seems to send out of window data
         - Wireshark had some bug, recently fixed, wrong displaying =

MPTCPv1 info:
             - relative DSN numbers were swapped or something else but =

wrong.

     - news about Intel's kbuild? (Mat):
         - No new bugs reported

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - /


Removing subflows:
     - If the initial subflow has been closed, do we want the path =

manager to close the last subflow when an address is removed?
     - Or leave it open until it's forced closed by an interface being =

shut down?
     - TODO: Matth: open a new ticket to track this (even if later we =

decide we keep the current behaviour) =E2=86=92 Issue 133



Removing the initial subflow:
     - We might have issues there, e.g. we have a pointer to the "first" =

socket (check the closing part)
     - To be validated, it's very likely we might have issues there



lock_deps issue:
     - reported by Geliang at the end of December
     - fixed with 3f8b2667f257 ("mptcp: properly annotate nested lock")
     - It looks like we have similar code (e.g. shutdown path) but not =

such splat
     - Any idea why?
     - We should certainly add this annotation every time we lock the sf =

socket
     - *Paolo* : TODO: open a new issue on Github to track that




Next meeting:
     - We propose to have the next meeting on Thursday, the 14th of January.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210114



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1029004212855748789==--
