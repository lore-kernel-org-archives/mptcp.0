Content-Type: multipart/mixed; boundary="===============8995188714743236116=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 29th of October 2020
Date: Fri, 30 Oct 2020 18:09:41 +0100
Message-ID: <497d317d-9d36-7254-8f9c-d787d4714262@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6488

--===============8995188714743236116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 122th meeting with Mat and Ossama (Intel OTC), =

Christoph (Apple), Paolo and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (/):

/


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1389109  [v3,mptcp-next] Squash to "mptcp: send out dedicated ADD_ADDR =

packet"

1387031  [mptcp-next] Squash to "selftests: mptcp: add link failure test =

case"

1386433  [mptcp-next,v3] mptcp: track window announced to peer

1385912  [mptcp-next] Squash to "selftests: mptcp: add link failure test =

case"

1385644  [net-next] Squash-to: "mptcp: move page frag allocation in =

mptcp_send...

1385380  [v5,mptcp-next,3/3] selftests: mptcp: add ADD_ADDR IPv6 test cases
1385379  [v5,mptcp-next,2/3] mptcp: send out dedicated ADD_ADDR packet
1385378  [v5,mptcp-next,1/3] mptcp: change add_addr_signal type

1385365  Squash to "selftests: mptcp: add ADD_ADDR timeout test case" v2

1385069  [net-next] Squash-to: "mptcp: refactor shutdown and close"

1384990  [net-next] mptcp: keep unaccepted MPC subflow into join list

1384773  [net] mptcp: add missing memory scheduling in the rx path



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

[net] mptcp: add missing memory scheduling in the rx path


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370701: RFC: [RFC,3/4] mptcp: add mptcp reset option support
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: Under Review: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - Not sure if it will be needed
     - best is certainly to wait for refactoring from Paolo
     - keep it in mind for later =E2=86=92 RFC

1387845: RFC: MPTCP stream performances:
     - non trivial problem
     - perf unstable in export branch
     - receiver is not sending ACK when it should do
     - also happening on net-next but problem less visible due to =

different way we enqueue packets on the send side
     - after we moved skb from subflow to mptcp, TCP window is (not =

updated?). No hook so far in MPTCP side to solve this
     - Better to read Paolo's report in the ML, there are more details =

than here :)
     - Paolo is working on a less hackish way to avoid dupacks (covering =

the same TCP seq but having different MPTCP options):
         - but perf are impacted =E2=86=92 from 30Gbps to 22Gbps
         - Paolo will share the patch
     - Maybe a solution: remove the workqueue for the receive part. =

Patch would be bigger.

1389827: New: [mptcp-next] mptcp: add mptcp_pm_should_add_signal_echo =

helper:
     - New helper (nice) but unclear why it is alone.
     - is it to be squashed earlier? (yest it is =E2=86=92 Done)
     - is it to be applied before another one already in the export branch?

1389851: New: [mptcp-next,1/8] mptcp: add ADD_ADDR port support for =

writing options
1389852: New: [mptcp-next,2/8] mptcp: add the outgoing ADD_ADDR port support
1389853: New: [mptcp-next,3/8] mptcp: send out ack for ADD_ADDR with port
1389854: New: [mptcp-next,4/8] mptcp: add port argument for =

mptcp_pm_announce_addr
1389855: New: [mptcp-next,5/8] mptcp: add the incoming ADD_ADDR port support
1389856: New: [mptcp-next,6/8] mptcp: add ADD_ADDR port support for netlink
1389857: New: [mptcp-next,7/8] selftests: mptcp: add ADD_ADDR port =

support for pm_nl_ctl
1389858: New: [mptcp-next,8/8] selftests: mptcp: add testcases for =

ADD_ADDR with port:
     - to be reviewed
     - seems the cover-letter was not sent to the ML (resend by Geliang)



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 101)

   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller]:
       - still no reproducer

   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller]:
       - TODO


     Bugs (opened, flagged as "bug" and assigned)

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] @dcaratti:
        - WIP

    85  Packetdrill: multiple timeout reported by the CI [bug] @matttbe:
        - WIP


     Bugs (opened and flagged as "bug" and not assigned)

   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller]
   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller]

    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]:
        - can be closed, should be rare to have that
        - normal to have the sockets in TIME-WAIT but we exceeded =

expected time

    70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
   76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
   54  ADD_ADDR: ports support [enhancement] @geliangtang
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch


     Recently closed (since last week)

   102  mptcp_pm_create_subflow_or_signal_addr: suspicious =

rcu_dereference_check() usage [bug] @geliangtang
    98  dss_ssn_specified_client packetdrill test fails (timeout) [bug] =

@dcaratti
    55  ADD_ADDR: IPv6 support [enhancement] @geliangtang
    31  Allow MPTCP + SYN_COOKIES [enhancement]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Commits to send to net-next:
     - can be sent all together
     - *Mat* can send those: (thanks!)

f98f5b9c8df3 selftests: mptcp: add ADD_ADDR timeout test case
54636b15a670 mptcp: add a new sysctl add_addr_timeout

d1d7fa643c41 mptcp: split mptcp_clean_una function

14dd19c7f04d tcp: propagate MPTCP skb extensions on xmit splits

4d4469b0b558 mptcp: use _fast lock version in __mptcp_move_skbs

dbb10e76de38 mptcp: adjust mptcp receive buffer limit if subflow has =

larger one


Some issues with Fedora + NM + net-next:
     - root cause is outside network apparently
     - hopefully the next RC should be OK



Force apps to use MPTCP:
     - package LD_PRELOAD script?
     - but not easy for services (e.g. launched by systemd)
     - BPF cgroup? No socket groups for the moment
     - sysctl per NS? Might be a first solution but still people might =

want to select only one app...
     - *Mat* is going to share an RFC and we can discuss on the ML



Extra tests:
     - news about Syzkaller? (Christoph):
         - running the latest syzkaller without extra modifications

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - still a bit more mptcp_join.sh failures
         - but still no more details

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - /



Next meeting:
     - We propose to have the next meeting on Thursday, the 6th of November.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - /!\ it looks like some regions change time next week-end, please =

reply to this email if this is an issue for you!
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201106



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8995188714743236116==--
