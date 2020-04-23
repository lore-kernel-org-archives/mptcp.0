Content-Type: multipart/mixed; boundary="===============7815239513036311927=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 23rd of April 2020
Date: Thu, 23 Apr 2020 19:08:36 +0200
Message-ID: <c0445600-3ae0-4f2d-d36f-1edd986435bd@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4235

--===============7815239513036311927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 96th meeting with Mat and Ossama (Intel OTC), Christoph =

(Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Florian Westphal, Paolo Abeni):

1273464: new: mptcp: handle mptcp listener destruction via rcu
1273466: new: mptcp: avoid flipping mp_capable field in syn_recv_sock()
1273465: new: mptcp: drop req socket remote_key* fields:
     - Applied by Davem and last one queued to stable

1275277: New: [net] mptcp: fix data_fin handing in RX path:
     - Applied by Davem and queued to stable

     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni, Davide Caratti, Bo YU):

1275770: new: [iproute2-next,1/4] uapi: update linux/mptcp.h
1275771: new: [iproute2-next,2/4] add support for mptcp netlink interfac
1275773: new: [iproute2-next,3/4] ss: allow dumping MPTCP subflow inform
1275772: new: [iproute2-next,4/4] man: mptcp man page:
     - IPRoute2 patches, reviewed internally and now upstreamed

1275495  [V3,-next] mptcp/pm_netlink.c : add check for nla_put_in/6_addr
     - external contribution, ACKed by Paolo

     our repo (by: Davide Caratti, Florian Westphal, Matthieu Baerts):

1265469: Needs Review / ACK: selftests:mptcp:pm: rm the right tmp file:
     - need review, simple modification
     - can be upstreamed?

1271345: Changes Requested: [4/7] mptcp: avoid callback invocation when
1271346: Changes Requested: [5/7] mptcp: use rcu helpers to fetch ulp su
1271347: Changes Requested: [6/7] mptcp: reverse order of sk_state_chang
1271348: Changes Requested: [7/7] mptcp: prevent null deref crash on no:
     - the 3 first patches have already been sent
     - obsoleted by the series of 3 patches sent upstream (and already =

merged)

1274449: Changes Requested: [RFC] net: mptcp: improve fallback after =

successful 3-way-handshake:
     - new version in preparation, yes



Bugs on Github:
     $ ghi list -S updated --reverse
     https://github.com/multipath-tcp/mptcp_net-next/issues/
     - TODO Matth: do not use "-S updated": commit messages containing =

#XX are interpreted as a reference to an issue. But there are many =

commit messages containing #XX referring to something else.

    2: reduce hooking in TCP code
    4: keep a single work struct in mptcp socket
    5: Allow ss/netstat etc. to show program name for client and listener
    8: fix possible race in subflow_finish_connect()
    9: fix "IPv4: Attempt to release TCP socket in state 1 "... on shutd:
        - should be fixed with recent patches
        - but maybe a different cause
   10: reduce mptcp options space usage
   11: fix fallback to TCP...
    3: fix 'mmap' related race
   13: [syzkaller] WARNING in mptcp_incoming_options
   12: [syzkaller] INFO: task hung in lock_sock_nested
    7: cleanup sendmsg_frag allocation
    6: loss and delay without reordering causes very slow transfer



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - Full DATA_FIN support [WIP by Mat]:
             - could be nice to have it: if ready
         - Active backup support
         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]
         - Opti in TCP option structures (unions) [to be rebased]

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



mptcp RX option clearing:
     - problem stated here:
 =

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/ASA6QXZTGR=
SCTURB23KJ6YCUTHEL7MGN/

     - we can have old values for some fields:
         - a risk:
              - an evil 3rd party can corrupt/force closing of an MPTCP =

stream without even the guessing the seq number

         - clearing might be needed
         - a bit like for the TCP timestamps
         - but it's touching TCP code and it's an exception for MPTCP =

which is not good
         - we might have to clean a few fields (the ones that track a =

"connection level" status, not per packet), not just one instruction
         - Eric might discover our code :-D
         - maybe time to optimise it?:
             - store only a reference?:
                 - But a big rework
                 - needs to handle SYN
                 - failure cases
             - not for stable...

     - next steps:
         - Paolo will write an RFC to clear some fields in one =

instruction and sent it to MPTCP ML first for review before netdev

     - https://github.com/multipath-tcp/mptcp_net-next/issues/10 :
             - linked but the initial idea cannot be used because we =

don't have a reference to the sk, only skb or part of the buffer

     - can we use a single 'sub_options' field instead of 'mp_capable', =

'mp_join', etc, to clean things up?

     - since the above will change it's binary layout, should we =

consider some additional effort to reduce 'mptcp_options_received' size?:
         - what about *not* copying the subopt data inside =

mptcp_options_received, just picking  a weak data reference (offest/len) =

inside the current skb?



in progress fixes for -net:
     - news about "Bugs from Github"?:
         - some might be fixed after having sent new patches to netdev
     - /



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - /
     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /
     - /



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Philip looked and the reported failing seems not related to =

our changes but to modifications from upstream 5.6.
         - Mat is tracking builds to check what is running
         - export branch has been updated 15 hours ago

     - packetdrill (Davide):
         - Davide did more tests related to TCP fallback, linked to the =

patch Davide sent to the mailing list
         - some refactoring might be needed

     - CI (Matth):
         - /



export branch:
     - tcp: mptcp: use mptcp receive buffer space to select rcv window:
         - Florian can sent it to netdev (net-next)

     - mptcp:sendmsg: truncate source buffer if mptcp sndbuf size was =

set from userspace:
         - we can drop it for the moment
         - Matth can do that: DONE
         - we still need to take a decision about setsockopt management



Next meeting:
     - We propose to have the next meeting on Thursday, the 30th of April.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200430



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
--===============7815239513036311927==--
