Content-Type: multipart/mixed; boundary="===============6681193709432850005=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 10th of September 2020
Date: Tue, 15 Sep 2020 22:13:06 +0200
Message-ID: <abc3e749-cb92-14dc-7e0f-296045dbfba3@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5888

--===============6681193709432850005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 115th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi) =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (/):

/

     our repo (by: Florian Westphal, Geliang Tang, Nicolas Rybowski, =

Paolo Abeni):

1358695  Squash-to: "mptcp: add ADD_ADDR related mibs"

1355998  [mptcp-next,v2,5/5] bpf:selftests: add bpf_mptcp_sock() =

verifier tests
1355997  [mptcp-next,v2,4/5] bpf:selftests: add MPTCP test base
1355996  [mptcp-next,v2,3/5] bpf: add 'bpf_mptcp_sock' structure and helper
1355994  [mptcp-next,v2,2/5] mptcp: attach subflow socket to parent cgroup
1355993  [mptcp-next,v2,1/5] bpf: expose is_mptcp flag to bpf_tcp_sock

1355957  [v2] tcp: propagate MPTCP skb extensions on xmit splits

1355829  [mptcp-next] mptcp: use _fast lock version in __mptcp_move_skbs

1353035  [v7,mptcp-next,4/4] mptcp: add accept_subflow re-check
1353034  [v7,mptcp-next,3/4] selftests: mptcp: add ADD_ADDR mibs check =

function
1353033  [v7,mptcp-next,2/4] mptcp: add ADD_ADDR related mibs
1353032  [v7,mptcp-next,1/4] mptcp: send out ADD_ADDR with echo flag



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Christoph Paasch, Geliang Tang):

1361214  selftests/mptcp: Better delay & reordering configuration

1360310  [net] mptcp: fix kmalloc flag in mptcp_pm_nl_get_local_id

1359415  [v2,net,2/2] mptcp: fix subflow's remote_id issues
1359412  [v2,net,1/2] mptcp: fix subflow's local_id issues


     our repo (by: Florian Westphal, Geliang Tang, Mat Martineau, =

Matthieu Baerts, Paolo Abeni):


1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - :'(

1349790: Changes Requested: [mptcp-next] mptcp: keep track of receivers =

advertised window :
     - WIP

1355637: Awaiting Upstream: [v9,mptcp-next,1/8] mptcp: remove addr and =

subflow in PM netlink
1355638: Awaiting Upstream: [v9,mptcp-next,2/8] mptcp: fix =

mptcp_pm_nl_rm_addr_received logic issue
1355639: Awaiting Upstream: [v9,mptcp-next,3/8] mptcp: implement =

mptcp_pm_remove_subflow
1355643: Awaiting Upstream: [v9,mptcp-next,4/8] mptcp: fix every =

subflow's local_id is zero
1355644: Awaiting Upstream: [v9,mptcp-next,5/8] mptcp: fix subflow's =

remote_id is zero issue
1355645: Awaiting Upstream: [v9,mptcp-next,6/8] mptcp: add RM_ADDR =

related mibs
1355646: Awaiting Upstream: [v9,mptcp-next,7/8] selftests: mptcp: add =

remove cfg in mptcp_connect
1355647: Awaiting Upstream: [v9,mptcp-next,8/8] selftests: mptcp: add =

remove addr and subflow test cases:
     - To applied but some needs to be dropped: =

https://patchwork.ozlabs.org/project/mptcp/cover/cover.1599038897.git.gelia=
ngtang(a)gmail.com/

1356477: Needs Review / ACK: Squash-to: "mptcp: add the incoming RM_ADDR =

support":
     - Paolo will look at it

1357123: Awaiting Upstream: [mptcp-net] mptcp: Wake up MPTCP worker when =

DATA_FIN found on a TCP FIN packet:
     - TODO Matth =E2=86=92 done
     - Mat will send it to netdev soon after

1357953: RFC: [RFC,mptcp-next,1/3] mptcp: split mptcp_clean_una function
1357954: RFC: [RFC,mptcp-next,2/3] mptcp: rework poll+nospace handling
1357955: RFC: [RFC,mptcp-next,3/3] mptcp: try to clean data inplace if =

possible:
     - Florian will rebase on top of Paolo' series
     - Depending on the modifications needed after the rebase, Paolo =

will look at that
     - a new version is in progress by Florian

1358623: New: Squash-to: "mptcp: remove addr and subflow in PM netlink v9":
     - Paolo will review once the original series is applied

1358780: New: Squash-to: "mptcp: allow picking different xmit subflows":
     - TODO: Matth =E2=86=92 status

1359494: New: Squash-to: "mptcp: implement mptcp_pm_remove_subflow v9":
     - Paolo will review once the original series is applied

1360606: New: [mptcp-next] mptcp: retransmit ADD_ADDR when timeout:
     - Need review
     - Mat will look at it

1360640: Under Review: [net-next,1/2] Squash-to: "mptcp: allow picking =

different xmit subflows":
     - changing the behaviour of the packet scheduler, see below

1360641: Under Review: [net-next,2/2] Squash-to: "mptcp: simult flow =

self-tests":
     - Under review by Mat

1361446: New: [v2] mptcp: call tcp_cleanup_rbuf on subflows:
     - Mat is looking at it



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 84)

   89  kmemleak in cookie_tcp_reqsk_alloc (mptcp_join.sh):
       - just created and linked to an email reported by Geliang
   87  [interop] watchdog: BUG: soft lockup - CPU#2 stuck for 22s [bug]:
       - due to a recent modification
       - last time was OK
       - quick to reproduce
   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
       - check 10 times no failure to mark as OK
       - check with packetdrill -vvv

     Bugs (opened, flagged as "bug" and assigned)

   85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
       - see above

   84  Received DATA_FIN+FIN does not trigger wakeup [bug] v5.9 =

@mjmartineau =E2=80=A1:
       - a patch has been sent, to be applied soon =E2=86=92 TODO Matth

   81  packetdrill detects mismatching 'B' flag in mp_join_client.pkt =

[bug] @dcaratti
   69  Packetdrill: dss: failing with new DATA_FIN patches [bug] @dcaratti:
       - TODO Matth =E2=86=92 done
       - if no news from Matth, can be merged at the end of the week

     Bugs (opened and flagged as "bug" and not assigned)

   87  [interop] watchdog: BUG: soft lockup - CPU#2 stuck for 22s [bug]
   83  [syzkaller] No output from test machine [bug]

   71  [interop] Bad mapping: ssn=3D16194949 map_seq=3D16120693 =

map_data_len=3D31416 [bug] [interop]:
       - it is now closed

   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
   65  clearing properly the status in listen() [bug]

   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug] =

[syzkaller] :
       - we can close it or wait another week
       - last hit was last week when using commits from the export =

branch on the 28th of August

   56  msk connection state set without msk lock [bug]

     In Progress (opened and assigned)

   82  improve packet scheduler for asymmetric links [enhancement] @pabeni :
       - see below in Scheduler section

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe :
       - Nicolas needs to send them upstream

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang
   50  REMOVE_ADDR support [enhancement] @geliangtang
   49  ADD_ADDR: echo bit support [enhancement] @geliangtang :
       - See patches linked to them

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

   86  selftests: mptcp_join tests are creating warnings [bug] @pabeni
   73  Simultaneous xmit issue [bug]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Scheduler:
     - Here is what Paolo proposes:

         Update the scheduler to less trivial heuristic: cache the last =

used subflow, and try to send on it a reasonably long burst of data.
         When the burst or the subflow send space is exhausted, pick the =

subflow with the lower ratio between write space and send buffer - that =

is, the subflow with the greater relative amount of free space.
 =

https://patchwork.ozlabs.org/project/mptcp/patch/ca41af6d8fa3dd99ef3dcdc92c=
079663075d42b6.1599474962.git.pabeni(a)redhat.com/

     - Christoph suggests to do some measurements. Hard to say if it is =

a good idea or not without testing.
     - But we need to be careful with what we queue, ideally not to =

queue more than what we can transfer for each subflow.

     - In mptcp.org:
         - we pick the subflow with the lowest RTT

         - then we push to fill up the send space: to fill up the =

congestion window:
             =E2=86=92 all these data can be "sent directly"
             =E2=86=92 we don't build a queue of data
             =E2=86=92 important not to have to deal too much with this que=
ue =

(reinject packets to another queue)

         - once the congestion window is filled up or there is no more =

data to transmit, we go back to step one =E2=86=92 pick subflow with lowest=
 RTT

         - in the tests that were done, using the RTT showed good results



Patches to net-next:
     - Paolo suggests to start sending patches (backlog is consequent)
     - The idea is to send the ones related to XMit once the squash-to =

patches are accepted (and validated)
     - once net-next is sync with -net, we can also send the patches =

related to ADD_ADDR and REMOVE_ADDR
     - other patches from Florian (buffer + fast lock) are independent =

with the rest and can be sent when you have time



Extra tests:
     - news about Syzkaller? (Christoph):
         - Github tickets have been updated
         - Just opened a new one 88, trying to get more information

     - news about interop with mptcp.org? (Christoph):
         - See above (Github ticket)
         - Will check if other tests than the failing one are OK

     - news about Intel's kbuild? (Mat):
         - no news on export branch builds, tests are still marked as =

unstable
         - Mat will try to reach the team managing them
         - but still testing mptcp selftests for patches sent to net-next
         - see: [mptcp] db71a2f198: WARNING:inconsistent_lock_state

     - packetdrill (Davide):
         - Waiting for Matth to merge PR

     - CI (Matth):
         - add kmemleak?:
             - TODO: Matth
         - issues with packetdrill: bisect to =

https://github.com/torvalds/linux/commit/2a9127fcf2296674d58024f83981f40b12=
8fffea =

but is it really the issue? =E2=86=92 apparently yes



Next meeting:
     - We propose to have the next meeting on Thursday, the 17th of =

September.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200917



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6681193709432850005==--
