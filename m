Content-Type: multipart/mixed; boundary="===============9021895220680519253=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of November 2019
Date: Fri, 15 Nov 2019 15:07:12 +0100
Message-ID: <19344af8-8de0-5e96-375a-b0c56730a3e5@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2553

--===============9021895220680519253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 75th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/
     - By Florian Westphal, Paolo Abeni, Peter Krystad

      ID  Name
-------  ---------------------------------------------------------------
1194086  [8/8] mptcp: Add IPv6 support for new sysctl initialization
1194081  [7/8] mptcp: Add IPv6 support for shutdown()
1194080  [6/8] mptcp: Add IPv6 support for key generation
1194087  [5/8] mptcp: Add IPV6 support for incoming connections
1194085  [4/8] mptcp: Add IPv6 support for mptcp_poll
1194088  [3/8] mptcp: Add IPV6 support for outgoing connections
1194084  [2/8] mptcp: Add IPv6 support for Associate MPTCP context
1194082  [1/8] mptcp: Add IPv6 support for MPTCP socket stubs
1192875  [4/4] mptcp: init new_ctx->icsk_af_ops() in subflow_ulp_clone()
1192871  [3/4] mptcp: init ctx->icsk_af_ops in subflow_ulp_init()
1192873  [2/4] mptcp: use customary name for tcp_sock variable
1192874  [1/4] mptcp: drop most of mptcp_init_sock() impl
1192074  mptcp: Missing chunk from "Add IPv6 support"
1189896  [5/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189897  [4/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189895  [3/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189893  [2/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189894  [1/5] mptcp: Make MPTCP IPv6 support depend on CONFIG_IPV6=3Dy
1189854  [4/4] poll: release lock before waiting
1189853  [3/4] protocol: use sk_wait_event helper
1189852  [2/4] options: ignore mptcp-level ack that is ahead of write_se
1189851  [1/4] protocol.h: mptcp_subflow_get_map_offset arg can be const
1189850  [0/4] four small cleanups and fixes



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/
     - By Christoph Paasch, Florian Westphal, Mat Martineau, Paolo =

Abeni, Peter Krystad

1190123: Deferred: mptcp: Add DATA_FIN transmission and handling
1191205: Needs Review / ACK: [1/2] mptcp: parse and emit MP_CAPABLE opti
1191206: Needs Review / ACK: [2/2] mptcp: process MP_CAPABLE data option
1192275: Deferred: [RFC,4/6] options: ack pending sequence
1192841: RFC: [RFC] mptcp: move from sha1 (v0) to sha256 (v1)
1193548: Changes Requested: [v2,0/4] mptcp: add and use wmem_queued acco
1193547: Changes Requested: [v2,1/4] mptcp: add wmem_queued accounting
1193549: Changes Requested: [v2,2/4] mptcp: allow partial cleaning of rt
1193550: Changes Requested: [v2,3/4] mptcp: add and use mptcp RTX flag
1193551: Changes Requested: [v2,4/4] sendmsg: block until mptcp sk is wr
1194231: RFC: Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
1194592: New: [RFC,1/1] mptcp: Optimize struct mptcp_received_options.
1194601: Changes Requested: mptcp: Basic single-subflow DATA_FIN
1194982: New: [RFC] mptcp: wmem accounting and nonblocking io support
1194983: New: [RFC,01/14] selftest: add mmap-write support
1194984: New: [RFC,02/14] selftests: make sockets non-blocking for defau
1194985: New: [RFC,03/14] mptcp: add wmem_queued accounting
1194986: New: [RFC,04/14] mptcp: allow partial cleaning of rtx head dfra
1194987: New: [RFC,05/14] mptcp: add and use mptcp RTX flag
1194988: New: [RFC,06/14] sendmsg: block until mptcp sk is writeable
1194989: New: [RFC,07/14] subflow: sk_data_ready: make wakeup on tcp soc
1194990: New: [RFC,08/14] mptcp: add and use mptcp_subflow_get_retrans
1194991: New: [RFC,09/14] mptcp: sendmsg: transmit on backup if other su
1194992: New: [RFC,10/14] recv: make DATA_READY reflect ssk in-sequence
1194993: New: [RFC,11/14] sendmsg: clear SEND_SPACE if write caused wmem
1194994: New: [RFC,12/14] mptcp_poll: don't consider subflow socket stat
1194995: New: [RFC,13/14] sendmsg: don't restart mptcp_sendmsg_frag
1194996: New: [RFC,14/14] sendmsg: truncate source buffer if mptcp sndbu
1195018: New: [v3,1/4,1/1] mptcp: move mp_capable initialization at subf
1195017: New: [v3,2/4] mptcp: disable on req sk if MD5SIG is enabled
1195016: New: [v3,3/4] mptcp: warn once if exceeding tcp opt space for d
1195019: New: [v3,4/4] mptcp: remove unneeded check in mptcp_established


Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file [TODO]

     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - MPTCPv1 support [Patches shared]
         - opti in TCP options? [Patch shared]
         - Send DATA_FIN, no corner cases [Patch shared]
         - IPv6 support [Done]
         - if the peer never sends MPTCP-level ACK, a lot of memory will =

be used [Patches shared]

     - Part 3 (after the KSelftests, to be sent ideally before the end =

of the year)
         - Full DATA_FIN support [WIP]
         - Shared recv window (drop data received on other subflows) [TODO]
         - Active backup support [WIP]

     - Part 4:
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)

     - Part 5:
         - opti/perfs



Remaining items for the initial submission: Update:
     - IPv6 support:
         - nothing more to do for initial submission

     - MPTCP v1 support:
         - Christoph is waiting for review
         - sha256 is complete (but on review)
         - if we move to MPTCPv1, we will lose support with mptcp.org
         - we already discussed about that and even if technically, that =

sounds bad because we already have v0 support but that will simplify the =

code, not having to support multiple versions, etc. and we hope that v1 =

support in mptcp.org will be stabilized soon!

     - DATA_FIN:
         - Mat is working on it
         - Mat sent a smaller patch: work with only one subflow for the =

moment =E2=86=92 when we close one subflow, we send the DATA_FIN (not worki=
ng =

when there are multiple subflows)
         - Mat is looking at a failure he got (end of the data is =

missing), maybe not related to the change. Maybe due to an MPTCP-level =

retransmission (bug).
         - Mat is waiting for a review
         - Mat will send also bug-fix patches when working on that
         - To be able to support multiple subflows, maybe a simple check =

could be added (more than 1 entries in the conn list) =E2=86=92 then we can =

apply the patch before the kselftest and the rest will continue to work. =

*Mat* will look at that

     - Active backup support:
         - Florian is working on it
         - Florian just sent 14 new patches
         - https://patchwork.ozlabs.org/patch/1194982/
         - with a nice description in the cover-letter :)

     - optimisation of options in TCP "struct mptcp_options_received":
         - Note: in some code of .h files, some spaces/tabs are used =

while it should be the opposite:
             included in the patch
         - the patch is waiting for review

     - if the peer never sends MPTCP-level ACK, a lot of memory will be =

used:
         - Florian is working on that
         - it is included in the different patches Florian sent

     - MAINTAINERS file:
         - mailing list: do we want to keep netdev (like ebpf stuff)
         - who can be co-maintainer?
         - better not to have only one maintainer
         - Mat will be on the list
         - Maintainer also means that we might need to review stuff and =

dedicate time on that. If it can be done on the work time, that's easier.
         - Matth doesn't mind to help!
         - We need to organize a remote beer event



Pending changes:
     - a lot of them would have to be squashed in many different commits
     - even Florian said that he would have to sit down to do that!
     - this situation is not ideal to develop new patches: better to =

merge this ASAP
     - MPTCPv1 and sha256 would not be squashed but would cause conflicts
     - /!\ don't forget to tell Matth (and the list) if you plan to do a =

rebase of "export".



Regarding MD5 series:
     - should we drop https://patchwork.ozlabs.org/patch/1193024/
     - *Mat* & *Peter* will look at that after the meeting



3rd Ack:
     - like TCP, the SYN is consuming 1 byte
     - so it makes sense to send a DATA_ACK there but it is not necessary
     - It is maybe required to send the DATA_ACK when TFO is used in =

combination with MPTCP (but not needed now)



Not being able to send MPTCP options:
     - related to MD5 series
     - we currently drop them (ADD_ADDR, etc.)
     - should we log that somewhere? comment? github issue? framapad =

copied between meetings? nothing?
     - By Paolo: I would like to avoid adding todos inside comments for =

the first 2 chunks patches - to avoid additional complex rebases =

squashing even later.
     - we can keep that in the pad and copy/paste the item after each =

meeting



ADD_ADDR6 echo:
     - we need 30 bytes (HMAC + IPv6).
       =E2=86=92 Errata by Christoph: HMAC is not in the echo. But 30 bytes=
 is =

possible if we include with ADD_ADDR6, echo =3D=3D 0 but with a port.
     - only taking the ID is apparently not enough
     - Christoph will look at that
     - the idea from the RFC is to drop the timestamp in this packet
     - Christoph is going to IETF meeting and if we need to change =

something, we can have an errata (feedback from implementer)



Patchwork:
     - do not hesitate to update status ;-)
     - do you receive notifications (email) when something is changed? =E2=
=86=92 no
     - Feel free to "delegate" a patch to someone, even after review
     - meaning of patchwork status now on the wiki: =

https://github.com/multipath-tcp/mptcp_net-next/wiki/Patchwork



CI:
     - Now also checking Kselftest in the commit where it is introduced
     - (still doing that at the end)



Rebase:
     - move 3 commits after kselftests
     - *Matth*: TODO



Selftests:
     - run IPv6 by default or only let these tests ran only by the CI? =

(We can set the new timeout depending on this answer)
     - maybe better to run both to have "robots" also testing IPv6
     - *Matth*: TODO
     - it seems there is no way to pass arguments to kselftests via the =

"make" command
     - Alternative:
         cd tools/testing/selftests/net/mptcp
         ./mptcp_connect.sh -6



Packetdrill:
     - Because Davide didn't practice his sign language for a while, we =

will talk about that next week
     - packetdrill v2.0 first breath on mptcp-net-next:
         https://paste.fedoraproject.org/paste/qstGNcEbMfi4oYDySh9LIg
     - Code at https://github.com/dcaratti/packetdrill/tree/mptcp-net-next
     - ~Some~ Many issues need to be fixed



Some nice photos to illustrate the Sigcomm award:
     - =

https://trends.levif.be/economie/high-tech/numerik/un-prix-prestigieux-pour=
-la-technologie-de-l-uclouvain-qui-equipe-800-millions-d-iphones/article-no=
rmal-1214903.html
     - Did you receive your certificate? No for most of us.
     - It seems some certificates are still in China. Olivier is looking =

at that.



Next meeting:
     - We propose to have it next Thursday, the 21st of November.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191121



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
--===============9021895220680519253==--
