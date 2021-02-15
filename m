Content-Type: multipart/mixed; boundary="===============2676267270721181210=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 11th of February 2021
Date: Mon, 15 Feb 2021 20:41:12 +0100
Message-ID: <a5896191-f6ce-387b-1e94-5f25f4e57fb2@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7813

--===============2676267270721181210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 135th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo, Davide, Florian and Perry Gagne (RedHat), =

Geliang (Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau (commits from Florian =

and Geliang)):

1436332  [net-next,2/2] mptcp: pm: add lockdep assertions
1436331  [net-next,1/2] selftests: mptcp: add command line arguments for =

mptcp...


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1438957  squashto: mptcp: schedule worker when subflow is closed

1438772  [v7,mptcp-next,11/11] selftests: mptcp: add testcases for =

removing ad...
1438771  [v7,mptcp-next,10/11] selftests: mptcp: set addr id for =

removing test...
1438770  [v7,mptcp-next,09/11] selftests: mptcp: add invert argument for =

chk_r...
1438769  [v7,mptcp-next,08/11] mptcp: remove a list of addrs when flushing
1438768  [v7,mptcp-next,07/11] mptcp: remove multi addresses and =

subflows in PM
1438767  [v7,mptcp-next,06/11] mptcp: remove multi subflows in PM
1438766  [v7,mptcp-next,05/11] mptcp: remove multi addresses in PM
1438765  [v7,mptcp-next,04/11] mptcp: add rm_list_rx in mptcp_pm_data
1438764  [v7,mptcp-next,03/11] mptcp: add rm_list in mptcp_options_received
1438763  [v7,mptcp-next,02/11] mptcp: add rm_list_tx in mptcp_pm_data
1438762  [v7,mptcp-next,01/11] mptcp: add rm_list in mptcp_out_options

1438302  [mptcp-next,3/3] mptcp: clean-up the rtx path.
1438301  [mptcp-next,2/3] mptcp: fix race in release_cb
1438300  [mptcp-next,1/3] mptcp: factor out __mptcp_retrans helper()

1437778  [mptcp-next,3/3] selftests: mptcp: fail if not enough SYN/3rd ACK
1437781  [mptcp-next,2/3] selftests: mptcp: display warnings on one line
1437779  [mptcp-next,1/3] selftests: mptcp: fix ACKRX debug message

1436751  [mptcp-net,5/5] selftests: mptcp: dump more info on errors
1436750  [mptcp-net,4/5] mptcp: add a missing retransmission timer =

scheduling
1436749  [mptcp-net,3/5] mptcp: better msk receive window updates
1436748  [mptcp-net,2/5] mptcp: init mptcp request socket earlier
1436747  [mptcp-net,1/5] mptcp: fix spurious retransmissions

1435084  [v3,mptcp-next] mptcp: add local addr info in mptcp_info



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
1431692: Changes Requested: [RFC,mptcp-next,5/6] mptcp: add tracepoints =

for PM operations
1431693: Changes Requested: [RFC,mptcp-next,6/6] mptcp: add tracepoints =

for subflow operations:
     - first reviewed done

     - It could be helpful to share on the mailing-list a list of where =

the tracepoints are going to be added and with which data:
         =E2=86=92 easier with a list (because there are a few trace) and a=
void =

having to make code
         =E2=86=92 @Geliang: may you share a list not to have to code some =
parts =

if it is not needed?

1438436: Changes Requested: [v3,mptcp-next,1/4] mptcp: move to next addr =

when subflow creation fail
1438439: Changes Requested: [v3,mptcp-next,4/4] selftests: mptcp: signal =

addresses testcases:
     - some changes are required, v4 expected


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 151)

   159  [syzkaller] WARNING in __mptcp_destroy_sock [bug] [syzkaller]:
       - this is critical, as syzkaller is stuck (=E2=86=92 was a false pos=
itive)

   158  iproute2: change backup mode (MP_PRIO) for active connections =

[enhancement] [iproute2]:
       - there is a support in the kernel but not in iproute2: to be =

able to use "ip mptcp endpoint *change* (...)" and not only "add" and =

"delete"

   157  [syzkaller] WARNING in dst_release [bug] [syzkaller]:
       - Florian has already a patch for this one

   156  [syzkaller] WARNING: refcount bug in __tcp_transmit_skb [bug] =

[syzkaller]
   155  [syzkaller] BUG: unable to handle kernel NULL pointer =

dereference in mptcp_subflow_get_send [bug] [syzkaller]
   153  [syzkaller] WARNING: refcount bug in mptcp_incoming_options =

[bug] [syzkaller]

   152  mptcp_release_cb is racy [bug] @pabeni
       - just closed


     Bugs (opened, flagged as "bug" and assigned)

   152  mptcp_release_cb is racy [bug] @pabeni:
       - just closed

   151  Only 1 ADD_ADDR has been sent when signalling multi invalid =

addresses [bug] @geliangtang:
       - related to the two patches above that needs to be modified

   149  iproute2: ss wrongly reports MPTCP sockets for kernel 5.7 =E2=86=92=
 5.9 =

[bug] [iproute2] @matttbe:
       - not possible to use the proto in the reply
       - nothing new in procfs related to MPTCP
       - maybe OK not to do anything because we should not have iproute2 =

version > kernel version?
       =E2=86=92 TODO: Matth; update the ticket =E2=86=92 Done

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau :
       - could be nice to use delegated actions with the new infrastructure


     Bugs (opened and flagged as "bug" and not assigned)

   157  [syzkaller] WARNING in dst_release [bug] [syzkaller]
   156  [syzkaller] WARNING: refcount bug in __tcp_transmit_skb [bug] =

[syzkaller]
   155  [syzkaller] BUG: unable to handle kernel NULL pointer =

dereference in mptcp_subflow_get_send [bug] [syzkaller]
   153  [syzkaller] WARNING: refcount bug in mptcp_incoming_options =

[bug] [syzkaller]
   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   142  packetdrill: support injecting ADD_ADDR echo bit [enhancement] =

[packetdrill] @dcaratti

   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang :
       - kernel code OK
       - Maybe packetdrill support?
       - RM_ADDR with a single address is not supported
       - Davide plans to look at the missing features in packetdrill and =

open new ticket(s)/PR(s)
       - @Davide: please also close this one (and #54) once it is done

   134  Checksum support [enhancement] @geliangtang
   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe

    60  PM: netlink: events per connection [enhancement] @fw-strlen:
        - Should we close it? (or assign Ossama?) =E2=86=92 Done

    54  ADD_ADDR: ports support [enhancement] @geliangtang:
        - Packetdrill support in a dedicated story? =E2=86=92 Davide will d=
o =

that, see #140.


     Recently closed (since last week)

   154  selftests: mptcp_connect: file received by client does not match =

[bug] @pabeni
   148  SYNRX: MPTCP -> MPTCP: expect x, got y [bug] @matttbe
   147  copyfd_io_poll: poll timed out: race/bug with poll wakeup [bug] =

@pabeni
   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] =

[syzkaller] @pabeni
   126  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller] @pabeni
   125  [syzkaller] KASAN: wild-memory-access Write in =

subflow_req_destructor [bug] [syzkaller] @pabeni
   112  sporadic failure of mptcp_join.sh selftest 13 [bug] @dcaratti
    51  MP_PRIO support [enhancement] @geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.12): =

https://github.com/multipath-tcp/mptcp_net-next/projects/7
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - 7614b4aedb855 selftests: mptcp: dump more info on errors:
             - this one might need some fixes (grammar)
         - 5a3b70e209296 mptcp: add a missing retransmission timer =

scheduling
         - 200b49d901e74 mptcp: better msk receive window updates
         - 12ca6e1ef6ad3 mptcp: init mptcp request socket earlier
         - 7d4e4a1ebd7c3 mptcp: fix spurious retransmissions
         - a5cbae22dc44a mptcp: fix poll after shutdown
         - 98e7bdd1f047e mptcp: deliver ssk errors to msk
     =E2=86=92 Mat is going to send these ones =E2=86=92 Done

     - net-next:
         - 24c2bb8afbd19 mptcp: clean-up the rtx path:
             - has dependences on fixes from -net, we need to wait for =

them to be applied on net-next
         - 135e92ea4633e mptcp: fix race in release_cb =E2=86=92 maybe this=
 one =

to -net but not all of them.
         - 080f6278e6cea mptcp: factor out __mptcp_retrans helper()
             - Above two patches did not apply to net-next, but look ok =

for future -net submission
         - What's left:
             - one patch from Geliang: "mptcp: add local addr info in =

mptcp_info" =E2=86=92 quite independent from the rest, could be sent in // =
maybe?
             - Florian' series related to MPTCP PM Netlink: events =

support =E2=86=92 validation is in progress but looks good, could be sent =

tomorrow maybe? =E2=86=92 Done
             - some selftests improvements, should be independent from =

the rest (will conflict with "selftests: mptcp: dump more info on =

errors"), we can wait if needed. =E2=86=92 Done



Extra tests:
     - news about Syzkaller? (Christoph):
         - Now running without debug kernel, finding new bugs because =

the execution is faster

     - news about interop with mptcp.org? (Christoph):
         - Working on support the latest 5.4.x kernel, easier to test

     - news about Intel's kbuild? (Mat):
         - 147 issue was reproduced but before the fix was merged

     - packetdrill (Davide):
         - A new format has been proposed to improve the readability of =

these scripts.
         - Please follow the new format (see last PR and Readme) for new =

scripts.
         - See above =E2=86=91

     - CI (Matth):
         - not building in 32-bit: cherry-picked: x86/build: Disable CET =

instrumentation in the kernel for 32-bit too
         - looking at updating the TG tree with GH Action



Related to:
     - =

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/ne=
t/mptcp/subflow.c#n710
     - the "goto" looks wrong, probably some resources are not freed
     - @Geliang: may you have a look at this please? It looks like it is =

related to some code you recently modified (Done)



kernel-ci.org:
     - build + seltests could be validated there
     - similar to kbuild but here the results are published
     - =E2=86=92 so it looks interesting, we should certainly contact them!
     - =E2=86=92 maybe it is an issue that our export branch is rebased =

regularly (but they can follow for-review branch)
     - kcidb: to publish results to a central place: =

https://staging.kernelci.org:3000
     - =E2=86=92 maybe we don't need to publish results from our CI if it i=
s =

public? We can check that later



If we need an alternative to GMeet:
     - https://meet.kernel.social



Paolo:
     - Paolo is looking at connection rate perf tests
     - It looks like there are some "room for improvement" to say that =

politely :)
     - Fallback to TCP: 10% compared to plain TCP
     - MPTCP socket stays around for 60 seconds



Perry is looking at perf:
     - Perry is working on http://lnst-project.org
     - TRex and others doesn't have native MPTCP support =E2=86=92 they hav=
e a =

different network stack, work needed there
     - "Workaround" is to use a proxy.
     - wrk =E2=86=92 to force MPTCP, e.g. with netperf
     - adding MPTCP support to existing tools should be "just" modifying =

the created sockets to use IPPROTO_MPTCP.
     - But support for some [gs]etsockopt's might be missing, could be =

blocking
     - For just the socket modification (TCP =E2=86=92 MPTCP), we can use =

LD_PRELOAD but "not nice"
     - On top of that, we also have to do:
         - ask the client to use multiple subflows =E2=86=92 iproute2
         - same for the server =E2=86=92 iproute2
         - routing rules =E2=86=92 iproute2



Next meeting:
     - On Thursday, the 18th of February.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210218



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2676267270721181210==--
