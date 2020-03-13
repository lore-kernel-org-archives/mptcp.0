Content-Type: multipart/mixed; boundary="===============0603182214348529754=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 12th of March 2020
Date: Fri, 13 Mar 2020 18:40:50 +0100
Message-ID: <dfb6eb80-b7e3-7bb6-426a-54fecac8aac6@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3939

--===============0603182214348529754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last Thursday, we had our 90th meeting with Mat, Peter and Ossama (Intel =

OTC), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     net-next: (by Paolo and Davide)

1250410: Awaiting Upstream: [net-next,1/2] mptcp: create msk early
1250408: Awaiting Upstream: [net-next,2/2] mptcp: drop unneeded checks
1253142: Applied: [net-next] net: mptcp: don't hang before sending 'MP =

capable with data'

     our repo: (by Paolo)

1249653  [v2,12/12] Squash-to: "selftests: add test-cases for MPTCP MP_J
1249654  [v2,11/12] Squash-to: "selftests: add PM netlink functional tes
1249648  [v2,10/12] Squash-to: "mptcp: add netlink based PM"
1249656  [v2,9/12] Squash-to: "subflow: place further subflows on new 'j
1249657  [v2,8/12] Squash-to: "mptcp: increment MIB counters in a few pl
1249650  [v2,7/12] Squash-to: "mptcp: add MIB counter infrastructure"
1249647  [v2,6/12] Squash-to: "mptcp: allow dumping subflow context to u
1249655  [v2,5/12] Squash-to: "mptcp: Implement path manager interface c
1249651  [v2,4/12] Squash-to: "mptcp: Add handling of outgoing MP_JOIN r
1249638  [v2,3/12] Squash-to: "mptcp: Add handling of incoming MP_JOIN r
1249652  [v2,2/12] Squash-to: "mptcp: Add ADD_ADDR handling"
1249649  [v2,1/12] mptcp: rename fourth ack field
1252338  Squash-to: "mptcp: add netlink based PM"



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Matthieu, Peter, Florian, Paolo



1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - still the bug?

1245636: Needs Review / ACK: mptcp: re-check dsn before reading from =

subflow:
     - Mat is going to look at it

1253090: New: [v4,1/5] mptcp: Re-factor mptcp_crypto_hmac_sha()
1253086: New: [v4,2/5] mptcp: v1 ADD_ADDR changes: options and parsing
1253087: New: [v4,3/5] mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
1253088: New: [v4,4/5] mptcp: v1 ADD_ADDR changes: add subflow_generate_
1253091: New: [v4,5/5] mptcp: v1 ADD_ADDR changes: use subflow_generate_
     - Paolo looked at it, a minor comment =E2=86=92 can be applied after =

"mptcp: simplify mptcp_accept()"

1253668: New: mptcp: propagate sendbuf setting to subflow on fallback
1253672: New: mptcp: copy mptcp receive buffer setting to subflow
1253677: New: tcp: mptcp: use mptcp receive buffer space to select rcv =

window:
     - to review



FYI: Current Roadmap: (part 3 has been updated)
     - Part 3 (next merge window):
         - PM: [Done]
             - locking [Done]
             - basic =E2=86=92 netlink support [Done]
         - MP_JOIN [Done]
         - ADD_ADDR for MPTCP v1 [In review]
         - clean the current patches [TODO]
         - squash the current patches [TODO]:
             - "subflow: place further subflows on new 'join_list'"
         - need to make sure we continue to support the protocol =E2=86=92 =

workaround for shared received windows [In progress]
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

we might need to add an helper in inet API
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
         - needed for the next merge window: not urgent
         - format-patch is maybe already adding the last signed-off
         - but Matth can also add them if we know who is going to send them

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - TODO
         - at least: "subflow: place further subflows on new 'join_list'"
         - Matth can squash it if he gets instruction
         - Or we can use a branch to recreate the topgit tree: but then =

please notify Matth before starting the work to free the export branch

     - ADD_ADDR for MPTCPv1:
         - Peter is looking at that
         - Patches are in

     - Shared received windows:
         - Florian is looking at that indirectly
         - is there anything we want to add for part 3?:
             - it seems we can send what we have for the moment and =

improve it in "part 4".



When to send it?:
     - Send it next week after the meeting
     - TODO list:
         - Review commit messages
         - squash "subflow: place further subflows on new 'join_list'"
         - ADD_ADDR for MPTCPv1
         - intensive tests in a loop next week



Extra tests:
     - news about Syzkaller? (Christoph):
         - Christoph is looking at fuzzing the Netlink API
         - it seems more work is needed to guide Syzkaller to do more =

than only the connection.
         - there is a question on the ML: if you have experience with =

Syzkaller, it can be helpful

     - new about Intel's kbuild? (Mat):
         - It seems it is building more than "export", e.g. =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
         - the TopGit can be unstable when updating it: one patch is =

applied then pushed, then the next one, etc.
         - it seems there are other options to restrict kbuild to =

validate only the export branch. *Mat* is going to look at that.

     - packetdrill (Davide):
         - testing now MP_CAPABLE + Data
         - and found an issue, see the patch on net-next.



CI:
     - mptcp_connect.sh -m mmap =E2=86=92 not yet (still the bug)
     - mptcp_connect.sh: more to run? e.g. -R, -S?
     - TODO, Matth: mptcp_connect.sh with -R ; -S



Userspace PM:
     - we need a tool to interact from the userspace with the kernel
     - mptcpd: Ossama is adding support to it
     - iproute2 is the usual tool to interact with the kernel for the =

network part
     - iproute2 support should be added for the current PM ("basic" usage)
     - once the PM has integrated what is in mptcp.org (per connection =

management), that will be only managed from mptcpd ("advanced" usage)



Next meeting:
     - We propose to have the next meeting on Thursday, the 19th of March.
     - /!\ *NOT* the Usual time: 16:00 UTC (9am PDT, 5pm CET) /!\
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200319



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
--===============0603182214348529754==--
