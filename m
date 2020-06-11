Content-Type: multipart/mixed; boundary="===============6793979850199315894=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 11th of June 2020
Date: Thu, 11 Jun 2020 19:01:25 +0200
Message-ID: <f3a5e140-0cc1-7ad3-3e92-dc61be603e8f@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4650

--===============6793979850199315894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 103rd meeting with Mat, Ossama and Todd (Intel =

OTC), Christoph (Apple), Paolo and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (by: Geliang Tang, Paolo Abeni):

1306666  [net] mptcp: don't leak msk in token container
1306664  [net] mptcp: fix races between shutdown and recvmsg
1305085  [net,v2] mptcp: bugfix for RM_ADDR option parsing
1303633  [net] inet_connection_sock: clear inet_num out of destroy helpe

     our repo (by: Davide Caratti, Florian Westphal, Paolo Abeni):

1306843  [mptcp-next,2/2] mptcp: add receive buffer auto-tuning
1306841  [mptcp-next,1/2] selftests: mptcp: add option to specify size o
1305430  [v2,3/3] mptcp: do nonce initialization at subflow creation tim
1305429  [v2,2/3] Squash-to: "net: mptcp: improve fallback to TCP"
1305428  [v2,1/3] Squash-to: "mptcp: refactor token container."
1303988  [mptcp-next,v2] net: mptcp: improve fallback to TCP
1303654  [4/4,DO-NOT-MERGE] mptcp: use kmalloc on kasan build
1303655  [3/4] mptcp: don't leak msk in token container
1303656  [2/4] Squash-to: "mptcp: introduce token KUNIT self-tests"
1303652  [1/4] Squash-to: "mptcp: refactor token container."
1292673  [RFC,net-next,2/2] mptcp: fix races between shutdown and recvms



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Davide Caratti, Paolo Abeni):

1307088: Awaiting Upstream: mptcp: close poll() races:
     - reviewed by Mat
     - *Matth* : TODO: can be applied

1307588: New: [net-next] mptcp: fallback in case of simultaneous connect:
     - can be reviewed
     - should address all comments
     - Christoph reported another splat but another patch will be needed =

for this one (different)



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     open: (latest from last week: 35)

Note: you can use some tags to automatically close issues:

 =

https://help.github.com/en/enterprise/2.16/user/github/managing-your-work-o=
n-github/closing-issues-using-keywords#about-issue-references

   39  [syzkaller] WARNING in subflow_data_ready (v2.0):
       - /

   36  [syzkaller] WARNING in mptcp_token_destroy:
       - /

   35  [syzkaller] WARNING in subflow_data_ready 3 @dcaratti:
       - will be closed when "mptcp: fallback in case of simultaneous =

connect" is applied

   34  WARNING: Bad mapping: ssn=3D1 map_seq=3D498340137 map_data_len=3D79:
       - maybe fixed with recent modifications on last export branch
       - Paolo was not able to reproduce it (but not sure if he was able =

to reproduce before)
       - *Christoph* will check if it is still detected by syzkaller

   33  weighttp-test on 1KB file with mptcp.org-client in "ndiffports"-mode
   31  Allow MPTCP + SYN_COOKIES [enhancement]
   30  ssh restart does not work

   26  Unstable packetdrill tests:
       - there is an issue (endianess issue but dack4 is now correctly =

understood), *Davide* will check
       - CI tests are more stable now

   25  mptcp_connect: Connection reset by peer during a test:
       - can certainly be closed
       - *Matth* : TODO check that

   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   21  sort-out {set,get}sockopt handling [enhancement]
   20  implement msk diag interface [enhancement]:
       - could be possible now that the token container has been refactor
       - there is an API issue with IPPROTO_MPTCP
       - "Florian said that the diag handler for IPPROTO_RAW already =

uses it"
       - adding something in '/proc/net/mptcp'?:
           - instead of a real diag interface
           - *Matth* : TODO: we said something about that at the LPC, =

check that

   19  let PM netlink update live sockets on local addresses list change =

[enhancement]
   18  allow 'force to MPTCP' mode [enhancement]
   17  audit 'backup' flag usage  [enhancement]
   15  reduce mptcp_out_option struct size [enhancement]
    6  loss and delay without reordering causes very slow transfer
    4  keep a single work struct in mptcp socket [enhancement]

     recently closed:

   38  [syzkaller] INFO: task hung in lock_sock_nested
   37  [syzkaller] general protection fault in mptcp_stream_connect
   32  [syzkaller] INFO: rcu detected stall in ip_rcv
   29  [syzkaller] INFO: task hung in lock_sock_nested
   28  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow
   23  refactor token container
   22  fix covscan issues 1 @dcaratti
   16  get rid of mptcp hooking in tcp_check_req()
   11  fix fallback to TCP  1 @dcaratti



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



Other in progress fixes for -net:
     - Paolo is currently at failures with AB: it gets stuck after a few =

connections:
         - the client tries to look at adding new subflows while the =

connection is closing
         - shutdown is blocking
         - maybe linked to issue 33



Part 4: new features:
     - news about "Full DATA_FIN support"?:
         - /

     - news about "ADD_ADDR for MPTCPv1: echo bit"?:
         - /

     - Florian might look soon at issue 21 (sort-out {set,get}sockopt =

handling)



Extra tests:
     - news about Syzkaller? (Christoph):
         - https://github.com/google/syzkaller/pull/1815
         - upstreaming what was used to test the PM
         - already got a review!

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - strangely no new update

     - packetdrill (Davide & Todd):
         - we can have 2 branches:
             - one for the CI (to test patches in mptcp_net-next)
             - one for the new features (stuff not in mptcp_net-next)
         - *Davide* will look at that
         - Todd continues working on MP_JOIN support. Might have less =

time but his work is on Github

     - CI (Matth):
         - should we test more combinations of mptcp_connect.sh?
             - there are many possible combinations
             - feel free to share interesting ones!

         - run the C reproducers from syzkaller:
             - to check regressions
             - *Matth: TODO: regroup them in a repo and test them

         - run AB tests:
             - when stable (Paolo working on it)
             - can be done in one VM with different ns
             - using https://github.com/pabeni/mptcp-tools/tree/master/mpab
             - maybe re-use the setup from mptcp_connect.sh
             - but it would only be internal: AB cannot be integrated in =

selftests for upstream

     - Coverity (Davide):
         - no news from coverity:
             - 2 cases are still open:
                 - one is fixed
                 - the other one is a false positive



Next meeting:
     - We propose to have the next meeting on Thursday, the 18th of June.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200618



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6793979850199315894==--
