Content-Type: multipart/mixed; boundary="===============2303241759062599080=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 7th of November 2019
Date: Fri, 08 Nov 2019 15:59:23 +0100
Message-ID: <d34ff789-6b5f-a2dc-f791-ccd0f03b3a98@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2442

--===============2303241759062599080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 74rd meeting with Peter and Ossama (Intel OTC), =

Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/

ID      State        Name
--      -----        ----
1189048 Accepted     mptcp: fix stray wake-up event
1189317 Accepted     mptcp: Use sk_family field in the mptcp_sock for =

address family.
1190120 Accepted     [v2,1/6] mptcp: Reference icsk_af_ops routines =

through saved pointer
1190118 Accepted     [v2,2/6] mptcp: Reference inet_stream_ops routines =

through socket->ops
1190116 Accepted     [v2,3/6] mptcp: Re-factor mptcp_getname routine to =

be af-agnostic
1190119 Accepted     [v2,4/6] mptcp: Re-factor subflow_v4_conn_request =

to be af-agnostic
1190122 Accepted     [v2,5/6] mptcp: Export low-level routines for IPv6
1190121 Accepted     [v2,6/6] mptcp: Add IPv6 support



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/

ID      State        Name
--      -----        ----
1189850 Awaiting Upstream [0/4] four small cleanups and fixes
1189851 Awaiting Upstream [1/4] protocol.h: mptcp_subflow_get_map_offset =

arg can be const
1189852 Awaiting Upstream [2/4] options: ignore mptcp-level ack that is =

ahead of write_seq
1189853 Awaiting Upstream [3/4] protocol: use sk_wait_event helper
1189854 Awaiting Upstream [4/4] poll: release lock before waiting
1189894 Awaiting Upstream [1/5] mptcp: Make MPTCP IPv6 support depend on =

CONFIG_IPV6=3Dy
1189893 Awaiting Upstream [2/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189895 Awaiting Upstream [3/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189897 Awaiting Upstream [4/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1189896 Awaiting Upstream [5/5] mptcp: Switch to CONFIG_MPTCP_IPV6
1190123 Changes Requested mptcp: Add DATA_FIN transmission and handling
1191205 New          [1/2] mptcp: parse and emit MP_CAPABLE option =

according to v1 spec.
1191206 New          [2/2] mptcp: process MP_CAPABLE data option.



Remaining items for the initial submission: Update:
     - IPv6 support:
         - Peter is working on it
         - everything seems OK for the initial submission
         - Peter will look at supported v6mapped but that's not needed =

for the 1st patch set
         - We should squash the last one
         =E2=86=92 *@Peter* to give instructions to Matt to know where to s=
quash =

it in multiple commits

     - MPTCP v1 support:
         - Christoph is working on it
         - First patches shared on the ML

         - one question also asked by Paolo on the ML:
             - not enough room to send MPTCP options
             - should be always OK with MP_CAPABLE
             - we might have issues even with MP_CAPABLE, e.g. MD5 =

because it can use 18 bytes
             - if we don't have enough space in MP_CAPABLE, we fallback =

to TCP
             - in mptcp.org, we don't try to use MPTCP if TCP_MD5 is =

configured.
             - but independent to MPTCPv1 support so Paolo will be able =

to look at that

         - question about 3rd packets with MP_CAPABLE. Christoph replied =

on a separated email:
             - if the draft is not very clear, we should not hesitate to =

send an email on the IETF ML

         - the first patch-set sent by Christoph is using SHA1. But it =

should use SHA256:
             - but how to apply it?
             - As we plan to put v1 patches just after having introduced v0
             - But if we squash, it means v0 will use SHA256 (even if we =

drop it in the next patch)
             - Or could be part of the patch introducing v1, but quite =

"big" (3 patches)
             - or as a new part 3, just after kselftests, would be sent =

immediately after
             - maybe difficult to review if it is in one big patch.

             - or move other patches from before the kselftests (related =

to multiple subflows support =E2=86=92 MP_JOIN support, PM, ADD_ADDR handli=
ng):
                 =E2=86=92 maybe the only solution to keep the number of pa=
tches =

under 20
                 =E2=86=92 seems to make sense
                 =E2=86=92 *@Matth*: move these commits just after the =

introduction of the kselftests

             - Wireshark support for v1 has just been merged
             - TCPDump support is not planned yet

     - DATA_FIN:
         - Mat is working on it
         - It seems still to be too big for the "initial submission" =

with the minimal feature
         - because sending the DATA_FIN might be required for some =

implementations (not closing the MPTCP connections), it could be good to =

at least send the DATA_FIN, without the full support.

         - *@Mat*: maybe for the initial submission, part 2, where only =

1 subflow is supported, could we send the DATA_FIN just before closing =

the connection? With the minimal support.

     - Shared recv window:
         - work to be done

     - Active backup support:
         - Florian is working on it
         - Patches (and winter) are coming

     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter is working on it
         - Note: in some code of .h files, some spaces/tabs are used =

while it should be the opposite
         - Peter will send patches soon

     - if the peer never sends MPTCP-level ACK, a lot of memory will be =

used:
         - Florian is working on that

     - MAINTAINERS file



kselftests:
     - should we modify the default timeout (instead of 450s)?
     - When you use --  make -C tools/testing/selftests =

TARGETS=3Dnet/mptcp run_tests   -- how do you pass arguments to =

mptcp_connect.sh script?:
         =E2=86=92 we need to run the script manually
         =E2=86=92 or maybe env vars? Never tried
         =E2=86=92 if ran manually, we don't depend on the timeout

     - *TODO* IPv6 should be enabled by default
     - *TODO* Timeout could be decreased but not under 45 seconds: we =

still need to setup a different timeout



Patchwork:
     - https://patchwork.ozlabs.org/project/mptcp/

     - which status to use?:
         - New =E2=86=92 Waiting for review for anybody
         - Under review =E2=86=92 In review or waiting for precisions?
         - Accepted =E2=86=92 =3D applied? Or waiting to be applied? (but t=
hen no =

longer visible)
         - Rejected =E2=86=92 we don't want that (at all)
         - RFC
         - Not applicable =E2=86=92 to be rebased?
         - Changes requested =E2=86=92 we need a new version (no more an "A=
ction =

Required" state)
         - Awaiting Upstream =E2=86=92 waiting to be applied (more visible =
than =

Accepted since it's an "Action Required" state, included by default in =

the patch list)
         - Superseded =E2=86=92 replaced by another one? Very similar to =

"Changes requested", we don't have to use it
         - Deferred =E2=86=92 for later?
         - Needs review/ACKs =E2=86=92 When assigned to something but the r=
eview =

didn't start =E2=86=92 we can also keep the "Under review" status

     - When do we archive?:
         - After each weekly meeting =E2=86=92 yes to be able to discuss ab=
out =

what has recently been changed
         - Once it is applied? =E2=86=92 then no



TODO Matth:
     - CI: Check Kselftest in the commit where it is introduced
     - Apply accepted patches
     - test IPv6 in kselftests
     - reduce timeout kselftests
     - put on the wiki the meaning of patchwork status



Next meeting:
     - We propose to have it next Thursday, the 14th of November.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191114



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
--===============2303241759062599080==--
