Content-Type: multipart/mixed; boundary="===============4793226519011582097=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 6th of February 2020
Date: Fri, 07 Feb 2020 15:32:25 +0100
Message-ID: <c837b085-099e-0aec-a9e4-8988a7017357@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3598

--===============4793226519011582097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 85th meeting with Mat and Peter (Intel OTC), =

Christoph (Apple), Paolo, Florian, Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     - By Matthieu Baerts

1232053  [GIT] Sync with net-next on 20190131: a few conflicts

(Other patches, from Florian, have been sent and directly accepted on =

'net' branch)



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
     - By Florian Westphal, Mat Martineau, Matthieu Baerts

1196109: RFC: [10/10,RFC] selftests:mptcp: decrease timeout to 100 sec:
     - old one, waiting for a another fix

1233392: New: subflow: place outgoing connections on the join list:
     - not needed for 'net' be needed after, for "export"

1233648: New: [RFC,1/3] mptcp: Check connection state before attempting send
1233650: New: [RFC,2/3] mptcp: Use per-subflow storage for DATA_FIN =

sequence number
1233649: New: [RFC,3/3] mptcp: Only send DATA_FIN with final mapping:
     - This series is for the "net" branch, at least the first 2, maybe =

the last one too
     - Waiting for feedback/review



FYI: Current Roadmap:
     - Part 3 (next merge window):
         - PM:
             - locking
             - basic =E2=86=92 netlink support
         - MP_JOIN
         - ADD_ADDR for MPTCP v1
         - clean the current patches
         - need to make sure we continue to support the protocol =E2=86=92 =

workaround for shared received windows

      - other items:
         - Full DATA_FIN support [WIP]:
             - could be nice to have it: if ready
         - Shared recv window (drop data received on other subflows) [TODO]:
             - could be nice to have
             - could be nice to share a prototype/RFC with TCP =

maintainers (Eric)
         - Active backup support [WIP]
         - Opti in TCP option structures (unions) [to be rebased)
         - ADD_ADDR for MPTCPv1 [TODO]
         - PM basic [WIP]
         - fix sender ID in MP_JOIN

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
         - syncookies



Shared receive windows:
     - =

https://www.files.netdevconf.info/d/8a1f3727ff7e48d89ea4/files/?p=3D/how-ha=
rd-can-it-be-adding-multipath-tcp-upstream-k_HNs4aZh.pdf =

=E2=86=92 page 37

     - MPTCP ooo packets (but not OOO for TCP) can fill the window of a =

subflow
          =E2=86=92 deadlock if the in-order packets are never received by =
the =

other end via the other subflows

     - Florian is working on having a workqueue at MPTCP level to =

process received data on subflow that can help for that issue.



Part 3 remaining stuff:
     - Review commit messages:
         - needed for the next merge window: not urgent

     - reduce locks when mptcp_stream_accept (currently 3 locks) but we =

might need to add an helper in inet API:
         - Paolo started to look at that

     - memleak if a request comes after a socket is closed:
         - Florian plans to look at that -> patch sent

     - PM:
         - maybe need more work: locking ??? (at least check which are =

the missing pieces, possibly some basic locking schema is missing)
         - do we want to ship it?
         - we will need to store data somewhere
         - fixed size (like mptcp.org): simple, fast but increase the size
         - or keep data we allocate in a separate data structure, we =

lookup using local IDs, etc.
         - this can slow down things: ADD_ADDR, REM_ADDR
         - maybe easier to start with data allocated in the mptcp sk and =

we see later what to do
          Florian: better to start with fixed-size buffer, if it gets =

too large we can alway make it kmalloc'd

     - MP_JOIN self-tests:
         - we need to cover this part

     - packetdrill:
         - any news?

     - there are also a couple of patches at the end of the series we =

will have to rebase/squash:
         - to be discussed next week

     - ADD_ADDR for MPTCPv1:
         - Peter plans to work on that



Extra tests:
     - news about Syzkaller? (see prev meeting):
         - now on top of "export" branch
         - can be changed if needed
         - not finding anything wrong for the moment
         - pull request has been accepted but it seems syzbot is not =

testing MPTCP sockets:
             - could be nice to contact them
             - Christoph can do that

     - new about Intel's kbuild? (Mat):
         - they are supposed to test the export branch
         - but no feedback yet
         - maybe normal



Documentation for kernel dev:
     - to explain the architecture, etc.
     - already partially explained during some talks
     - could be nice to have it, yes...



Socket option whitelisting (from Mat):
     - we started to allow them but we stopped doing that because it =

would fix the API

     - for the moment, all setsockopts at any time are passed to the subflow

     - better to avoid this and properly manage this later:
         - what do we do for subflows created later
         - can we pass to one specific subflow
         - For example: how to put a different marks on different =

subflows? Having the possibility to get FD per subflow?:
             - Could be nice to get some use-cases, e.g. from Android =

kernel team?
         - Maybe could be nice to get data/stats per subflow
         - TODO: check if there are use-cases

     - so for now, we should return "unsupported" (Mat will send a patch)

     - ideally we try not to break applications using get/set sockopt by =

aggregating/propagating stuffs.



Netdev conf (Vancouver):
     - https://twitter.com/netdev01/status/1225442264551391239



Next meeting:
     - We propose to have the next meeting on Thursday, the 13th of =

February.
     - Usual time: 17:00 UTC (9am PST, 6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200213



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
--===============4793226519011582097==--
