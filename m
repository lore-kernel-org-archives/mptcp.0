Content-Type: multipart/mixed; boundary="===============1825651310959135285=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 18th of February 2021
Date: Sat, 20 Feb 2021 12:08:46 +0100
Message-ID: <71c38c57-7d95-1d28-bf6e-e6e7243c82d8@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7875

--===============1825651310959135285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 136th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi) =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau (commits from Paolo, =

Florian, Geliang, Matthieu):

1440143  [net-next] mptcp: add local addr info in mptcp_info

1440135  [net-next,8/8] mptcp: add netlink event support
1440136  [net-next,7/8] genetlink: add CAP_NET_ADMIN test for multicast =

bind
1440134  [net-next,6/8] mptcp: avoid lock_fast usage in accept path
1440133  [net-next,5/8] mptcp: pass subflow socket to a few helpers
1440132  [net-next,4/8] mptcp: move subflow close loop after sk close check
1440131  [net-next,3/8] mptcp: schedule worker when subflow is closed
1440128  [net-next,2/8] mptcp: split __mptcp_close_ssk helper
1440129  [net-next,1/8] mptcp: move pm netlink work into pm_netlink

1440116  [net-next,4/4] selftests: mptcp: fail if not enough SYN/3rd ACK
1440117  [net-next,3/4] selftests: mptcp: display warnings on one line
1440118  [net-next,2/4] selftests: mptcp: fix ACKRX debug message
1440115  [net-next,1/4] selftests: mptcp: dump more info on errors

1439721  [net,6/6] mptcp: add a missing retransmission timer scheduling
1439716  [net,5/6] mptcp: better msk receive window updates
1439718  [net,4/6] mptcp: init mptcp request socket earlier
1439717  [net,3/6] mptcp: fix spurious retransmissions
1439723  [net,2/6] mptcp: fix poll after shutdown
1439720  [net,1/6] mptcp: deliver ssk errors to msk


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1440633  [v2,mptcp-next] Squash to "mptcp: add rm_list in mptcp_out_options"

1440600  mptcp: provide subflow aware release function

1440563  [mptcp-net] mptcp: fix DATA_FIN processing for orphaned sockets.

1440146  [mptcp-next] mptcp: drop unused subflow in =

mptcp_pm_subflow_establish...

1439777  [mptcp-next] Squash to "selftests: mptcp: fail if not enough =

SYN/3rd ...

1439727  [v2,2/2] mptcp: dispose initial struct socket when its subflow =

is clo...
1439726  [1/2] mptcp: reset last_snd on subflow close

1439689  [mptcp-net] mptcp: fix DATA_FIN generation on early shutdown.




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

with unread data::
     - WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - WIP =E2=86=92 v2 can be shared now that everything is in net-next

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
     - WIP

1441262: New: mptcp: put subflow sock on connect error:
     - TODO: to be applied

1441510: New: [v2,mptcp-next] Squash to "mptcp: add rm_list_tx in =

mptcp_pm_data":
     - v2 shared today, to be reviewed =E2=86=92 Done

1441518: New: [v2,mptcp-next] mptcp: free resources when the port number =

is mismatched:
     - v2 shared today, to be reviewed =E2=86=92 Done

1441551: New: [v4,mptcp-next,1/2] mptcp: move to next addr when subflow =

creation fail
1441552: New: [v4,mptcp-next,2/2] selftests: mptcp: signal addresses =

testcases:
     - v4 shared today, to be reviewed =E2=86=92 Done

1441645: New: [mptcp-net] mptcp: do not wakeup listener for MPJ subflows:
     - new patch, to be reviewed =E2=86=92 Done

1441703: New: [iproute2-next] mptcp: add support for port based endpoint:
     - new patch, to be reviewed =E2=86=92 Done

1441714: New: mptcp: reset 'first' and ack_hint on subflow close:
     - linked to what syzbot reported but not a fix for that: we already =

have a fix in mptcp-next
     - but maybe linked to one of the syzbot reports, the ones with =

reproducers
     - Florian is going to remove "first" instead.



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 159)

   166  iproute2: ADD_ADDR: ports support [enhancement] [iproute2]:
       - TODO: assign Paolo (patch already sent today) =E2=86=92 Done

   165  Intermittent copyfd_io_poll: poll timed out in mptcp_join.sh:
       - happened a couple of time on kbuild
       - there was one on mptcp_connect.sh but this one looks different
       - Paolo was not able to reproduce it locally with different =

setup, more info needed
       - Mat is going to add them in the ticket =E2=86=92 Done

   164  unexpected poll() wakeup on incoming MP_JOIN [bug] @pabeni:
       - should be addressed by patch "mptcp: do not wakeup listener for =

MPJ subflows"
       - there is already a Closes tag :+1:

   163  allow ss dumping msk socket in TCP_LISTEN status:
       - We list all sockets by going through the token list
       - Listener sockets doesn't have token
       - Maybe safe to go through the TCP listener list and filter the =

MPTCP ones =E2=86=92 maybe OK if there are not a lot of sockets =E2=86=92 w=
ould we have =

a lot of sockets?
       - Or list them in a new list?

   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is =

provided [bug]:
       - From an end user, trying to exec apps designed for plain TCP
       - behaviour is different than what TCP is doing
       - TCP is ignoring unknown CMSG argument

   160  `./mptcp_connect.sh -m mmap` test blocks [bug]:
       - timeout at the script level
       - trying with SO_SNDTIMEO


     Bugs (opened, flagged as "bug" and assigned)

   164  unexpected poll() wakeup on incoming MP_JOIN [bug] @pabeni:
       - see above

   151  Only 1 ADD_ADDR has been sent when signalling multi invalid =

addresses [bug] @geliangtang:
       - should be fixed with =

https://patchwork.ozlabs.org/project/mptcp/cover/cover.1613635984.git.gelia=
ngtang(a)gmail.com/

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is =

provided [bug]:
       - See above

   160  `./mptcp_connect.sh -m mmap` test blocks [bug]:
       - Assigned to Matth

   156  [syzkaller] WARNING: refcount bug in __tcp_transmit_skb [bug] =

[syzkaller]
   153  [syzkaller] WARNING: refcount bug in mptcp_incoming_options =

[bug] [syzkaller]
   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
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

    54  ADD_ADDR: ports support [enhancement] @geliangtang:
        - we need a new story for packetdrill support
        - Davide is going to do that (same for 140 and maybe others)


     Recently closed (since last week)

   161  glib support for IPPROTO_MPTCP
   159  [syzkaller] WARNING in __mptcp_destroy_sock [bug] [syzkaller]
   157  [syzkaller] WARNING in dst_release [bug] [syzkaller] @fw-strlen
   155  [syzkaller] BUG: unable to handle kernel NULL pointer =

dereference in mptcp_subflow_get_send [bug] [syzkaller] @fw-strlen
   152  mptcp_release_cb is racy [bug] @pabeni
   149  iproute2: ss wrongly reports MPTCP sockets for kernel 5.7 =E2=86=92=
 5.9 =

[bug] [iproute2] @matttbe
   147  copyfd_io_poll: poll timed out: race/bug with poll wakeup [bug] =

@pabeni
   112  sporadic failure of mptcp_join.sh selftest 13 [bug] @dcaratti
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller] =

@fw-strlen
    60  PM: netlink: events per connection [enhancement] @fw-strlen
    51  MP_PRIO support [enhancement] @geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.12): =

https://github.com/multipath-tcp/mptcp_net-next/projects/7
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
     - 5.13: TODO Matth


Patches to send to netdev:
     - net:
         - note: some patches have been merged in -net but is not in =

5.11 (.0)
         - da0ff1038c190 mptcp: fix DATA_FIN generation on early shutdown
         - 3bec5cb51783 mptcp: fix DATA_FIN processing for orphaned sockets
         - 85b8c8d3ef4f mptcp: provide subflow aware release function
         - c1e8864231ba mptcp: reset last_snd on subflow close
         - =E2=86=92 Paolo will sent these patches =E2=86=92 Done

We should probably send this one too:
     - fb4bec1924c4 mptcp: dispose initial struct socket when its =

subflow is closed

And maybe:
     d66e0832f257 mptcp: drop unused subflow in =

mptcp_pm_subflow_established
     1956a17cd676 mptcp: clean-up the rtx path
     3a90e26fb18d mptcp: fix race in release_cb
     08d4b3614aa0 mptcp: factor out __mptcp_retrans helper()
     =E2=86=92 For net-next IF there are no conflicts with the patches for =
-net
     =E2=86=92 but probably best to wait for the next window

     - net-next:
         - best to wait for the next window



Extra tests:
     - news about Syzkaller? (Christoph):
         - Broken \o/ or :'(
         - But it is due to syzkaller, bug reported and already fixed!

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Issue 165 happened again last night
         - Mat will share more details

     - packetdrill (Davide):
         - Davide is going to (fix his pulseaudio config or the pipewire =

one and then) send a PR

         - Matth is able to reproduce locally the issue reported by the =

CI: connect_close_full.pkt

     - connection rate base tests (Paolo):
         - last week, tests were "quite bad"
         - but looks like it is due to the environment
         - it was an httperf with a single IP source
         - port selection was very expensive because only one IP src and =

dest =E2=86=92 we have to go through a list
         - With MPTCP, the shutdown is taking longer compared to TCP
         - workaround: modifying the client to use a lot of local ip =

addresses, avoid having to go through a long list
         - 2/3 of TCP perfs, quite good!
         - crypto things is not taking lot of CPU (2-3%)
         - a hook (mptcp_poll()) is called 10 times more with MPTCP than =

with TCP (tcp_poll()): didn't check more

     - CI (Matth):
         - working to switch to Github Actions and Cirrus-ci



mptcp.org perf:
     - if connections are smaller (1Byte), overhead is pretty high
     - longer connections are OK
     - 2/3 of TCP with upstream looks nice!



Next meeting:
     - On Thursday, the 25th of February.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210225



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1825651310959135285==--
