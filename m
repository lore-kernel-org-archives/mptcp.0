Content-Type: multipart/mixed; boundary="===============7340717552247847067=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 22nd of October 2020
Date: Thu, 22 Oct 2020 18:28:57 +0200
Message-ID: <0256a7d5-6de2-144c-547f-7d6da508123b@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6407

--===============7340717552247847067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 121th meeting with Mat and Ossama (Intel OTC), =

Paolo and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Geert Uytterhoeven, Geliang Tang, =

Matthieu Baerts, Paolo Abeni):

1385623  [net] selftests: mptcp: depends on built-in IPv6
1385495  [net] mptcp: depends on IPV6 but not as a module
1384682  mptcp: MPTCP_IPV6 should depend on IPV6 instead of selecting it
1384199  mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP instead of =

selecting ...
1384177  [net-next,2/2] mptcp: move mptcp_options_received's port =

initializati...
1384175  [net-next,1/2] mptcp: initialize mptcp_options_received's ahmac


     our repo (by: Davide Caratti, Florian Westphal, Paolo Abeni):

1384988  [net-next] Squash-to: "mptcp: introduce mptcp_schedule_work"
1382940  [net-next] Squash-to: "mptcp: refactor shutdown and close"
1382705  [net-next] Squash-to: "mptcp: refactor shutdown and close"
1382663  Squash-to: "mptcp: refactor shutdown and close"
1382274  [net-next,2/2] mptcp: use tcp_build_frag():
     =E2=86=92 there were conflicts when applying it, all good?
     =E2=86=92 there is a squash to patch to fix thing there

1382272  [net-next,1/2] tcp: factor out tcp_build_frag()
1379256  [mptcp-next,v2] selftests: mptcp: add link failure test case
1374921  [mptcp-next] mptcp: skip to next candidate if subflow has =

unacked data



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

1383239  [RFC,2/2] tcp: factor out __tcp_close() helper
1383237  [RFC,1/2] tcp: factor out tcp_build_frag()


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: Under Review: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - Somehow related to the one below: mptcp: add missing memory =

scheduling in the rx path
     - WIP but new version needed apparently

1384773: New: [net] mptcp: add missing memory scheduling in the rx path:
     - Good candidate for -net
     - *To be reviewed*
     - To be applied when ready at the bottom of the export branch

1384990: Awaiting Upstream: [net-next] mptcp: keep unaccepted MPC =

subflow into join list:
     - we could relax some tests linked to processing incoming datafin
     - we can put it at the end of the export branch but before "mptcp: =

send out dedicated ADD_ADDR packet"
     - to be applied

1385069: Awaiting Upstream: [net-next] Squash-to: "mptcp: refactor =

shutdown and close":
     - Should fix 101 by I actually tested this only vs self-tests
     - *Christoph* is currently not able to validate this patch with his =

syzkaller environment
     - *Mat* is trying to setup a syzkaller env
     - to be applied

1385365: Awaiting Upstream: Squash to "selftests: mptcp: add ADD_ADDR =

timeout test case" v2:
     - to be applied

1385378: Awaiting Upstream: [v5,mptcp-next,1/3] mptcp: change =

add_addr_signal type
1385379: Awaiting Upstream: [v5,mptcp-next,2/3] mptcp: send out =

dedicated ADD_ADDR packet
1385380: Awaiting Upstream: [v5,mptcp-next,3/3] selftests: mptcp: add =

ADD_ADDR IPv6 test cases:
     - to be applied after "mptcp: keep unaccepted MPC subflow into join =

list"

1385644: Awaiting Upstream: [net-next] Squash-to: "mptcp: move page frag =

allocation in mptcp_sendmsg()":
     - fix a not properly resolved merge conflict
     - to be applied

1385912: Under Review: [mptcp-next] Squash to "selftests: mptcp: add =

link failure test case":
     - maybe we don't need that for the selftests?
     - will see Geliang's answer to know if we keep/drop/modify this =

patch =E2=86=92 maybe it was solving a problem for *Geliang* ?

1386127: Changes Requested: [mptcp-next,v2] mptcp: track window =

announced to peer:
     - Certainly better to apply it now because it stabilise stuff.
     - Squash-to patches can be sent later if needed
     - to be applied



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 99)

   101  [syzkaller] KASAN: use-after-free Read in tcp_check_space [bug]:
         - should be solved by a patch from Paolo above


     Bugs (opened, flagged as "bug" and assigned)

    98  dss_ssn_specified_client packetdrill test fails (timeout) [bug] =

@dcaratti (can we close this?):
        - The test is passing on Davide's side
        - a modification is needed in the packetdrill test, fix coming.
        - *Davide* will share this fix

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti:
        - Davide identified where is the issue, it's understood
        - but modifying it will make TCP tests unstable
        - WIP

    85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
        - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   101  [syzkaller] KASAN: use-after-free Read in tcp_check_space [bug]:
       - Assigned to Paolo (but already fixed)

    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]:
        - should be address by Florian's patches

    70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe:
       - WIP

   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe:
       - WIP

   55  ADD_ADDR: IPv6 support [enhancement] @geliangtang:
       - Code is ready (see patches from *Geliang* above)
       - maybe packetdrill test missing, would be really nice!

   54  ADD_ADDR: ports support [enhancement] @geliangtang:
       - WIP

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch:
       - WIP


     Recently closed (since last week)

   100  [syzkaller] KASAN: null-ptr-deref Write in add_wait_queue [bug]
    97  null ptr dereference on close timeout under memory pressure =

[bug] @pabeni
    92  mptcp_close() deletes MPTCP socket before disconnection =

completes [bug] @mjmartineau



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Perf:
     - Paolo did some perf test to compare MPTCP with plain TCP on =

export and net-next
     - export branch MPTCP performance vs net-next vs plain TCP, via =

netperf plus mptcp_tools/use_mptcp:
         - net-next is almost 40% slower than TCP in loopback test
         - export is much worse than that (!!!):
             - throughput goes to ~0 after a few secs
             - looks like reader or writer or both are woken-up with too =

much delay (under investigation)
             - the issue disappears when turning on debug or pcap
             - the receivers might not send some ACKs when it is required.
             =E2=86=92 To be addressed before sending the new patches from =
the =

'export' branch
             =E2=86=92 on net-next, we don't need explicit wake up on MPTCP=
 level
             =E2=86=92 *Paolo* will try to collect some data and share them=
 on =

the ML



Extra tests:
     - news about Syzkaller? (Christoph):
         - See Github

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - the same issue from last week related to MPTCP_JOIN is =

popping up some time but no more details about that
         - still waiting for more details from kbuild guys.

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - Solution to support patches sent by email:
             - https://patchew.org
             - =E2=86=92 read ML, apply patch in a git branch to start test=
 ; =

hooks to send a reply
         - Matth: TODO: look if it is possible to deploy =E2=86=91 or =

alternative solution



Next meeting:
     - We propose to have the next meeting on Thursday, the 29nd of October.
     - Usual UTC time: 15:00 UTC (9am PDT, 5pm CET, 11pm UTC+8)
     - /!\ it looks like some regions change time next week-end, please =

reply to this email if this is an issue for you!
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201029



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7340717552247847067==--
