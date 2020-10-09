Content-Type: multipart/mixed; boundary="===============4700331850954233639=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 8th of October 2020
Date: Fri, 09 Oct 2020 22:52:55 +0200
Message-ID: <4ceb429e-4ef4-b775-0bdf-7b51906ab311@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6277

--===============4700331850954233639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 119th meeting with Mat and Ossama (Intel OTC), =

Paolo and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Matthieu Baerts, Paolo Abeni, Rikard =

Falkeborn):

1377527  [net-next] selftests: mptcp: interpret \n as a new line
1377217  [net-next] mptcp: fix infinite loop on recvmsg()/worker() race.
1376734  [net-next] mptcp: don't skip needed ack
1376726  [net] mptcp: more DATA FIN fixes
1376565  [net-next,v2,1/2] mptcp: Constify mptcp_pm_ops
1375648  [net] tcp: fix syn cookied MPTCP request socket leak


     our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Paolo =

Abeni):

1377493  [net-next] selftests: mptcp: interpret \n as a new line

1377396  [net] net: mptcp: make DACK4/DACK8 usage consistent among all =

subflows

1376740  [net-next] Squash-to: "mptcp: refactor shutdown and close"

1376684  [net-next] Squash-to: mptcp: move page frag allocation in =

mptcp_sendm...

1376301  [net-next] mptcp: ADD_ADDRs with echo bit are smaller

1375632  [v3,13/13] mptcp: send explicit ack on delayed ack_seq incr
1375633  [v3,12/13] mptcp: keep track of advertised windows right edge
1375634  [v3,11/13] mptcp: rework poll+nospace handling
1375631  [v3,10/13] mptcp: try to push pending data on snd una updates
1375630  [v3,09/13] mptcp: move page frag allocation in mptcp_sendmsg()
1375629  [v3,08/13] mptcp: refactor shutdown and close
1375628  [v3,07/13] mptcp: introduce MPTCP snd_nxt
1375626  [v3,06/13] mptcp: add accounting for pending data
1375627  [v3,05/13] mptcp: reduce the arguments of mptcp_sendmsg_frag
1375625  [v3,04/13] mptcp: introduce mptcp_schedule_work
1375624  [v3,03/13] tcp: factor out __tcp_close() helper
1375621  [v3,02/13] mptcp: don't skip needed ack
1375623  [v3,01/13] mptcp: more DATA FIN fixes

1375217  [v2] tcp: fix syn cookied MPTCP request socket leak

1374891  [v5,mptcp-next,2/2] selftests: mptcp: add ADD_ADDR timeout test =

case
1374890  [v5,mptcp-next,1/2] mptcp: add a new sysctl add_addr_timeout



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Davide Caratti):

1377553  [net] net: mptcp: make DACK4/DACK8 usage consistent among all =

subflows


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1372421: Changes Requested: [v3,mptcp-next,1/2] mptcp: send out =

dedicated ADD_ADDR packet
1372422: Changes Requested: [v3,mptcp-next,2/2] selftests: mptcp: add =

subflow and ADD_ADDR IPv6 test cases:
     - WIP

1374921: Needs Review / ACK: [mptcp-next] mptcp: skip to next candidate =

if subflow has unacked data:
     - Waiting for review
     - *Paolo* will have a look at it later

1375475: New: [mptcp-next] selftests: mptcp: add link failure test case:
     - Depends on the previous patch (mptcp: skip to next candidate if =

subflow has unacked data) not to have other failure in the selftests

1375893: New: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - Waiting for review
     - *Mat* will have a look at it later

1376724: New: [mptcp-next] Squash-to: mptcp: keep track of advertised =

windows right edge:
     - Can be applied: we can enable pr_debug dynamically
     - TODO: *Matth*

1378182: Changes Requested: [net,1/2] mptcp: fix fallback for MP_JOIN =

subflows
1378181: Changes Requested: [net,2/2] mptcp: subflows garbage collection:
     - Will try to send a v2 fixing Mat's comment.


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 95)

   99  simult_flows selftest is unstable: remaining sockets in TIME-WAIT =

state [bug]:
       - Could be due to out of window data we have at the end of the =

"export" branch
       - With what Paolo sent, this situation should be less frequent
       - But a final fix (non trivial so that will be for Florian :) ) =

is required

   98  dss_ssn_specified_client packetdrill test fails (timeout) [bug]:
       - seems to be an issue with packetdrill test itself
       - because the data fin are sent first and then the FIN
       - *Davide* has a PR but not fixing this specific issue right now.

   97  null ptr dereference on close timeout under memory pressure [bug] =

@pabeni :
       - introduced by the recent refactor
       - we could still enqueue data to a subflow after the it has been =

closed
       - allocation could fail, send the notification to socket struct =

but will receive a null pointer
       - should be fixed by "mptcp: mp join fallback fixes" series


     Bugs (opened, flagged as "bug" and assigned)

   97  null ptr dereference on close timeout under memory pressure [bug] =

@pabeni

   94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti :
       - the received packet doesn't match the socket
       - it doesn't match the expected socket

   92  mptcp_close() deletes MPTCP socket before disconnection completes =

[bug] @mjmartineau:
       - should be addressed by the recent sendmsg refactor, right?
       - *Mat* is going to verify this and close it if OK

   91  MPJ: Fallback to TCP if the client receives a 4th ACK without DSS =

options from the server [bug] @pabeni:
       - should be addressed by "mptcp: mp join fallback fixes" series

   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
       - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   99  simult_flows selftest is unstable: remaining sockets in TIME-WAIT =

state [bug]
   98  dss_ssn_specified_client packetdrill test fails (timeout) [bug]
   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe :
       - WIP

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe :
       - WIP

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang
   54  ADD_ADDR: ports support [enhancement] @geliangtang
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

   95  Additional random values are set with ADD_ADDR+echo bit packets =

[bug] @matttbe
   89  kmemleak in cookie_tcp_reqsk_alloc (mptcp_join.sh) [bug] @pabeni



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - *@Christoph* Is it running on top of latest export branch =

with sendmsg refactor?
         - There was one report from syzbot but already fixed by Paolo

     - news about interop with mptcp.org? (Christoph)

     - news about Intel's kbuild? (Mat):
         - got reports but still difficult to know what's wrong: we only =

have "Test X has failed"
         - Mat will check how to get more details

     - packetdrill (Davide):
         - echo-bit explicit?:
             - not mandatory, but it can be modified

     - CI (Matth):
         - could be good to continue to run on a slow server but also a =

non laggy one



selftests:
     - OK to depend on IPTables?:
         - we should at least skip the test if the tool is not available
         - and probably better to switch to nftables
         - bpftables has been deprecated, we can no longer be cool and =

do it with bpf :'(
         - TODO: *Matth*



Next meeting:
     - We propose to have the next meeting on Thursday, the 15th of October.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201015



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4700331850954233639==--
