Content-Type: multipart/mixed; boundary="===============8536495518232623794=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 28th of May 2020
Date: Thu, 28 May 2020 19:03:29 +0200
Message-ID: <8f6fe9ea-59b1-9a68-2d79-79164d2146d5@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4533

--===============8536495518232623794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 101st (\o/) meeting with Mat, Ossama and Todd (Intel =

OTC), Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Florian Westphal, Paolo Abeni, =

Todd Malsbary):

1297422  mptcp: attempt skb coalescing when moving skbs to mptcp rx queue
1297369  [net] mptcp: avoid NULL-ptr derefence on fallback
1295810  [net] mptcp: use untruncated hash in ADD_ADDR HMAC

     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*


     netdev (if mptcp ML is in cc) (by: Florian Westphal):

1297426: Changes Requested: [v3,mptcp-next,1/2] mptcp: adjust tcp =

rcvspace after moving skbs from ssk to sk queue
1297427: Changes Requested: [v3,mptcp-next,2/2] mptcp: move recbuf =

adjustment to recvmsg path:
     - Florian sent a new version on mptcp ML that should address =

Christoph's comments
     - the patch: mptcp: add receive buffer auto-tuning =

(http://patchwork.ozlabs.org/project/mptcp/patch/20200528130239.16498-3-fw(=
a)strlen.de/)
     - it replaces the two patches above

     our repo (by: Davide Caratti, Florian Westphal, Paolo Abeni):

1292675: Changes Requested: [RFC,net-next,1/2] net: mptcp: improve =

fallback to TCP
1292673: Changes Requested: [RFC,net-next,2/2] mptcp: fix races between =

shutdown and recvmsg.:
     - non RFC in progress
     - handle the rtx queue correctly
     - a new update should arrive soon

1297452: Changes Requested: [v2,1/4] mptcp: add __init annotation on =

setup functions
1297454: Changes Requested: [v2,2/4] mptcp: refactor token container.
1297455: Changes Requested: [v2,3/4] mptcp: move crypto test to KUNIT
1297456: Changes Requested: [v2,4/4] mptcp: introduce token KUNIT =

self-tests:
     - We can include that in the export branch
     - A squash-to patch can be sent after

1298797: RFC: Re: Crashers on netnext with apache-benchmark:
     - Paolo is trying to reproduce the issue using the export branch =

for both client and server
     - Paolo saw an issue related to the connect() (see =E2=86=93)
     - Paolo saw other issues but not the one of Christoph :)
     - But can be due to the fact the kconfig is different and different =

timing
     - We can have issues when closing sockets

1299694: New: [net] mptcp: fix unblocking connect():
     - linked to =E2=86=91

1299790: New: [mptcp-next,1/2] selftests: mptcp: add option to specify =

size of file to transfer
1299791: New: [mptcp-next,2/2] mptcp: add receive buffer auto-tuning:
     - linked to the patches sent to netdev

1299794: Changes Requested: [net] mptcp: fix NULL ptr dereference in =

MP_JOIN error path:
     - v2 coming without the debug lines



Bugs on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 26)

   29  [syzkaller] INFO: task hung in lock_sock_nested:
       - on top of net-next (export is the same)

   28  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow:
       - on top of net-next (export is the same)

   27  unblocking connect fails most of the time:
       - linked to "1299694: New: [net] mptcp: fix unblocking connect()"

   26  Unstable packetdrill tests
   25  mptcp_connect: Connection reset by peer during a test
   24  Revisit layout of struct mptcp_subflow_context
   23  refactor token container
   22  fix covscan issues @dcaratti
   21  sort-out {set,get}sockopt handling
   20  implement msk diag interface
   19  let PM netlink update live sockets on local addresses list change
   18  allow 'force to MPTCP' mode
   17  audit 'backup' flag usage
   16  get rid of mptcp hooking in tcp_check_req()
   15  reduce mptcp_out_option struct size
   11  fix fallback to TCP  @dcaratti
    6  loss and delay without reordering causes very slow transfer
    4  keep a single work struct in mptcp socket

     recently closed:

/



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - Active backup support
         - sending "simultaneously" on different subflows (multiple non =

backup subflows)
         - Full DATA_FIN support [WIP by Mat]
         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]
         - Opti in TCP option structures (unions) [DONE by Paolo]
         - Shared recv window (full support) [DONE by Florian]

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink
         - PM bpf
         - Scheduler bpf
         - syncookies
         - [gs]etsockopt per subflow
         - notify the userspace when a subflow is added/removed =E2=86=92 c=
msg



Other in progress fixes for -net:
     - /



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - /
     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /
     - Paolo was planning to work on issue 19 but he was interrupted by =

other bugs



Extra tests:
     - news about Syzkaller? (Christoph):
         - 2 two issues, see Github
         - Christoph will launch Syzkaller on top of the export branch =

once it will be updated

     - news about interop with mptcp.org? (Christoph):
         - same as last week
         - ADD_ADDRv1 works
         - test: client off-tree, server mptcp.org:
             - telnet to the server
             - two subflows are created
             - when Ctrl+C the server, the server app hangs

     - news about Intel's kbuild? (Mat):
         - Mat saw an issue this issue just before starting the meeting
         - seems related to what the CI already saw
         - but more analysis will be needed

     - packetdrill (Davide + Todd):
         - Davide looked at the issue 26  on Github:
             - seems to be related to the parsing of the options in =

packetdrill
             - seems not an issue in the implementation of the protocol =

in the kernel
             - Davide will propose a fix soon

         - Todd saw an issue, maybe related, will sync on the IRC channel

         - Todd is working on supporting MP_JOIN subflows

     - CI (Matth):
         - /

     - Coverity (Davide):
         - no new reports, so good news!



Next meeting:
     - We propose to have the next meeting on Thursday, the 4th of June.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200604



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8536495518232623794==--
