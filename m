Content-Type: multipart/mixed; boundary="===============1803697361805261018=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 7th of May 2020
Date: Thu, 07 May 2020 19:27:20 +0200
Message-ID: <2c6a4431-e9e7-f4f5-0179-b2f223435e8c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4347

--===============1803697361805261018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 98th meeting with Mat, Ossama and Todd Malsbary (Intel =

OTC), Christoph (Apple), Paolo and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



New member:
     - Todd Malsbary
     - new member from Intel team because there are still work to do :)
     - Welcome!



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Eric Biggers):

1281732  [1/7] mptcp: use SHA256_BLOCK_SIZE, not SHA_MESSAGE_BYTES

     our repo (by: Matthieu Baerts):

https://github.com/multipath-tcp/mptcp_net-next/commits/
     - one simple patch added at the end to enable MPTCP by default
     - needed for Intel's kbuild



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Christoph Paasch, Davide Caratti, Florian Westphal, =

Matthieu Baerts, Paolo Abeni):

1265469: Needs Review / ACK: selftests:mptcp:pm: rm the right tmp file:
     - need review

1274449: Changes Requested: [RFC] net: mptcp: improve fallback after su:
     - work in progress
     - also work ongoing with packetdrill

1281415: Changes Requested: SYN/ACK+MP_JOIN keeps getting retransmitted:
     - RFC: superseded by "mptcp: cope better with MP_JOIN failure"

1282808: New: [net-next] mptcp: set correct vfs info for subflows:
     - reviewed by Mat, can be set to net-next
     - or to -net?
     - Paolo will sent it to -net

1284428: New: [mptcp-next,1/7] mptcp: avoid blocking in tcp_sendpages
1284427: New: [mptcp-next,2/7] mptcp: make sure timer is inited/started
1284424: New: [mptcp-next,3/7] mptcp: avoid blocking in tcp_sendpages du
1284426: New: [mptcp-next,4/7] mptcp: fill skb extension cache outside o
1284429: New: [mptcp-next,5/7] mptcp: fill skb page frag cache outside o
1284430: New: [mptcp-next,6/7] mptcp: remove inner wait loop from mptcp_
1284431: New: [mptcp-next,7/7] net: allow __skb_ext_alloc to sleep:
     - Because it is good to sleep!
     - Reviewed by Paolo and Mat
     - Florian will send them to netdev tomorrow if there is no other =

comments

1285369: New: [RFC,1/2] mptcp: add new sock flag to deal with join subfl
1285367: New: [RFC,2/2] mptcp: cope better with MP_JOIN failure:
     - Discussions in progress on the ML



Bugs on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open:

   21  sort-out {set,get}sockopt handling
   20  implement msk diag interface
   19  let PM netlink update live sockets on local addresses list change:
       - allow the "active backup" scenario

   18  allow 'force to MPTCP' mode
   17  audit 'backup' flag usage:
       - use multiple subflows concurrently
       - not a lot of new code needed, mostly fixes

   16  get rid of mptcp hooking in tcp_check_req()
   15  reduce mptcp_out_option struct size
   11  fix fallback to TCP  @dcaratti
    7  cleanup sendmsg_frag allocation:
        - should be fixed with latest patches from Florian

    6  loss and delay without reordering causes very slow transfer
    5  Allow ss/netstat etc. to show program name for client and listener
    4  keep a single work struct in mptcp socket
    3  fix 'mmap' related race:
        - should be fixed with latest patches from Florian


     recently closed:

   14  audit mptcp_disconnect()
   13  [syzkaller] WARNING in mptcp_incoming_options
   10  reduce mptcp options space usage
    2  reduce hooking in TCP code



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
     - see pending patches



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - no progress to share

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - no progress to share yet
         - but the work is still on going by Peter



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - it was blocked because the committer was not the owner of the =

repo
         - the committer of the last commit is now Matt
         - we got a success email
         - in the future, we should only get emails if the build status =

is not "success"
         - Mat tried that an error is correctly reported (and it tests =

the different architectures)

     - packetdrill (Davide):
         - a few new tests are coming (related to the fallback issue)

     - CI (Matth):
         - the committer of the last commit on the export branch is now Matt



Radix tree:
     - we have this list of token stored in a Radix tree
     - issue with it because:
         - locking for the lookup (and insertion) is needed (but lookup =

is fast, manipulation not)

         - traversing it will be needed:
             - lock needed to traverse it all along
             - we need it for new features: debug (list MPTCP =

connections), PM (new rules on existing connections)

         - we could maintain a list in // but manipulating the tree + =

radix tree is complex and needs locks

         - initially, we thought radix tree would be OK to avoid lock =

for a lookup (RCU) but not the case

     - Paolo is looking at using a hash table:
         - with a fixed number of buckets (decided at boot time)
         - limit the number of items per buckets to avoid DOS attacks
         - limit might be around 200k entries (64k buckets, max 4 =

entries per bucket)
         - if we arrive at the limit of one bucket, we tried with =

another token. We should only fallback when the hashtable is (almost) full.
         - similar to what is done in mptcp.org except the size is not =

fixed, dynamically set at boot time (+ limit the number of entries per =

bucket).

     - resizeable hashtable?:
         - API is complex
         - we still need to put a limit, main goal is to reduce the memory
         - not sure about what locking is needed



Next meeting:
     - We propose to have the next meeting on Thursday, the 14th of May.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200514



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
--===============1803697361805261018==--
