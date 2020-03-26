Content-Type: multipart/mixed; boundary="===============7777514289881247593=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 19th of March 2020
Date: Thu, 26 Mar 2020 16:18:55 +0100
Message-ID: <158e3b0a-c46b-fa9e-e14b-4266bee05cdc@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4081

--===============7777514289881247593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last Thursday, we had our 91st meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     net-next: (Paolo, Florian)

mptcp: rename fourth ack field
mptcp: create msk early
mptcp: drop unneeded checks
RFC: tcp: mptcp: use mptcp receive buffer space to select rcv window

     our repo: (Paolo, Florian)

1255763  [v5,5/5] mptcp: v1 ADD_ADDR changes: use subflow_generate_hmac(
1255762  [v5,4/5] mptcp: v1 ADD_ADDR changes: add subflow_generate_hmac(
1255760  [v5,3/5] mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
1255761  [v5,2/5] mptcp: v1 ADD_ADDR changes: options and parsing
1255759  [v5,1/5] mptcp: Re-factor mptcp_crypto_hmac_sha()
1245636  mptcp: re-check dsn before reading from subflow



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Matthieu, Florian, Paolo

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - still have the bug
     - we can convert that as a Github issue

1253668: Changes Requested: mptcp: propagate sendbuf setting to subflow =

on fallback
1253672: Changes Requested: mptcp: copy mptcp receive buffer setting to =

subflow
1253677: Changes Requested: tcp: mptcp: use mptcp receive buffer space =

to select rcv window:
1258245: New: [mptcp-next,v2] tcp: mptcp: use mptcp receive buffer space =

to select rcv window:
     - one has been sent to net-next for RFC
     - the rest might be sent to net-next
     - or include in the "export" branch?
     - but this will increase the number of patches we will sent to net-next
     - so better to send these patches directly to net-next
     - but better to wait for part 3 to be included

1255550: Awaiting Upstream: [v1,1/3] Squash-to: "mptcp: Implement path =

manager interface commands"
1255552: Awaiting Upstream: [v1,2/3] Squash-to: "mptcp: add netlink =

based PM"
1255551: Awaiting Upstream: [v1,3/3] Squash-to: "selftests: add =

test-cases for MPTCP MP_JOIN":
     - to be applied
     - new small patches should arrive to fix sporadic failure

1258047: Awaiting Upstream: [1/2] mptcp: fix compilation error without IPV6
1258046: Awaiting Upstream: [2/2] mptcp: fix compilation warning without =

IPV6:
     - to be applied



FYI: Current Roadmap:
     - Part 3 (next merge window):
         - PM: [Done]
             - locking [Done]
             - basic =E2=86=92 netlink support [Done]
         - MP_JOIN [Done]
         - ADD_ADDR for MPTCP v1 [DONE]
         - clean the current patches [TODO]
         - squash the current patches [TODO]:
             - "subflow: place further subflows on new 'join_list'"
         - need to make sure we continue to support the protocol =E2=86=92 =
we =

will not fully support it
         - PM basic [Done]
         - fix sender ID in MP_JOIN [Done]

     - Part 4 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - reduce locks when mptcp_stream_accept (currently 3 locks) but =

we might need to add an helper in inet API:
             - already covered by "mptcp: create msk early" [DONE]
         - Full DATA_FIN support [WIP]:
             - could be nice to have it: if ready
         - Active backup support [WIP]
         - ADD_ADDR for MPTCPv1: echo bit
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



Part 3 remaining stuff:
     - Review commit messages:
         - needed for the next merge window
         - Mat will look at that

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - "subflow: place further subflows on new 'join_list'"
         - Paolo will look at how to squash it in multiple commits

     - ADD_ADDR for MPTCPv1:
         - DONE

     - new patches coming:
         - small fixes from Paolo
         - Davide has a fix, will send it directly to net-next as soon =

as possible.

     - apply pending patches:
         - Matth will do that

     - Shared received windows:
         - we don't include other changes in this patch-set
         - Florian has sent an RFC to get feedback from Eric

     - cover letter:
         - Mat will draft one

     - Let's try to send it ASAP, ideally max this Monday



Extra tests:
     - news about Syzkaller? (Christoph):
         - Christoph is looking at fuzzing the netlink API but he has =

some issues with syzkaller
         - checking with syzkaller guys.

     - new about Intel's kbuild? (Mat):
         - t/* branches are now blacklisted
         - but hard to know what is tested for the moment because there =

is no "success" email.
         - Mat will turn them on for the moment to verify everything is OK
         - "export" branch was successful

     - packetdrill (Davide):
         - mpc + data https://github.com/multipath-tcp/packetdrill/pull/3
         - Matth can look at it and merge it to have the CI testing it



mptcp.org:
     - Christoph is adding support for MPTCPv1

     - He was able to launch interop tests (without MP_JOIN): running =

fine with net-next kernel!

     - do we need to ntohl the key? Christoph will try to run interop =

tests: big/small endian



Reviewed-by tags:
     - should we add them next time we add new patches in the TopGit =

tree? ("export" branch)

     - Paolo: for patches with many authors, I _think_ it's less relevant

     - feel free to add Reviewed-by tags before sending to net-next if =

you got reviews from mptcp ML



CI:
     - mptcp_connect.sh -m mmap =E2=86=92 not yet (still the bug):
         - the bug should be there and tracked with a Github issue

     - mptcp_connect.sh: more to run? e.g. -R, -S?:
         - TODO

     - how I can run `make W=3D1` only for files in `net/mptcp`? (to run =

it with -Wunused-but-set-variable and more):
         - make W=3D1 then clear the objects and retry the compile and =

look for warnings with KCFLAGS=3D"-Werror"



Issues:
     - now added in Github
     - feel free to use it
     - Paolo started to use it
     - Proposition to add this URL in MAINTAINERS file to have other =

seeing known-issues. =E2=86=92 feel free to send a patch



Next meeting:
     - We propose to have the next meeting on Thursday, the 26th of March.
     - /!\ *NOT* the Usual time: 16:00 UTC (9am PDT, 5pm CET) /!\
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200326



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
--===============7777514289881247593==--
