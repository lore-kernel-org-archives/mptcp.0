Content-Type: multipart/mixed; boundary="===============3441697730068717148=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 1st of October 2020
Date: Fri, 02 Oct 2020 17:52:56 +0200
Message-ID: <84ab12ca-d274-a2e4-1c2e-96816271b38b@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6167

--===============3441697730068717148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 118th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau):

1373835  [net,2/2] mptcp: Handle incoming 32-bit DATA_FIN values
1373833  [net,1/2] mptcp: Consistently use READ_ONCE/WRITE_ONCE with =

msk->ack_...

     our repo (by: Mat Martineau):

1373835  [net,2/2] mptcp: Handle incoming 32-bit DATA_FIN values
1373833  [net,1/2] mptcp: Consistently use READ_ONCE/WRITE_ONCE with =

msk->ack_...



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1357954: RFC: [RFC,mptcp-next,2/3] mptcp: rework poll+nospace handling
1357955: RFC: [RFC,mptcp-next,3/3] mptcp: try to clean data inplace if =

possible:
     - Now in Paolo' series
     - TODO: Matth: superseded =E2=86=92 done for 2/3

1362441: Changes Requested: [net] tcp: fix syn cookied MPTCP request =

socket leak:
     - Both Paolo and Florian didn't get the reported error
     - maybe due to something else
     - v2 will be needed anyway (rebase required)
     - TODO: Matth: retest =E2=86=92 done: OK

1368822: Rejected: [mptcp-next,1/3] mptcp: add add_addr_echo sysctl:
     - replaced by Netfilter rules.

1370698: New: [RFC,1/4] net: tcp: drop unused function argument from =

mptcp_incoming_options:
     - was sent upstream

1370700: New: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: New: [RFC,3/4] mptcp: add mptcp reset option support
1370702: New: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP (on PM side)

1372421: Changes Requested: [v3,mptcp-next,1/2] mptcp: send out =

dedicated ADD_ADDR packet
1372422: Changes Requested: [v3,mptcp-next,2/2] selftests: mptcp: add =

subflow and ADD_ADDR IPv6 test cases:
     - still some discussions ongoing
     - TODO: Matth: check ADD_ADDR ignored in some conditions? reordering?

1374890: New: [v5,mptcp-next,1/2] mptcp: add a new sysctl add_addr_timeout
1374891: New: [v5,mptcp-next,2/2] selftests: mptcp: add ADD_ADDR timeout =

test case:
     - can be applied =E2=86=92 done

1374921: New: [mptcp-next] mptcp: skip to next candidate if subflow has =

unacked data:
     - saw when testing what was happening when one subflow is put down
     - was the simpler way to fix the issue
     - Florian will share the script later to reproduce that =E2=86=92 done

1375085: New: [v2,01/13] mptcp: more DATA FIN fixes
1375086: New: [v2,02/13] mptcp: don't skip needed ack
1375088: New: [v2,03/13] tcp: factor out __tcp_close() helper
1375089: New: [v2,04/13] mptcp: introduce mptcp_schedule_work
1375090: New: [v2,05/13] mptcp: reduce the arguments of mptcp_sendmsg_frag
1375091: New: [v2,06/13] mptcp: add accounting for pending data
1375092: New: [v2,07/13] mptcp: introduce MPTCP snd_nxt
1375093: New: [v2,08/13] mptcp: refactor shutdown and close
1375095: New: [v2,09/13] mptcp: move page frag allocation in mptcp_sendmsg()
1375094: New: [v2,10/13] mptcp: try to push pending data on snd una updates
1375096: New: [v2,11/13] mptcp: rework poll+nospace handling
1375097: New: [v2,12/13] mptcp: keep track of advertised windows right edge
1375098: New: [v2,13/13] mptcp: send explicit ack on delayed ack_seq incr:
     - compared to v1:
         - new patches from Florian at the end
         - less bugs :)
     - the 2 first patches can be upstreamed (for -net and net-next)
     - we can probably apply all patches and modify them later =E2=86=92 to=
 have =

more tests and easier to maintain the patches if they are on the export =

branch
     - could be nice to also have feedback from syzkaller
     - =E2=86=92 so for the next merge window (except the 2 first patches w=
hen =

they are reviewed)
     - TODO: Matth: apply them tomorrow =E2=86=92 we can also wait next week

1375155: New: [mptcp-next] mptcp: ADD_ADDRs with echo bit are smaller:
     - Fixing issue 95


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 92)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe:
       - we discussed about that last week

   95  Additional random values are set with ADD_ADDR+echo bit packets =

[bug] @matttbe
       - See above, there is a fix


   94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti:
       - Davide is on it, should be fix soon


     Bugs (opened, flagged as "bug" and assigned)

   95  Additional random values are set with ADD_ADDR+echo bit packets =

[bug] @matttbe:
       - see above

   94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti:
       - see above

   92  mptcp_close() deletes MPTCP socket before disconnection completes =

[bug] v5.9 @mjmartineau =E2=80=A1:
       - workaround could be to send a RST (MP_FASTCLOSE?)
       - Sending MP_FASTCLOSE would cause other issues: would replace =

the DATA_FIN and would be interpreted differently
       - proper solution coming with Paolo's refactoring of shutdown() =

and close()
       - Without a fix, we would have the other end retransmitting data
       - we cannot really combine MP_FASTCLOSE and DATA_FIN
       - let's do it the Redmond's way: continue until the issue is reported
       - at that time, we might have a better view on how we can fix it =

nicely on stable

   89  kmemleak in cookie_tcp_reqsk_alloc (mptcp_join.sh) [bug] @pabeni:
       - see above (patches)

   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
       - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   91  MPJ: Fallback to TCP if the client receives a 4th ACK without DSS =

options from the server [bug]
   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe:
       - see above

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe:
       - new version in progress

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang:
       - WIP =E2=86=92 see patches

   54  ADD_ADDR: ports support [enhancement] @geliangtang:
       - Assigned to Geliang

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch:
       - /


     Recently closed (since last week)

   93  32-bit DATA_FIN not expanded to 64 bits [bug] v5.9 @mjmartineau =E2=
=80=A1
   87  [interop] watchdog: BUG: soft lockup - CPU#2 stuck for 22s [bug] =

[interop]
   84  Received DATA_FIN+FIN does not trigger wakeup [bug] v5.9 =

@mjmartineau =E2=80=A1
   50  REMOVE_ADDR support [enhancement] @geliangtang
   49  ADD_ADDR: echo bit support [enhancement] @geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - updating Syzkaller now

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - start getting updates again, for every export branch again
         - showing 24 failures, not all are net related
         - none of them are MPTCP related
         - they also have issues to build some BPF tests

     - packetdrill (Davide):
         - Would be nice to validate more the DATA_FIN part:
             - note that currently, when we send the close, we can only =

look at the first next packet (dedicated DATA_FIN) but not after (TCP =

FIN) =E2=86=92 issue 94
             - once this is fix, we could validate more cases around =

DATA_FIN sending/handling

         - MP_JOIN: they need to be modified to ack the ADD_ADDR =

(echo-bit) =E2=86=92 Davide is looking at that.

     - CI (Matth):
         - /



Next meeting:
     - We propose to have the next meeting on Thursday, the 8th of October.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201008



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3441697730068717148==--
