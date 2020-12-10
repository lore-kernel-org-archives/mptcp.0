Content-Type: multipart/mixed; boundary="===============2632118381009432282=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 3rd of December 2020
Date: Thu, 10 Dec 2020 20:13:55 +0100
Message-ID: <711e4e0e-7246-3c3e-7d0a-6dcfbf1f401a@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7124

--===============2632118381009432282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 127th meeting with Mat and Ossama (Intel), =

Christoph (Apple), Geliang (Xiaomi) and myself (Tessares).


Davide, Paolo and Florian all got a red card but not hat.


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Paolo):

1407108  [net-next,6/6] mptcp: use mptcp release_cb for delayed tasks
1407107  [net-next,5/6] mptcp: avoid a few atomic ops in the rx path
1407105  [net-next,4/6] mptcp: allocate TX skbs in msk context
1407106  [net-next,3/6] mptcp: protect the rx path with the msk socket =

spinlock
1407102  [net-next,2/6] mptcp: implement wmem reservation
1407104  [net-next,1/6] mptcp: open code mptcp variant for lock_sock


     our repo (by: /):

/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Florian):

1408363: New: [net-next,1/3] security: add const qualifier to struct =

sock in various places
1408362: New: [net-next,2/3] tcp: merge 'init_req' and 'route_req' functions
1408365: New: [net-next,3/3] mptcp: emit tcp reset when a join request =

fails:
     - Waiting for feedback from the security team


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets
1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1403495: Changes Requested: [mptcp-next,1/5] mptcp: add the outgoing =

MP_PRIO support
1403497: Changes Requested: [mptcp-next,2/5] mptcp: add the incoming =

MP_PRIO support
1403498: Changes Requested: [mptcp-next,3/5] mptcp: deal with =

MPTCP_PM_ADDR_FLAG_BACKUP in PM netlink
1403499: Changes Requested: [mptcp-next,4/5] mptcp: add the mibs for MP_PRIO
1403500: Changes Requested: [mptcp-next,5/5] selftests: mptcp: add the =

MP_PRIO testcases:
     - some questions are still opened
     - Behaviour with the Netlink interface are still pending
     - @Paolo: might you have a look at these questions (how to use the =

flags in the Netlink PM) please? =E2=86=92 Done
     - once replied, should be easy to implement

1406751: Needs Review / ACK: [v3] mptcp: let MPTCP create max size skbs:
     -  To be applied =E2=86=92 Done

1408030: New: [v7,mptcp-next,1/7] mptcp: create the listening socket for =

new port
1408031: New: [v7,mptcp-next,2/7] mptcp: add port number check for MP_JOIN
1408032: New: [v7,mptcp-next,3/7] mptcp: add port number announced check
1408033: New: [v7,mptcp-next,4/7] mptcp: deal with =

MPTCP_PM_ADDR_ATTR_PORT in PM netlink
1408034: New: [v7,mptcp-next,5/7] selftests: mptcp: add port argument =

for pm_nl_ctl
1408035: New: [v7,mptcp-next,6/7] mptcp: add the mibs for ADD_ADDR with port
1408036: New: [v7,mptcp-next,7/7] selftests: mptcp: add testcases for =

ADD_ADDR with port:
     - Mat would like to have a look and test it
     - v7 should address Paolo's comment from v6
     - Review needed on these ones =E2=86=92 Done

1408091: New: [mptcp-next] Squash to "[MPTCP][PATCH v7 mptcp-next 3/7] =

mptcp: add port number announced check"
1408144: New: [mptcp-next] mptcp: enable use_port when invoke =

addresses_equal:
     - Part of ADD_ADDR port support patch set
     - will insert into ADD_ADDR port support v8
     - need review =E2=86=92 Done

1408800: New: [mptcp-next] mptcp: add the address ID assignment bitmap:
   - for issue 117
     - need review =E2=86=92 Done

1408047: New: [v2,mptcp-next,1/2] mptcp: remove address when netlink =

flush addrs
1408049: New: [v2,mptcp-next,2/2] selftests: mptcp: add the flush addrs =

testcase
    - these are ready
    - to be applied =E2=86=92 Done

1409483: New: [mptcp-next] Squash to "mptcp: use adding up size to get =

ADD_ADDR length":
     - to be squashed in a commit already in the export branch
     - needs review =E2=86=92 Done

1409493: New: [mptcp-next] mptcp: use MPTCPOPT_HMAC_LEN macro:
     - is independent to the rest
     - needs review =E2=86=92 Done

1409622: Changes Requested: [RFC] selinux: handle MPTCP consistently =

with TCP:
     - sent upstream
     - waiting for feedback from upstream =E2=86=92 Done
     - should be re-sent as non RFC?
     - patches sent by Florian are still waiting for feedback, maybe =

normal and we have to wait more?

1409810: Rejected: [mptcp-next] mptcp: address potential infinite loop =

on receive:
     - replaced by a patch from Eric (not sent to mptcp ml, directly netdev)

1410365: New: [mptcp-next] mptcp: link MPC subflow into msk only after =

accept
     - this will likely hide issues/104, but will not fix it (it fixes =

issues/103)
     - needs review =E2=86=92 Done

1410476: New: [net-next] mptcp: pm: simplify select_local_address():
     - need reviews =E2=86=92 Done




Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 116)

   119  [syzkaller] memory leak in __get_filter:
       - new, to be analysed

   117  Allow user-space to set endpoint ID [enhancement] [help wanted] =

@geliangtang:
       - Geliang already sent a patch: mptcp: add the address ID =

assignment bitmap
       - v2 might be needed


     Bugs (opened, flagged as "bug" and assigned)

   104  [syzkaller] general protection fault in skb_release_data [bug] =

[syzkaller] @geliangtang:
       - Geliang is able to reproduce the issue
       - Paolo has a patch -- mptcp: link MPC subflow into msk only =

after accept -- that hides this issue
       - but still a fix for 104 will be needed

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti:
        - Davide sent a workaround
        - Some fix in packetdrill are still needed

    85  Packetdrill: multiple timeout reported by the CI [bug] =

[packetdrill] @matttbe:
        - The situation is better thanks to a modification in run_all.py =

done by Florian


     Bugs (opened and flagged as "bug" and not assigned)

   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
     - any repro for this one?
     - No repro but still happening with the export branch from 3 days =

ago but no repro
     - possibly related to: =

https://syzkaller.appspot.com/x/repro.syz?x=3D103bf743500000 ???

   114  packetdrill: dss tolerance issue to emit the FIN+ACK [bug] =

[packetdrill]
   112  sporadic failure of mptcp_join.sh selftest 13 [bug]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   109  [syzkaller] memory leak in skb_ext_add [bug] [syzkaller]
   108  [syzkaller] memory leak in sk_clone_lock [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]

   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller] =

[pabeni takes this one]:
       - TODO: change assigned =E2=86=92 Done

    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   117  Allow user-space to set endpoint ID [enhancement] [help wanted] =

@geliangtang:
       - see above

    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe

    54  ADD_ADDR: ports support [enhancement] @geliangtang:
        - see "Patches" section =E2=86=91

    51  MP_PRIO support [enhancement] @geliangtang:
        - see "Patches" section =E2=86=91

    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch:
        - syzkaller is able to find its way
        - it seems we could improve it to make sure more is covered
        - not MPTCP specific issue
        - TODO: unassign Christoph =E2=86=92 Done


     Recently closed (since last week)

   118  ignore me: sorry for the noise, testing IRC notifications
   111  [syzkaller] divide error in __tcp_select_window [bug] [syzkaller]
   105  warning in `mptcp_reset_timer()` with `mptcp_connect.sh -m mmap` =

[bug]
    99  simult_flows selftest is unstable: remaining sockets in =

TIME-WAIT state [bug]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.11): =

https://github.com/multipath-tcp/mptcp_net-next/projects/6
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - next patches are from Geliang
         - We need to squash one patch in "mptcp: use adding up size to =

get ADD_ADDR length" =E2=86=92 Done
         - Then we could send the outgoing ADD_ADDR port support series =

that is already in the export branch =E2=86=92 Done
         - @Florian: Or send fast-close support first if they are ready?



Extra tests:
     - news about Syzkaller? (Christoph):
         - See above

     - news about interop with mptcp.org? (Christoph):
         - IPerf test is really slow with last export
         - Trying to find what caused the regression
         - It looks like the receiver is dropping data at the MPTCP level
         - sender is mptcp.org
         - upstream is receiver
         - Christoph will open a new bug report =E2=86=92 Done

     - news about Intel's kbuild? (Mat):
         - Builds still running but still an intermittent MP_JOIN failure
         - This test is time sensitive
         - seems to happen less often

     - packetdrill (Davide):
         - Florian fixed an issue in run_all.py
         - FC tests are back
         - New tests from Paolo (regression)
         - Tests for ADD_ADDR with v6 are not passing, to be investigate

     - CI (Matth):
         - Some improvements in IRC notifications

    - stream performances:
       - looks like east - west traffic is way slower than loopback, =

root cause still to be investigated
       - between 2 VMs? yep



- what about including use_mptcp in mptcpd? and what about some =

additional script/glue to automatically generate
MPTCP-enabled systemd units?:
     - looks fine to add this. Not directly related to mptcpd but linked =

to mptcp
     - Ossama will reply to this email =E2=86=92 Done



- [pabeni] should I resend the selinux patch (possibly without the typo) =

removing the RFC tag?:
     - linked to "selinux: handle MPTCP consistently with TCP" patch
     - Maybe yes, a non RFC version would be good to "force" feedback
     - (upstream comments received)



- next upstream batch ? ebpf? or port-based endpoint support?:
     - see the discussion above



Next meeting:
     - We propose to have the next meeting on Thursday, the 10th of =

December.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201210



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you 3 hours ago,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2632118381009432282==--
