Content-Type: multipart/mixed; boundary="===============5343110240265933521=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 18th of June 2020
Date: Fri, 19 Jun 2020 10:04:12 +0200
Message-ID: <85a5123e-e64a-67dd-10c8-e77302f701c7@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4743

--===============5343110240265933521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 104th meeting with Mat, Ossama and Todd (Intel =

OTC), Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Geliang Tang, Wei Yongjun):

1309344  [net-next,v2] mptcp: use list_first_entry_or_null
1309332  [net,v2] mptcp: drop MPTCP_PM_MAX_ADDR
1309132  [net,v2] mptcp: fix memory leak in mptcp_subflow_create_socket(


     our repo (by: Davide Caratti, Paolo Abeni):

1309695  [v2] net: mptcp: improve fallback to TCP
1307667  [2/2] mptcp: drop MP_JOIN request sock on syn cookies
1307668  [1/2] mptcp: cache msk on MP_JOIN init_req
1307588  [net-next] mptcp: fallback in case of simultaneous connect
1307088  mptcp: close poll() races



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni, Geliang Tang):

1311076  [net,2/2] mptcp: drop MP_JOIN request sock on syn cookies
1311074  [net,1/2] mptcp: cache msk on MP_JOIN init_req:
     - Reviewed but not accepted yet (Accepted just after the meeting)

1310048  [net-next,3/3] mptcp: add MP_FASTCLOSE suboption handling
1310041  [net-next,2/3] mptcp: add MP_FAIL suboption handling
1310034  [net-next,1/3] mptcp: add MP_PRIO suboption handling:
     - Changes requested


     our repo (by: Christoph Paasch, Florian Westphal, Matthieu Baerts, =

Paolo Abeni):

1310276: Changes Requested: [mptcp-next,v2,1/3] net: use mptcp =

setsockopt function for SOL_SOCKET on mptcp sockets
1310275: Changes Requested: [mptcp-next,v2,2/3] mptcp: add =

REUSEADDR/REUSEADDR support
1310277: Changes Requested: [mptcp-next,v2,3/3] mptcp: support =

IPV6_V6ONLY setsockopt:
     - *Florian* will address Mat's comments

1310579: RFC: Re: [PATCH mptcp-next 2/2] mptcp: add receive buffer =

auto-tuning:
     - The patch looks correct
     - *Florian* will send a delta to be squashed (after Paolo' series =

has been accepted)

1310586: New: [mptcp-next] selftests/mptcp: Capture pcap on both sender =

and receiver:
     - need review

1310588: Changes Requested: mptcp: check for plain TCP sock at accept time
    - obsoleted by the series below =E2=86=92 Superseded

1310590: New: [mptcp-next] mptcp: default KUNIT_* fragments to =

KUNIT_ALL_TESTS:
     - need review

1312005: New: [v2,1/4] Squash-to: "net: mptcp: improve fallback to TCP"
1312008: New: [v2,2/4] mptcp: check for plain TCP sock at accept time
1312006: New: [v2,3/4] mptcp: create first subflow at msk creation time
1312009: New: [v2,4/4] mptcp: __mptcp_tcp_fallback() returns a struct sock:
     - Address the feedback from Mat (for 2/4)
     - plus additional cleanup related to TCP fallback
     - need review



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 39)

   39  [syzkaller] WARNING in subflow_data_ready (v2.0):
       - *Davide* is looking at issue 39 and also at his audio system

   34  WARNING: Bad mapping: ssn=3D1 map_seq=3D498340137 map_data_len=3D79
   33  weighttp-test on 1KB file with mptcp.org-client in "ndiffports"-mode
   31  Allow MPTCP + SYN_COOKIES [enhancement]
   30  ssh restart does not work
   26  Unstable packetdrill tests:
       - probably fixed with recent modifications from Todd

   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   21  sort-out {set,get}sockopt handling [enhancement]

   20  implement msk diag interface [enhancement]:
       - Paolo looked a bit more
       - issue with socket option number (MPTCP using 2 bytes while one =

1 is used in diag)

       - Ideas of solutions:
           1) one byte is available (sorry it cut) but will cause issues =

with ss:
               - from there there is one bit which is unused (shutdown =

something) =E2=86=92 maybe we can abuse it?
               - hacky but the code change would be very limited

           2) use the two most significant bits in the family bytes that =

are not used
           3) switch to inet_diag_v3 where we would use 2 bytes for the =

socket type:
               - we check the size of the structure to know if we are in =

v2 or v3
               - needs a bit of changes everywhere: dccp, raw, etc.
               - could slow down the support (if other wants to do =

modifications in this v3) but cleanest

       - How to pick?:
           - ask upstream?
           - if we want to change the version (inet_diag_v3), we might =

need these discussions before anyway
           - *Paolo* will send the question to netdev ML

   19  let PM netlink update live sockets on local addresses list change =

[enhancement]
   18  allow 'force to MPTCP' mode [enhancement]
   17  audit 'backup' flag usage  [enhancement]
   15  reduce mptcp_out_option struct size [enhancement]

    6  loss and delay without reordering causes very slow transfer:
        - should we close?
        - investigate a bit more why we have an issue only when there is =

no re-ordering
        - but doesn't seem to be MPTCP specific
        - *Matt* will redo the tests with the same loss and delay param =

but with reordering

    4  keep a single work struct in mptcp socket [enhancement]


     recently closed:

   36  [syzkaller] WARNING in mptcp_token_destroy
   35  [syzkaller] WARNING in subflow_data_ready 3 @dcaratti
   25  mptcp_connect: Connection reset by peer during a test



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



Net-next has been re-opened:
     - Paolo proposes to upstream some patches
     - up to KUNIT patches
     - Then next week the fallback related ones: we can sync on IRC to =

know when to send them



Add reviewed-by, tested-by, acked-by etc. tags:
     - we can add them when applying in mptcp-next (export) branch.
     - feel free to send them in emails instead of a LGTM to have them =

appearing
     - We can also add them after having applied them



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - *Mat* is making some progress, will send a RFC

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - no news



Extra tests:
     - news about Syzkaller? (Christoph):
         - see Github
         - no new ones this week!

     - news about interop with mptcp.org? (Christoph):
         - having some issues with weighttp (updated 3 days ago)

     - news about Intel's kbuild? (Mat):
         - they seem having issues
         - Mat is monitoring that

     - packetdrill (Davide & Todd):
         - Todd has an alpha version that supports MP_JOIN \o/:
             - pushed to his repo
             - MP_JOIN works in both directions
             - Review in progress by Davide

         - Issue 26 is probably fixed with recent modifications from Todd

     - CI (Matth):
         - /
         - we discussed about new features last week, still planned

     - Coverity (Davide):
         - all good!



Meeting at a different time?:
     - Would we have contributors from the East? Maybe
     - A solution is to have meetings at different times: to have EU, =

Asia ; EU, US ; Asia, US
     - We can start by asking external contributors if they are =

interested to participate
     - *Matth* will do that



Wiki:
     - a few updates on the home page
     - + a changelog: =

https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog
     - feel free to contribute ;)



Any changes to do in the Maintainer file?:
     - maintainers? all good
     - ML:
         - we are not going to be kicked soon so we can keep it or change
         - if we want to change, better to do that now
         - but there is no pressure
     - other? no



Next meeting:
     - We propose to have the next meeting on Thursday, the 25th of June.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200625



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5343110240265933521==--
