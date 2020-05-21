Content-Type: multipart/mixed; boundary="===============1182588871371921271=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 21th of May 2020
Date: Thu, 21 May 2020 18:37:33 +0200
Message-ID: <daf7fdfe-c7a4-a878-8a68-dc3e2e5c175e@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4443

--===============1182588871371921271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 100th (\o/) meeting with Mat, Ossama and Todd (Intel =

OTC), Christoph (Apple), Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Christoph Paasch, Florian =

Westphal, Matthieu Baerts, Paolo Abeni, Todd Malsbary):

1293559  [net] mptcp: use rightmost 64 bits in ADD_ADDR HMAC

1291530  [net-next,v2,3/3] mptcp: cope better with MP_JOIN failure
1291527  [net-next,v2,2/3] inet_connection_sock: factor out destroy help
1291526  [net-next,v2,1/3] mptcp: add new sock flag to deal with join su

1291444  [net] selftests:mptcp:pm: rm the right tmp file

1290468  [net-next] mptcp: Use 32-bit DATA_ACK when possible

1287651  [net-next,7/7] net: allow __skb_ext_alloc to sleep
1287650  [net-next,6/7] mptcp: remove inner wait loop from mptcp_sendmsg
1287649  [net-next,5/7] mptcp: fill skb page frag cache outside of mptcp
1287648  [net-next,4/7] mptcp: fill skb extension cache outside of mptcp
1287647  [net-next,3/7] mptcp: make sure timer is inited once data is pe
1287646  [net-next,2/7] mptcp: avoid blocking in tcp_sendpages
1287644  [net-next,1/7] mptcp: break and restart in case mptcp sndbuf i:
     - note: these IDs are from the previous version

     our repo (by: /):

(most of the above ones went in our repo, shortly before being sent =

upstream)



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Davide Caratti, Paolo Abeni):

1292675: New: [RFC,net-next,1/2] net: mptcp: improve fallback to TCP:
     - a new version is coming addressing the different comments raised =

by Mat and Paolo

1292673: New: [RFC,net-next,2/2] mptcp: fix races between shutdown and r

1293349: New: [RFC] mptcp: refactor token container.:
     - it needs review



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 24)

   26  NEW: Unstable packetdrill tests:
       - https://github.com/multipath-tcp/mptcp_net-next/issues/26
       - not easy to reproduce: DSS is different
   25  NEW: mptcp_connect: Connection reset by peer during a test:
       - "mptcp: fix races between shutdown and recvmsg" might help
       - not able to reproduce so far
   24  Revisit layout of struct mptcp_subflow_context
   23  refactor token container:
       - WIP by Paolo
   22  fix covscan issues @dcaratti (indirectly fixed by issue 11)
   21  sort-out {set,get}sockopt handling
   20  implement msk diag interface
   19  let PM netlink update live sockets on local addresses list change
   18  allow 'force to MPTCP' mode
   17  audit 'backup' flag usage
   16  get rid of mptcp hooking in tcp_check_req()
   15  reduce mptcp_out_option struct size
   11  fix fallback to TCP  @dcaratti:
       - Davide is working on fixing it
    6  loss and delay without reordering causes very slow transfer
    4  keep a single work struct in mptcp socket

     recently closed:

/



FYI: Current Roadmap: (same as last week)
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
         - some progress in the shutdown
         - when Christoph was doing some interop tests, when killing =

iperf, it randomly hangs:
             - maybe linked to DATA_FIN?
             - anybody else saw that?

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Notifications are now only sent to Mat who forwards only the =

unstable ones.
         - Notification from the 19/05: kselftest UNSTABLE:
             - due to changes in MPTCP? maybe not: all bpf tests
             - next one OK? (didn't get any new results yet)

     - packetdrill (Davide & Todd):
         - Todd is progressing on ADD_ADDRv1
         - Todd will continue looking at MP_JOIN
         - Davide is focusing on TCP fallback

     - CI (Matth):
         - some unstable tests, see above

     - Coverity (Davide):
         - 2 issues:
             - https://github.com/multipath-tcp/mptcp_net-next/issues/22
             - the other one seems to be a false positive when using =

kmalloc_cache.



ADD_ADDR HMAC ambiguity:
     - feedback from IETF: we need to change it again.
     - Todd is preparing a new patch (not a revert, something different)



interop with mptcp.org:
     - perf are pretty low but expected due to the way OOO packets are =

handled
     - for now, testing upstream version for the server =E2=86=92 so only u=
pload =

is bad when using two subflows and sending data at the same time
     - it's limiting the number of tests that can be ran



Next meeting:
     - We propose to have the next meeting on Thursday, the 28th of May.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200528



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
--===============1182588871371921271==--
