Content-Type: multipart/mixed; boundary="===============2853658632389512324=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 2nd of December 2019
Date: Tue, 03 Dec 2019 10:09:15 +0100
Message-ID: <68abfd15-af23-f0ea-d5c0-bcc561e9ae79@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2760

--===============2853658632389512324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 77th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By Davide Caratti, Florian Westphal, Paolo Abeni

1202768  selftests: remove pcap captures with 'make clean'
1201563  init ssn_offset for incoming/outgoing join requests
1200453  subflow: don't increment msk refcount on join connect completio
1200038  [3/7] remove second conditional
1200037  [2/7] mptcp: must drop reqsk as well
1200035  [1/7] subflow: fix join error handling
1199503  [2/4] squash-to "mptcp: Write MPTCP DSS headers to outgoing dat
1199499  [3/4] Squash-to: "mptcp: Add handling of outgoing MP_JOIN reque
1199502  [4/4] Squash-to: mptcp: Add handling of incoming MP_JOIN reques
1199501  [1/4] crypto: refactor crypto helpers.



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     - By Christoph Paasch, Davide Caratti, Florian Westphal, Mat =

Martineau, Matthieu Baerts, Paolo Abeni, Peter Krystad

1194592: Changes Requested: [RFC,1/1] mptcp: Optimize struct mptcp_recei
1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec
1199714: Awaiting Upstream: [v3] mptcp: Basic single-subflow DATA_FIN
1202759: Awaiting Upstream: [0/9] mptcp: support mptcp joins
1202758: Awaiting Upstream: [1/9] token: handle join-before-accept-compl
1202760: Awaiting Upstream: [2/9] mptcp: fix race from mptcp_close/mptcp
1202761: Awaiting Upstream: [3/9] copy connection id from first subflow
1202762: Awaiting Upstream: [4/9] store tcp_sk, not socket
1202763: Awaiting Upstream: [5/9] add mptcp_subflow_shutdown
1202764: Awaiting Upstream: [6/9] make accept not allocate kernel socket
1202765: Awaiting Upstream: [7/9] pass subflow socket to mptcp_finish_co
1202766: Awaiting Upstream: [8/9] subflow: place further subflows on new
1203040: New: [v3] mptcp: fix option length of mp_capable syn/ack
1203059: Needs Review / ACK: [1/3] skb: add helpers to allocate ext inde
1203061: Needs Review / ACK: [2/3] mptcp: avoid data stream corruption o
1203062: Needs Review / ACK: [3/3] imptcp: properly detect skb collapsin
1203224: New: [1/3] mptcp: move from sha1 (v0) to sha256 (v1)
1203225: New: [2/3] mptcp: parse and emit MP_CAPABLE option according to
1203227: New: [3/3] mptcp: process MP_CAPABLE data option.
1203258: Awaiting Upstream: [v2,9/9] don't flag parent socket as RCV_SH



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file [TODO]
     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - MPTCPv1 support [Patches waiting for final review]
         - opti in TCP options? [Patch shared but it needs rebase and split]
         - Send DATA_FIN, no corner cases [Patches can be applied]
         - IPv6 support [Done]
         - if the peer never sends MPTCP-level ACK, a lot of memory will =

be used [Patches to be applied]
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
         - Christoph is working on it:
             - new version sent during the meeting
         - Paolo is adding SHA256 support:
             - Christoph has the patches in his tree
     - DATA_FIN:
         - Mat has shared a patch, waiting to be applied
         - Mat has a second part for that, working on that
     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter has shared a patch but waiting for the git tree to =

stabilized before doing a rebase + split
     - MAINTAINERS file:
         - TODO



Other WIP items:
     - Active backup support:
         - Florian is working on it, patches have been shared
         - WIP: limit the number of MP_JOIN requests and nb of subflow =

sockets
         - we can drop the patch exporting __tcp_poll =E2=86=92 TODO when w=
e =

apply the patches removing the use of this function



Patches to apply (by Matth):
     - 1) DATA_FIN
     - 2) MPTCPv1 =E2=86=92 wait a bit for a review
     - 3) SendMsg "refactor" =E2=86=92 if reviewed
     - Also the series from Florian (mptcp: support mptcp joins)
     - And the fix from Davide (option length of mp_capable syn/ack v0)



MP_JOIN:
     - From Paolo: "My [mis?]understanding is that MP_JOIN should not be =

attempted before the msk is fully established (fourth_ack)"
     - the idea of fully_established: we validated that we can transfer =

"MPTCP data" (no middlebox)
     - we should then accept MP_JOIN even if we are not "fully =

established" (making sure we don't have nasty middleboxes)



RFC6824bis:
     - will we have an update before the "release" (new RFC)?
     - yes, the proposed changes should be accepted



ML:
     - it seems that people who don't subscribe to the list cannot send =

messages
     - should we allow that? (if there is no spam)
     - yes but some bugs in the ML software cannot allow them for the =

moment. Mat is going to look at it



Misc.:
     - =

https://rule11.tech/the-history-of-multipath-tcp-with-olivier-bonaventure/
     - http://vger.kernel.org/~davem/net-next.html



Next meeting:
     - /!\ *Back to Thursday, already this week*
     - We propose to have the next meeting on Thursday, the 5th of December.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191205



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you in 2 days,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2853658632389512324==--
