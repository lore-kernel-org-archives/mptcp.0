Content-Type: multipart/mixed; boundary="===============3496459121635990195=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 30th of July 2020
Date: Fri, 07 Aug 2020 23:34:49 +0200
Message-ID: <be071bc6-f49b-735f-0340-06fb7b6cb0fe@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5521

--===============3496459121635990195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last week, we had our 110th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi), =

Nicolas and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Christoph Hellwig, Matthieu Baerts):

1336841  [net] mptcp: fix joined subflows with unblocking sk
1336444  Re: get rid of the address_space override in setsockopt v2
1335658  [iproute2] mptcp: show all endpoints when no ID is specified

     our repo (by: Mat Martineau, Matthieu Baerts):

1336746  [mptcp-net] mptcp: fix joined subflows with unblocking sk
1335275  [mptcp-next,v4,12/12] mptcp: Safely store sequence number when
1335272  [mptcp-next,v4,11/12] mptcp: Safely read sequence number when l
1335274  [mptcp-next,v4,10/12] mptcp: Skip unnecessary skb extension all
1335273  [mptcp-next,v4,09/12] mptcp: Only use subflow EOF signaling on
1335271  [mptcp-next,v4,08/12] mptcp: Use full MPTCP-level disconnect st
1335270  [mptcp-next,v4,07/12] mptcp: Add helper to process acks of DATA
1335269  [mptcp-next,v4,06/12] mptcp: Use MPTCP-level flag for sending D
1335268  [mptcp-next,v4,05/12] mptcp: Track received DATA_FIN sequence n
1335265  [mptcp-next,v4,04/12] mptcp: Add mptcp_close_state() helper
1335263  [mptcp-next,v4,03/12] mptcp: Remove outdated and incorrect comm
1335264  [mptcp-next,v4,02/12] mptcp: Return EPIPE if sending is shut do
1335266  [mptcp-next,v4,01/12] mptcp: Allow DATA_FIN in headers without



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Christoph Paasch, Florian Westphal, Geliang Tang, =

Matthieu Baerts):

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - TODO Matth

1327905: Awaiting Upstream: [mptcp-iproute2] mptcp: show all endpoints =

when no ID is specified:
     - TODO Matth =E2=86=92 change state

1337426: New: [mptcp-next] selftests/mptcp: Better delay & reordering =

configuration:
     - To be reviewed

1338597: New: [RFC,v3,01/10] tcp: remove cookie_ts bit from request_sock
1338598: New: [RFC,v3,02/10] mptcp: token: move retry to caller
1338599: New: [RFC,v3,03/10] mptcp: subflow: split subflow_init_req
1338600: New: [RFC,v3,04/10] mptcp: rename and export =

mptcp_subflow_request_sock_ops
1338601: New: [RFC,v3,05/10] tcp: pass want_cookie down to req_init =

function
1338602: New: [RFC,v3,06/10] mptcp: subflow: add =

mptcp_subflow_init_cookie_req helper
1338603: New: [RFC,v3,07/10] tcp: syncookies: create mptcp request =

socket for ACK cookies with MPTCP option
1338604: New: [RFC,v3,08/10] mptcp: enable JOIN requests even if cookies =

are in use
1338605: New: [RFC,v3,09/10] selftests: mptcp: make 2nd net namespace =

use tcp syn cookies unconditionally
1338606: New: [RFC,v3,10/10] selftests: mptcp: add test cases for mptcp =

join tests with syn cookies:
     - Florian will send them soon to netdev

1338758: New: [v4,mptcp-next,1/5] mptcp: rename addr_signal and the =

related functions
1338760: New: [v4,mptcp-next,2/5] mptcp: add the outgoing RM_ADDR support
1338761: New: [v4,mptcp-next,3/5] mptcp: add the incoming RM_ADDR support
1338762: New: [v4,mptcp-next,4/5] mptcp: trigger the RM_ADDR signal
1338763: New: [v4,mptcp-next,5/5] mptcp: add remove subflow support:
     - Paolo will review the new version



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 64)

   69  Packetdrill: dss: failing with new DATA_FIN patches [bug]:
       - maybe normal

   68  selftests: diag: failing with new DATA_FIN patches [bug]:
       - to be investigated

   67  `./mptcp_connect.sh -m mmap` timeout [bug]:
       - could happen if there is not enough memory, unlikely possible =

according to Paolo =E2=86=92 we don't receive the wake up signal if limited=
 by =

the sendbuffer

   66  [interop] IPv4: Attempt to release TCP socket in state 1 =

00000000cbc88a4a [bug]:
       - maybe introduced by the last series from Paolo

   65  clearing properly the status in listen() [bug]:
       - not blocking but still to be done


     Bugs (open and flagged as "bug")

   69  Packetdrill: dss: failing with new DATA_FIN patches [bug]
   68  selftests: diag: failing with new DATA_FIN patches [bug]
   67  `./mptcp_connect.sh -m mmap` timesout [bug]
   66  [interop] IPv4: Attempt to release TCP socket in state 1 =

00000000cbc88a4a [bug]
   65  clearing properly the status in listen() [bug]
   64  Kernel crash when using `pm_nl_ctl` and `use_mptcp.sh` [bug]
   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug]

   56  msk connection state set without msk lock [bug] @pabeni:
       - can be closed: patch has been sent.
       - Matth: TODO

    6  loss and delay without reordering causes very slow transfer [bug] =

@cpaasch:
        - Patch has been shared


     In Progress (open and assigned to someone)

   49  ADD_ADDR: echo bit support [enhancement] @pkrystad:
       - could be re-assigned maybe? Follow-up: Contacted @pkrystad, =

this can be reassigned

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] @cpaasch:
       - Christoph will look if it is necesseraly (some paths are =

already tested)

   17  allow non 'backup' subflows creation [enhancement] @pabeni:
       - more complex than expected, already 15 patches and some issues =

to fix
       - for the moment the packet scheduler is "suboptimal": sending on =

subflows having the bigger available snd space
       - limited by the send buffer at the MPTCP level? Smaller than the =

sum of the ones of the two subflows?
       - built to be modular later :)


     Recently closed (since last week)

   63  New subflows send MP_JOIN to port 0 [bug]
   58  Full DATA_FIN support [enhancement] v5.9 @mjmartineau =E2=80=A1



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.9): =

https://github.com/multipath-tcp/mptcp_net-next/projects/1
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - New issue was sent on Github

     - news about interop with mptcp.org? (Christoph):
         - New issue sent on Github
         - tested the export branch and with Florian patches, everything =

looks fine!

     - news about Intel's kbuild? (Mat):
         - No email (success/failure)
         - Jenkins status: seems still broken

     - packetdrill (Davide):
         - Sync with Google upstream repo
         - Some fixes for the MP_JOIN
         - One fix also for ADD_ADDR (in review)
         - Some tests might need to be adapted due to the recent =

modification with the DATA_FIN =E2=86=92 Mat will look at that

     - CI (Matth):
         - goal: run all packetdrill tests
         - next step: reproducers from syzkaller

mptcpd:
     [davide] initial specfile =

(https://gitlab.com/dcaratti/mptcpd/-/blob/main/mptcpd.spec) that builds =

in a copr (https://copr.fedorainfracloud.org/coprs/dcaratti/mptcpd/ )

     [davide] I will file a package request for fedora, after "todo" =

items are done (and check if %license is correct):
     - One question about the license to be clarified by Ossama and Mat
     - "make check" cannot be ran if the host kernel needs to be MPTCP =

out-of-tree
     - mptcpd will support Net-next in the next version



"bounced" messages: what to do?:
     - recently received a lot of spams
     - maybe an issue on RedHat side wrongly scoring stuff
     - Davide can open an issue on RedHat IT side
     - Difficult for Mat to get more details



Next meeting:
     - We propose to have the next meeting on Thursday, the 6th of August.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200806



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3496459121635990195==--
