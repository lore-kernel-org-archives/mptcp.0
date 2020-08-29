Content-Type: multipart/mixed; boundary="===============6974694752185795640=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 27th of August 2020
Date: Sat, 29 Aug 2020 21:37:32 +0200
Message-ID: <e57f55b6-cac9-187c-9a87-e2c5421ad1d3@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5666

--===============6974694752185795640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 113th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi), =

Nicolas and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Florian):

A patch to fix mptcp-connect.sh with "mmap"?


     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Nicolas Rybowski):

1349344  [bpf-next,3/3] bpf: add 'bpf_mptcp_sock' structure and helper
1349341  [bpf-next,2/3] mptcp: attach subflow socket to parent cgroup


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - TODO Matth

1348371: Awaiting Upstream: [mptcp-next,v3] mptcp: adjust mptcp receive =

buffer limit if subflow has larger one
1349244: Awaiting Upstream: [mptcp-next] mptcp: only wake parent if =

subflow is writable
1349247: Awaiting Upstream: [mptcp-next] mptcp: free acked data before =

waiting for more memory
1349374: Awaiting Upstream: [mptcp-next,1/1] mptcp: fix stale =

subflow->writeable caching:
     - All 4: To add in the export branch
     - Maybe we want to squash some of them
     - To add: reviewed-by from Mat

1349790: Changes Requested: [mptcp-next] mptcp: keep track of receivers =

advertised window:
     - Some discussions on-going with Mat and Florian to follow the RFC
     - Sounds a bit more complicated than expected
     - Need to check if often reach the max of the window

1350294: New: [v8,mptcp-next,1/8] mptcp: remove addr and subflow in PM =

netlink
1350295: New: [v8,mptcp-next,2/8] mptcp: fix =

mptcp_pm_nl_rm_addr_received logic issue
1350299: New: [v8,mptcp-next,3/8] mptcp: implementing =

mptcp_pm_remove_subflow
1350300: New: [v8,mptcp-next,4/8] mptcp: fix every subflow's local_id is =

zero
1350305: New: [v8,mptcp-next,5/8] mptcp: fix subflow's remote_id is zero =

issue
1350312: New: [v8,mptcp-next,6/8] mptcp: add RM_ADDR related mibs
1350317: New: [v8,mptcp-next,7/8] selftests: mptcp: add remove cfg in =

mptcp_connect
1350320: New: [v8,mptcp-next,8/8] selftests: mptcp: add remove addr and =

subflow test cases:
     - A lot of modification since last Paolo's review
     - Geliang would like Paolo to look at it
     - Paolo will try to look at it

1352233: New: [v6,mptcp-next,1/4] mptcp: drop re-check mechanism for =

PM's flags
1352235: New: [v6,mptcp-next,2/4] mptcp: send out ADD_ADDR with echo flag
1352238: New: [v6,mptcp-next,3/4] mptcp: add ADD_ADDR related mibs
1352240: New: [v6,mptcp-next,4/4] selftests: mptcp: add ADD_ADDR mibs =

check function:
     - Mat will look at the latest version

1352466: New: [v2] Squash-to: "mptcp: cleanup mptcp_subflow_discard_data()":
     - v2 fixing an issue reported by Mat
     - Mat will look at the v2



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 80)

   82  improve packet scheduler for asymmetric links [bug] [enhancement] =

@pabeni :
       - technically it is an enhancement
       - but can be seen as a bug :)
       - selftests should pass currently but this is needed

   81  packetdrill detects mismatching 'B' flag in mp_join_client.pkt =

[bug] @dcaratti :
       - needed to support multiple concurrent subflows
       - we would need to check what we would like to do:
           - extend iproute to set the backup flag (per interface? other?)
           - other ways?
       - the pull request for packetdrill is already available


     Bugs (opened, flagged as "bug" and assigned)

   82  improve packet scheduler for asymmetric links [bug] [enhancement] =

@pabeni
   81  packetdrill detects mismatching 'B' flag in mp_join_client.pkt =

[bug] @dcaratti

   69  Packetdrill: dss: failing with new DATA_FIN patches [bug] @dcaratti :
       - a PR has already been created
       - another one is coming (fixing comments from the previous PR)


     Bugs (opened and flagged as "bug" and not assigned)

   73  Simultaneous xmit issue [bug]
   71  [interop] Bad mapping: ssn=3D16194949 map_seq=3D16120693 =

map_data_len=3D31416 [bug] [interop]
   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]

   67  `./mptcp_connect.sh -m mmap` test blocks [bug] :
       - Already fixed by Florian
       - TODO Matth: add in export branch + mark as fixed =E2=86=92 done

   65  clearing properly the status in listen() [bug]
   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug] =

[syzkaller]
   56  msk connection state set without msk lock [bug]

*@Paolo* :
     - Report the issue discussed at the meeting related to "mptcp: keep =

track of receivers advertised window" patch


     In Progress (opened and assigned)

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang
   50  REMOVE_ADDR support [enhancement] @geliangtang
   49  ADD_ADDR: echo bit support [enhancement] @geliangtang :
       - see patches above

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch :
       - /

   17  allow non 'backup' subflows creation [enhancement] @pabeni :
       - can be closed
       - TODO: Matth: done


     Recently closed (since last week)

None.



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - /
         - testing the latest export branch

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - still no new emails
         - some progress seem have been done
         - Mat will continue to monitor that and report issue related to =

MPTCP if any

     - packetdrill (Davide):
         - see discussion issue 81
         - Davide is seeing the same failure: MP_JOIN, both client and =

server
         - TODO: Matth: check if there are issues with the CI when mmap =

test is fixed
         - @Davide: It seems all packetdrill tests are having issues =

(timeout)

     - CI (Matth):
         - blocked because of the timeout with mmap
         - should be fixed soon thx to Florian's patch



Netdev:
     - feedbacks:
         - lot of good questions
         - positive feedbacks!
         - some questions about alternatives and other but in general it =

went well
     - when video, slides, others are available, Mat will share them.



Last week of Nicolas as an Intern at Tessares:
     - Working on a v2 for the patch sent upstream
     - Had fun with BPF!
     - Clearer view on what we would do next with BPF.



Poll issue:
     - Paolo is looking at fixing that
     - quite complex
     - makes selftests green again :)



multiple xmits:
     - Paolo would like to send it "soon" to get feedback sooner



Data_fin:
     - Mat is continuing looking at comments that were recently reported =

and linked to DATA_FIN



Next meeting:
     - We propose to have the next meeting on Thursday, the 3rd of =

September.
     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200903



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6974694752185795640==--
