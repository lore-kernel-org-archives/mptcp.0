Content-Type: multipart/mixed; boundary="===============0428353914069423901=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 17th of September 2020
Date: Fri, 18 Sep 2020 17:45:05 +0200
Message-ID: <02e1f38d-24eb-ac2f-1516-b8eb52d15003@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5936

--===============0428353914069423901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 116th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi) =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Paolo Abeni):

1363375  [net-next,v2,13/13] mptcp: simult flow self-tests
1363372  [net-next,v2,12/13] mptcp: call tcp_cleanup_rbuf on subflows
1363371  [net-next,v2,11/13] mptcp: allow picking different xmit subflows
1363370  [net-next,v2,10/13] mptcp: allow creating non-backup subflows
1363369  [net-next,v2,09/13] mptcp: move address attribute into =

mptcp_addr_info
1363368  [net-next,v2,08/13] mptcp: add OoO related mibs
1363366  [net-next,v2,07/13] mptcp: cleanup mptcp_subflow_discard_data()
1363367  [net-next,v2,06/13] mptcp: move ooo skbs into msk out of order =

queue.
1363365  [net-next,v2,05/13] mptcp: introduce and use mptcp_try_coalesce()
1363362  [net-next,v2,04/13] mptcp: basic sndbuf autotuning
1363364  [net-next,v2,03/13] mptcp: trigger msk processing even for OoO =

data
1363363  [net-next,v2,02/13] mptcp: set data_ready status bit in =

subflow_check...
1363359  [net-next,v2,01/13] mptcp: rethink 'is writable' conditional


     our repo (by: Geliang Tang, Mat Martineau, Matthieu Baerts, Paolo =

Abeni):

1365992  [v2,mptcp-next] Squash-to: "mptcp: remove addr and subflow in =

PM netl...

1364271  [v3,mptcp-next,2/2] mptcp: add mptcp_destroy_common helper
1364268  [v3,mptcp-next,1/2] Squash-to: "mptcp: remove addr and subflow =

in PM ...

1362609  [net-next] Squash-to: "mptcp: allow picking different xmit =

subflows"
1362120  [net-next] Squash-to: "mptcp: allow picking different xmit =

subflows"

1361446  [v2] mptcp: call tcp_cleanup_rbuf on subflows

1360641  [net-next,2/2] Squash-to: "mptcp: simult flow self-tests"

1359494  Squash-to: "mptcp: implement mptcp_pm_remove_subflow v9"

1357123  [mptcp-net] mptcp: Wake up MPTCP worker when DATA_FIN found on =

a TCP ...

1356477  Squash-to: "mptcp: add the incoming RM_ADDR support"

1355647  [v9,mptcp-next,8/8] selftests: mptcp: add remove addr and =

subflow tes...
1355646  [v9,mptcp-next,7/8] selftests: mptcp: add remove cfg in =

mptcp_connect
1355645  [v9,mptcp-next,6/8] mptcp: add RM_ADDR related mibs
1355639  [v9,mptcp-next,3/8] mptcp: implement mptcp_pm_remove_subflow
1355637  [v9,mptcp-next,1/8] mptcp: remove addr and subflow in PM netlink

1325171  [mptcp-next] selftests: mptcp: interpret \n as a new line



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Colin Ian King, Matthieu Baerts, =

Nicolas Rybowski, Ye Bin):

1365743  [v3] mptcp: Fix unsigned 'max_seq' compared with zero in =

mptcp_data_q...

1365316  [net-next] selftests: mptcp: interpret \n as a new line

1364176  [next] mptcp: fix spelling mistake "colesced" -> "coalesced"

1362472  [bpf-next,v2,3/5] bpf: add 'bpf_mptcp_sock' structure and helper
1362471  [bpf-next,v2,2/5] mptcp: attach subflow socket to parent cgroup


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1349790: Changes Requested: [mptcp-next] mptcp: keep track of receivers =

advertised window:
     - Need to rebase the work on top of Paolo's work
     - WIP

1357953: RFC: [RFC,mptcp-next,1/3] mptcp: split mptcp_clean_una function
1357954: RFC: [RFC,mptcp-next,2/3] mptcp: rework poll+nospace handling
1357955: RFC: [RFC,mptcp-next,3/3] mptcp: try to clean data inplace if =

possible:
     - WIP

1361694: New: [mptcp-next] mptcp: split mptcp_clean_una function:
     - Can be reviewed
     - Was part of the RFC above: this can be integrated stand-alone as =

it has no dependency on sendmsg refactor or poll rework.
     - but if no review on that, that will be part of the previous =

series, v2
     - Mat will look at it if no rebase needed =E2=86=92 done

1362441: Changes Requested: [net] tcp: fix syn cookied MPTCP request =

socket leak:
     - Geliang had some failure with the patch
     - Maybe something related to timing?
     - TODO: Matth: validate this with the environment of the CI

1366099: New: [v4,mptcp-next,1/2] mptcp: add struct mptcp_pm_add_entry
1366105: New: [v4,mptcp-next,2/2] mptcp: retransmit ADD_ADDR when timeout:
     - Mat didn't have a chance to look at the v4 yet


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 89)

   90  mptcp_connect.sh: BUG in mptcp_pm_free_anno_list() [bug] @geliangtang
       - already closed


     Bugs (opened, flagged as "bug" and assigned)

   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe :
       - investigation ongoing

   84  Received DATA_FIN+FIN does not trigger wakeup [bug] v5.9 =

@mjmartineau =E2=80=A1 :
       - one patch in the export branch improve interop with v5.8
       - but there are still some issue with mptcp.org
       - a lot of retransmission are seen
       - Mat is working on a patch for that, issue seems to be in the =

upstream version


     Bugs (opened and flagged as "bug" and not assigned)

   89  kmemleak in cookie_tcp_reqsk_alloc (mptcp_join.sh) [bug]:
       - Assigned to Paolo

   87  [interop] watchdog: BUG: soft lockup - CPU#2 stuck for 22s [bug] =

[interop] :
       - more info are required

   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
   65  clearing properly the status in listen() [bug]

   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug] =

[syzkaller] :
       - Not seen in one week, can be closed!

   56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   82  improve packet scheduler for asymmetric links [enhancement] @pabeni :
       - can be closed
       - similar (with the current infrastructure available)
       - time to stabilise this before extending it

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe :
       - Nicolas is going to send a v3 soon

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang :
       - no patch have been sent (yet)
   50  REMOVE_ADDR support [enhancement] @geliangtang
   49  ADD_ADDR: echo bit support [enhancement] @geliangtang :
       - two pending patches are still needed
       - we can wait next week
   54  ADD_ADDR: ports support [enhancement]  @geliangtang :
       - just assigned Geliang

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch :
       - Christoph will need support from syzkaller guys
       - Maybe some stuff missing in syzkaller (inet_diag related)


     Recently closed (since last week)

   90  mptcp_connect.sh: BUG in mptcp_pm_free_anno_list() [bug] @geliangtang
   83  [syzkaller] No output from test machine [bug]
   81  packetdrill detects mismatching 'B' flag in mp_join_client.pkt =

[bug] @dcaratti
   73  Simultaneous xmit issue [bug]
   71  [interop] Bad mapping: ssn=3D16194949 map_seq=3D16120693 =

map_data_len=3D31416 [bug] [interop]
   69  Packetdrill: dss: failing with new DATA_FIN patches [bug] @dcaratti



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



What to send to netdev?:
     - ADD/REMOVE addresses changes?:
         - we need to wait for the next sync between net and net-next
         - we should send a merge request to David Miller before the WE
         - TODO: Matth: send this merge request =E2=86=92 Done

     - tcp: propagate MPTCP skb extensions on xmit splits?:
         - this could not be needed, better to wait



Extra tests:
     - news about Syzkaller? (Christoph):
         - no additional info than what was shared above

     - news about interop with mptcp.org? (Christoph):
         - no additional info than what was shared above

     - news about Intel's kbuild? (Mat):
         - got some news from the team
         - they are aware of the issues, related to changes in next-net
         - they are looking at that, should get more news next week
         - it seems MPTCP tests have been temporary disabled, also =

looking at that

     - packetdrill (Davide):
         - all tests passing on Davide' side
         - one is not passing but Davide will share a fix soon

     - CI (Matth):
         - use 2 cores by default
         - doesn't seem to be an issue, no need to have tests with only =

one core



Next meeting:
     - We propose to have the next meeting on Thursday, the 24th of =

September.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200924



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0428353914069423901==--
