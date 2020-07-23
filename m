Content-Type: multipart/mixed; boundary="===============3447472576339750852=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 23rd of July 2020
Date: Thu, 23 Jul 2020 18:36:12 +0200
Message-ID: <8c87d80b-80d2-49a2-a1b9-5dffb1f7d508@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5252

--===============3447472576339750852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 109th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi), =

Nicolas and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Paolo Abeni):

1333946  [net-next] mptcp: zero token hash at creation time.
1330779  [05/22] net: remove compat_sock_common_{get,set}sockopt

     our repo (by: Paolo Abeni):

1332184  [v2] Squash-to: "mptcp: make msk established at remote key =

reception ...
1331274  Squash-to: "subflow: introduce and use =

mptcp_can_accept_new_subflow()"



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Christoph Hellwig, Paolo Abeni):

1334734  [net-next,8/8] subflow: introduce and use =

mptcp_can_accept_new_subflo...
1334731  [net-next,7/8] subflow: use rsk_ops->send_reset()
1334732  [net-next,6/8] subflow: explicitly check for plain tcp rsk
1334730  [net-next,5/8] mptcp: cleanup subflow_finish_connect()
1334728  [net-next,4/8] mptcp: explicitly track the fully established =

status
1334727  [net-next,3/8] mptcp: mark as fallback even early ones
1334720  [net-next,2/8] mptcp: avoid data corruption on reinsert
1334724  [net-next,1/8] subflow: always init 'rel_write_seq':
     - everything from the export branch

1334464  [25/26] net: pass a sockptr_t into ->setsockopt
1334442  [08/26] net: switch sock_set_timeout to sockptr_t:
     - not directly related to MPTCP


     our repo (by: Florian Westphal, Geliang Tang, Mat Martineau, =

Matthieu Baerts, Paolo Abeni):

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - *Matth* TODO

1327905: Needs Review / ACK: [mptcp-iproute2] mptcp: show all endpoints =

when no ID is specified:
     - to be reviewed

1331246: Changes Requested: [net] mptcp: explicitly zeros msk fields on =

clone:
     - can be dropped
     - real fix is quite different, almost unrelated

1333328: New: [RFC,v2,mptcp-next,01/12] tcp: remove cookie_ts bit from =

request_sock
1333330: New: [RFC,v2,mptcp-next,02/12] tcp: syncookies: use single =

reqsk_free location
1333332: New: [RFC,v2,mptcp-next,03/12] mptcp: token: move retry to caller
1333334: New: [RFC,v2,mptcp-next,04/12] mptcp: subflow: split =

subflow_init_req into helpers
1333337: New: [RFC,v2,mptcp-next,05/12] mptcp: rename and export =

mptcp_subflow_request_sock_ops
1333338: New: [RFC,v2,mptcp-next,06/12] tcp: remove sk_listener const =

qualifier from req_init function
1333339: New: [RFC,v2,mptcp-next,07/12] tcp: pass want_cookie down to =

req_init function
1333342: New: [RFC,v2,mptcp-next,08/12] mptcp: subflow: add =

mptcp_subflow_init_cookie_req helper
1333343: New: [RFC,v2,mptcp-next,09/12] tcp: syncookies: create mptcp =

request socket for ACK cookies with MPTCP option
1333345: New: [RFC,v2,mptcp-next,10/12] tcp: handle want_cookie clause =

via reqsk_put
1333348: New: [RFC,v2,mptcp-next,11/12] mptcp: enable JOIN requests even =

if cookies are in use
1333349: New: [RFC,v2,mptcp-next,12/12] selftests: mptcp: make 2nd net =

namespace use tcp syn cookies unconditionally:

     - If there is no other feedback in MPTCP ML or Netdev, *Florian* =

will send the series next week without the RFC tag

1333668: Changes Requested: [v2,mptcp-next,1/4] mptcp: rename the =

existing ADD_ADDR related functions
1333669: Changes Requested: [v2,mptcp-next,2/4] mptcp: add the RM_ADDR =

option writing
1333671: Changes Requested: [v2,mptcp-next,3/4] mptcp: add the RM_ADDR =

option parsing
1333675: Changes Requested: [v2,mptcp-next,4/4] mptcp: trigger the =

RM_ADDR signal:

     - Paolo reviewed it and sent some suggestions
     - *Geliang* will sent a new version next week
     - there is an opened question in patch 3/4 in =

mptcp_pm_nl_rm_addr_received() function about the shutdown of the subflow

1334279: New: [mptcp-next,v2,01/12] mptcp: Allow DATA_FIN in headers =

without TCP FIN
1334281: New: [mptcp-next,v2,02/12] mptcp: Return EPIPE if sending is =

shut down during a sendmsg
1334283: New: [mptcp-next,v2,03/12] mptcp: Remove outdated and incorrect =

comment
1334280: New: [mptcp-next,v2,04/12] mptcp: Add mptcp_close_state() helper
1334287: New: [mptcp-next,v2,05/12] mptcp: Track received DATA_FIN =

sequence number and add related helpers
1334286: New: [mptcp-next,v2,06/12] mptcp: Use MPTCP-level flag for =

sending DATA_FIN
1334288: New: [mptcp-next,v2,07/12] mptcp: Add helper to process acks of =

DATA_FIN
1334285: New: [mptcp-next,v2,08/12] mptcp: Use full MPTCP-level =

disconnect state machine
1334284: New: [mptcp-next,v2,09/12] mptcp: Only use subflow EOF =

signaling on fallback connections
1334291: New: [mptcp-next,v2,10/12] mptcp: Skip unnecessary skb =

extension allocation for bare acks
1334289: New: [mptcp-next,v2,11/12] mptcp: Safely read sequence number =

when lock isn't held
1334290: New: [mptcp-next,v2,12/12] mptcp: Safely store sequence number =

when sending data:

     - v3 expected
     - checkpatch fixes are needed
     - *Mat* is looking at that


Issues on Github:

     Recently opened: (latest from last week: 60)

   64  Kernel crash when using `pm_nl_ctl` and `use_mptcp.sh` [bug]:
       - no issue with ip mptcp

   63  New subflows send MP_JOIN to port 0 [bug]:
       - easy to reproduce but not an issue in the selftests

   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow:
       - found yesterday but no reproducer yet

   61  move msk clone after ctx creation [enhancement]:
       - would be better

     Bugs (open and flagged as "bug"):

   64  Kernel crash when using `pm_nl_ctl` and `use_mptcp.sh` [bug]
   63  New subflows send MP_JOIN to port 0 [bug]

   56  msk connection state set without msk lock [bug] @pabeni:
        - should be addressed in current export branch
        - *Mat* maybe there are still some lock missing for some?

    6  loss and delay without reordering causes very slow transfer [bug] =

@cpaasch:
        - maybe not a "bug"
        - *Christoph* will look at that, feel free to change the tag

     In Progress (open and assigned to someone)

   58  Full DATA_FIN support [enhancement] v5.9 @mjmartineau =E2=80=A1:
       - v3 is expected

   49  ADD_ADDR: echo bit support [enhancement] @pkrystad:
       - no news from *Peter*

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] @cpaasch:
       - /

   17  allow non 'backup' subflows creation [enhancement] @pabeni:
       - Paolo is working on that (using subflows in //)
       - found a bug: corruption when packets are received and the =

window is full (if I understood correctly)
       - solution: let spin the lock (not the bottle)
       - seems difficult to work without it
       - *Paolo* will share RFC, would be easier to understand the issue :)

     Recently Closed

   47  mptcp_join selftests are failing since "mptcp: fix race in =

subflow_data_ready()" [bug] @dcaratti



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.9): =

https://github.com/multipath-tcp/mptcp_net-next/projects/1
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - no update by mail but it seems the builds are failing
         - looks like an issue on kbuild' side

     - packetdrill (Davide):
         - *Davide* looking at writing new tests for the fallback use case

     - CI (Matth):
         - Installed latest version of tcpdump
         - decode the stacktrace if any found during the tests
         - automatically mark patches as merged on patchwork when applied
         - + mark previous versions as "Superseded"

     - Coverity (Davide):
         - /
         - note: they are certainly only looking at Linus' branch so we =

need to wait
         - so no need to check this each week
         - *Matth* remove it from the list: Davide will talk about it =

when needed



Netdev 0x14:
     - Mat recorded a talk about MPTCP yesterday
     - scheduled on the 21st of August, last day
     - start the 13th but only 3-4h per day
     - description has changed a bit
     - =

https://netdevconf.info/0x14/session.html?talk-using-upstream-MPTCP-in-linu=
x-systems



mptcpd:
     - *Davide* is looking at packaging it for Fedora
     - But running into some issues
     - Ossama and Mat are happy to help
     - maybe one lib is not packaged: ell (embedded linux lib)
     - lwd is maybe using ell



BPF:
     - Nicolas is working on marking subflows using BPF (setsockopt)
     - new field in bpf_tcp_sock needed to get access to tp->is_mptcp
     - new BPF callback will be added, e.g. for additional subflows not =

using tcp_connect() and thus not having the BPF callback when connected, =

etc.



Next meeting:
     - We propose to have the next meeting on Thursday, the 30th of July.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200730



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Math
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3447472576339750852==--
