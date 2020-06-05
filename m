Content-Type: multipart/mixed; boundary="===============0869360843915084877=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 4th of June 2020
Date: Fri, 05 Jun 2020 11:39:47 +0200
Message-ID: <9337f22b-9747-223c-81f5-57a746830403@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4595

--===============0869360843915084877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 102nd meeting with Mat and Todd (Intel OTC), =

Christoph (Apple), Paolo, Davide and Florian (RedHat), Matthieu =

(Anonyme) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1300832  [net-next] mptcp: fix NULL ptr dereference in MP_JOIN error pa:
     - Fix from Paolo

1300554  [net] mptcp: remove msk from the token container at destruction
1299962  [net] mptcp: fix race between MP_JOIN and close
1299794  [net] mptcp: fix NULL ptr dereference in MP_JOIN error path
1299694  [net] mptcp: fix unblocking connect():
     - Series from Paolo (note: ID are not referring to the last version)


     our repo (by: Paolo Abeni):

1299960  [v3,4/4] mptcp: introduce token KUNIT self-tests
1299959  [v3,3/4] mptcp: move crypto test to KUNIT
1299958  [v3,2/4] mptcp: refactor token container.
1299957  [v3,1/4] mptcp: add __init annotation on setup functions:
     - Series from Paolo



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Christoph Paasch, Davide Caratti, Florian Westphal, =

Paolo Abeni):

1292673: Changes Requested: [RFC,net-next,2/2] mptcp: fix races between:
     - Can be applied in our export branch.
     - Has been reviewed

1299790: Needs Review: [mptcp-next,1/2] selftests: mptcp: add option to:
     - can be applied after a review
     - needs to be reviewed

1299791: Needs Review / ACK: [mptcp-next,2/2] mptcp: add receive buffer:
     - v2 has been sent

1300552: Changes Requested: [v2,mptcp-next] mptcp: add receive buffer a:
     - Christoph did a review
     - Fix needed only if "mptcp: improve fallback to TCP" is merged first:
         1300852: RFC: Re: [PATCH v2 mptcp-next] mptcp: add receive =

buffer auto-tuning
     - Florian proposed to apply the other patch first

1300546: New: [net-next] net: mptcp: improve fallback to TCP:
     - Waiting for review
     - a new version will come (rebase needed)

1301702: RFC: Re: Crashers on netnext with apache-benchmark:
     - should be submitted upstream
     - Paolo will do a proper submission, directly to netdev ML



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 29)

   35  [syzkaller] WARNING in subflow_data_ready 1 @dcaratti:
       - linked to what Davide did
       - for more details, Christoph did a first (good) analysis on the =

ticket

   34  WARNING: Bad mapping: ssn=3D1 map_seq=3D498340137 map_data_len=3D79:
       - when running AB tests
       - will need to be reproduced with VMCore

   33  weighttp-test on 1KB file with mptcp.org-client in "ndiffports"-mode:
       - more aggressive than Apache Benchmark (because multithreaded)
       - with mptcp.org with ndiffports set to 8 =E2=86=92 8 subflows
       - stalled but no more analysis done so far, less urgent

   32  [syzkaller] INFO: rcu detected stall in ip_rcv:
       - use after free: very difficult to detect because KASAN doesn't =

detect that when kmemcache is used. Was detected when switching to a =

simple kmalloc
       - idea: add a commit to use kmalloc instead of kmemcache to be =

able to detect errors sooner. (Of course, we would not upstream this)
       - introduce by the modification in the token container
       - Paolo looked at that and will send a patch later
       - Paolo sent a patch on IRC, @Christoph will test it

   31  Allow MPTCP + SYN_COOKIES [enhancement]:
       - just not to forget it and to track it
       - needed for busy server

   30  ssh restart does not work:
       - probably missing socket options (normal)
       - can be worrying, can impact other apps

   29  [syzkaller] INFO: task hung in lock_sock_nested
   28  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow:
       - maybe linked with Paolo's fix (use-after-free)

   26  Unstable packetdrill tests:
       - Not reproduced recently (even without Davide's last fix)

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

27  unblocking connect fails most of the time



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
     - Correct handling of [gs]etsockopt is important:
         - see GH issue 30
         - can block the usage of MPTCP
         - apps can fail because some optional stuff are not supported
     - Matt: being able to modify the autosize of the token hlist:
         - looking at the Out-off-tree implem first.



Extra tests:
     - news about Syzkaller? (Christoph):
         - Reported on GH

     - news about interop with mptcp.org? (Christoph):
         - Matt: review ADD_ADDRv1 patch

     - news about Intel's kbuild? (Mat):
         - got a failure email yesterday but linked to BPF

     - packetdrill (Davide & Todd):
         - Progressing with MP_JOIN support
         - Receive is done, other direction support is in progress

     - CI (Matth):
         - now testing kunit

     - Coverity (Davide):
         - all good



Network Manager:
     - Having IP rules and routes setup automatically?:
         - ip rule from <2nd IP> table X
         - ip route add default via <next hop> table X
     - As far as we know, there is no support
     - Matthieu (2) proposes to contact NM devs
     - The last version of the kernel supports more things with Netlink
     - The configuration of the rules could be done via Netlink
     - Idea would be: good default settings
     - ConnMan is already supporting MPTCP (tested with out-of-tree kernel)



Mailing list change:
     - Recent modifications were done
     - Search seems broken
     - a few months ago they switched from mailman to another list, =

breaking all links
     - + spam on the list
     - we might have to change if they decide to drop the server (not clear)
     - Mat is trying to get more info on that
     - Solution would be to move to a ML under kernel.org
     - Moving archive and subscribers might be a pain (+ link to the list)
     - But maybe for better



Next meeting:
     - We propose to have the next meeting on Thursday, the 11th of June.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200611



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
--===============0869360843915084877==--
