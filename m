Content-Type: multipart/mixed; boundary="===============7671036981571412106=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 25th of June 2020
Date: Sat, 27 Jun 2020 11:28:00 +0200
Message-ID: <1e618c94-2cd4-5723-55c9-33d0e27bc2d0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4841

--===============7671036981571412106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last Thursday, we had our 105th meeting with Mat, Ossama and Todd (Intel =

OTC), Christoph (Apple), Paolo, Davide and Florian (RedHat), Geliang =

Tang (Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Geliang Tang:
     - (Geliang Tang sounds like Glenn Town)
     - New contributor from Beijing, China (UTC+08:00)
     - He recently looked at the code and send some fixes
     - Working at Xiaomi



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Geliang Tang):

1314275  [net] mptcp: drop sndr_key in mptcp_syn_options

     our repo (by: Florian Westphal, Matthieu Baerts, Paolo Abeni):

1316519  [mptcp-next,3/3] mptcp: support IPV6_V6ONLY setsockopt
1316518  [mptcp-next,2/3] mptcp: add REUSEADDR/REUSEPORT support
1316517  [mptcp-next,1/3] net: use mptcp setsockopt function for SOL_SOC

1315320  [v3,4/4] mptcp: __mptcp_tcp_fallback() returns a struct sock
1312006  [v2,3/4] mptcp: create first subflow at msk creation time
1312008  [v2,2/4] mptcp: check for plain TCP sock at accept time
1312005  [v2,1/4] Squash-to: "net: mptcp: improve fallback to TCP"

1312835  [mptcp-next] mptcp: use mptcp worker for path management

1310590  [mptcp-next] mptcp: default KUNIT_* fragments to KUNIT_ALL_TEST
1310586  [mptcp-next] selftests/mptcp: Capture pcap on both sender and =

receiver



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Christoph Paasch, Florian Westphal, Geliang Tang, =

Paolo Abeni):

1310579: RFC: Re: [PATCH mptcp-next 2/2] mptcp: add receive buffer auto:
     - It has been included in the next patch from Florian, just below

1314402: New: [mptcp-next] mptcp: init autotune state also in simultane:
     - Waiting for review

1316824: New: [1/3] inet_diag: support for wider protocol numbers
1316826: New: [2/3] mptcp: add msk interations helpers
1316827: New: [3/3] mptcp: add MPTCP socket diag interface
1317043: New: [4/4] selftests/mptcp: add diag interface tests:
     - diag interface for MPTCP socket
     - following the recommendation from David Miller
     - Also a new selftests
     - Also waiting some feedbacks

1316834: New: [iproute2-next,1/2] include: update mptcp uAPI
1316833: New: [iproute2-next,2/2] ss: mptcp: add msk diag interface support:
     - Userspace part, linked to the previous series.



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 39)

   39  [syzkaller] WARNING in subflow_data_ready (v2.0) @dcaratti

   34  WARNING: Bad mapping: ssn=3D1 map_seq=3D498340137 map_data_len=3D79:
       - *Paolo* has a fix for that (shared on Friday)
       - The fix will be squashed later

   33  weighttp-test on 1KB file with mptcp.org-client in "ndiffports"-mode
   31  Allow MPTCP + SYN_COOKIES [enhancement]
   30  ssh restart does not work
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   21  sort-out {set,get}sockopt handling [enhancement]
   20  implement msk diag interface [enhancement] @pabeni
   19  let PM netlink update live sockets on local addresses list change =

[enhancement]
   18  allow 'force to MPTCP' mode [enhancement]
   17  audit 'backup' flag usage  [enhancement]
   15  reduce mptcp_out_option struct size [enhancement]

    6  loss and delay without reordering causes very slow transfer:
        - Matth has a simple patch to always add "reorder" to TC command
        - Christoph suggests to add less delay but more packets with =

this delay
        - *Christoph* will send a patch

    4  keep a single work struct in mptcp socket [enhancement]


New one from Mat (reported on the ML):
     - issue with accept() (blocking), more details on the ML
     - *Mat* will add more details and share that on Github (Done =E2=86=92 =

issue 40)
     - Maybe related to the Fallback refactor (incoming socket events =

are not handled the same way)
     - *TODO* Could be good to cover this with a selftest.


     recently closed:

   26  Unstable packetdrill tests:
        - fixed (in Packetdrill, by Todd)



FYI: Current Roadmap:
     - Part 4 (next merge window):
         - Fix bugs reported on Github: =

https://github.com/multipath-tcp/mptcp_net-next/issues/
         - IPv6 - IPv4 mapped support
         - not dropping MPTCP options (ADD_ADDR, etc.)
         - FAST_CLOSE
         - full MPTCP v1 support (reliable add_addr, etc.)
         - after a few attempts of failed MPTCP, we fallback to TCP =

(like TFO is doing)
         - PM server (more advanced)
         - Active backup support
         - sending "simultaneously" on different subflows (multiple non =

backup subflows)
         - Full DATA_FIN support [WIP by Mat]
         - ADD_ADDR for MPTCPv1: echo bit [WIP by Peter]
         - Opti in TCP option structures (unions) [DONE by Paolo]
         - Shared recv window (full support) [DONE by Florian]

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

     *Matth*: TODO: look at what we can do on Github =E2=86=92 project, lab=
el, etc.
     https://github.com/multipath-tcp/mptcp_net-next/projects

Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - Mat was blocked with the issue with accept()
         - Mat should be able to share a RFC soon

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - no news, maybe more next week

Extra tests:
     - news about Syzkaller? (Christoph):
         - good news: nothing
         - "bad mapping" issue will be closed soon
         - issue 39 is still happening. Davide is looking at that

     - news about interop with mptcp.org? (Christoph):
         - weighttp has some issues
         - debug have been shared on the ML
         - according to the info from perf, the server seems idle
         - *Christoph* will try with less connections

     - news about Intel's kbuild? (Mat):
         - no new update, looks like the builds are green but selftests =

are unstable: maybe linked with issues with BPF and not linked to MPTCP
         - *Mat* will continue to monitor this

     - packetdrill (Davide & Todd):
         - MP_JOIN on the way (Todd)
         - Also some additional fixes, PR should be ready now
         - *Davide* is looking at the review
         - so soon we will be able to have pkt test with multiple subflows
         - out-of-tree kernel is no longer supported (not compatible =

with the socket API, even v1) but generating v0 packets is still OK =

except to generate ADD_ADDR and MP_JOIN.
         - we could drop the scripts to be able to test the whole dir =

(mptcp)
         - but keep the possibility to generate v0 packets (not a lot of =

code, easy to maintain but no longer able to verify)

     - CI (Matth):
         - /

     - Coverity (Davide):
         - *Davide* is trying to clear the last (false positive, =

confirmed) report that regards kmem_cache_create() for subflows.
         - the false positive is just for MPTCP, the way we use =

kmem_cache_create



Sysctl:
     - similar to net.mptcp.mptcp_enabled in mptcp.org
     - would it be accepted upstream?
     - simpler than CGroup =E2=86=92 =

https://github.com/multipath-tcp/mptcp_net-next/issues/18
     - check the systemtap script https://paste.centos.org/view/16641a10
     - Paolo proposes to ask this to Netdev ML but after the patches we =

want to share during this window
     - We could also add support to only have MPTCP for incoming =

connections (good for CDN) and outgoing connections as it was recently =

done in mptcp.org by Christoph



BPF:
     - An intern at Tessares is interested to look at that.
     - What's the most interesting thing to look at "now"?
     - Ideally something around the scheduler but hard now, no?
     - PM?
     - setsockopt per subflow? =E2=86=92 maybe a good start
     - issue 18? =E2=86=92 suggested by other kernel devs at Netdev 0x12



syzkaller repro:
     - https://github.com/multipath-tcp/mptcp-syzkaller-repro
     - feel free to add/move new/existing ones
     - syzkaller repro: needs syzexecuter but not as easy to put in =

place, can probably be scripted (but it can also be long)
     - start with .c reproducers
     - kernel configuration: it is important, e.g. some depends on =

Kasan, some not



Meeting at a different time:
     - to have people from different timezone to be present
     - have meeting at different times?
     - *Matth*: TODO: send mail (when back to work)



Next meeting:
     - We propose to have the next meeting on Thursday, the 2nd of July.
     - Usual time (for the moment): 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200702



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7671036981571412106==--
