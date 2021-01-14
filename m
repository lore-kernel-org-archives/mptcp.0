Content-Type: multipart/mixed; boundary="===============8902547495060919473=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of January 2021
Date: Thu, 14 Jan 2021 20:39:39 +0100
Message-ID: <633d27ca-5be1-5017-d6e9-c4d062c623f0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7392

--===============8902547495060919473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 131st meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Mat Martineau as commiter (Geliang =

as author), Paolo Abeni):

1425353  [net,2/2] mptcp: better msk-level shutdown.
1425354  [net,1/2] mptcp: more strict state checking for acks

1424014  [net-next,8/8] selftests: mptcp: add the MP_PRIO testcases
1424011  [net-next,7/8] mptcp: add the mibs for MP_PRIO
1424007  [net-next,6/8] selftests: mptcp: add set_flags command in pm_nl_ctl
1424009  [net-next,5/8] mptcp: add set_flags command in PM netlink
1424013  [net-next,4/8] mptcp: add the incoming MP_PRIO support
1424008  [net-next,3/8] mptcp: add the outgoing MP_PRIO support
1424012  [net-next,2/8] selftests: mptcp: add testcases for setting the =

addres...
1424015  [net-next,1/8] mptcp: add the address ID assignment bitmap

     our repo (by: Paolo Abeni):

1425165  [v3,mptcp-next,4/4] mptcp: schedule work for better snd subflow =

selec...
1425164  [v3,mptcp-next,3/4] mptcp: do not queue excessive data on subflows.
1425161  [v3,mptcp-next,2/4] mptcp: re-enable sndbuf autotune
1425163  [v3,mptcp-next,1/4] mptcp: always graft subflow socket to parent.

1419300  [mptcp-net,2/2] mptcp: better msk-level shutdown.
1419299  [mptcp-net,1/2] mptcp: more strict state checking for acks



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1426446  [net] mptcp: fix locking in mptcp_disconnect()


     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets
1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1424024: Not Applicable: Re: [MPTCP][PATCH mptcp-next] selftests: mptcp: =

add command line arguments for mptcp_join.sh:
     - Were depending on v4-mapped support series

1425412: New: [mptcp-next,1/2] mptcp: implement delegated action =

infrastructure
1425410: New: [mptcp-next,2/2] mptcp: leverage the deferred actions for =

packet scheduling:
     - Reviewed done by Mat
     - Opened question on squashing the two patches
     - TODO: change status =E2=86=92 Changes Requested =E2=86=92 Done

1425934: Changes Requested: [mptcp-next,v5,1/4] mptcp: support MPJoin =

with IPv4 mapped in v6 sk
1425936: Changes Requested: [mptcp-next,v5,2/4] mptcp: pm nl: support =

IPv4 mapped in v6 addresses
1425938: Changes Requested: [mptcp-next,v5,3/4] selftests: mptcp: add =

IPv4-mapped IPv6 testcases
1425937: Changes Requested: [mptcp-next,v5,4/4] selftests: increase =

timeout to 10 min:
     - Small modification to do

1426175: New: [v5,mptcp-next,1/5] mptcp: use WRITE_ONCE/READ_ONCE for =

the pernet *_max
1426177: New: [v5,mptcp-next,2/5] mptcp: drop *_max fields in mptcp_pm_data
1426178: New: [v5,mptcp-next,3/5] mptcp: create subflow or signal addr =

for newly added address
1426179: New: [v5,mptcp-next,4/5] selftests: mptcp: use minus values for =

removing address numbers
1426180: New: [v5,mptcp-next,5/5] selftests: mptcp: add testcases for =

newly added addresses
1426182: New: [v10,mptcp-next,1/9] mptcp: create the listening socket =

for new port
1426183: New: [v10,mptcp-next,2/9] mptcp: drop unused skb in =

subflow_token_join_request
1426184: New: [v10,mptcp-next,3/9] mptcp: add a new helper =

subflow_req_create_thmac
1426185: New: [v10,mptcp-next,4/9] mptcp: add port number check for MP_JOIN
1426186: New: [v10,mptcp-next,5/9] mptcp: enable use_port when invoke =

addresses_equal
1426187: New: [v10,mptcp-next,6/9] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1426188: New: [v10,mptcp-next,7/9] selftests: mptcp: add port argument =

for pm_nl_ctl
1426189: New: [v10,mptcp-next,8/9] mptcp: add the mibs for ADD_ADDR with =

port
1426190: New: [v10,mptcp-next,9/9] selftests: mptcp: add testcases for =

ADD_ADDR with port
1426191: New: [v2,mptcp-next] selftests: mptcp: add command line =

arguments for mptcp_join.sh
1426193: New: [v2,mptcp-next,1/5] mptcp: add =

mptcp_pm_should_add_signal_send_ack helper
1426194: New: [v2,mptcp-next,2/5] mptcp: simplify =

mptcp_pm_nl_add_addr_send_ack debug log
1426195: New: [v2,mptcp-next,3/5] mptcp: add a new sysctl add_addr_urgent
1426196: New: [v2,mptcp-next,4/5] mptcp: add urgent status for ADD_ADDR
1426197: New: [v2,mptcp-next,5/5] selftests: mptcp: add add_addr_urgent =

testcases:
     - mainly a rebase
     - also a small change in the port support
     - Mat will have a look at the new versions



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 132)

   134  Checksum support @geliangtang:
       - Needed for MP_FAIL (and to detect nasty middleboxes)

   133  PM: Closing the MPTCP connection when last subflow is not the =

initial one and its IP address is removed [enhancement]:
       - related to the discussion we had at the last meeting


     Bugs (opened, flagged as "bug" and assigned)

   126  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller] @dcaratti

   123  sndmsg autotuning is disable [bug] @pabeni:
       - TODO: can be closed =E2=86=92 done

   122  PM doesn't create subflow with IPv4 mapped IPv6 socket [bug] =

@geliangtang
    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti


     Bugs (opened and flagged as "bug" and not assigned)

   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] [syzkaller]
   129  set subflow socket consistently [bug] [enhancement]
   127  [syzkaller] WARNING in corrupted [bug] [syzkaller]
   125  [syzkaller] KASAN: wild-memory-access Write in =

subflow_req_destructor [bug] [syzkaller]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]

   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]:
       - sadly no repro yet for the ones above :-/

   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]:
       - Should be fixed thanks to a commit from Davide
       - @Christoph can you retry please?

   112  sporadic failure of mptcp_join.sh selftest 13 [bug]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   134  Checksum support @geliangtang
   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
    60  PM: netlink: events per connection [enhancement] @fw-strlen
    54  ADD_ADDR: ports support [enhancement] @geliangtang

    51  MP_PRIO support [enhancement] @geliangtang:
        - almost finished
        - see checkbox on the ticket

    19  let PM netlink update live sockets on local addresses list =

change [enhancement] @geliangtang


     Recently closed (since last week)

   121  [syzkaller] divide error in __tcp_select_window [bug] =

[syzkaller] @pabeni
    31  Allow MPTCP + SYN_COOKIES [enhancement] v5.9 1 =E2=80=A1



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.12): =

https://github.com/multipath-tcp/mptcp_net-next/projects/7:
         - New
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         -

     - net-next:
         - Paolo would like to send "re-enable autotuning" soon
         - But maybe best to wait for "mptcp: delegate actions" series



nested lock:
     - in-kernel vs userspace sockets have different lock infrastructure
     - we saw new issues with Geliang' series (port support) because =

here we have a new bind socket which is an in-kernel one:
         - so it makes sense not to have seen this splat earlier
         - Paolo will send a new patch adding a comment next to the =

annotation after the merge



Extra tests:
     - news about Syzkaller? (Christoph):
         - nothing new has been found, switching to latest export branch

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - Builds are still running
         - MP_JOIN tests has failed recently, certainly the same =

unstable test

     - packetdrill (Davide):
         - New test added by Paolo
         - Good be good to cover more syscall, e.g. connect, etc.
         - =E2=86=92 increase code coverage
         - would be hard to re-use the plain TCP tests that are already =

in the repo
         - we need new tests.

     - CI (Matth):
         - had to increase the timeout, mptcp_join.sh is taking quite a =

bit of time



Git permissions:
     - push are made by the CI and mostly myself
     - devs don't need push access: they are working with forks (and =

computers)
     - better to avoid accidental pushes / misclicks
     - we want devs to be able to be assigned to tasks/issues, modify =

them and edit the wiki
     - =E2=86=92 Christoph is looking at that =E2=86=92 Done
     - We now have one group (admins) with write access to manage TopGit =

+ export
     - and one group for the devs team



Next meeting:
     - We propose to have the next meeting on Thursday, the 21st of January.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210121



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8902547495060919473==--
