Content-Type: multipart/mixed; boundary="===============1539349468030249433=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 12th of November 2020
Date: Thu, 12 Nov 2020 18:09:38 +0100
Message-ID: <7b6c9b6c-6755-1a62-c8d9-1ee417114914@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6688

--===============1539349468030249433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 124th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Davide, Paolo and Florian (RedHat) and myself (Tessares).


This time, the Four Seasons Total Landscaping place was full of people, =

we had to switch to "Google meets Business", Reutershagweg in Aachen =

(Germany), just next to Belgium.


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Geliang Tang, Paolo Abeni):

1397241  [v2,net-next] mptcp: fix static checker warnings in =

mptcp_pm_add_timer
1396358  [net] mptcp: provide rmem[0] limit

=E2=86=92 Note: for netdev, they are switching to kernel.org's patchwork


     our repo (by: Paolo Abeni):

1395917  [v2] Squash-to "mptcp: refactor shutdown and close":
     - It looks like this breaks packetdrill "add_addr_server.pkt" test



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1398844  [net-next,13/13] mptcp: send explicit ack on delayed ack_seq incr
1398842  [net-next,12/13] mptcp: keep track of advertised windows right edge
1398840  [net-next,11/13] mptcp: rework poll+nospace handling
1398841  [net-next,10/13] mptcp: try to push pending data on snd una updates
1398838  [net-next,09/13] mptcp: move page frag allocation in =

mptcp_sendmsg()
1398836  [net-next,08/13] mptcp: refactor shutdown and close
1398834  [net-next,07/13] mptcp: introduce MPTCP snd_nxt
1398831  [net-next,06/13] mptcp: add accounting for pending data
1398833  [net-next,05/13] mptcp: reduce the arguments of mptcp_sendmsg_frag
1398828  [net-next,04/13] mptcp: introduce mptcp_schedule_work
1398827  [net-next,03/13] tcp: factor out __tcp_close() helper
1398826  [net-next,02/13] mptcp: use tcp_build_frag()
1398824  [net-next,01/13] tcp: factor out tcp_build_frag()
     =E2=86=92 had an issue with patch 6/13, will have to re-send.


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP

1394896: Needs Review / ACK: [RFC,mptcp-next,1/6] mptcp: add the =

outgoing MP_PRIO support
1394898: Needs Review / ACK: [RFC,mptcp-next,2/6] mptcp: add the =

incoming MP_PRIO support
1394899: Needs Review / ACK: [RFC,mptcp-next,3/6] mptcp: add =

prio_changed flag
1394900: Needs Review / ACK: [RFC,mptcp-next,4/6] mptcp: send out =

MP_PRIO before RM_ADDR
1394901: Needs Review / ACK: [RFC,mptcp-next,5/6] mptcp: add the mib for =

MP_PRIO
1394902: Needs Review / ACK: [RFC,mptcp-next,6/6] selftests: mptcp: add =

MP_PRIO check in chk_rm_nr:
     - reviewed by Mat
     - Changes requested

1395128: New: [1/5] tcp: make two mptcp helpers available to tcp stack
1395130: New: [2/5] tcp: parse mptcp options contained in reset packets
1395131: New: [3/5] mptcp: add mptcp reset option support
1395132: New: [4/5] mptcp: parse and act on incoming FASTCLOSE option
1395133: New: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - Reviewed by Geliang and Mat
     - Changes requested
     - Florian is also modifying Packetdrill to validate that \o/

1396503: New: Re: [PATCH MPTCP 3/5] mptcp: add mptcp reset option support:
     - not sure why patchwork detected this

1396876: New: [mptcp-next,1/2] mptcp: drop rm_addr_signal flag
1396877: New: [mptcp-next,2/2] mptcp: rename add_addr_signal and =

mptcp_add_addr_status:
     - Waiting for review

1397295: New: [v4,mptcp-next,01/13] mptcp: unify ADD_ADDR and echo =

suboptions writing
1397297: New: [v4,mptcp-next,02/13] mptcp: unify ADD_ADDR and ADD_ADDR6 =

suboptions writing
1397298: New: [v4,mptcp-next,03/13] mptcp: add port support for ADD_ADDR =

suboption writing
1397299: New: [v4,mptcp-next,04/13] mptcp: use adding up size to get =

ADD_ADDR length
1397300: New: [v4,mptcp-next,05/13] mptcp: add the outgoing ADD_ADDR =

port support
1397301: New: [v4,mptcp-next,06/13] mptcp: send out dedicated packet for =

ADD_ADDR using port
1397302: New: [v4,mptcp-next,07/13] mptcp: add port parameter for =

mptcp_pm_announce_addr
1397303: New: [v4,mptcp-next,08/13] mptcp: print out port and ahmac when =

receiving ADD_ADDR
1397304: New: [v4,mptcp-next,09/13] mptcp: add port number check for MP_JOIN
1397305: New: [v4,mptcp-next,10/13] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1397306: New: [v4,mptcp-next,11/13] selftests: mptcp: add port argument =

for pm_nl_ctl
1397307: New: [v4,mptcp-next,12/13] mptcp: add the mibs for ADD_ADDR =

with port
1397308: New: [v4,mptcp-next,13/13] selftests: mptcp: add testcases for =

ADD_ADDR with port:
     - v4 looks OK
     - but still an opened question about how to accept the new subflow =

on a different ports (having any other sockets listening on that port? =

setsockopt to open a new port + announce?
     - maybe OK to have it in export but not in netdev until =E2=86=91 is s=
orted =

out?
     - @Geliang: may you start a discussion about "secured" and =

"practical" solutions to accept new subflows on a different port?
     - we could also have the "sending" part send later upstream and =

wait for another solution for the receive part

1397534: New: [v2] mptcp: refine MPTCP-level ack scheduling:
     - Waiting for review

1397575: New: [net-next,1/6] mptcp: separate accouting for wmem forward =

alloc mem
1397574: New: [net-next,2/6] mptcp: protect the rx path with the msk =

socket spinlock
1397572: New: [net-next,3/6] mptcp: allocate TX skbs in msk context.
1397576: New: [net-next,4/6] mptcp: avoid a few atomic ops in the rx path
1397577: New: [net-next,5/6] mptcp: simplify mptcp_nospace
1397578: New: [net-next,6/6] mptcp: use mptcp backlog:
     - mptcp: just another complete datapath refactor
     - Mat already did a review
     - some bugs left (if not that would not be funny) but many =

improvements too!



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 106)

   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]:
       - some system can panic when a WARN is hit


     Bugs (opened, flagged as "bug" and assigned)

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti
    85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe


     Bugs (opened and flagged as "bug" and not assigned)

   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]
   105  warning in `mptcp_reset_timer()` with `mptcp_connect.sh -m mmap` =

[bug]
   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller]
   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller]
    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]
    70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
   54  ADD_ADDR: ports support [enhancement] @geliangtang
   51  MP_PRIO support [enhancement] @geliangtang
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

None.



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - memleak detection feature has been enabled, finding more issues

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - got more logs:
      # 12 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] =

- ack[ ok ]
      #                                         add[fail] got 2 =

ADD_ADDR[s] expected 4
         - Seems failing because the ADD_ADDR is received after the FIN =

was sent
         - also an mptcp_connect.sh failure, see the list

     - packetdrill (Davide):
         - Florian is working on supporting MP_FASTCLOSE + MP_TCPRESET

     - CI (Matth):
         - /



More patches to send to netdev?:
     - Once Paolo's patches have been accepted, Mat can send another =

series of Misc. patches.



Next meeting:
     - We propose to have the next meeting on Thursday, the 19th of =

November.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201119



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1539349468030249433==--
