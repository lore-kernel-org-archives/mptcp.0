Content-Type: multipart/mixed; boundary="===============4620323701194996863=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 2nd of June 2020
Date: Sat, 04 Jul 2020 16:28:58 +0200
Message-ID: <7e1572a8-62c7-ca97-f85c-ec85d069c528@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4913

--===============4620323701194996863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last Thursday, we had our 106th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang Tang =

(Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Davide Caratti, Florian Westphal, =

Paolo Abeni):

1320094  [net-next,2/2] mptcp: add receive buffer auto-tuning
1320091  [net-next,1/2] selftests: mptcp: add option to specify size of
1319952  [net-next] mptcp: do nonce initialization at subflow creation t
1319179  [net-next,6/6] mptcp: close poll() races
1319176  [net-next,5/6] mptcp: __mptcp_tcp_fallback() returns a struct s
1319178  [net-next,4/6] mptcp: create first subflow at msk creation time
1319173  [net-next,3/6] mptcp: check for plain TCP sock at accept time
1319181  [net-next,2/6] mptcp: fallback in case of simultaneous connect
1319172  [net-next,1/6] net: mptcp: improve fallback to TCP
1317876  [net-next,v2,4/4] mptcp: introduce token KUNIT self-tests
1317873  [net-next,v2,3/4] mptcp: move crypto test to KUNIT
1317875  [net-next,v2,2/4] mptcp: refactor token container
1317874  [net-next,v2,1/4] mptcp: add __init annotation on setup functio

     our repo (by: Florian Westphal, Paolo Abeni):

1317568  Squash-to: "net: mptcp: improve fallback to TCP"
1317473  [net] mptcp: fix DSS map generation on fin retransmission
1314402  [mptcp-next] mptcp: init autotune state also in simultaneous co



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Mat Martineau, Paolo Abeni):

1318177: Changes Requested: [RFC] mptcp: Use full MPTCP-level disconnect =

state machine:
     - Working on a v2 with a split in different commits

1319751: New: [RFC,1/5] mptcp: cleanup subflow_finish_connect()
1319753: New: [RFC,2/5] subflow: explicitly check for plain tcp rsk
1319754: New: [RFC,3/5] subflow: use rsk_ops->send_reset()
1319756: New: [RFC,4/5] subflow: introduce and use mptcp_can_accept_new_
1319755: New: [RFC,5/5] subflow: do not create child subflow for fallba:
     - Series: mptcp: cope better with mp_join storm
     - Link to issue 33 on Github (weighttp-test)
     - should improve the situation there
     - Waiting for review
     - Waiting for tests from Christoph
     - For the patch 2/5, there is a note about SYN cookie, not =

supported with MPTCP (yet)
     - we should in theory not arrive there for the moment.

1321331: New: [v3,1/4] inet_diag: support for wider protocol numbers
1321329: New: [v3,2/4] mptcp: add msk interations helper
1321332: New: [v3,3/4] mptcp: add MPTCP socket diag interface
1321333: New: [v3,4/4] selftests/mptcp: add diag interface tests:
     - token iterator uses RCU to traverse then a lock on each sock
     - faster than spinlock
     - avoid possible deadlock
     - New version waiting for review

1321336: New: [v2,1/2] include: update mptcp uAPI
1321335: New: [v2,2/2] ss: mptcp: add msk diag interface support:
     - Waiting for review



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 39)

   42  remove unneeded branches in critical path [enhancement]:
       - perf related topic, not urgent
       - should not be difficult
       - linked to issue 15

   41  reduce indirect call usage [enhancement]:
       - perf related topic, not urgent
       - should not be difficult

   39  [syzkaller] WARNING in subflow_data_ready (v2.0) 2 @dcaratti
   34  WARNING: Bad mapping: ssn=3D1 map_seq=3D498340137 map_data_len=3D79
   33  weighttp-test on 1KB file with mptcp.org-client in "ndiffports"-mo
   31  Allow MPTCP + SYN_COOKIES [enhancement]
   30  ssh restart does not work
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   21  sort-out {set,get}sockopt handling [enhancement]

   20  implement msk diag interface [enhancement] @pabeni:
       - should be fixed by patches recently shared

   19  let PM netlink update live sockets on local addresses list change =

[enhancement]
   18  allow 'force to MPTCP' mode [enhancement]

   17  audit 'backup' flag usage  [enhancement]:
       - Paolo is looking at this
       - to be able to send traffic over multiple subflows at the same time

   15  reduce mptcp_out_option struct size [enhancement]
    6  loss and delay without reordering causes very slow transfer
    4  keep a single work struct in mptcp socket [enhancement]

     recently closed:

   40  Blocking accept() does not return



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

*Matth* check how to use Github for the roadmap



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - RFC has been shared

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /
         - Peter is still interested by this



Meetings at a different time:
     - one hour earlier: 8am PDT, 5pm CEST, 11pm UTC+8



Packetdrill issues:
     - See ML for more details
     - some are due to "fs: Do not check if there is a fsnotify watcher =

on pseudo inodes"
     - "fsnotify: suppress access/modify events on stream files" =

(temporary fix) is now in export branch
     - Do we still need it?:
         - Paolo found a patch that has been sent to fix the issue: =

b6509f6a8c4313c068c69785c001451415969e
         - *Matth* : we no longer need the patch we have in the export =

branch (once the above patch is available in net-next)

     - We still have another issue reported on IRC:
         - open an issue on Github
         - seems to be present on slow system, with debug
         - *Matth* : check that



Extra tests:
     - news about Syzkaller? (Christoph):
         - Running on latest export branch with all Paolo patches

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - same as before:
             - building of the export branch is still done
             - tests are still unstable (not tested)

     - packetdrill (Davide):
         - 2 PR have been accepted:
             - supporting MP_JOIN (Todd) + additional fixes (Todd):
                 - Matth: check if MP_JOIN tests are checked
             - enable MPTCP (sysctl)

     - CI (Matth):
         - focus on .c reproducer (from next week)

     - Coverity (Davide):
         - /



Syn-cookies:
     - Florian is looking at that
     - Working fine on the MP_CAPABLE
     - how to handle MP_JOIN?:
         - when we are full, we drop
         - in mptcp.org, we limit to 32 accept



- mptcp: fix DSS map generation on FIN retransmission:
     - candidate for -net
     - linked to issue 34
     - does not conflicts with others so we can send
     - (for -net, maybe best to send them on a Friday not to have to ask =

for a sync)



Next meeting:
     - We propose to have the next meeting on Thursday, the 9th of July.
     - *NEW* Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200709



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4620323701194996863==--
