Content-Type: multipart/mixed; boundary="===============7664684888251207114=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 17th of December 2020
Date: Fri, 18 Dec 2020 00:00:27 +0100
Message-ID: <38f95e6d-5fb4-9e79-ecd5-3698eb9188d3@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7207

--===============7664684888251207114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we had our INT8_MAX+2 th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Davide, Paolo and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau):

1414602  [net-next,9/9] mptcp: let MPTCP create max size skbs
1414603  [net-next,8/9] mptcp: pm: simplify select_local_address()
1414599  [net-next,7/9] mptcp: parse and act on incoming FASTCLOSE optio
1414600  [net-next,6/9] tcp: parse mptcp options contained in reset pack
1414601  [net-next,5/9] mptcp: hold mptcp socket before calling tcp_done
1414598  [net-next,4/9] mptcp: use MPTCPOPT_HMAC_LEN macro
1414597  [net-next,3/9] selftests: mptcp: add the flush addrs testcase
1414596  [net-next,2/9] mptcp: remove address when netlink flushes addrs
1414595  [net-next,1/9] mptcp: attach subflow socket to parent cgroup

1416290  [v2,net-next] mptcp: clear use_ack and use_map when dropping =

other su...


     our repo (by: Geliang Tang, Paolo Abeni):

1416111  [mptcp-net] mptcp: properly annotate nested lock

1416006  [mptcp-net,v2] mptcp: fix pending data accounting

1415493  [mptcp-next] Squash to "mptcp: add the address ID assignment =

bitmap"

1415026  [mptcp-net] mptcp: fix security context on server socket

1414708  [mptcp-next] Squash to "[PATCH v3 mptcp-next 1/6] mptcp: add =

the outg...

1414604  [mptcp-next] Squash-to: "mptcp: push pending frames when =

subflow has ...

1413273  [v3,mptcp-next,6/6] selftests: mptcp: add the MP_PRIO testcases
1413272  [v3,mptcp-next,5/6] mptcp: add the mibs for MP_PRIO
1413271  [v3,mptcp-next,4/6] selftests: mptcp: add set_flags command in
1413270  [v3,mptcp-next,3/6] mptcp: add set_flags command in PM netlink
1413269  [v3,mptcp-next,2/6] mptcp: add the incoming MP_PRIO support
1413268  [v3,mptcp-next,1/6] mptcp: add the outgoing MP_PRIO support

1413262  [v4,mptcp-next,2/2] selftests: mptcp: add testcases for setting
1413254  [v4,mptcp-next,1/2] mptcp: add the address ID assignment bitmap

1409622  [RFC] selinux: handle MPTCP consistently with TCP



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1417092  linux: handle MPTCP consistently with TCP

1417085  [net,4/4] mptcp: fix pending data accounting
1417080  [net,3/4] mptcp: push pending frames when subflow has free spac
1417083  [net,2/4] mptcp: properly annotate nested lock
1417079  [net,1/4] mptcp: fix security context on server socket:
     - Waiting to be applied upstream
     - Done just after the meeting


     our repo (by: Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets
1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1415495: New: [v8,mptcp-next,1/8] mptcp: create the listening socket for
1415496: New: [v8,mptcp-next,2/8] mptcp: add port number check for MP_JO
1415497: New: [v8,mptcp-next,3/8] mptcp: add port number announced check
1415498: New: [v8,mptcp-next,4/8] mptcp: enable use_port when invoke add
1415499: New: [v8,mptcp-next,5/8] mptcp: deal with MPTCP_PM_ADDR_ATTR_PO
1415500: New: [v8,mptcp-next,6/8] selftests: mptcp: add port argument fo
1415501: New: [v8,mptcp-next,7/8] mptcp: add the mibs for ADD_ADDR with
1415502: New: [v8,mptcp-next,8/8] selftests: mptcp: add testcases for A:
     - Waiting for reviews
     - Mat will have a look

1416891: Changes Requested: [v2,mptcp-next,1/2] mptcp: convert IPv4 =

address to IPv4-mapped
1416892: Changes Requested: [v2,mptcp-next,2/2] selftests: mptcp: add =

IPv4-mapped IPv6 testcases:
     - Changes requested by Mat
     - Linked to issue 122 on GH
     - Discussions needed:
         - Direction taken: modifying entries in the local address
         - It seems not "clean": it seems more natural not to modify =

stuff for this check, maybe we should change the way the check is done?
         - i.e. when comparing addresses, we can check for IPv4 mapped
         - @Geliang: would it be OK to take this direction?

1416976: New: [mptcp-next,1/3] mptcp: create subflow or signal addr for =

newly added address
1416977: New: [mptcp-next,2/3] selftests: mptcp: use minus value for =

removing address numbers
1416978: New: [mptcp-next,3/3] selftests: mptcp: add testcases for newly =

added addresses:
     - Waiting for reviews
     - Mat started to look
     - Linked to https://github.com/multipath-tcp/mptcp_net-next/issues/19
     - The goal of #19 what to allow the Netlink API to use a new =

endpoint (e.g. new WiFi link)
     - (Maybe later we can add a flag to disable this behaviour)
     - It makes sense to do that and that's what Geliang is doing here, =

good!
     - But is it OK to do this iteration there in the code at this place?
     - Patch: =

https://patchwork.ozlabs.org/project/mptcp/patch/73d430a234a018dbef408242b1=
b40461e96dfb91.1608111058.git.geliangtang(a)gmail.com/
     - Mat might need help for the review on this one




Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 127)

   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] =

[syzkaller]:
       - no repro yet

   129  set subflow socket consistently [bug] [enhancement]:
       - When looking at buf autotuning, Paolo found not nice to have =

different struct sockets for client/outbound subflows and server/inbound =

subflows.
       - Sharing a common structure would be nice
       - Also, we need to traverse the conn_list to set the NOSPACE bit =

on each subflow
       - We might want to share this structure for [sg]etsockopt

   128  When the last subflow is closed without DATA_FIN and msk =

Established, close msk (after a timeout) [enhancement]:
       - We might want different behaviours for inbound and outbound =

sockets, e.g.:
           - client might want to create new subflows over new subflows =

even if there is no existing one
           - server might want not being stuck and close connections
         - MPTCP keep alive might be something different, more advanced =

behaviour
         - A dedicated timeout might be good for now
         - For the moment, we don't have dedicated MPTCP setsockopt, =

maybe we can also wait
         - sysctl should be there to configure the default value
         - should be fine to add new sysctl just for MPTCP if they are =

specific
         - Or Netlink API but might be more tricky for the end user, =

e.g. when forcing some specific app to create MPTCP sockets instead of =

TCP one with LD_PRELOAD


     Bugs (opened, flagged as "bug" and assigned)

   126  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller] =

@dcaratti:
       - With the repro, we reproduce another issue: 115, all the time :-)
       - will fix this one and check this 126 happens again.
       - but maybe linked

   123  sndmsg autotuning is disable [bug] @pabeni:
       - As soon as autotuning is re-enabled, some selftests are failing =

(multiple xmit)
       - Very difficult to get complete link utilisation (no longer =

blocked by buffers)
       - Trying to use mptcp.org, Paolo is interested by BLEST
       - Min RTT in mptcp.org works fairly well in most scenarios but in =

heterogeneous, we might not fully use all links
       - sum of the thgput of all subflow * minRTT (?)
       - best way to try reaching full speed: set very very large TCP =

rcv and snt windows, just to see if we are not blocked because of that
       - what Paolo sees is: unstable at the beginning and better later. =

So if it is transferring a few small files, it is not great
       - Christoph: we need early reinjection. To avoid the packets on =

the slow links blocking the whole connection. It is explained there: =

https://www.usenix.org/conference/nsdi12/technical-sessions/presentation/ra=
iciu
       - The sender is blocked somehow, best is to analyse pcaps

   122  PM doesn't create subflow with IPv4 mapped IPv6 socket [bug] =

@geliangtang:
       - See patches above =E2=86=91

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti:
        - Davide will check if he can still reproduce it


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
   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
   112  sporadic failure of mptcp_join.sh selftest 13 [bug]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
    54  ADD_ADDR: ports support [enhancement] @geliangtang
    51  MP_PRIO support [enhancement] @geliangtang
    19  let PM netlink update live sockets on local addresses list =

change [enhancement] @geliangtang

    60  PM: netlink: events per connection [enhancement]
     - Florian is working on PM to share events
     - the API will not be exactly the same, prefix different
     - Florian will try to reduce the modifications


     Recently closed (since last week)

   124  ./mptcp_connect.sh -m mmap test blocks: regression [bug]
   117  Allow user-space to set endpoint ID [enhancement] [help wanted] =

@geliangtang
   114  packetdrill: dss tolerance issue to emit the FIN+ACK [bug] =

[packetdrill]
   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]
   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller] @geliangtang
    67  `./mptcp_connect.sh -m mmap` test blocks [bug]




FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
     - TODO: 5.12



Patches to send to netdev:
     - net:
         - everything has been sent

     - net-next:
         - / (closed)



Extra tests:
     - news about Syzkaller? (Christoph):
         - See above =E2=86=91

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Mat confirms it is the same issue he had with selftests, see =

the meeting notes from last week
         - Mat has more access now, should be easier to retrieve more =

details about an issue

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - /


Next meeting:
     - We cancel the two next ones? =E2=86=92 Yes



Next meeting:
     - We propose to have the next meeting in 3 weeks, on Thursday, the =

7th of January 2021.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210107



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next year,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7664684888251207114==--
