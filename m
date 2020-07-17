Content-Type: multipart/mixed; boundary="===============6064938320602580567=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 16th of July 2020
Date: Fri, 17 Jul 2020 18:03:49 +0200
Message-ID: <7cce7a12-6516-ee69-ee2c-a5a99fa102b0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5079

--===============6064938320602580567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 108th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Nicolas and =

myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Paolo Abeni, YueHaibing):

1329176  [net-next] mptcp: Remove unused inline function mptcp_rcv_synse
1326857  [iproute2-next,2/2] ss: mptcp: add msk diag interface support
1326855  [iproute2-next,1/2] include: update mptcp uAPI

     our repo (by: Paolo Abeni):

1327059  [net-next,9/9] subflow: introduce and use mptcp_can_accept_new_
1327058  [net-next,8/9] subflow: use rsk_ops->send_reset()
1327057  [net-next,7/9] subflow: explicitly check for plain tcp rsk
1327056  [net-next,6/9] mptcp: cleanup subflow_finish_connect()
1327055  [net-next,5/9] mptcp: make msk established at remote key recept
1327054  [net-next,4/9] mptcp: zero token hash at creation time.
1327053  [net-next,3/9] mptcp: mark as fallback even early ones
1327052  [net-next,2/9] mptcp: avoid data corruption on reinsert
1327050  [net-next,1/9] subflow: always init 'rel_write_seq'



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Davide Caratti):

1329812  [net-next] mptcp: silence warning in subflow_data_ready()

     our repo (by: Florian Westphal, Geliang Tang, Mat Martineau, =

Matthieu Baerts, Paolo Abeni):

1319755: Needs Review / ACK: [RFC,5/5] subflow: do not create child =

subflow for fallback MP_JOIN:
     - the patch has been dropped (controversial changes)
     - in SYN cookies patches, there is a similar issue that can maybe =

be addressed the same way.

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - *Matth* it needs to be split

1327905: New: [mptcp-iproute2] mptcp: show all endpoints when no ID is =

specified:
     - *waiting for review*

1329030: Changes Requested: [RFC,01/11] mptcp: move helper to where its =

used
1329029: Changes Requested: [RFC,02/11] tcp: remove cookie_ts bit from =

request_sock
1329031: Changes Requested: [RFC,03/11] tcp: syncookies: use single =

reqsk_free location
1329032: Changes Requested: [RFC,04/11] mptcp: token: move retry to caller
1329033: Changes Requested: [RFC,05/11] mptcp: subflow: split =

subflow_init_req into helpers
1329034: Changes Requested: [RFC,06/11] mptcp: rename and export =

mptcp_subflow_request_sock_ops
1329035: Changes Requested: [RFC,07/11] mptcp: subflow: add =

mptcp_subflow_init_cookie_req helper
1329036: Changes Requested: [RFC,08/11] tcp: syncookies: keep mptcp =

option enabled
1329037: Changes Requested: [RFC,09/11] tcp: handle want_cookie clause =

via reqsk_put
1329038: Changes Requested: [RFC,10/11] mptcp: enable JOIN requests even =

if cookies are in use
1329039: Changes Requested: [RFC,11/11] selftests: mptcp: make 2nd net =

namespace use tcp syn cookies unconditionally:
     - *Florian* agrees with the comments
     - he will create an update soon
     - just one issue with the cast, discussions are ongoing, also =

linked to the discussions we had on "subflow: do not create child =

subflow for fallback MP_JOIN" 's patch
     - we need to store the nonce sent on the SYN =E2=86=92 can be stored i=
n the =

~master~ MPTCP socket, not the request one

1329874: Changes Requested: [mptcp-next,01/12] mptcp: Allow DATA_FIN in =

headers without TCP FIN
1329876: Changes Requested: [mptcp-next,02/12] mptcp: Return EPIPE if =

sending is shut down during a sendmsg
1329878: Changes Requested: [mptcp-next,03/12] mptcp: Add =

mptcp_close_state() helper
1329875: Changes Requested: [mptcp-next,04/12] mptcp: Track received =

DATA_FIN sequence number and add related helpers
1329881: Changes Requested: [mptcp-next,05/12] mptcp: Use MPTCP-level =

flag for sending DATA_FIN
1329882: Changes Requested: [mptcp-next,06/12] mptcp: Add helper to =

process acks of DATA_FIN
1329886: Changes Requested: [mptcp-next,07/12] mptcp: Send DATA_FIN in =

appropriate states during shutdown or close
1329884: Changes Requested: [mptcp-next,08/12] mptcp: Use full =

MPTCP-level disconnect state machine
1329879: Changes Requested: [mptcp-next,09/12] mptcp: Only use subflow =

EOF signaling on fallback connections
1329883: Changes Requested: [mptcp-next,10/12] mptcp: Skip unnecessary =

skb extension allocation for bare acks
1329885: Changes Requested: [mptcp-next,11/12] mptcp: Safely read =

sequence number when lock isn't held
1329880: Changes Requested: [mptcp-next,12/12] mptcp: Safely store =

sequence number when sending data:
     - *Paolo* reviewed that before the meeting
     - discussions are ongoing.
     - selftests are passing \o/
     - there are interesting corner cases detected by the selftests =

which is good!
     - *Mat* will shoot a new version later

1330069: Changes Requested: [net-next] mptcp: add REMOVE_ADDR support v1:
     - *Paolo* reviewed that before the meeting
     - one open question choices made during the implementation
     - sending the REMOVE_ADDR =E2=86=92 we should send it, it's not mandat=
ory
     - hard to keep track of what has been announced =E2=86=92 if we sent a=
n =

ADD_ADDR before
     - often, the client will send REMOVE_ADDR =E2=86=92 it's more unlikely=
 that =

the server looses one address.
     - so we should optimise this UC: client sends RM_ADDR, the server =

processes it



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/
 =

https://github.com/multipath-tcp/mptcp_net-next/issues?q=3Dis%3Aissue+is%3A=
open+no%3Alabel
 =

https://github.com/multipath-tcp/mptcp_net-next/issues?q=3Dis%3Aissue+is%3A=
open+no%3Aproject

     open: (latest from last week: 47)

   60  PM: netlink: events per connection [enhancement]
   59  TFO support [enhancement]
   58  Full DATA_FIN support [enhancement] v5.9 @mjmartineau =E2=80=A1
   57  After a few attempts of failed MPTCP, directly fallback to TCP =

for new connections [enhancement]

   56  msk connection state set without msk lock [bug]:
       - when working on DATA_FIN support, Mat discovered that
       - Paolo already has some ideas
       - issue introduced by patches only in the export branch
       - Paolo hopes sending a patch addressing this issue soon

   55  ADD_ADDR: IPv6 support [enhancement]
   54  ADD_ADDR: ports support [enhancement]
   53  MP_TCPRST support [enhancement]
   52  MP_FAIL support [enhancement]
   51  MP_PRIO support [enhancement]
   50  REMOVE_ADDR support [enhancement]
   49  ADD_ADDR: echo bit support [enhancement] @pkrystad
   48  MP_FASTCLOSE support [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] @cpaasch
   42  remove unneeded branches in critical path [enhancement]
   41  reduce indirect call usage [enhancement]
   31  Allow MPTCP + SYN_COOKIES [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   21  sort-out {set,get}sockopt handling [enhancement]
   19  let PM netlink update live sockets on local addresses list change =

[enhancement]
   18  allow 'force to MPTCP' mode [enhancement]
   17  allow non 'backup' subflows creation [enhancement] @pabeni
   15  reduce mptcp_out_option struct size [enhancement]
    6  loss and delay without reordering causes very slow transfer [bug] =

@cpaasch

     recently closed:

   47  mptcp_join selftests are failing since "mptcp: fix race in =

subflow_data_ready()" [bug] @dcaratti
   39  [syzkaller] WARNING in subflow_data_ready (v2.0) @dcaratti
   30  ssh restart does not work
   20  implement msk diag interface [enhancement] @pabeni
    4  keep a single work struct in mptcp socket [enhancement]
    2  reduce hooking in TCP code


FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/
         - FAST_CLOSE:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/48 =

(future)

         - RM_ADDR:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/50 =

(future)
             - to be assign to Geliang (geliangtang username on Github)

         - MP_PRIO:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/51 =

(future)

         - MP_FAIL:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/52 =

(future)

         - MP_TCPRST:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/53 =

(future)

         - after a few attempts of failed MPTCP, we fallback to TCP =

(cache like TFO is doing):=E2=86=92 =

https://github.com/multipath-tcp/mptcp_net-next/issues/57 (future)

         - PM server (more advanced) [DONE by Paolo]

         - Active backup support [WIP by Paolo]:
             - https://github.com/multipath-tcp/mptcp_net-next/issues/17
             - do we need a new issue?

         - sending "simultaneously" on different subflows (multiple non =

backup subflows) [WIP by Paolo]:
             =E2=86=92 same as above?
             - out of order in reception side is also in the list
             - we will need an RB-tree for that
             - *Christoph* can also do some tests with the mptcp.org =

implementation

         - easily allow other apps to use MPTCP (sysctl, bpf, systemtap, =

LD_PRELOAD =E2=86=92 doc?) [WIP Nicolas]:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/18 =

or de we need new stories per idea?
             - split might help to keep track on what is done there
             - *Matth* TODO =E2=86=91

         - Full DATA_FIN support [WIP by Mat]:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/58 =

(next)

         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/49 =

(future)

         - Opti in TCP option structures (unions) [DONE by Paolo]

         - Shared recv window (full support) [DONE by Florian]

     - Part 5 (extra needed for prod):
         - ADD_ADDR: support v6 =E2=86=92 too long:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/55 =

(future)

         - ADD_ADDR: support ports:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/54 =

(future)

         - opti/perfs: too vague, no new ticket

         - TFO:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/59 =

(future)

         - PM netlink per connection:
             =E2=86=92 https://github.com/multipath-tcp/mptcp_net-next/issu=
es/60 =

(future)

         - PM bpf TODO
         - Scheduler bpf TODO
         - syncookies [WIP Florian] TODO
         - [gs]etsockopt per subflow: BPF TODO
         - [gs]etsockopt: forward to new/existing SF TODO
         - notify the userspace when a subflow is added/removed =E2=86=92 c=
msg TODO
         - *Matth* TODO =E2=86=91



Already done?:
     - IPv6 - IPv4 mapped support:
         - Seems YES

     - not dropping MPTCP options (ADD_ADDR, etc.):
          - too long messages are not sent if we never have room
          - see issue 55



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - see above (pending patches)

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - no news

     - RM_ADDR support (Geliang):
         - see above (pending patches)



Extra tests:
     - news about Syzkaller? (Christoph):
         - nothing new on Christoph side
         - there is a new one from syzbot
         - it seems nobody looked at it
         - *Matth* TODO: create a new issue

     - news about interop with mptcp.org? (Christoph):
         - *Christoph* will try more tests with Florian's patches
         - anybody has a public server with MPTCP? not here
         - If needed, *Florian* can setup a server at home
         - idea would be to scan for servers supporting MPTCP (MPTCPv1)
         - if we want to check upstream, we can test if checksum is =

supported but not needed now

     - news about Intel's kbuild? (Mat):
         - Mat didn't receive new emails but tests are running! (success!)

     - packetdrill (Davide):
         - mp_join client test seems broken
         - we can see SYN+MP_JOIN but to port 0?
         - *Davide* tried to reproduce that with a test and the good =

port is picked
         - maybe something with the routing rules? Not sure the right =

rules are set there.
         - To be investigated more

     - Coverity (Davide):
         - (no news here)

     - CI (Matth):
         - now running with last version of iproute2 with MPTCP support =

in ss
         - other small improvement for reproduction and logging



Netlink PM: per connection:
     - plans? (linked to Ossama's email)
     - combining the two APIs?
     - first we should focus on being able to use multiple paths at the =

same path
     - then look at how we can notify the userspace =E2=86=92 trying to loo=
k at =

being as closed as possible to the API from mptcp.org
     - PM: assuming that it can be done sync while with Netlink, we will =

have the notification and the action done later



sockopt:
     - example with the mark =E2=86=92 forward to subflows and use BPF to c=
hange =

something per SF?
     - copy the info from the msk to the subflow sk?
     - only stuff we select =E2=86=92 not all
     - to be discussed again later



BPF:
     - how to know if a sk is MPTCP? =E2=86=92 We can get events about the =
MPTCP =

sk by looking at the "protocol"
     - how to know if a sk is a subflow? =E2=86=92 we would need a new help=
er / =

extend bpf_sock (or bpf_tcp_sock)
     - not so many events with the MPTCP sk:
         - because BPF callback are not called for the MPTCP sk
         - e.g. tcp_set_state() call a BPF callback but we only use this =

for the subflows
         - we would need to add callback there



Next meeting:
     - We propose to have the next meeting on Thursday, the 23th of July.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200723



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6064938320602580567==--
