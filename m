Content-Type: multipart/mixed; boundary="===============0326271708396559240=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 5th of November 2020
Date: Fri, 06 Nov 2020 15:16:17 +0100
Message-ID: <465d6268-d471-62f8-6d60-67893d74b539@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6575

--===============0326271708396559240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 123rd meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Davide, Paolo and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Davide Caratti, Mat Martineau):

1393323  [net-next,v2,7/7] selftests: mptcp: add ADD_ADDR timeout test case
1393322  [net-next,v2,6/7] docs: networking: mptcp: Add MPTCP sysctl entries
1393321  [net-next,v2,5/7] mptcp: add a new sysctl add_addr_timeout
1393318  [net-next,v2,4/7] mptcp: split mptcp_clean_una function
1393320  [net-next,v2,3/7] tcp: propagate MPTCP skb extensions on xmit =

splits
1393319  [net-next,v2,2/7] mptcp: use _fast lock version in =

__mptcp_move_skbs
1393317  [net-next,v2,1/7] mptcp: adjust mptcp receive buffer limit if =

subflow...

1392003  [net] mptcp: token: fix unititialized variable


     our repo (by: Geliang Tang):

1390711  [v2,mptcp-next] Squash to "mptcp: change add_addr_signal type"



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Florian Westphal, Geliang Tang, Mat Martineau, Paolo =

Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP, same as last week

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - WIP, same as last week

1387845: RFC: MPTCP stream performances:
     - can be drop

1390270: RFC: [RFC] mptcp: refine MPTCP-level ack scheduling:
     - can be drop, v1 sent

1392576: Changes Requested: [mptcp-next] docs: networking: mptcp: Add =

MPTCP sysctl entries:
     - applied

1394437: New: [net-next] Squash-to "mptcp: refactor shutdown and close":
     - depends on some local changes Paolo has on his side
     - v2 needed to have something building

1394439: New: [v1] mptcp: refine MPTCP-level ack scheduling
     -  can be reviewed: this has a fix from an issue mentioned earlier

1394788: New: [v3,mptcp-next,01/12] mptcp: unify ADD_ADDR and echo =

suboptions writing
1394789: New: [v3,mptcp-next,02/12] mptcp: unify ADD_ADDR and ADD_ADDR6 =

suboptions writing
1394790: New: [v3,mptcp-next,03/12] mptcp: add port support for ADD_ADDR =

suboption writing
1394791: New: [v3,mptcp-next,04/12] mptcp: use adding up size to get =

ADD_ADDR length
1394792: New: [v3,mptcp-next,05/12] mptcp: add the outgoing ADD_ADDR =

port support
1394793: New: [v3,mptcp-next,06/12] mptcp: send out dedicated packet for =

ADD_ADDR using port
1394794: New: [v3,mptcp-next,07/12] mptcp: add port parameter for =

mptcp_pm_announce_addr
1394795: New: [v3,mptcp-next,08/12] mptcp: print out port and ahmac when =

receiving ADD_ADDR
1394796: New: [v3,mptcp-next,09/12] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1394797: New: [v3,mptcp-next,10/12] selftests: mptcp: add port argument =

for pm_nl_ctl
1394798: New: [v3,mptcp-next,11/12] mptcp: add the mib for ADD_ADDR with =

port
1394799: New: [v3,mptcp-next,12/12] selftests: mptcp: add testcases for =

ADD_ADDR with port:
     - for the listen part, we need to bind on another port
     - should be fine if we make sure the binaries are the same, from =

the same user (maybe problematic) and in the same NS
     - but can we easily check that? Is it safe?
     - idea: have mptcpd creating this listen socket (and announce the =

port)?
     - how can we ensure only trusted application can open these other =

ports?
     - goal (security): avoid having another app opening a port to =

bypass some rules limiting an app on a specific port
     - maybe safer: the application should tell the kernel =

(netlink/sockopt) to accept MP_JOIN from another ports (and maybe =

interface/IP) and ask to announce ADD_ADDR over another port

1394896: New: [RFC,mptcp-next,1/6] mptcp: add the outgoing MP_PRIO support
1394898: New: [RFC,mptcp-next,2/6] mptcp: add the incoming MP_PRIO support
1394899: New: [RFC,mptcp-next,3/6] mptcp: add prio_changed flag
1394900: New: [RFC,mptcp-next,4/6] mptcp: send out MP_PRIO before RM_ADDR
1394901: New: [RFC,mptcp-next,5/6] mptcp: add the mib for MP_PRIO
1394902: New: [RFC,mptcp-next,6/6] selftests: mptcp: add MP_PRIO check =

in chk_rm_nr

Note:
     - Florian has some patches related to MP_FASTCLOSE
     - he will send them after the meeting



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 104)

   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]:
       - might be linked to 104 where there is a reproducer
       - no reproducer for 106 but the trace looks the same as the 104

   105  warning in `mptcp_reset_timer()` with `mptcp_connect.sh -m mmap` =

[bug]:
       - can be linked to 70
       - *Matth:* to check


     Bugs (opened, flagged as "bug" and assigned)

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti:
        - WIP

    85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
        - for the moment, only issue with mp_join (timeout after 2 minutes)


     Bugs (opened and flagged as "bug" and not assigned)

   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]
   105  warning in `mptcp_reset_timer()` with `mptcp_connect.sh -m mmap` =

[bug]
   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller]
   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller]
    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]
    70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
   54  ADD_ADDR: ports support [enhancement] @geliangtang
   51  MP_PRIO support [enhancement] @geliangtang

   49: MP_FASTCLOSE
       - Florian is working on that

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

None.



Warnings (WARN_ON):
     - We should be careful about them, especially for the benign ones
     - It is costly (especially if you have them in a loop)
     - Some people use a sysctl to panic on a warning



Refactoring:
     - Paolo is working on (yet another) refactoring :-)
     - =E2=86=92 getting rid of a workqueue for the receiving part



Commits to send to Netdev:
     - Paolo would like to some patches to be sent
     - he will send a proposition later



Davide on Fedora:
     - goal: send mptcpd to have it in Fedora 34
     - spec are ready but need to be validated
     - https://gitlab.com/dcaratti/mptcpd/-/blob/main/mptcpd.spec
     - not sure if other distro are packaging it
     - there is a git hook that triggers a build when we commit on the =

gitlab repo
     - ideally, it could be nice to have a githook from the official =

mptcpd github repo to trigger a build in case of new tag
     - Could be good to also propose packages for other distro like =

Debian (Ubuntu) =E2=86=92 Matth? :)



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Extra tests:
     - news about Syzkaller? (Christoph):
         - See Github =E2=86=91

     - news about interop with mptcp.org? (Christoph):
         - Had some issues last week, will retry

     - news about Intel's kbuild? (Mat):
         - haven't receive any new build report
         - Mat will investigate why the builds have stopped

     - packetdrill (Davide):
         - See Github =E2=86=91

     - CI (Matth):
         - tests looks a bit more stable but still some are failing =

(packetdrill, see above)



CGroup BPF hook on socket creation:
     - Mat looked at that
     - it would be a bit different from the others (we don't have the =

socket, we then cannot retrieve the cgroup from the "usual" way)



Next meeting:
     - We propose to have the next meeting on Thursday, the 12th of =

November.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201112



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0326271708396559240==--
