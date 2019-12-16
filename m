Content-Type: multipart/mixed; boundary="===============8195174645030113679=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 12th of December 2019
Date: Mon, 16 Dec 2019 17:54:07 +0100
Message-ID: <e0f07c24-284b-8a38-e493-b7ccb07e2448@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3081

--===============8195174645030113679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Thursday, we had our 79th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:


Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

1205721  [22/48] mptcp: add subflow write space signalling and mptcp_poll
1205720  [0/1] proposed export branch rebase
1205201  Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN if =

one on...
1205182  Re: [PATCH v4] mptcp: fix option length of mp_capable syn/ack
1204880  mptcp: Remove dss_flags field from struct mptcp_options_received
1204879  mptcp: Remove flags field from struct mptcp_options_received
1204810  [v3,3/3] mptcp: process MP_CAPABLE data option.
1204808  [v3,2/3] mptcp: parse and emit MP_CAPABLE option according to =

v1 spec.
1204807  [v3,1/3] mptcp: move from sha1 (v0) to sha256 (v1)
1204700  [v4] mptcp: fix option length of mp_capable syn/ack
1204204  [v3,3/3] mptcp: properly detect skb collapsing
1204203  [v3,2/3] mptcp: avoid data stream corruption on allocation failure.
1204201  [v3,1/3] skb: add helpers to allocate ext independently from =

sk_buff
1203258  [v2,9/9] don't flag parent socket as RCV_SHUTDOWN if one one =

subflow ...
1202766  [8/9] subflow: place further subflows on new 'join_list'
1202765  [7/9] pass subflow socket to mptcp_finish_connect
1202764  [6/9] make accept not allocate kernel socket struct
1202763  [5/9] add mptcp_subflow_shutdown
1202762  [4/9] store tcp_sk, not socket
1202761  [3/9] copy connection id from first subflow to mptcp socket
1202760  [2/9] mptcp: fix race from mptcp_close/mptcp join
1202758  [1/9] token: handle join-before-accept-completion case
1202759  [0/9] mptcp: support mptcp joins



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

1194592: Changes Requested: [RFC,1/1] mptcp: Optimize struct =

mptcp_received_options.:
     - remaining changes are only for after what we want to send to net-next
1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - please see the discussion below: kselftests timeout
1205319: Awaiting Upstream: mptcp: Fix dd command line option:
     - should be squashed [APPLIED]
1205323: New: [v2,1/4] MAINTAINERS: Add MPTCP maintainers [APPLIED]
1205322: New: [v2,2/4] MAINTAINERS: Add net/mptcp/ files to MPTCP =

section [APPLIED]
1205321: New: [v2,3/4] MAINTAINERS: Add MPTCP selftests to MPTCP section =

[APPLIED]
1205320: New: [v2,4/4] MAINTAINERS: Add uapi header to MPTCP section: =

[APPLIED]
     - please see the discussion below: MAINTAINERS file
1207144: New: subflow: process pending data on state changes, too: [APPLIED]
     - looks good for everybody?
1207190: Awaiting Upstream: [v2,1/4] mptcp: clear 'is_tcp' socket flag =

when the MP_CAPABLE handshake fails [APPLIED]
1207193: Awaiting Upstream: [v2,2/4] mptcp: cleanup fallback handling =

[APPLIED]
1207192: Awaiting Upstream: [v2,3/4] mptcp: add subflow to conn_list =

early [APPLIED]
1207206: Awaiting Upstream: [v3,4/4] mptcp: avoid acquiring the msk lock =

in mptcp_finisch_connect(): [APPLIED]
     - please see below
1208166: New: mptcp: Remove request_version field from =

subflow_request_sock [APPLIED]
1208167: New: mptcp: Remove version field from subflow_request_sock =

[APPLIED]
1208169: New: [1/2] mptcp: Move struct mptcp_options_received [APPLIED]
1208168: New: [2/2] mptcp: Remove version field from =

mptcp_options_received: [APPLIED]
     - Paolo just reviewed that, all 4 patches are OK
1208571: New: mptcp: only orphan partially subflow at close time:
     - one question/suggestion from Florian
     - testing the new suggestion, v2 will be sent if suggestion is OK



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file [to be applied] [APPLIED]
     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - opti in TCP options? [Done]
         - Send DATA_FIN, no corner cases [Done]
         - IPv6 support [Done]
         - if the peer never sends MPTCP-level ACK, a lot of memory will =

be used [to be rebased but more important for part 3]
     - Part 3:
         - MPTCPv1 support [Done]
     - Part 4 (after the KSelftests, to be sent ideally before the end =

of the year)
         - Full DATA_FIN support [WIP]
         - Shared recv window (drop data received on other subflows) [TODO]
         - Active backup support [WIP]
     - Part 5:
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
     - Part 6:
         - opti/perfs
         - TFO



Items for the initial submission: Update:
     - MPTCP v1 support:
         - Done but fallback issues to be applied
     - optimisation of options in TCP "struct mptcp_options_received":
         - Done for part 1=E2=86=923
     - MAINTAINERS file:
         - please see below



New tree:
     - Paolo has proposed a branch for that (with some "squash-to")
     - Davide has applied fixes on top: =

https://paste.centos.org/view/6097ee81#L83
     - Can we directly re-use Davide's branch?
     - The suggestion here is:
         - take Paolo's branch (v4) to recreate the tree
         - extract Davide's fixes and apply them later (but soon) =E2=86=92 =

Davide will do that [DONE]



KSelftest timeout:
     - Because there is still an issue when no re-ordering is used, =

better to keep the 450 seconds
     - But this patch is not applied upstream yet: =

https://patchwork.kernel.org/patch/11204935/
     - But we need it to support timeout of > 45 seconds (default value)
     - That's why it is in the commit introducing the kselftests
     - Should we remove it?
     - Yes we should
     - *Matth*  will do that [DONE]

MAINTAINERS file:
     - Possible other lines include:
         - L:        mptcp(a)lists.01.org :
             - The issue with including this ML is that it currently =

rejects messages from non-subscribers.
             - Mat can reconfigure the ML, the tradeoff is in forwarding =

spam to subscribers
             - Matth: that's what we have on netdev ML
             - Mat has just changed that
         - Q:        https://patchwork.ozlabs.org/project/mptcp/list/ :
             - If all MPTCP patches go to Netdev ML directly, it might =

be confusing for patches to end up in two patchworks (netdev and mptcp)
         - T:        git git://github.com/multipath-tcp/mptcp_net-next.git :
             - Mat has seen two main models for net subsystem management:
                 - netdev-based (TCP, TLS): Patches are sent to netdev, =

approved by subsystem maintainers, and approved and applied by David Miller.
                 - subtree (netfilter, BPF, bluetooth, wireless): =

Messages are sent to netdev (netfilter/BPF) or a separate ML (bluetooth, =

wireless) and are approved and merged to separate git repositories by =

subsystem maintainers. Those maintainers then send pull requests for =

batches of commits to netdev for David Miller to merge directly in git.
             - Mat's view: The scope of MPTCP seems more like the other =

netdev-based projects, so for changes going directly upstream I've =

proposed MAINTAINERS entries that match that development model. If we =

opt to use our own git repo to merge upstream changes and then send pull =

requests, then we would include the "T:" entry for our github repo.
             - Matth's view: should we not start as a subtree because it =

is quite big and it will continue to grow quite quickly in the near future?
             - Pull requests will be difficult for the moment (really =

linked to TCP + new)
             - But we will continue like before
         - in conclusion, we only add a link to the ML, anybody can send =

emails there.
         - our patchwork and git repository are "internal"
         - *Matth*: add the L line when applying the patches [DONE]



Other WIP items:
     - Active backup support:
         - Florian is working on it, patches have been shared
     - DATA_FIN:
         - Mat is working on it



Net-dev:
     - suggestion by Paolo:
         - once everything is merged (Paolo suggested Matth to work =

during the night to be ready tomorrow morning) [DONE]
         - we send the series to mptcp ML =E2=86=92 Matth can do that [DONE]
         - we send part 1 as a non RFC: [DONE]
             - we need the checkpatch fixes
             - and signed-off
             - could be send on Friday
         - we send part 2 a bit later: [DONE]
             - we need the checkpatch fixes
             - and signed-off
             - we can send part 2 once the tests are done
         - we send part 3 "just after":
             - we need the checkpatch fixes
             - and signed-off
             - Mat needs to notify Christoph
         - =E2=86=92 goal is to send everything on "Friday" (US time)
     - we can cc: mptcp ML, no need to add everybody in cc



Signed-off:
     - we need to add Mat or Christoph ones before sending
     - *Matth* can do that [DONE]



Commit messages:
     - first pass already done by some
     - could be good to read the draft patches that will be sent to =

mptcp ML  [DONE]



IRC:
     - a channel? Yes: #MPTCPUpstream on freenode
     - not to move the ML there
     - useful for last minute coordination, questions when applying =

patches, small questions, etc.



Ideas:
     - =

https://opensource.googleblog.com/2019/12/announcing-google-summer-of-code-=
2020.html?m=3D1
     - could be good to start PM work, e.g. for Android, etc.
     - but one important thing is that we need someone to help the =

student, it can take time



- feedback from the field: some mobile networks are not nice for MPTCP:
     - what has been seen is the SYN with MPTCP is received by the =

server, SYN+ACK always dropped, with or without MPTCP
     - we should put in place a safeguard like they do with TFO: after a =

few attempts we fallback to TCP
     - TODO for the roadmap Matth [DONE]



Next meeting:
     - We propose to have the next meeting on Thursday, the 19th of =

December.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191219



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you on Thursday,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8195174645030113679==--
