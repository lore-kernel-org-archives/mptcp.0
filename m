Content-Type: multipart/mixed; boundary="===============6890124566228476502=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of May 2020
Date: Thu, 14 May 2020 19:08:50 +0200
Message-ID: <394dbf82-c2bf-b46f-d3c7-988e4dc9182f@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4385

--===============6890124566228476502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 99th meeting with Mat, Ossama and Todd (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Christoph Paasch, Paolo Abeni):

1287914  [net] mptcp: Initialize map_seq upon subflow establishment
1285495  [net] mptcp: set correct vfs info for subflows
+ better cope with MP_JOIN failure series

     our repo (by: Florian):

Florian patches but they need to be updated, see the new version below




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Christoph Paasch):

1290468  [net-next] mptcp: Use 32-bit DATA_ACK when possible

     our repo (by: Davide Caratti, Florian Westphal, Matthieu Baerts, =

Paolo Abeni):

1265469: Needs Review / ACK: selftests:mptcp:pm: rm the right tmp file:
     - Matth: to upstream

1274449: Changes Requested: [RFC] net: mptcp: improve fallback after =

successful 3-way-handshake:
     - v2 is in progress

1285369: Changes Requested: [RFC,1/2] mptcp: add new sock flag to deal =

with join subflows
1285367: Changes Requested: [RFC,2/2] mptcp: cope better with MP_JOIN =

failure:
     - a v1 has been sent to upstream
     - Waiting for an ACK by Eric
     - a Reviewed-by would be nice, Mat is looking at that
     - Note: there is a new version: =

https://patchwork.ozlabs.org/project/netdev/patch/968fb022a824140c6761c755e=
916f4526fee0a29.1589383730.git.pabeni(a)redhat.com/

1285373: Changes Requested: Re: [PATCH mptcp-next 3/7] mptcp: avoid =

blocking in tcp_sendpages due to skb alloc:
     - new version available

1287644: Awaiting Upstream: [net-next,1/7] mptcp: break and restart in =

case mptcp sndbuf is full
1287646: Awaiting Upstream: [net-next,2/7] mptcp: avoid blocking in =

tcp_sendpages
1287647: Awaiting Upstream: [net-next,3/7] mptcp: make sure timer is =

inited once data is pending for transmission
1287648: Awaiting Upstream: [net-next,4/7] mptcp: fill skb extension =

cache outside of mptcp_sendmsg_frag
1287649: Awaiting Upstream: [net-next,5/7] mptcp: fill skb page frag =

cache outside of mptcp_sendmsg_frag
1287650: Awaiting Upstream: [net-next,6/7] mptcp: remove inner wait loop =

from mptcp_sendmsg_frag
1287651: Awaiting Upstream: [net-next,7/7] net: allow __skb_ext_alloc to =

sleep:
     - Florian plans to send it soon to netdev



Bugs on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open:

   24  Revisit layout of struct mptcp_subflow_context:
     - new one, linked to a discussion with Paolo and Christoph

   23  refactor token container
     - what Paolo discussed last week and working on

   22  fix covscan issues @dcaratti
     - see below

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

   7  cleanup sendmsg_frag allocation:
       - linked to Florian patch-set

   5  Allow ss/netstat etc. to show program name for client and listener =

MPTCP subflows:
       - linked to vfs fixes by Paolo

   3  fix 'mmap' related race
       - linked to Florian patch-set



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



in progress fixes for -net:
     - /



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - Mat is making some progress there: propagate the DATA_FIN to =

bare ACKs
         - when there are data with the TCP FIN, we have to be careful there

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /

     - Token in a hash list:
         - Paolo is looking at that
         - But he prefers to redo it as he likes perfection!

     - mptcp.org supporting MPTCPv1:
         - Christoph is looking at that
         - next step: support ADD_ADDRv1



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - we get successful kselftest notification
         - maybe we could only get non successful one to reduce =

notifications?

     - packetdrill (Davide):
         - https://github.com/dcaratti/packetdrill/tree/fallback-after3whs
         - for those wanting to see what happens with fallback
         - of course we need to wait for patches in MPTCP repo to have =

these tests passing

     - CI (Matth):
         - mmap test has been added (fixed by Florian's patches)

     -  Coverity (davide):
         - covscan on Linux kernel
         - now running on MPTCP code
         - Davide receives random updates
         - 2 reported problems:
             - see Github issue N=C2=B022:  fix covscan issues
         - TODO: Matth: add to the list of item to discuss at the weekly =

meeting =E2=86=92 Done



TODO: add Todd to the calendar event:
     - Done!



netdev conf:
     - moved to August 16, fully virtual
     - Mat still plans to present something
     - paper and slides deadline is mid July



Next meeting:
     - We propose to have the next meeting on Thursday, the 21st of May.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200521



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
--===============6890124566228476502==--
