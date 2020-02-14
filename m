Content-Type: multipart/mixed; boundary="===============8323331550775817853=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 13th of February 2020
Date: Fri, 14 Feb 2020 16:27:38 +0100
Message-ID: <8863b4f0-329f-0e5b-7f90-10fb30aeaa50@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3658

--===============8323331550775817853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 86th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By /



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Florian Westphal, Mat Martineau, Matthieu Baerts, Paolo Abeni, =

Peter Krystad

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - same as last week

1233392: Needs Review / ACK: subflow: place outgoing connections on the =

join list:
     - by Florian
     - *Waiting for review*

1233648: Needs Review / ACK: [RFC,1/3] mptcp: Check connection state =

before attempting send
1233650: Needs Review / ACK: [RFC,2/3] mptcp: Use per-subflow storage =

for DATA_FIN sequence number
1233649: Needs Review / ACK: [RFC,3/3] mptcp: Only send DATA_FIN with =

final mapping:
     - by Mat
     - needed for "net" ideally
     - *waiting for review* : should not be too long/hard

1235143: New: mptcp: Protect subflow socket options before connection =

completes:
     - got some reviews
     - v2 is needed (at least a change in the commit message + switch to =

other function for tcp_[gs]etsockopt)

1235200: New: [1/2] mptcp: Re-factor mptcp_crypto_hmac_sha()
1235198: New: [2/2] mptcp: Make v1 changes for ADD_ADDR and RM_ADDR options:
     - by Peter
     - got a few reviews

1236411: New: [RFC,1/6] Squash-to: "mptcp: Add ADD_ADDR handling"
1236416: New: [RFC,2/6] Squash-to: "mptcp: Add path manager interface"
1236413: New: [RFC,3/6] Squash-to: "mptcp: Add handling of incoming =

MP_JOIN requests"
1236414: New: [RFC,4/6] Squash-to: "mptcp: Add handling of outgoing =

MP_JOIN requests"
1236415: New: [RFC,5/6] Squash-to: "mptcp: Implement path manager =

interface commands":
     - by Paolo
     - WIP
     - got reviews from Florian

1236417: New: [RFC,6/6] mptcp: add netlink based PM:
     - can be nice to review this one because it introduces a netlink API
     - once it's upstream, hard to change
     - *waiting for review*

1236945: New: mptcp: select CRYPTO
1236960: New: [RFC,net] mptcp: select CRYPTO:
     - kconfig complains there is a missing dependency
     - should we send it?:
         - yes. If not accepted, we squash it (see above patch)
     - we will need it for MP_JOIN

1237408: New: [RFC,1/5] mptcp: perform mptcp ack update during read =

operations
1237409: New: [RFC,2/5] tcp: permit skb stealing in recv actor
1237410: New: [RFC,3/5] mptcp: add and use mptcp_data_ready helper
1237411: New: [RFC,4/5] mptcp: update mptcp ack sequence from work queue
1237412: New: [RFC,5/5] mptcp: add rmem queue accounting:
     - by Florian
     - got some reviews by Paolo



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
         - Shared recv window (drop data received on other subflows) [TODO]:
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

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink
         - PM bpf
         - Scheduler bpf
         - syncookies
         - [gs]etsockopt per subflow



Part 3 remaining stuff:
     - Review commit messages:
         - needed for the next merge window: not urgent

     - PM:
         - Paolo is looking at that
         - waiting for reviews
         - patches 1 =E2=86=92 5 should not change a lot
         - patches 6 is going to change a bit

     - reduce locks when mptcp_stream_accept (currently 3 locks) but we =

might need to add an helper in inet API:
         - TODO

     - MP_JOIN self-tests:
         - TODO
         - there is a dependence on the PM (with netlink)
         - and even a dependence in the other way because it is used to =

validate the PM
         - =E2=86=92 so part of the new PM

     - packetdrill:
         - David is working on that
         - https://github.com/multipath-tcp/packetdrill/pull/1
         - TODO: *Matth* : try it (with the CI) and if positive, we merge
         - we might need to update DSS related tests when Florian's =

patches are going to be merged

         - Davide is testing two scripts related to TCP fallback but =

they are failing at the end:
             - https://paste.centos.org/view/94fdbe8d :

=3D=3D=3D=3D
`../common/defaults.sh`

+0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
+0    setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0

+0    bind(3, ..., ...) =3D 0
+0    listen(3, 1) =3D 0
+0      < S 0:0(0) win 32792 <mss 1460,sackOK,nop,nop,nop,wscale =

7,mpcapable v1 flags[flag_h] nokey>
+0      > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale =

8,mpcapable v1 flags[flag_h] key[skey] >
+0.01   < . 1:1(0) ack 1 win 257 <mpcapable v1 flags[flag_h] =

key[ckey=3D2,skey]>
+0    accept(3, ..., ...) =3D 4

// server does 2 writes, 100 bytes each
+0.1    < P. 1:201(200) ack 1 win 225
//+0      > .  1:1(0) ack 201  <dss dack8=3D1 ssn=3D1 dll=3D0 nocs>
+0      > .  1:1(0) ack 201

+0    read(4, ..., 200) =3D 200
+0    write(4, ..., 100) =3D 100
+0      > P. 1:101(100) ack 201
+0    < . 201:201(0) ack 101 win 225
=3D=3D=3D=3D

                 - failing at line 16
                 - there is a RST with DSS options

             - https://paste.centos.org/view/875e1ea0 :

=3D=3D=3D=3D
`../common/defaults.sh`

+0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
+0    setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0

+0    bind(3, ..., ...) =3D 0
+0    listen(3, 1) =3D 0
+0      < S 0:0(0) win 32792 <mss 1460,sackOK,nop,nop,nop,wscale =

7,mpcapable v1 flags[flag_h] nokey>
+0      > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale =

8,mpcapable v1 flags[flag_h] key[skey] >
+0.01   < . 1:1(0) ack 1 win 257 <mpcapable v1 flags[flag_h] =

key[ckey=3D2,skey]>
+0    accept(3, ..., ...) =3D 4

// server does 2 writes, 100 bytes each
+0    write(4, ..., 100) =3D 100
+0      > P. 1:101(100) ack 1 <dss dack8=3D1 dsn8=3D1 ssn=3D1 dll=3D100 noc=
s, =

nop, nop>
+0.1    < . 1:1(0) ack 101 win 225
+0    write(4, ..., 100) =3D 100
+0      > P. 101:201(100) ack 1
+0.1    < . 1:1(0) ack 201 win 225
=3D=3D=3D=3D

                 - failing at line 18
                 - there are DSS options while we should not

             - Question is: when should we fallback to TCP when we don't =

receive MPTCP option with the TCP ACK?:
                 - related to =C2=A73.7 of =

https://www.rfc-editor.org/authors/rfc8684.html#name-fallback
                 - it is possible that there are some bugs: not =

respecting the RFC
                 - better to always include the DSS ACK
                 - receiver: to validate the path, it needs to receive a =

full window of data with DSS ACK
                 - sender: to validate the path: get the 4th ACK
                 - What if the 3rd ACK is lost/OOO?
                 - TODO *Christoph/Paolo* : To be continued on the ML

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - TODO

     - ADD_ADDR for MPTCPv1:
         - Peter is looking at that
         - show the options processing
         - the echo will required the PM to be validated

     - DATA_FIN:
         - Mat is looking at that
         - once the pending patches are accepted, they will be sent to =

netdev (at least the 2 first ones):
             - https://patchwork.ozlabs.org/patch/1233648/
             - https://patchwork.ozlabs.org/patch/1233650/

         - for the last one, it should not be an issue with one subflow =

but improve the logic:
             - https://patchwork.ozlabs.org/patch/1233649/
             - still a better protection and small

         - *waiting for reviews*

     - Shared received windows:
         - Florian is looking at that (indirectly)



Extra tests:
     - news about Syzkaller? (see prev meeting):
         - running on the "export" branch
         - looking good so far

     - new about Intel's kbuild? (Mat):
         - one test where MPTCP is not ON by default but maybe tries =

random config's:
             - found an issue with CRYPTO (patch sent)
         - one test where MPTCP is ON by default:
             - everything OK
         - MPTCP should be enabled on other builds, waiting for an answer



[gs]etsockopt:
     - idea:
         - new getsockopt to get "ids" of subflows
         - new [gs]etsockopt to pass that to a specific subflow:
 =

https://github.com/bhesmans/mptcp/commit/0b2c48a366d98d94ef195d7dbb834e3214=
41a6dc
         - idea for later

     - get notified when there are changes in subflows?:
         - http://man7.org/linux/man-pages/man3/cmsg.3.html ?
         - could be interesting to be notified from the userspace when =

there is a fallback to TCP
         - apps will create MPTCP socket: it there is a fallback, it =

could be nice to be notified (push event)



Next meeting:
     - We propose to have the next meeting on Thursday, the 20th of =

February.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200220



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
--===============8323331550775817853==--
