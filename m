Content-Type: multipart/mixed; boundary="===============1324391132888407820=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 30th of January 2020
Date: Fri, 31 Jan 2020 19:02:10 +0100
Message-ID: <c99fc3d1-a69b-cc84-5200-16ce0ed53d63@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3569

--===============1324391132888407820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 84th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Florian, Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By Florian Westphal, Geert Uytterhoeven, Mat Martineau, Randy Dunlap
     - All these patches have been directly sent to netdev ML, not =

applied in our TopGit tree (export branch)

1229123  [net-next,2/2] mptcp: Fix code formatting
1229125  [net-next,1/2] mptcp: do not inherit inet proto ops
1231348  mptcp: Fix undefined mptcp_handle_ipv6_mapped for modular IPV6
1231046  mptcp: MPTCP_HMAC_TEST should depend on MPTCP
1231044  mptcp: Fix incorrect IPV6 dependency check
1231042  [net] Revert "MAINTAINERS: mptcp@ mailing list is moderated"
1230708  MAINTAINERS: mptcp@ mailing list is moderated
1230404  [net-next,v1,4/4] mptcp: handle tcp fallback when using syn coo
1230403  [net-next,v2,3/4] mptcp: mptcp_close: avoid a lockdep splat whe
1230402  [net-next,v4,2/4] mptcp: protocol: fix panic on user pointer ac
1230400  [net-next,v1,1/4] mptcp: protocol: defer freeing of cached ext



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Matthieu Baerts

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - note that the fix for selftests core has been applied: it now =

takes into account the timeout we set.
     - but we still have a bug when there is no re-ordering



FYI: Current Roadmap: (before the meeting)
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - Merged!
     - Part 2 (minimum set for MPTCP, up to MPTCPv1 including =

KSelftests, one subflow):
         - Merged!
     - Kernel 5.6:
         - fix issues reported by users and Syzkaller
     - Part 3 (to be sent when the next merge window opens)
         - Full DATA_FIN support [WIP]
         - Shared recv window (drop data received on other subflows) [TODO]
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)
         - ADD_ADDR for MPTCPv1 [TODO]
         - PM basic [WIP]
     - Part 4 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server
     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO
         - PM netlink
         - PM bpf
         - Scheduler bpf
         - syncookies



Initial submission to net-next:
     - Part 2:
         - v3 has been merged!
         - We got more likes than Wireguard :-D =

https://twitter.com/davem_dokebi/status/1220715287365943298



Kernel 5.6:
     - stabilisation

     - run Syzkaller

     - doc?:
         - userspace devs:
             - maybe better to wait for the next kernel with multiple =

subflows support
         - kernelspace devs:
             - Is it something needed? To be discussed next week

     -  Jakub Sitnicki new Net co-maintainer: does it change anything =

for us?:
         - he was already maintaining the net tree for some time, should =

not change anything



Where to store patches for "net" and "net-next"?:
     - a new repo?

     - maybe easier with branches?: =E2=86=92 should be fine
         - fixes-net
         - fixes-net-next
         - =E2=86=92 we would force push on them because we will continue t=
o =

send patches to netdev
         - =E2=86=92 if not OK, we can change that later

     - these branches can be used for having a pre-review

     - would be easier to have the patches on Git to run CI jobs

     - we could have CI jobs on public CI (appveyor.com, travis (but =

annoying to store the .yml file), etc.):
         - *Matth* can look at that



About patches sent by other people directly to netdev ML:
     - do we have to send ACK-by/Reviewed-By?

     - for the moment we had fixes to fix compilation issues, better to =

merge them directly, net maintainers will not wait for us

     - for the rest, net maintainers might wait for us to review. Most =

of the time, there are no explicit request except if it is for a long =

time in "waiting for review" status.

     - we should then try to review these patches ASAP when directly =

posted to netdev from other people



Part 3 remaining stuff:
     - Review commit messages:
         - needed for the next merge window: not urgent

     - reduce locks when mptcp_stream_accept (currently 3 locks) but we =

might need to add an helper in inet API:
         - Paolo started to look at that

     - memleak if a request comes after a socket is closed:
         - Florian plans to look at that

     - PM:
         - maybe need more work: locking ??? (at least check which are =

the missing pieces, possibly some basic locking schema is missing)
         - do we want to ship it?
         - see the discussions below

     - MP_JOIN self-tests:
         - we need to cover this part

     - packetdrill:
         - latest state: https://github.com/dcaratti/packetdrill/tree/dss_v1

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - to be discussed next week

     - ADD_ADDR for MPTCPv1:
         - Peter plans to work on that

     - Path Manager basic with netlink interface.

     - Active backup support:
         - Florian is working on it, patches have been shared

     - DATA_FIN:
         - Mat is working on it



For the next iteration:
     - PM:
         - locking
         - basic =E2=86=92 netlink support

     - MP_JOIN

     - ADD_ADDR for MPTCP v1

     - clean the current patches

     - need to make sure we continue to support the protocol =E2=86=92 shar=
ed =

received windows



last data packet is ACKed when the app read data:
     - in Out-Of-Tree (OOT) MPTCP and iOS: data are ACKed directly

     - maybe not nice to rely on the application to ACK the last one: =

userspace can take time, the server can then timeout, not nice



ACK:
     - in OOT MPTCP: we ACK the last in order chunk. Once it's ordered, =

we ACK everything

     - in OOT MPTCP, there is a single lock per connection =E2=86=92 easier=
 but =

more intrusive to TCP

     - alternative solution:
         - share a pointer for the lock but would not be accepted
         - a workqueue that is triggered to send a ACK
         - can be useful to keep in mind: it's rare to have more than 3 =

subflows.



MP_JOIN:
     - addr ID: it's related to the sender's address
     - for the moment in the "export" branch, we mix things =E2=86=92 TODO



ADD_ADDR echo reply:
     - it's too long, would be easier with only the ID
     - but (too) late to change the RFC
     - this cannot fit in a "normal" packet transporting data
     - we would need to send a dedicated ACK
     - can be seen as a dup ACK
     - (same for dedicated ADD_ADDR, RM_ADDR, etc.)
     - TCP CC should ignore these dup ACK containing these MPTCP options =

(according to the RFC)
     - sounds not like a bit deal, it's not often it happens



Extra tests:
     - news about Syzkaller? (see prev meeting):
         - an instance running at Apple (Christoph)
         - Christoph has modifications for Syzkaller to take into =

account MPTCP
         - That means syzbot will test that and report issues on netdev ML
         - Christoph will send the Pull Request
         - and test the end of the "export" branch

     - news about Intel's kbuild? (Mat):
         - they are going to test out "export" branch
         - running our kselftests and more
         - "export" branch is re-written every day: should be OK



Socket option whitelisting (from Mat):
     - Revisit socket option whitelisting?

     - In discussion of patch to allow TCP_CONGESTION, changes were =

dropped so we allow all socket options to pass through to subflows.

     - will we need a 'if (level =3D=3D SO_MPTCP)'?

     - we would like to whitelist some but later

     - if we pass option to existing subflows, what happens when there =

is a new subflow created: we keep the modifications in a list and we =

send options to subflows

     - could we pass options only to some subflows, not all

     - =E2=86=92 to be discussed next week



Path Manager: (Paolo):
     - Basic but using netlink instead of sysctl

     - revisiting the current pm.c

     - idea would be to fix issues with the locks, then improve PM basic =

to support netlink, should be compatible with OOT Netlink PM

     - discussion to be continue next week or on the ML



Move the parent branch of export from net-next to net:
     - if net-next is behind net for a long time, better to switch
     - [after meeting note]: it seems net-next was updated during the =

meeting
     - we just need to resolve conflicts



Next meeting:
     - We propose to have the next meeting on Thursday, the 6th of February.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200206



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
--===============1324391132888407820==--
