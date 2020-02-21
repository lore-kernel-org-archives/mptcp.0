Content-Type: multipart/mixed; boundary="===============2047576022714307104=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of February 2020
Date: Fri, 21 Feb 2020 14:45:13 +0100
Message-ID: <815ae65b-cab1-5685-eaba-979182655895@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3716

--===============2047576022714307104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 87th meeting with Ossama (Intel OTC), Christoph =

(Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - Internal:
         /

     - Net: Mat Martineau, Matthieu Baerts
1237720  [net,v2,2/3] mptcp: Protect subflow socket options before conn
1238542  [net] mptcp: select CRYPTO



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Florian Westphal, Mat Martineau, Matthieu Baerts, Paolo Abeni, =

Peter Krystad

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - still a bug

1233392: Needs Review / ACK: subflow: place outgoing connections on the:
     - has been acked, can be applied

1233648: Needs Review / ACK: [RFC,1/3] mptcp: Check connection state bef
1233650: Needs Review / ACK: [RFC,2/3] mptcp: Use per-subflow storage fo
1233649: Needs Review / ACK: [RFC,3/3] mptcp: Only send DATA_FIN with f:
     - *need review* (for more than one week)

1235200: Changes Requested: [1/2] mptcp: Re-factor mptcp_crypto_hmac_sha
1235198: Changes Requested: [2/2] mptcp: Make v1 changes for ADD_ADDR a:
     - v2 in progress, waiting for PM netlink

1237722: New: [net,v2,1/3] mptcp: Keep TCP fallback subflow valid after
1237721: New: [net,v2,3/3] mptcp: Use TCP sendmsg/recvmsg for fallback:
     - patch 2/3 has been upstreamed
     - Paolo's understanding is that they are no longer needed
     - *Mat* : can you confirm please?

1239496: New: [1/7] Squash-to: "mptcp: Add ADD_ADDR handling"
1239501: New: [2/7] Squash-to: "mptcp: Add path manager interface"
1239497: New: [3/7] Squash-to: "mptcp: Add handling of incoming MP_JOIN
1239500: New: [4/7] Squash-to: "mptcp: Add handling of outgoing MP_JOIN
1239498: New: [5/7] Squash-to: "mptcp: Implement path manager interface
1239502: New: [6/7] mptcp: add netlink based PM
1239499: New: [7/7] selftests: add PM netlink functional tests:
     - *need review*
     - in review by Matth
     - v3 is in preparation by Paolo
     - could be good to merge them quickly to unblock Peter and run more =

tests
     - ideally we end reviews this week and we merge next week
     - long term objective: modify 'iproute2' to communicate with this PM

1241449: New: [v3,1/6] mptcp: add and use mptcp_data_ready helper
1241451: New: [v3,2/6] mptcp: update mptcp ack sequence from work queue
1241452: New: [v3,3/6] mptcp: add rmem queue accounting
1241453: New: [v3,4/6] mptcp: remove mptcp_read_actor
1241454: New: [v3,5/6] mptcp: protocol: re-check dsn before reading from
1241455: New: [v3,6/6] mptcp: send acks when moving skbs to mptcp recei:
     - same as the previous v3 but commit messages have been modified
     - LGTP (Paolo)
     - idea from Paolo to rebase on top of "net-next" and upstream this
     - then we can keep our the rest of the patches to be upstreamed =

later in a "smaller series"
     - Florian will share the patches after the new rebase and before =

sending that to netdev



FYI: Current Roadmap:
     - Part 3 (next merge window):
         - PM:
             - locking
             - basic =E2=86=92 netlink support
         - MP_JOIN
         - ADD_ADDR for MPTCP v1
         - clean the current patches
         - need to make sure we continue to support the protocol =E2=86=92 =

workaround for shared received windows

      - other items:
         - Full DATA_FIN support [WIP]:
             - could be nice to have it: if ready
         - Shared recv window (drop data received on other subflows) =

[TODO]:
             - could be nice to have
             - could be nice to share a prototype/RFC with TCP =

maintainers (Eric)
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)
         - ADD_ADDR for MPTCPv1 [TODO]
         - PM basic [WIP]
         - fix sender ID in MP_JOIN

     - Part 4 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server
         - reduce locks when mptcp_stream_accept (currently 3 locks) but =

we might need to add an helper in inet API

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink
         - PM bpf
         - Scheduler bpf
         - syncookies
         - [gs]etsockopt per subflow
         - notify the userspace when a subflow is added/removed =E2=86=92 c=
msg



Part 3 remaining stuff:
     - Review commit messages:
         - needed for the next merge window: not urgent

     - PM + MP_JOIN self-tests:
         - Paolo is looking at that

     - packetdrill:
         - David is working on that
         - testing TCP fallback part (especially when the DSS options =

don't pass after the 3-way HS)
         - Matth tried to use it, the compilation failed and didn't have =

time to look at it in more details. Certainly something simple

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - TODO

     - ADD_ADDR for MPTCPv1:
         - Peter is looking at that

     - DATA_FIN:
         - Mat is looking at that

     - Shared received windows:
         - Florian is looking at that now directly
         - trying something in tcp_select_window(), we will need to =

share that to Eric, will see but that would ease the code for MPTCP



Extra tests:
     - news about Syzkaller? (see prev meeting):
         - no new panic
         - syzbot is now using CONFIG_MPTCP

     - new about Intel's kbuild? (to check next week with Mat)



mptcp.org:
     - Christoph is looking at supporting MPTCPv1 \o/



Netdev 0x14:
     - Might be only Mat from Intel
     - Mat might need help to present (will check when Mat will be back)
     - Paolo should go
     - Matth should go as well



Next meeting:
     - We propose to have the next meeting on Thursday, the 27th of =

February.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200227



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2047576022714307104==--
