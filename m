Content-Type: multipart/mixed; boundary="===============9127670499142426648=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 23rd of January 2020
Date: Thu, 23 Jan 2020 22:42:51 +0100
Message-ID: <5c91c39c-c774-0be9-f8d1-84c319862306@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3493

--===============9127670499142426648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 83rd meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By Mat Martineau, Matthieu Baerts, Paolo Abeni, Peter Krystad

1226819  [v2] mptcp: fix compilation warning without IPV6
1226763  [v2] Squash-to: "mptcp: cope with later TCP fallback"
1226670  mptcp: uniform the use of CONFIG_MPTCP_IPV6
1226050  Re: Commit text change: Handle MPTCP TCP options
1225102  mptcp: Refine some comments
1225099  Update commit message for "mptcp: cope with later TCP fallback"
1225091  Update commit message for "mptcp: Implement MPTCP receive path"
1225085  Move subflow ipv6 code earlier in subflow.c
1225081  mptcp: Remove protocol spec comments from mptcp_parse_option
1224907  [v2] mptcp: fix caller of mptcp_handle_ipv6_mapped
1224480  [v2] mptcp: handle ipv4-mapped ipv6 address.
1224132  [net-next] Squash-to: "mptcp: move from sha1 (v0) to sha256 (v1



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     - By Matthieu Baerts, Peter Krystad

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec
1223968: Rejected: mptcp: Store 32 and 64-bit ACKs separately
1223969: Rejected: mptcp: Re-factor expand_ack
1224646: Changes Requested: mptcp: Optimize DSS fields in mptcp_options_
1224647: Changes Requested: mptcp: Optimize ADD_ADDR fields in mptcp_opt
1224648: Changes Requested: mptcp: Deal with family field being removed
1224649: Changes Requested: mptcp: Optimize MP_JOIN fields in mptcp_opti



FYI: Current Roadmap:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - Merged!

     - Part 2 (minimum set for MPTCP, up to MPTCPv1 including =

KSelftests, one subflow):
         - Sent to Netdev, in review
         - Waiting for Eric's feedback

     - Part 3 (to be sent before the end of the merge window or more =

probably at the next one)
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

=E2=86=92 we should discuss about the roadmap next time: part 3+ will be fo=
r the =

next merge window.



Initial submission to net-next:
     - Part 1:
         - v7 was merged

     - Part 2:
         - v3 has been sent on Tuesday



Part 2 remaining stuff:
     - wait for reviews

     - for next time: always cc Eric for TCP related patches

     - When to re-send if we don't have any feedback:
         - Eric didn't reply to Christoph's private email yet (the one =

asking if he got all emails or if we have to re-submit)

         - We propose to send a new version on Monday if we don't have =

any feedback (not to spam netdev even more)

         - Patches are still marked as "Needs Review / ACK"
           https://patchwork.ozlabs.org/patch/1226939/

         - if we re-send, we should include the checkpatch fixes

     - checkpatch: 3 issues:
         - one space/tabs mix (1 tabs + 9 spaces instead of 2 tabs + 1 =

space)
         - one extra space after '*' when declaring a function
         - one comparison to "NULL": var =3D=3D NULL instead of !var
         =E2=86=92 we can wait for when we will need to send a new version
         =E2=86=92 *Matth* can send patches and apply them later



Part 3 remaining stuff:
     - Review commit messages:
         - needed for the next merge window: not urgent

     - reduce locks in mptcp_stream_accept() (currently 3 locks) but we =

might need to add an helper in inet API:
         - Paolo started to look at that
         - we suppose he is still on it, to be discussed next week

     - memleak if a request comes after a socket is closed:
         - Florian plans to look at that
         - we suppose he is still on it, to be discussed next week

     - PM:
         - the one we have:
             - was/is an interim PM
             - maybe need more work: locking ??? (at least check which =

are the missing pieces, possibly some basic locking schema is missing)

         - do we want to ship it?

         - the idea would be to have:
             - a "basic" path manager that can create subflows
             - a server-side dedicated PM that sends ADD_ADDR, maybe =

more but not too much (max nb of subflows if it is not possible to block =

via another way?)
             - a netlink PM (see mptcp.org) to be able to customise it =

from the userspace
             - a flexible BPF oriented PM (easy to implement =E2=86=92 easy=
 to =

hook, easy to call bpf functions to change behaviours)

     - MP_JOIN self-tests:
         - we need to cover this part

         - some levels of self-tests should be implemented:
             - some bots are launching them, could be good to have more =

tests
             - we will need to interact with the PM

         - we can use packetdrill for more advanced tests (and have our =

CI testing them)

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - to be discussed next week

     - ADD_ADDR for MPTCPv1:
         - Peter plans to work on that



Other WIP items:
     - Active backup support:
         - Florian is working on it, patches have been shared

     - DATA_FIN:
         - Mat is working on it



Extra tests:
     - Syzkaller?:
         - Intel's kbuild is not doing that
         - others do but can we ask them to validate our code?
         - should we setup a dedicated server? Not complex but you need =

resources
         - might create a lot of noise if we test on top of net-next
         - might be annoying to extract MPTCP stuffs
         - we need to syzkaller to support MPTCP, to check what needs to =

be modified
         - we can restrict the list of syscalls
         - we might have to do more hacks to limit sockets to MPTCP? But =

"easy" to tell him to also create MPTCP ones.
         - Maybe some people have experience on that? Florian?
         - Christoph will try to look at a setup like this

     - Intel's kbuild? (Mat):
         - Mat is looking to have some tests launched more regularly.
         - next time, Mat will get all the emails (not only the authors)
         - he enjoyed the non documented part of this kbuild :-)
         - automatic (when pushed in Mat's branch on git.kernel.org) but =

it can take time
         - it can also test BPF stuff but it's separated: we hope they =

will monitor it, waiting for answers
         - Mat will come back to us if he has more replies from KBuild guys
         - Mat will push -f regularly the export branch to this repo: =

once per week?



packetdrill:
     - Davide will talk about that next wee



pcap on Wireshark wiki:
     - Can Matt (Coudron) add the ones from Davide (TCPDump Pull Request)?

     - Can we share "simple" traces with an MP_JOIN + ADD_ADDR? (from =

packetdrill?):
         - but we don't support ADD_ADDR for MPTCPv1 yet



topic for next time:
     - roadmap for part 3 and 4 (and more)
     - because that will be sent later, next merge window


Next meeting:
     - We propose to have the next meeting on Thursday, the 30th of January.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200130



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
--===============9127670499142426648==--
