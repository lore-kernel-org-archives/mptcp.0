Content-Type: multipart/mixed; boundary="===============5937265981982295747=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 19th of December 2019
Date: Sat, 21 Dec 2019 08:57:06 +0100
Message-ID: <c703f49d-e1dc-593a-58a0-701c63cba7e5@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3243

--===============5937265981982295747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Thursday, we had our 80th meeting with Mat, Peter and Ossama (Intel =

OTC), Paolo (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:


Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3
     - By Paolo Abeni, Matthieu Baerts

1214271  Squash-to: "tcp: coalesce/collapse must respect MPTCP extension
1214225  Squash-to: "mptcp: Add MPTCP to skb extensions"
1213556  [v3] Squash-to: "tcp: Prevent coalesce/collapse when skb has MP
1212550  Squash-to: "mptcp: Add MPTCP socket stubs"
1212331  [2/2] Squash-to: "mptcp: Implement MPTCP receive path"
1212314  [1/2] Squash-to: "mptcp: Add MPTCP socket stubs"
1212209  Squash-to: "mptcp: recvmsg() can drain data from multiple subfl
1211460  Squash-to: "mptcp: Add key generation and token tree"
1211244  Squash-to: "sock: Make sk_protocol a 16-bit value"
1210776  Squash-to: "mptcp: Implement MPTCP receive path"
1210775  Squash-to: "mptcp: Handle MP_CAPABLE options for outgoing conne
1210697  [v2] Squash-to: "mptcp: cope with later TCP fallback"
1210382  Squash-to: tcp: Check for filled TCP option space before SACK
1210375  Squash-to: "sock: Make sk_protocol a 16-bit value"
1209395  Re: [PATCH] mptcp: cope with later TCP fallback.



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Paolo Abeni, Matthieu Baerts, Peter Krystad

1194592: Changes Requested: [RFC,1/1] mptcp: Optimize struct mptcp_recei
1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec
1214280: Changes Requested: [RFC,1/4] Squash-to: "mptcp: Handle MP_CAPAB
1214277: Changes Requested: [RFC,2/4] Squash-to "mptcp: Create SUBFLOW s
1214278: Changes Requested: [RFC,3/4] Squash-to: "mptcp: Implement MPTCP
1214279: Changes Requested: [RFC,4/4] Squash-to: "mptcp: cope with later



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - Sent to Netdev, in review

     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - Sent to Netdev, in review, waiting for Part 1 to be ready

     - Part 3 (MPTCPv1):
         - Ready to be sent to Netdev, waiting for Part 2 to be ready

     - Part 4 (to be sent before the end of the merge window or more =

probably at the next one)
         - Full DATA_FIN support [WIP]
         - Shared recv window (drop data received on other subflows) [TODO]
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)

     - Part 5 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)

     - Part 6 (extra needed for prod):
         - opti/perfs
         - TFO



Initial submission to net-next:
     - Part 1:
         - We got some reviews from Eric Dumazet and recommendations =

from Davem
         - v1 has been sent on Friday:
             - comments from Eric about patch 2 (struct sock) and patch =

9 (SACK)
         - v2 has been sent on Monday:
             - v1 -> v2: sk_pacing_shift left as a regular struct member =

(patch 2), and modified SACK space check based on recent -net fix (patch 9).
             - comment from Eric about patch 2 again (struct sock)
         - v3 has been sent on Tuesday:
             - v2 -> v3: Ensure sk_type alignment in struct sock (patch 2)
             - discussions on: tcp: Prevent coalesce/collapse when skb =

has MPTCP extensions:
                 - Eric: This seems a very pessimistic change to me. Are =

you planing later to refine this limitation ? Surely if a sender sends =

TSO packet, we allow all the segments being aggregated at receive side =

either by GRO or TCP coalescing.
                 - Davem: This turns off absolutely crucial functional =

elements of our TCP stack, and will avoid all of the machinery that =

avoids wastage in TCP packets sitting in the various queues. =

skb->truesize management, etc. I will not apply these patches with such =

a non-trivial regression in place for MPTCP streams, sorry.
                 - Paolo has just added support of coalescing for MPTCP:
                     - to coalesce the ones with the same options
                     - some room to improvement (DSN/ACK in sequence) =

but additional hooks needed and it will increase the complexity
                     - here we address Eric concerns
                     - for the moment we are checking the bit-field on =

each packet. We can optimise this later. Compiler can optimise stuff but =

maybe not to that point.
                     - *Paolo* will check what the binary looks like =

just after the meeting =E2=86=92 The compiler did well his job!
         - v4 & v5 have been sent on Thursday after the meeting:
             - We got a full review from Eric (except the last patch)
             - v6 is ready but will be sent in January

     - Part 2:
         - v1 was sent on Friday
         - v2 was sent on Wednesday (rebase) but rejected until part 1 =

is applied. =E2=86=92 =

https://lore.kernel.org/netdev/20191218.124244.864160487872326152.davem(a)d=
avemloft.net/

     - Part 3:
         - v1 was not sent on Wednesday, David Miller prefers to wait.
         - We are not going to send Part 3 until part 1 & 2 are merged, =

not even as an RFC



Other WIP items:
     - Mostly on hold, focusing on part 1 =E2=86=92 3



mptcpd:
     - mptcpd 0.3: Beta release
     - https://github.com/intel/mptcpd/releases/tag/v0.3
     - mainly plugin API, fixes, stabilisation, it's now a beta!
     - could be nice to stress it (and the kernel part) to see if we can =

use it for servers with a lot of connections (we can lose netlink messages)



Perfs figures:
     - saw issues with the unblocked connect =E2=86=92 mptcp_finish_connect=
() =

can set msk fields async. In a specific sequences from the userspace, we =

can have issues.
     - we can address that later
     - tests were done with MPTCP, one subflow, loopback, same machine
     - we are close to TCP so that's good!



Plan for the next weeks:
     - Rest
     - Enjoy the end of the year! Merry Xmas and Happy New Year everybody!
     - Check patches from Part 1, ideally around the 2nd/3rd of January
     - Tag "netdev-v6-part1" using:
       $ git fetch origin
       $ git tag -sfm "Multipath TCP part 1: Prerequisites, version 6" \
         netdev-v6-part1 $(git log -1 --format=3D%H --grep \
         '^skb: add helpers to allocate ext independently from s' \
         origin/net-next..origin/export)
       $ git tag -sfm "Multipath TCP: full working branch, version 7" \
         netdev-v7-full origin/export
     - Send part 1 v6 to netdev, ideally around the 2nd/3rd of January



Misc:
     - Let's do it! =

https://www.tessares.net/a-key-step-for-mptcp-integration-in-linux-5-x/



Next meeting:
     - We decided to *skip the two next meetings* (26th / 2nd)
     - We propose to have the next meeting on Thursday, the 9th of January.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200109



Feel free to comment on these points and propose new ones for the next
meeting!


Merry Xmas and Happy New Year everybody!

Talk to you next year,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5937265981982295747==--
