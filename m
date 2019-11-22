Content-Type: multipart/mixed; boundary="===============8816861377657736923=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 21th of November 2019
Date: Fri, 22 Nov 2019 13:54:29 +0100
Message-ID: <da2fe87e-6b2f-4a66-6dbc-a69257d4d00e@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2659

--===============8816861377657736923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 76th meeting with Mat, Peter and Ossama (Intel =

OTC), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By Florian Westphal, Matthieu Baerts, Paolo Abeni

      ID  Name
-------  ---------------------------------------------------------------
1199013  [3/3] mptcp/ipv6: mptcp_v6_prot needs costom destroy.
1199012  [2/3] mptcp: use ipv6-specific proto struct
1199010  [1/3] selftests: fixup for IPv6 tests
1198519  Re: [PATCH v2 01/13] selftest: add mmap-write support
1198499  Re: [PATCH v2 01/13] selftest: add mmap-write support
1198403  Re: [PATCH v3 3/4] mptcp: warn once if exceeding tcp opt space
1197002  [v2,13/13] sendmsg: truncate source buffer if mptcp sndbuf size
1197001  [v2,12/13] mptcp_poll: don't consider subflow socket state anym
1197000  [v2,11/13] sendmsg: clear SEND_SPACE if write caused wmem to gr
1196999  [v2,10/13] recv: make DATA_READY reflect ssk in-sequence state
1196998  [v2,09/13] mptcp: sendmsg: transmit on backup if other subflows
1196997  [v2,08/13] mptcp: add and use mptcp_subflow_get_retrans
1196996  [v2,07/13] subflow: sk_data_ready: make wakeup on tcp sock cond
1196995  [v2,06/13] sendmsg: block until mptcp sk is writeable
1196994  [v2,05/13] mptcp: add and use mptcp RTX flag
1196993  [v2,04/13] mptcp: allow partial cleaning of rtx head dfrag
1196992  [v2,03/13] mptcp: add wmem_queued accounting
1196991  [v2,02/13] selftests: make sockets non-blocking for default pol
1196990  [v2,01/13] selftest: add mmap-write support
1196989  [v2] mptcp: wmem accounting and nonblocking io support
1196111  [09/10] selftests:mptcp: force MPTCP_IPV6 config
1196107  [08/10] selftests:mptcp: do not reset "ret" when skipping
1196108  [07/10] selftests:mptcp: avoid global var clash
1196110  [06/10] selftests:mptcp: only display the NS id
1196106  [05/10] selftests:mptcp: reduce time to wait for DAD
1196105  [04/10] selftests:mptcp: reduce wait time for the listen
1196112  [03/10] selftests:mptcp: align v4 and v6 results
1196104  [02/10] selftests:mptcp: enable v6 by default
1196102  [01/10] selftests:mptcp: fix typo
1195019  [v3,4/4] mptcp: remove unneeded check in mptcp_established_opti



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     - By Christoph Paasch, Florian Westphal, Mat Martineau, Matthieu =

Baerts, Paolo Abeni, Peter Krystad

1191205: Needs Review / ACK: [1/2] mptcp: parse and emit MP_CAPABLE opti
1191206: Needs Review / ACK: [2/2] mptcp: process MP_CAPABLE data option
1192841: Needs Review / ACK: [RFC] mptcp: move from sha1 (v0) to sha256
1194231: Needs Review / ACK: Re: [RFC PATCH] mptcp: move from sha1 (v0)
1194592: Needs Review / ACK: [RFC,1/1] mptcp: Optimize struct mptcp_rece
1194982: Changes Requested: [RFC] mptcp: wmem accounting and nonblocking
1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec
1197058: Under Review: [v2] mptcp: Basic single-subflow DATA_FIN
1198891: New: [RFC,1/3] skb: add helpers to allocate ext independently f
1198892: New: [RFC,2/3] mptcp: avoid data stream corruption on allocatio
     - fix a TODO
     - there are some questions, also waiting for comments
1198893: New: [RFC,3/3] mptcp: properly detect skb collapsing
     - fix a possible crash, linked to what Matth's reported



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file [TODO]

     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - MPTCPv1 support [Patches shared]
         - opti in TCP options? [Patch shared]
         - Send DATA_FIN, no corner cases [Patch shared]
         - IPv6 support [Done]
         - if the peer never sends MPTCP-level ACK, a lot of memory will =

be used [to be rebased but more important for part 3]

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
         - TFO



Items for the initial submission: Update:
     - MPTCP v1 support:
         - Christoph is working on it: patches have been sent:
             - some rebases needed + questions to answer
             - Christoph is on it

         - Paolo is adding SHA256 support:
             - there are also some changes related to SHA1 too, can be =

squashed and split out of SHA256 patches

     - DATA_FIN:
         - Mat is working on it
         - Patch for the part 2 (1 subflow) has been shared
         - Preparing a v2 after Paolo's comments
         - Some opened questions there
         - One idea from Mat would be to send the DATA_FIN on all active =

subflows (harder to find which one is exactly the last one).
         - Is it OK to do that? (DATA_FIN with the TCP FIN in all active =

subflows):
             - RFC point of view?
             - Optimisation point of view?
             - Sounds good but maybe *@Christoph* has some feedback on that?
         - With Mat's current patch, DSS is added if missing
         - We need to be careful when we will send data over multiple SF =

at the "same time" because we *might* send different DATA_FIN for the =

same connection.
         - But for the current situation, it should be fine.
         - TODO for later (part 3/4?) might be needed.

     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter has shared a patch, it will need to be rebased

     - MAINTAINERS file



Other WIP items:
     - Active backup support:
         - Florian is working on it, patches have been shared



Packetdrill:
     - packetdrill v2.0 first breath on mptcp-net-next:
         - https://paste.fedoraproject.org/paste/OYg~NQRQAjOmATplPU-u5Q

     - Code at https://github.com/dcaratti/packetdrill/tree/mptcp-net-next

     - Some/Many issues need to be fixed =

(https://github.com/dcaratti/packetdrill/issues )

     - Matth has forwarded the mail from Neal to Davide



Feedback to the IETF:
     - Clarifying that the reception of a DATA_ACK means that the server =

successfully received the MP_CAPABLE (Text "If B has data to send first, =

then the reliable delivery of the ACK can be inferred by the receipt of =

this data with an MPTCP DATA_ACK inside the DSS option (Section 3.3).) =

(cfr. discussions on/around 7th of November)

     - Should we vouch to disallow early or late DSS mappings that are =

covering a TCP-sequence space different than the packet they are being =

sent on (cfr., our discussion on/around September 25th):

         - One question for *Christoph* (+ Gregory/Benjamin/Olivier) =

from Mat on the mailing: can we be more strict? e.g. with early mapping =

and some middleboxes doing some aggregation and keeping only the TCP =

options of one packet (last one?).

         - Or keep it in the RFC and not implemented if that can be =

useful later if we see in the field that some middleboxes are doing that

         - Or mention in the RFC that it is a nice to have.

     - ADD_ADDR-option size
         - from Christoph: last  week we discussed this briefly and I =

replied by mail that the size-problem is actually for the non-Echo =

option. In that one there is no way to get around it and all the bits =

need to be presented.
         - Do you agree on that? =E2=86=92 Yes



Selftests:
     - v6 by default
     - now faster
     - found issues when moving 3 commits after kselftests (thx Paolo =

for the fix!)

     - timeout of 300 sec?:
         =E2=86=92 we have an issue when there is no reordering
         =E2=86=92 *TODO* we need to check that

     - it seems that with the new version, we might not capture the end =

of a connection

     - should we extend the kselftests to:
         - also check some setsockopts?
         - stress the server?
         =E2=86=92 to be discussed on ML

     - if tests can be automated and shared (e.g. kselftests), they can =

run each time we modify the code (rebase/MPTCP modification) by the CI.
     - Feel free to share your tests ;-)



Crash with IPv6:
     - see =

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/LSBVB22KGO=
PUCSO5GRY7P7S2EBOYW635/
     - Paolo fixed it today



Rebase:
     - 13 patches have been added at the end
     - MPTCPv1
     - SHA256
     - DATA_FIN
     =E2=86=92 squash now, fix patches =E2=86=91 (if needed) later?
     =E2=86=92 or add at the end, schedule a rebase later?
     - we can do that before sending a non RFC to netdev



When to send part 1 and 2 upstream?:
     - According to http://phb-crystal-ball.org/
     - We should target ~8 of December, not later (XMas, etc.)



LPC 2019:
     - videos are now available: https://youtu.be/Y64n_R14GtI



Meeting (together in the same room) somewhere?:
     - Netconf (Canada in March) =E2=86=92 Closed to Mat & Peter
     - FOSDEM (1-2 February) =E2=86=92 Matt should go there
     - Devconf (https://www.devconf.info/cz/) (Brno, Czech republic, end =

of  Jan) =E2=86=92 Florian/Paolo should go there



Next meeting:
     - /!\ *Unusual date for the next meeting*. Because the 28th and =

29th are bank holidays in the US, we propose to have the next meeting =

the following Monday, the 2nd of December.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191202



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you in one week and a half,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8816861377657736923==--
