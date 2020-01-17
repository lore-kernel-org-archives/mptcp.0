Content-Type: multipart/mixed; boundary="===============8647564345477736671=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 16th of January 2020
Date: Fri, 17 Jan 2020 16:25:28 +0100
Message-ID: <d85341f9-c0fb-fcb2-43d6-90433e21d8a5@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3392

--===============8647564345477736671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 82nd meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3
     - By Florian Westphal, Mat Martineau, Paolo Abeni

1223261  [v2] protocol: add comment to smb mb
1223121  subflow: remove unneded memory barriers
1223087  subflow: get a ref to the current net
1222807  Handle subflow join failures
1221512  Squash-to: "mptcp: add basic kselftest for mptcp"
1220539  [v2,7/7] Squash-to: "mptcp: Add handling of incoming MP_JOIN re
1220540  [v2,6/7] Squash-to: "mptcp: cope with later TCP fallback"
1220541  [v2,5/7] Squash-to: "mptcp: Implement MPTCP receive path"
1220537  [v2,4/7] Squash-to: "mptcp: Write MPTCP DSS headers to outgoing
1220534  [v2,3/7] Squash-to: "mptcp: Add key generation and token tree"
1220536  [v2,2/7] Squash-to "mptcp: Create SUBFLOW socket for incoming c
1220535  [v2,1/7] Squash-to: "mptcp: Handle MP_CAPABLE options for outgo



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Matthieu Baerts, Paolo Abeni, Peter Krystad

1194592: Changes Requested: [RFC,1/1] mptcp: Optimize struct mptcp_recei
1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec
1223676: New: [v1] mptcp: handle ipv4-mapped ipv6 address.:
     - Discussions in progress between Paolo and Mat
     - Paolo would like not to increment the export functions in IPv6
     - Mat: we need to be careful that the "mapped" parameter is always =

true now
     - Paolo will change that and send a v2
1223968: New: mptcp: Store 32 and 64-bit ACKs separately
1223969: New: mptcp: Re-factor expand_ack
1224132: New: [net-next] Squash-to: "mptcp: move from sha1 (v0) to sha25

These 4 patches should be reviewed and applied before sending that to =

netdev ML



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - Merged!

     - Part 2 (minimum set for MPTCP, up to MPTCPv1 including =

KSelftests, one subflow):
         - Going to be sent to Netdev

     - Part 3 (to be sent before the end of the merge window or more =

probably at the next one)
         - Full DATA_FIN support [WIP]
         - Shared recv window (drop data received on other subflows) [TODO]
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)

     - Part 4 (to fully support MPTCP):
         - Shared recv window (full support)
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)

     - Part 5 (extra needed for prod):
         - opti/perfs
         - TFO



Initial submission to net-next:
     - Part 1:
         - v7 was merged on 20200109
     - Part 2:
         - v3 is going to be sent



Part 2 remaining stuff:
     - Paolo is looking at TCP fallback (DONE: patches have been applied)

     - reviewing and comment about memory barriers in part 2 =E2=86=92 we n=
eed =

to improve comment around them (would be nice to squash that in patches =

from part 2):
         - Florian can help looking at that *DONE*

     - memleak if a request comes after a socket is closed:
         - Florian plans to look at that =E2=86=92 but for part 3

     - reduce locks when mptcp_stream_accept (currently 3 locks) but we =

might need to add an helper in inet API:
         - Paolo is looking at that *NOT MANDATORY*
         - probably better to postpone this one and not block the =

submission of part 2

     - let's spend a little time reviewing the commit messages (after =

all this squashing someone could be outdated WRT the actual code):
         - can be done by anybody. Only for part 2 for the moment. Mat =

and Peter will look at that

     - got a kasan splat on ipv4-mapped ipv6 address with packetdrill:
         - RFC patch posted -> Paolo
         - v2 was sent just after the meeting

     - UAF in ipv4 fallback to be at least investigated:
         - patch has been sent and applied: "subflow: get a ref to the =

current net"

     - Signed-off:
         - Matth: *TODO*

     - Cover letter:
         - mention that if Dave applies it, he will get likes on Twitter? :)
             https://twitter.com/davem_dokebi/status/1204101313170038784
             https://twitter.com/davem_dokebi/status/1204102241394651136
             https://twitter.com/davem_dokebi/status/1215724129619308546
             https://twitter.com/davem_dokebi/status/1217211643828035590
         - we need to combine the two previous drafts we shared on the ML:
             - *Christoph* did that just after the meeting

     - When to send it:
         - Maybe not a good idea to send it at the end of the week =

(Friday) because we might rush and people might not see the patches
         - Monday is a day off for some people in the US
         - Maybe better Monday evening/Tuesday morning

     - In summary: =

https://annuel2.framapad.org/p/mptcp_upstreaming_20200116_patches_part2



Other WIP items:
     - packetdrill-based testing:
         - a bunch of them (v1 based) are available
         - would be great to integrate them in the automated tests
         - Davide plans to split v0 and v1 tests
         - Davide will share instructions (build + launch tests)
         - Matth will integrate that in the tests launched by the CI
         - Christoph will clone/copy the repo under github.com/multipath-tcp
         - how was the previous version?:
             - https://github.com/multipath-tcp/packetdrill_mptcp
             - It was working before
             - Tessares shared the fixes they have and still using it
             - Christoph can launch the new version with old tests

     - Active backup support:
         - Florian is working on it, patches have been shared

     - DATA_FIN:
         - Mat is working on it



Patchwork: main status:
     - New =E2=86=92 waiting for a review
     - Need a review =E2=86=92 waiting for a review since last meeting
     - Superseded =E2=86=92 replaced by a new version
     - Awaiting Upstream =E2=86=92 waiting to be applied (so it is "accepte=
d", =

someone said "LGTM", but it is not applied in git)
     - Accepted =E2=86=92 applied



netdev conf:
     - Mat and Ossama sent a proposal
     - Waiting for feedback from the committee (expected around the 1st =

of February).
     - Will share that when received



Next meeting:
     - We propose to have the next meeting on Thursday, the 23rdh of =

January.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200123



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
--===============8647564345477736671==--
