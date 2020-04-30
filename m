Content-Type: multipart/mixed; boundary="===============0974944660043797985=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 30th of April 2020
Date: Thu, 30 Apr 2020 19:07:27 +0200
Message-ID: <650aca53-049e-eb2b-5f0a-d16624907c23@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4290

--===============0974944660043797985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 97th meeting with Mat and Ossama (Intel OTC), Christoph =

(Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Florian Westphal, Paolo Abeni):

1279438  [net] mptcp: replace mptcp_disconnect with a stub
1276323  [net] mptcp: fix race in msk status update

     our repo (by: /):

/

(note: one patch has been dropped: mptcp:sendmsg: truncate source buffer =

if mptcp sndbuf size was set from userspace)



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1280377  [net,v2] mptcp: fix uninitialized value access
1280366  [net,v2,5/5] mptcp: initialize the data_fin field for mpc packe
1280363  [net,v2,4/5] mptcp: fix 'use_ack' option access.
1280364  [net,v2,3/5] mptcp: avoid a WARN on bad input.
1280361  [net,v2,2/5] mptcp: move option parsing into mptcp_incoming_opt
1280356  [net,v2,1/5] mptcp: consolidate synack processing.

Also iproute2 patches have been accepted (included a fix to add a ref =

from the main man page to the mptcp one)

     our repo (by: Davide Caratti, Matthieu Baerts):

1265469: Needs Review / ACK: selftests:mptcp:pm: rm the right tmp file:
     - maybe no review needed, can be sent directly

1274449: Changes Requested: [RFC] net: mptcp: improve fallback after =

successful 3-way-handshake:
     - a new version is expected



iproute2:
     - MPTCP patches are now included
     - will be included in iproute2 next (5.7) version



Bugs on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

   18  allow 'force to MPTCP' mode
   17  audit 'backup' flag usage
   16  get rid of mptcp hooking in tcp_check_req()
   15  reduce mptcp_out_option struct size
   14  audit mptcp_disconnect()
   13  [syzkaller] WARNING in mptcp_incoming_options
   11  fix fallback to TCP  @dcaratti
   10  reduce mptcp options space usage
        - can be closed when pending patches are merged
    7  cleanup sendmsg_frag allocation:
        - Florian is looking at this one, not to sleep while we should not
    6  loss and delay without reordering causes very slow transfer
    5  Allow ss/netstat etc. to show program name for client and =

listener MPTCP subflows:
        - Paolo might look at this one
    4  keep a single work struct in mptcp socket
    3  fix 'mmap' related race
    2  reduce hooking in TCP code:
        - can be closed when pending patches are merged

recently closed:

   12  [syzkaller] INFO: task hung in lock_sock_nested
    9  fix "IPv4: Attempt to release TCP socket in state 1 "... on shutdown
    8  fix possible race in subflow_finish_connect()



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/

         - Shared recv window (full support):
             - fixed with "tcp: mptcp: use mptcp receive buffer space to =

select rcv window"
             - nothing else seems to be needed =E2=86=92 [DONE]
             - Matth: update the roadmap

         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)

         - Full DATA_FIN support [WIP by Mat]
         - Active backup support
         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]

         - Opti in TCP option structures (unions) [to be rebased]:
             - Fixed by the refactoring sent by Paolo on net-next

         - NEW: sending "simultaneously" on different subflows (multiple =

non backup subflows)

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



Github issues:
     - feel free to add/comment/remove/close them



in progress fixes for -net:
     - /



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - Matt is looking at that (the whole DATA_FIN handshake)
     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - Matt will check with Peter to know if there are any progress



Extra tests:
     - news about Syzkaller? (Christoph):
         - /
         - seems stable

     - news about Intel's kbuild? (Mat):
         - the reason why it was not building is because the commiter =

was not in the whitelist
         - we need a commit enabling MPTCP by default =E2=86=92 TODO: Matth=
 can =

add this commit

     - packetdrill (Davide):
         - in progress

     - CI (Matth):
         - /



Netdev:
     - cannot be non virtual
     - either virtual or rescheduled?
     - Jamal should send more information soon



Conflict:
     - BPF guys try to imitate us!
     - =

https://lore.kernel.org/bpf/CAADnVQ+weKq=3D-=3DKB7j=3D0FfCE0bLanJ_ppn_p-rop=
du8zMhWGqQ(a)mail.gmail.com/
     - their meeting is scheduled at the same time as our meeting! =

(Thursday 9am pacific time)
     - but MPTCP meetings are better!



Next meeting:
     - We propose to have the next meeting on Thursday, the 7th of May.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200507



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
--===============0974944660043797985==--
