Content-Type: multipart/mixed; boundary="===============5757167883474737946=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 24th of September 2020
Date: Wed, 30 Sep 2020 22:15:31 +0200
Message-ID: <0c5f2c29-46de-fd22-cca6-b8cbb5e603df@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6120

--===============5757167883474737946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 117th meeting with Mat and Ossama (Intel OTC), =

Paolo, Davide and Florian (RedHat), Geliang (Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau, Paolo Abeni):

1368467  [net,v3] mptcp: Wake up MPTCP worker when DATA_FIN found on a TC...

1366446  [net-next] mptcp: fix integer overflow in =

mptcp_subflow_discard_data()


     our repo (by: Florian Westphal, Geliang Tang):

1368324  [mptcp-next] Squash-to: "mptcp: retransmit ADD_ADDR when =

timeout v5"

1368118  [v5,mptcp-next,3/3] mptcp: retransmit ADD_ADDR when timeout
1368117  [v5,mptcp-next,2/3] mptcp: add sk_stop_timer_sync helper
1368113  [v5,mptcp-next,1/3] mptcp: add struct mptcp_pm_add_entry

1367894  [mptcp-next,2/2] Squash-to: "mptcp: implement =

mptcp_pm_remove_subflow...
1367893  [mptcp-next,1/2] Squash-to: "mptcp: remove addr and subflow in =

PM net...

1361694  [mptcp-next] mptcp: split mptcp_clean_una function



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Geliang Tang, Nicolas Rybowski):

1370199  [net-next,16/16] mptcp: retransmit ADD_ADDR when timeout
1370197  [net-next,15/16] mptcp: add sk_stop_timer_sync helper
1370195  [net-next,14/16] mptcp: add struct mptcp_pm_add_entry
1370193  [net-next,13/16] selftests: mptcp: add remove addr and subflow =

test c...
1370182  [net-next,12/16] selftests: mptcp: add remove cfg in mptcp_connect
1370181  [net-next,11/16] mptcp: add mptcp_destroy_common helper
1370179  [net-next,10/16] mptcp: add RM_ADDR related mibs
1370177  [net-next,09/16] mptcp: implement mptcp_pm_remove_subflow
1370174  [net-next,08/16] mptcp: remove addr and subflow in PM netlink
1370173  [net-next,07/16] mptcp: add accept_subflow re-check
1370171  [net-next,06/16] selftests: mptcp: add ADD_ADDR mibs check function
1370169  [net-next,05/16] mptcp: add ADD_ADDR related mibs
1370166  [net-next,04/16] mptcp: send out ADD_ADDR with echo flag
1370165  [net-next,03/16] mptcp: add the incoming RM_ADDR support
1370162  [net-next,02/16] mptcp: add the outgoing RM_ADDR support
1370160  [net-next,01/16] mptcp: rename addr_signal and the related =

functions

1366857  [bpf-next,v3,3/5] bpf: add 'bpf_mptcp_sock' structure and helper
1366854  [bpf-next,v3,2/5] mptcp: attach subflow socket to parent cgroup:
     - v4 is needed with bigger changes not requested before (BTF support)


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1349790: Changes Requested: [mptcp-next] mptcp: keep track of receivers =

advertised window:

1357954: RFC: [RFC,mptcp-next,2/3] mptcp: rework poll+nospace handling
1357955: RFC: [RFC,mptcp-next,3/3] mptcp: try to clean data inplace if =

possible:
     - should be rebased on top of Paolo' series (sendmsg refactor)

1362441: Changes Requested: [net] tcp: fix syn cookied MPTCP request =

socket leak:
     - causing issue in selftests
     - will check later

1367888: Under Review: [v2,mptcp-next] mptcp: add ADD_ADDR IPv6 support:
     - working on a v3

1368822: Changes Requested: [mptcp-next,1/3] mptcp: add add_addr_echo sysctl
1368823: Changes Requested: [mptcp-next,2/3] mptcp: add add_addr_timeout =

sysctl
1368824: Changes Requested: [mptcp-next,3/3] selftests: mptcp: add =

ADD_ADDR timeout test case:
     - something that should be easy to do with packetdrill
     - but validating basic support with selftests would be good as well =

(e.g. dropping echo bits with netfilter)

1370680: New: [RFC,1/8] tcp: factor out __tcp_close() helper
1370678: New: [RFC,2/8] mptcp: introduce mptcp_schedule_work
1370676: New: [RFC,3/8] mptcp: reduce the arguments of mptcp_sendmsg_frag
1370679: New: [RFC,4/8] mptcp: add accounting for pending data
1370681: New: [RFC,5/8] mptcp: introduce MPTCP snd_nxt
1370684: New: [RFC,6/8] mptcp: refactor shutdown and close
1370683: New: [RFC,7/8] mptcp: move page frag allocation in mptcp_sendmsg()
1370682: New: [RFC,8/8] mptcp: try to push pending data on snd una updates:
     - sendmsg refactor
     - patch 6 might overlap with what Mat did (to be checked)
     - some selftests don't pass yet
     - but ones they are passing, we can probably quickly merge this to =

have more tests
     - any feedback is more than welcome!
     - should fix a "use-after-free" issue reported by Paolo

1370698: New: [RFC,1/4] net: tcp: drop unused function argument from =

mptcp_incoming_options
1370700: New: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: New: [RFC,3/4] mptcp: add mptcp reset option support
1370702: New: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - it's a structure for future code later on PM side
     - first patch can be sent upstream soon



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 90)

   92  mptcp_close() deletes MPTCP socket before disconnection completes =

v5.9 @mjmartineau =E2=80=A1:
       - when doing a shutdown/close refactor, linked to what Paolo did
       - but the refactor is a bit too big for v5.9
       - do we need something: workaround or nothing?
       - problem is when testing v5.9 with mptcp.org and the issue is on =

v5.9 side causing mptcp.org to retransmit the last packet for a while
       - can be an issue with other MPTCPv1 implementation
       - =E2=86=92 do we need something specific for v5.9? yes...
       - In 5.9, we never retransmit the DATAFIN+ACK, that's why it is =

safe :)
       - might be difficult to have the new sendmsg refactoring in the =

next merge window
       - workaround: maybe send a RST when receiving retransmitted =

DATA_FIN+ACK? To tell the other hand to give up, at least to clear states!

   91  MPJ: Fallback to TCP if the client receives a 4th ACK without DSS =

options from the server [bug]:
       - there is a packetdrill test to easily reproduce the issue


     Bugs (opened, flagged as "bug" and assigned)

   89  kmemleak in cookie_tcp_reqsk_alloc (mptcp_join.sh) [bug] @pabeni:
       - WIP

   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
       - WIP
       - Davide doesn't have the issue
       - Matth has the issue only with the wrapper to launch multiple tests
       - TODO: Matth: detail what was found on the ticket

   84  Received DATA_FIN+FIN does not trigger wakeup [bug] v5.9 =

@mjmartineau =E2=80=A1:
       - can be closed
       - TODO: Matth =E2=86=92 done by Mat


     Bugs (opened and flagged as "bug" and not assigned)

   91  MPJ: Fallback to TCP if the client receives a 4th ACK without DSS =

options from the server [bug]

   87  [interop] watchdog: BUG: soft lockup - CPU#2 stuck for 22s [bug] =

[interop]:
       - closed!

   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]:
       - Christoph was able to reproduce it

   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   92  mptcp_close() deletes MPTCP socket before disconnection completes =

v5.9 @mjmartineau =E2=80=A1:
       =E2=86=92 should be flagged as bug
       - TODO: Matth: =E2=86=91 =E2=86=92 done by Mat

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe:
       - a new version of the patches is needed

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang:
       - WIP

   54  ADD_ADDR: ports support [enhancement] @geliangtang:
       - For later

   50  REMOVE_ADDR support [enhancement] @geliangtang:
       - can be closed!
       - Matth: todo =E2=86=92 done

   49  ADD_ADDR: echo bit support [enhancement] @geliangtang:
       - can be closed! (even if one selftest is in progress)
       - Matth: todo =E2=86=92 done

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

   90  mptcp_connect.sh: BUG in mptcp_pm_free_anno_list() [bug] @geliangtang

   88  [syzkaller] INFO: task hung in lock_sock_nested

   82  improve packet scheduler for asymmetric links [enhancement] @pabeni

   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug] =

[syzkaller]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - =E2=86=92 see GitHub

     - news about interop with mptcp.org? (Christoph):
         - =E2=86=92 see GitHub

     - news about Intel's kbuild? (Mat):
         - didn't hear any news

     - packetdrill (Davide):
         - when the first DATAFIN packet is received, no other packets =

can be treated by Packetdrill
         - probably a bug in packetdrill that needs to be analysed
         - TODO: Matth: create a Github ticket to track this =E2=86=92 Done=
: 94

     - CI (Matth):
         - got some issues with mptcp_connect.sh -m mmap
         - VM memory could be related to an issue with this test
         - TODO: Matth: add this in a new selftests to have more tests =

by others
         - TODO: Matth: get more info in case of timeout: enable debug =

dynamically + sysrq?



Next steps:
     - having more stress tests!



Python:
     - add support for IPPROTO_MPTCP =E2=86=92 Matth is looking at that



Tests for later:
     - use an upstream kernel with MPTCP on a phone (Linux/Android)



Next meeting:
     - We propose to have the next meeting on Thursday, the 1st of October.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201001



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5757167883474737946==--
