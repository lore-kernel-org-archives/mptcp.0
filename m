Content-Type: multipart/mixed; boundary="===============3602145850087367595=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 9th of July 2020
Date: Thu, 09 Jul 2020 21:53:22 +0200
Message-ID: <c26a6c73-686a-4f02-5b7f-ce666ee69ba4@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4965

--===============3602145850087367595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Today, we had our 107th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Davide and Florian (RedHat), Geliang Tang (Xiaomi), =

Nicolas and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Nicolas Rybowski:
     - new member during the summer
     - intern at Tessares
     - working on BPF:
         - focussing on TCP BPF for the moment
         - short term: MPTCP BPF =E2=86=92 similar to TCP BPF: act differen=
tly =

per subflow
         - mid term: extending the PM with BPF
         - ideally long term: extending the scheduler with BPF



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Davide Caratti, Eric Biggers, =

Florian Westphal, Matthieu Baerts):

1325346  [v2,4/5] mptcp: use sha256() instead of open coding
1325343  [v2,2/5] crypto: lib/sha256 - add sha256() function:
     - we should be careful about not adding conflicts there
     - =E2=86=92 it will go in crypto-next, not sure when we will have it i=
n =

net-next

1323874  [net-next] mptcp: fix race in subflow_data_ready()
1323600  [net-next] selftests: mptcp: capture pcap on both sides
1322953  [net-next,3/3] mptcp: support IPV6_V6ONLY setsockopt
1322952  [net-next,2/3] mptcp: add REUSEADDR/REUSEPORT support
1322950  [net-next,1/3] net: use mptcp setsockopt function for SOL_SOCKE
1322482  [net] mptcp: fix DSS map generation on fin retransmission

     our repo (by: Christoph Paasch, Matthieu Baerts, Paolo Abeni):

1324811  Squash-to: inet_diag: support for wider protocol numbers
1324545  Squash-to: "mptcp: add MPTCP socket diag interface"
1322633  [mptcp-next] diag: fix use-after-free Read in inet_diag_lock_ha
1321333  [v3,4/4] selftests/mptcp: add diag interface tests
1321332  [v3,3/4] mptcp: add MPTCP socket diag interface
1321329  [v3,2/4] mptcp: add msk interations helper
1321331  [v3,1/4] inet_diag: support for wider protocol numbers



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1325936  [net-next,4/4] selftests/mptcp: add diag interface tests
1325933  [net-next,3/4] mptcp: add MPTCP socket diag interface
1325931  [net-next,2/4] mptcp: add msk interations helper
1325934  [net-next,1/4] inet_diag: support for wider protocol numbers

     our repo (by: Mat Martineau, Matthieu Baerts, Paolo Abeni):

1318177: Changes Requested: [RFC] mptcp: Use full MPTCP-level disconnect =

state machine:
     - *Mat* is working on a v2

1319751: New: [RFC,1/5] mptcp: cleanup subflow_finish_connect()
1319753: New: [RFC,2/5] subflow: explicitly check for plain tcp rsk
1319754: New: [RFC,3/5] subflow: use rsk_ops->send_reset()
1319756: New: [RFC,4/5] subflow: introduce and use mptcp_can_accept_new_
1319755: New: [RFC,5/5] subflow: do not create child subflow for fallba:
     - Note: "mptcp: cope better with mp_join storm" fixes issues/33
     - patch 5/5 has not so nice const cast.
     - *All* Any feedback welcome.

1321336: Awaiting Upstream: [v2,1/2] include: update mptcp uAPI
1321335: Awaiting Upstream: [v2,2/2] ss: mptcp: add msk diag interface:
     - waiting for the patches for the kernel to be applied first in =

net-next

1325171: New: [mptcp-next] selftests: mptcp: interpret \n as a new line:
     - waiting for a review
     - There are two "Fixes" tags =E2=86=92 for two different Linux version
     - Maybe we don't need them? =E2=86=92 net-next
     - But still a fix =E2=86=92 split?
     - *Matth* =E2=86=92 split



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 42)

   47  mptcp_join selftests are failing since "mptcp: fix race in =

subflow_data_ready()" [bug] @dcaratti:
       - Paolo shared some ideas
       - *Davide* is looking at that

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] @cpaasch:
       - *Christoph* will look at that
       - To properly test the new API

   42  remove unneeded branches in critical path [enhancement]
   41  reduce indirect call usage [enhancement]
   31  Allow MPTCP + SYN_COOKIES [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   21  sort-out {set,get}sockopt handling [enhancement]

   20  implement msk diag interface [enhancement] @pabeni
       - waiting for upstream merge to close issue/20

   19  let PM netlink update live sockets on local addresses list change =

[enhancement]
   18  allow 'force to MPTCP' mode [enhancement]

   17  allow non 'backup' subflows creation [enhancement] @pabeni:
       - *Paolo* is currently working on issues/17. There are quite a =

bit of needed changes to let that work.
       - Specifically he is currently struggling with some EoF-related =

issues with should be addressed by full data fin support as per =

martineau's RFC patch
       - So he would support merging the latter as soon as self-tests do =

not explode ;)
       - These tests are still exploding

   15  reduce mptcp_out_option struct size [enhancement]
    6  loss and delay without reordering causes very slow transfer [bug] =

@cpaasch

     recently closed:

   46  Sparse issues (`make C=3D1`)
   45  [packetdrill] mp_capable: error only in debug mode @matttbe
   44  [syzkaller] KASAN: use-after-free Read in inet_diag_lock_handler' =

@cpaasch
   39  [syzkaller] WARNING in subflow_data_ready (v2.0) @dcaratti
   34  WARNING: Bad mapping: ssn=3D1 map_seq=3D498340137 map_data_len=3D79
   33  weighttp-test on 1KB file with mptcp.org-client in "ndiffports"-mode
   30  ssh restart does not work
    4  keep a single work struct in mptcp socket [enhancement]

Message from Paolo:
     - likely issue/43 should be closed - ask Christoph:
         - *Paolo* : not sure it was the number 43



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, rm_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(cache like TFO is doing)
         - PM server (more advanced) [DONE by Paolo]
         - Active backup support [WIP by Paolo]
         - sending "simultaneously" on different subflows (multiple non =

backup subflows) [WIP by Paolo]
         - easily allow other apps to use MPTCP (sysctl, bpf, systemtap, =

LD_PRELOAD =E2=86=92 doc?) [WIP Nicolas]
         - Full DATA_FIN support [WIP by Mat]
         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]
         - Opti in TCP option structures (unions) [DONE by Paolo]
         - Shared recv window (full support) [DONE by Florian]

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink per connection
         - PM bpf
         - Scheduler bpf
         - syncookies [WIP Florian]
         - [gs]etsockopt per subflow
         - notify the userspace when a subflow is added/removed =E2=86=92 c=
msg



Github Projects:
     - Starting to use Github Projects to replace the roadmap here
     - 3 projects have been created:
         - Bugs (related to code on stable/net/net-next repo)
         - Next (for the current merge window)
         - Future (for future merge windows)
     - https://github.com/multipath-tcp/mptcp_net-next/projects
     - Next step: move missing items from the Roadmap to Github Projects
     - *Matth* : do the next step



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - *Mat* is applying comments from Paolo
         - splitting commits
         - trying to get the selftests to pass

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about interop with mptcp.org? (Christoph):
         - Weighttp tests: much more faster

     - news about Intel's kbuild? (Mat):
         - Mat is not receiving new updates
         - There are problems with automation

     - packetdrill (Davide):
         - still some (sporadic?) issues with the new mp_join and =

add_addr tests

     - Coverity (Davide):
         - Issue 11 might not be fixed =E2=86=92 *Davide* to check
         - no news (at all) this week =E2=86=92 maybe another issue

     - CI (Matth):
         - fix MPC pktdrill tests: CRYPTO_SHA1 needed
         - check sparse output (make C=3D1)
         - results now stored in TAP files to track failed tests
         - detect timeout with non selftests tests
         - compile and use latest iproute2 version



mptcpd:
     - *Ossama* is looking at supporting the current Netlink API of the =

upstream kernel
     - on the kernel side, we will need to port the Netlink PM from =

mptcp.org
     - hopefully the two PM should be able to work in //
     - Davide is suggesting to start packaging mptcpd in Fedora
     - *Davide* will try a shot in copr.fedoraproject.org
     - Should not be difficult to package, no crazy stuff there that are =

hard to package/compile, no exotic dependences



Next meeting:
     - We propose to have the next meeting on Thursday, the 16th of July.
     - *NEW* Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200716



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3602145850087367595==--
