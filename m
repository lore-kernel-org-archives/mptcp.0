Content-Type: multipart/mixed; boundary="===============1650037223859112593=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 3rd of September 2020
Date: Sat, 05 Sep 2020 12:44:15 +0200
Message-ID: <5521bc92-8bf6-eb2b-0c7d-06c5f1954b99@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5731

--===============1650037223859112593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 114th meeting with Mat (Intel OTC), Christoph =

(Apple), Paolo and Davide (RedHat), Geliang (Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Davide Caratti, YueHaibing):

1355689  [net-next] selftests: mptcp: fix typo in mptcp_connect usage
1353662  [net-next] mptcp: Remove unused macro MPTCP_SAME_STATE


     our repo (by: Florian Westphal, Paolo Abeni):

1353755  fix for most poll selftest timeouts
1352466  [v2] Squash-to: "mptcp: cleanup mptcp_subflow_discard_data()"
1349374  [mptcp-next,1/1] mptcp: fix stale subflow->writeable caching
1349247  [mptcp-next] mptcp: free acked data before waiting for more memory
1349244  [mptcp-next] mptcp: only wake parent if subflow is writable
1348371  [mptcp-next,v3] mptcp: adjust mptcp receive buffer limit if =

subflow h...



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Nicolas Rybowski):

1349344  [bpf-next,3/3] bpf: add 'bpf_mptcp_sock' structure and helper
1349341  [bpf-next,2/3] mptcp: attach subflow socket to parent cgroup


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Nicolas Rybowski, Paolo Abeni):

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - TODO: Matth

1349790: Changes Requested: [mptcp-next] mptcp: keep track of receivers =

advertised window:
     - Florian is working on a v2

1353032: Awaiting Upstream: [v7,mptcp-next,1/4] mptcp: send out ADD_ADDR =

with echo flag
1353033: Awaiting Upstream: [v7,mptcp-next,2/4] mptcp: add ADD_ADDR =

related mibs
1353034: Awaiting Upstream: [v7,mptcp-next,3/4] selftests: mptcp: add =

ADD_ADDR mibs check function
1353035: Awaiting Upstream: [v7,mptcp-next,4/4] mptcp: add =

accept_subflow re-check:
     - TODO: Matth =E2=86=92 done

1355637: New: [v9,mptcp-next,1/8] mptcp: remove addr and subflow in PM =

netlink
1355638: New: [v9,mptcp-next,2/8] mptcp: fix =

mptcp_pm_nl_rm_addr_received logic issue
1355639: New: [v9,mptcp-next,3/8] mptcp: implement mptcp_pm_remove_subflow
1355643: New: [v9,mptcp-next,4/8] mptcp: fix every subflow's local_id is =

zero
1355644: New: [v9,mptcp-next,5/8] mptcp: fix subflow's remote_id is zero =

issue
1355645: New: [v9,mptcp-next,6/8] mptcp: add RM_ADDR related mibs
1355646: New: [v9,mptcp-next,7/8] selftests: mptcp: add remove cfg in =

mptcp_connect
1355647: New: [v9,mptcp-next,8/8] selftests: mptcp: add remove addr and =

subflow test cases:
     - Paolo will look at that
     - v10 will arrive next week

1355829: Awaiting Upstream: [mptcp-next] mptcp: use _fast lock version =

in __mptcp_move_skbs:
     - TODO: Matth =E2=86=92 Done
     - Florian was right, as usual :-)

1355957: New: [v2] tcp: propagate MPTCP skb extensions on xmit splits:
     - TODO: Matth =E2=86=92 Done

1355993: Awaiting Upstream: [mptcp-next,v2,1/5] bpf: expose is_mptcp =

flag to bpf_tcp_sock
1355994: Awaiting Upstream: [mptcp-next,v2,2/5] mptcp: attach subflow =

socket to parent cgroup
1355996: Awaiting Upstream: [mptcp-next,v2,3/5] bpf: add =

'bpf_mptcp_sock' structure and helper
1355997: Awaiting Upstream: [mptcp-next,v2,4/5] bpf:selftests: add MPTCP =

test base
1355998: Awaiting Upstream: [mptcp-next,v2,5/5] bpf:selftests: add =

bpf_mptcp_sock() verifier tests:
     - TODO: Matth =E2=86=92 done
     - Then can be sent upstream

1356477: New: Squash-to: "mptcp: add the incoming RM_ADDR support":
     - needs review



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 82)

   84  Received DATA_FIN+FIN does not trigger wakeup [bug] v5.9 =

@mjmartineau =E2=80=A1:
       - when checking 5.8 (Fedora) vs 5.9-rc3 (-net master branch)
       - because of a FIN without data payload
       - Mat is looking at that
       - Could be related to an issue seen by Paolo

   83  [syzkaller] No output from test machine:
       - Christoph will try to reproduce it
       - it means: the VM died and disappeared
       - there is a reproducer with an MPTCP socket
       - not sure if it is linked to MPTCP code


     Bugs (opened, flagged as "bug" and assigned)

   84  Received DATA_FIN+FIN does not trigger wakeup [bug] v5.9 =

@mjmartineau =E2=80=A1:
       - see above

   81  packetdrill detects mismatching 'B' flag in mp_join_client.pkt =

[bug] @dcaratti:
       - Should be addressed with PR#18 in Packetdrill
       - Matth: TODO =E2=86=92 review this PR#18 and merge (or Davide can =

self-merge it)

   69  Packetdrill: dss: failing with new DATA_FIN patches [bug] @dcaratti:
       - Should be addressed with PR#17 in Packetdrill
       - Matth: TODO =E2=86=92 review this PR#17 and merge (or Davide can =

self-merge it)


     Bugs (opened and flagged as "bug" and not assigned)

   73  Simultaneous xmit issue [bug]
       - can be closed
       - Matth: TODO update ticket

   71  [interop] Bad mapping: ssn=3D16194949 map_seq=3D16120693 =

map_data_len=3D31416 [bug] [interop]
       - can be closed after an ACK from @Christoph
       - Matth: TODO update ticket

   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
   65  clearing properly the status in listen() [bug]

   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug] =

[syzkaller]:
       - Matth: TODO update ticket

   56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   82  improve packet scheduler for asymmetric links [enhancement] @pabeni :
       - after having tweaked the scheduler, links with different =

conditions can be fully used
       - having an issue but more experiments are needed

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang
   50  REMOVE_ADDR support [enhancement] @geliangtang
   49  ADD_ADDR: echo bit support [enhancement] @geliangtang :
       - see patches above

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch :
       - WIP


     Recently closed (since last week)

   67  `./mptcp_connect.sh -m mmap` test blocks [bug]
   17  allow non 'backup' subflows creation [enhancement] @pabeni



Patches from the "export" branch:
     - multiple xmit:
         - we would need to wait for the selftests to be enabled =E2=86=92 =

linked to #82
         - alternative: enable selftests for symmetric links and fixes =

later?
         - will see how it is going in the next weeks with #82

     - REMOVE_ADDR: could be sent when the last patch (squashed-to) is =

integrated

     - selftests/mptcp: Better delay & reordering configuration:
         - Christoph can send that



New features for net-next:
     - continue to let the different authors to send patches from the =

"export" branch to net-next?
     - Or maintain an mptcp-next branch sync with net-next and ask for a =

pull?
     - at the end, that's more for the net maintainers. Maybe at some =

points they will suggest us to send PR instead of individual patches?
     - Should we start discussions with them about that? Or just wait?
     - no decision yet, we continue like before



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - see Github section

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - we got a report on the ML (unpacking failed) but doesn't seem =

related to MPTCP
         - selftests are still unstable, seems related to the setup, not =

MPTCP code
         - not sure any more what is running: also testing the new =

selftests?
         - Mat will monitor that

     - packetdrill (Davide):
         - planning to work on:
             - DATA_FIN: to cover this feature better (see GH discussions)
             - covering MP_PRIO

     - CI (Matth):
         - packetdrill tests are failing
         - maybe linked to #84? =E2=86=92 No, see #85
         - Matth: TODO =E2=86=92 take traces on "any" =E2=86=92 DONE, see #=
85
         - Matth: continue the "git bisect"
         - Davide has issues only with MP_JOIN (src addr)



Next meeting:
     - We propose to have the next meeting on Thursday, the 10th of =

September.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200910



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1650037223859112593==--
