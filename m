Content-Type: multipart/mixed; boundary="===============7000482608088713695=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 15th of October 2020
Date: Sat, 17 Oct 2020 09:07:48 +0200
Message-ID: <641458b4-5049-a8c7-ec12-bdd1a6a87ec7@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6336

--===============7000482608088713695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 120th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi) =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Paolo Abeni):

1379409  [net,2/2] mptcp: subflows garbage collection
1379412  [net,1/2] mptcp: fix fallback for MP_JOIN subflows

     our repo (by: Davide Caratti, Matthieu Baerts, Paolo Abeni):

1379112  [net-next] Squash-to: mptcp: refactor shutdown and close
1378902  [net,2/2] mptcp: subflows garbage collection
1378903  [net,1/2] mptcp: fix fallback for MP_JOIN subflows
1376724  [mptcp-next] Squash-to: mptcp: keep track of advertised windows =

right...



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Davide Caratti, Florian Westphal, Geliang Tang, =

Matthieu Baerts, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     -  WIP

1374921: Needs Review / ACK: [mptcp-next] mptcp: skip to next candidate =

if subflow has unacked data:
     - TODO: Matth: to be applied

1375893: Needs Review / ACK: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - Review in progress

1379256: New: [mptcp-next,v2] selftests: mptcp: add link failure test case:
     - TODO: Matth: to be applied

1380010: Changes Requested: [v4,mptcp-next,1/3] mptcp: change =

add_addr_signal type
1380012: Changes Requested: [v4,mptcp-next,2/3] mptcp: send out =

dedicated ADD_ADDR packet
1380013: Changes Requested: [v4,mptcp-next,3/3] selftests: mptcp: add =

ADD_ADDR IPv6 test cases:
     - for an accept() socket, the first subflow is added to the msk =

list only when it is accepted.
     - the first subflow in the msk can be NULL
     - idea: add the packet in the join list at 3rd ACK time (would =

required an additional spinlock)
     - Paolo will share more details on the ML
     - =E2=86=92 might help Geliang patches

1380996: Awaiting Upstream: [mptcp-next] Squash to "selftests: mptcp: =

add ADD_ADDR timeout test case":
     - OK to keep IPTables for now
     - best to try the other tests and exit with "SKIP" only if this =

single test requiring iptables cannot be executed
     - or split in 3 files: common, the ones without iptables, the ones =

with it.
     - Paolo will think about that
     - TODO: Matth: share bytecode for IPv6 and take offset from IP =E2=86=
=92 done

1382272: New: [net-next,1/2] tcp: factor out tcp_build_frag()
1382274: New: [net-next,2/2] mptcp: use tcp_build_frag():
     - cleanup of some patches in the export branch
     - fix some GH issues (97)
     - modify TCP code =E2=86=92 the goal would be to send these two patche=
s to =

simplify reviews and got some feedback from Eric.

1382632: Changes Requested: [mptcp-next] mptcp: track window announced =

to peer:
     - Works very well
     - just some details to fix (ideally without a hook and with a =

READ_ONCE())
     - v2 is expected

1382663: New: Squash-to: "mptcp: refactor shutdown and close":
     - TODO: Matth: to be applied

1382705: New: [net-next] Squash-to: "mptcp: refactor shutdown and close":
     - This one and the previous one fix 2 different but related issues:
         - not sending DATA_FIN =E2=86=92 this one
         - the msk socket doesn't expire after orphan =E2=86=92 orphans are=
 now =

killed, thx Paolo!
     - TODO: Matth: to be applied



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 99)

/

     Bugs (opened, flagged as "bug" and assigned)

   98  dss_ssn_specified_client packetdrill test fails (timeout) [bug] =

@dcaratti:
       - linked to a patch above =E2=86=91 (last in the list)
       - but tests need to be modified anyway (will need a PR for =

Packetdrill)

   97  null ptr dereference on close timeout under memory pressure [bug] =

@pabeni:
       - linked to a patch above =E2=86=91 (2 patches series)

   94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti:
       - issue on packetdrill side
       - WIP

   92  mptcp_close() deletes MPTCP socket before disconnection completes =

[bug] @mjmartineau:
       - it seems it was still happening last Friday
       - Maybe fix with the patch sent by Davide
       - @Mat: if still present after having applied pending patches, =

please share .pcap trace

   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
       - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   99  simult_flows selftest is unstable: remaining sockets in TIME-WAIT =

state [bug]:
       - related to last patch from Florian
       - we could have unrelated additional load in the host/VM that =

could cause issues there.
       - should we ignore new errors then? (to avoid unstable tests)

   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe:
       - WIP

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe:
       - WIP

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang:
       - in progress

   54  ADD_ADDR: ports support [enhancement] @geliangtang:
       - adding ports in ADD_ADDR we send is easy
       - problem is to accept MP_JOIN to another port
       - in mptcp.org:
           - we accept connections from any port: we look if there is =

MPTCP option, an MP_JOIN, a valid token
           - we don't have a listener on that port in mptcp.org
           - it's a kind of a hack here where we hook on TCP code
       - we could have the userspace that listen to a different port
       - Next steps: share the patches and a dedicated message on the ML =

to discuss that
       - Idea: the PM could create the listening socket from the kernel side
       - =E2=86=92 @Geliang: start the discussion on the ML

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch:
       - WIP


     Recently closed (since last week)

   91  MPJ: Fallback to TCP if the client receives a 4th ACK without DSS =

options from the server [bug] @pabeni




FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
     - =E2=86=92 TODO Matth: update =E2=86=91, 5.11



Extra tests:
     - news about Syzkaller? (Christoph):
         - Updated to test the last export branch

     - news about interop with mptcp.org? (Christoph):
         - will do more tests

     - news about Intel's kbuild? (Mat):
         - some failures with mptcp_join.sh
         - =E2=86=92 maybe temporally
         - no more details

     - packetdrill (Davide):
         - covered above

     - CI (Matth):
         - /



Next meeting:
     - We propose to have the next meeting on Thursday, the 22nd of October.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201022



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7000482608088713695==--
