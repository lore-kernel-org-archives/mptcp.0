Content-Type: multipart/mixed; boundary="===============3950665493113742835=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 5th of December 2019
Date: Thu, 05 Dec 2019 19:19:44 +0100
Message-ID: <edff5e71-1775-d742-4379-0970f702c3fc@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2797

--===============3950665493113742835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 78th meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By Mat Martineau

1199714  [v3] mptcp: Basic single-subflow DATA_FIN



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     - By Christoph Paasch, Davide Caratti, Florian Westphal, Matthieu =

Baerts, Paolo Abeni, Peter Krystad

1194592: Changes Requested: [RFC,1/1] mptcp: Optimize struct mptcp_recei =

 =

 =


1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec =


1202759: Awaiting Upstream: [0/9] mptcp: support mptcp joins =

 =

 =


1202758: Awaiting Upstream: [1/9] token: handle join-before-accept-compl =


1202760: Awaiting Upstream: [2/9] mptcp: fix race from mptcp_close/mptcp =


1202761: Awaiting Upstream: [3/9] copy connection id from first subflow =


1202762: Awaiting Upstream: [4/9] store tcp_sk, not socket =


1202763: Awaiting Upstream: [5/9] add mptcp_subflow_shutdown =


1202764: Awaiting Upstream: [6/9] make accept not allocate kernel socket =


1202765: Awaiting Upstream: [7/9] pass subflow socket to mptcp_finish_co =


1202766: Awaiting Upstream: [8/9] subflow: place further subflows on new =


1203040: Changes Requested: [v3] mptcp: fix option length of mp_capable =


1203224: Needs Review / ACK: [1/3] mptcp: move from sha1 (v0) to sha256 =


1203225: Needs Review / ACK: [2/3] mptcp: parse and emit MP_CAPABLE opti =


1203227: Needs Review / ACK: [3/3] mptcp: process MP_CAPABLE data option =


1203258: Awaiting Upstream: [v2,9/9] don't flag parent socket as RCV_SHU =


1204201: Awaiting Upstream: [v3,1/3] skb: add helpers to allocate ext in =


1204203: Awaiting Upstream: [v3,2/3] mptcp: avoid data stream corruption =


1204204: Awaiting Upstream: [v3,3/3] mptcp: properly detect skb collapsi



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file [TODO]

     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - MPTCPv1 support [In review]
         - opti in TCP options? [to be rebased]
         - Send DATA_FIN, no corner cases [Done]
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
         - Review has been done, waiting for upstream
         - *Matth*: connect on IRC in case of issue (on freenode)
             - Paolo is reachable as 'pabeni'

     - DATA_FIN:
         - Done for part 2
         - Mat has some fixes (receiver side) but that will be for Part 3

     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter has shared a patch, to be rebased
         - Matth will do the rebase

     - MAINTAINERS file:
         - Mat will share a patch + instructions about where to squash =

it/them



What need to be done before sending the series to netdev:
     - new patch:
          - fallback handling should be cleaned-up a bit:
              - *Paolo* is working on that.
              - Might be difficult to have it for Monday, hopefully for =

next week.
              - But Paolo is suggesting to wait for it

          - remove export of __tcp_poll:
              - linked to the squash of some patches from Florian =

applied at the end of the series
              - Will be part of *Florian* 's rebase?

          - MAINTAINERS file:
              - *Mat* is working on it

     - we need a new version for:
         - Davide's fix for MPTCPv0 (address comments) =E2=86=92 done durin=
g the =

meeting (instead of following the meeting... :-D )

     - apply and squashes all existing patches we have:
         - Florian's patches that are currently at the end of the series =

=E2=86=92 Florian will do that tomorrow, after Matth's modifications
         - Florian's patches related to MP_JOINs (waiting to be applied) =

=E2=86=92 Matth will do that (3)
         - Paolo's patches related to sendmsg() (waiting to be applied) =

=E2=86=92 Matth will do that (2)
         - Christoph/Paolo's patches for MPTCPv1 (address comments) =E2=86=
=92 =

Matth will do that (1)
         - Peter's patch to optimize mptcp_received_options (rebase + =

split) =E2=86=92 Matth will do that (4)
         - fallback cleanup when ready (5)



Net-next:
     - open for 8 weeks from likely Sunday

     - But in these 8 weeks, there will be holidays (in =

Europe/America/Australia, Sorry Asia)

     - We should send our patches as soon as possible, ideally next week =

if everything in good shape

     - We need some real feedback on the code from Net/TCP maintainers.



Submissions:
     - we want to send both part 1 and 2
     - (they will certainly not accept to merge part 1 if they don't =

have part 2)

     - Idea from Paolo: create a part 3 with only MPTCPv1 patches:
         - to have a smaller patch-set (part 2)
         - Christoph can send this part 3

     - *Mat* will draft a cover-letter and share it on the ML



Commit message:
     - we have to make sure they are still OK, at least up to the kselftests

     - *all* : Could be good if this is done by a maximum of people

     - We can also propose patches modifying .topmsg file
         =E2=86=92 git checkout t/<commit>, e.g. git checkout =

t/mptcp-Add-path-manager-interface
         =E2=86=92 $EDITOR .topmsg
         =E2=86=92 send patch



Submission to netdev:
     - we need to add the signed-off of the submitter (if not already =

present I guess)

     - We need to add Mat' signed-off up to kselftests then Christoph's =

one on MPTCPv1 patches (included SHA256 support)

     - *TODO* before the submission



Other WIP items:
     - Active backup support:
         - Florian is working on it, patches have been shared

     - DATA_FIN:
         - Mat is working on patch for part 3
         - next step is sending the ACK
         - after that: state machine for MPTCP



Force applications to use MPTCP without modifying the app:
     - We can use LD_PRELOAD:
 =

https://github.com/pabeni/mptcp-tools/blob/master/use_mptcp/use_mptcp.sh

     - *all* : Please test it and report issues

     - For the moment, some (most) apps don't work well because the =

fallback is not done properly, Paolo is working on it)

     - We could use BPF with CGroup, see ML (in some setups, it might be =

difficult to use LD_PRELOAD)

     - Question for next week: should we host this in script branch?



Tests:
     - could be good to do some comparisons using a perf app (e.g. AB) =

with and without MPTCP =E2=86=92 *TODO*


RFC6824bis:
     - Timing of submission relative to RFC6824bis official publication?:
         - They are waiting for us, should converge in a few days
         - The RFC is already allocated =E2=86=92 8684
         - That should arrive soon: =

https://www.rfc-editor.org/authors/rfc8684.html

     - should we clarify what should be written in the "version" field =

of the 3rd ACK of an MP_CAPABLE?:

         - section 3.1: If a host supports multiple versions of MPTCP, =

the sender of the MP_CAPABLE option SHOULD signal the highest version =

number it supports. In return, in its MP_CAPABLE option, the receiver =

will signal the version number it wishes to use, which MUST be equal to =

or lower than the version number indicated in the initial MP_CAPABLE.

         - Nothing about the 3rd ACK. Nothing for the other bits too

         - *Christoph* will look at that

     - A question about:
         - "If receiving a message with the "B" flag set to 1 and this =

is not understood, then the MP_CAPABLE in this SYN MUST be silently =

ignored, which triggers a fallback to regular TCP"

         - =E2=86=92 it means we drop the MP_CAPABLE info but we don't drop=
 the SYN

         - what we are currently doing



mptcp.org:
     - could be good to have v1

     - also with SHA256 (note that the net-next implementation is a bit =

different, using Crypto lib)

     - Note: SHA1 was exactly like the mptcp.org implementation but =

Paolo modified it to look like the Crypto implementation



Next meeting:
     - We propose to have the next meeting on Thursday, the 12th of =

December.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191212



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
--===============3950665493113742835==--
