Content-Type: multipart/mixed; boundary="===============6477084798270502115=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 11th of March 2021
Date: Thu, 11 Mar 2021 18:57:07 +0100
Message-ID: <e308928e-872d-a7b3-2b0b-751572915de2@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8102

--===============6477084798270502115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Today, we just had our 139th meeting with Mat and Ossama (Intel), Paolo, =

Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3


     netdev (if mptcp ML is in cc) (Davide Caratti, Mat Martineau):

1448927  [net] mptcp: fix length of ADD_ADDR with port sub-option

1447508  [net,9/9] mptcp: free resources when the port number is mismatched
1447507  [net,8/9] mptcp: fix missing wakeup
1447510  [net,7/9] mptcp: fix race in release_cb
1447509  [net,6/9] mptcp: factor out __mptcp_retrans helper()
1447511  [net,5/9] mptcp: reset 'first' and ack_hint on subflow close
1447502  [net,4/9] mptcp: dispose initial struct socket when its subflow =

is cl...
1447504  [net,3/9] mptcp: fix memory accounting on allocation error
1447505  [net,2/9] mptcp: put subflow sock on connect error
1447506  [net,1/9] mptcp: reset last_snd on subflow close


     our repo (by: Davide Caratti, Geliang Tang, Mat Martineau, Matthieu =

Baerts, Paolo Abeni ):

1451044  [mptcp-next] Squash to "mptcp: only admit explicitly supported =

sockop...
1449638  [mptcp-next] Squash-to: "mptcp: move sockopt function into a =

new file"
1449534  [v3,mptcp-next] Squash to "mptcp: add rm_list in =

mptcp_out_options" -...

1449092  [mptcp-next] selftests: mptcp: support capture with other options
1448960  [mptcp-next] Squash to "selftests: mptcp: launch mptcp_connect =

with t...

1448958  [net-next,v3,3/3] mptcp: revert "mptcp: provide subflow aware =

release...
1448957  [net-next,v3,2/3] mptcp: only admit explicitly supported sockopt
1448955  [net-next,v3,1/3] mptcp: move sockopt function into a new file

1447428  [net,v2] mptcp: fix length of ADD_ADDR with port suboption

1447193  [v6,mptcp-next,5/5] selftests: mptcp: remove id 0 address =

testcases
1447192  [v6,mptcp-next,4/5] selftests: mptcp: add addr argument for =

del_addr
1447191  [v6,mptcp-next,3/5] mptcp: remove id 0 address
1447190  [v6,mptcp-next,2/5] mptcp: unify RM_ADDR and RM_SUBFLOW receiving
1447188  [v6,mptcp-next,1/5] mptcp: remove all subflows involving id 0 =

address

1447136  [mptcp-next,6/6] Squash to "mptcp: remove multi addresses and =

subflow...
1447135  [mptcp-next,5/6] Squash to "mptcp: remove multi subflows in PM"
1447134  [mptcp-next,4/6] Squash to "mptcp: add rm_list_rx in =

mptcp_pm_data"
1447133  [mptcp-next,3/6] Squash to "mptcp: add rm_list in =

mptcp_options_recei...
1447132  [mptcp-next,2/6] Squash to "mptcp: add rm_list_tx in =

mptcp_pm_data"
1447130  [mptcp-next,1/6] Squash to "mptcp: add rm_list in =

mptcp_out_options"

1446930  [mptcp-net] selftests: mptcp: Restore packet capture option in =

join t...



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*


     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - WIP

1442954: Needs Review / ACK: [mptcp-next,1/3] mptcp: add tracepoint for =

mptcp_subflow_get_send
1442956: Needs Review / ACK: [mptcp-next,2/3] mptcp: add tracepoint for =

get_mapping_status
1442957: Needs Review / ACK: [mptcp-next,3/3] mptcp: add tracepoint for =

subflow_check_data_avail:
     - Needs review

1450494: New: [RFC,1/2] mptcp: DSS checksum support
1450496: New: [RFC,2/2] mptcp: add MP_FAIL support:
     - Looking for comments
     - Mat will have a look



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 170)

   171  iproute2: support removing ID 0 [enhancement] [iproute2]:
       - kernel support added
       - also in selftests with pm tool
       - we need to modify iproute2 to reflect that


     Bugs (opened, flagged as "bug" and assigned)

   170  possible deadlock in ipv6_sock_mc_close [bug] [syzkaller] @pabeni:
       - linked to the series about sockopt
       - TODO: close it =E2=86=92 Done

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - feel free to share early patches (even broken ones) to have =

early feedback


     Bugs (opened and flagged as "bug" and not assigned)

   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is =

provided [bug]
   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   167  packetdrill: add coverage for RM_ADDR [enhancement] =

[packetdrill] @dcaratti
   158  iproute2: change backup mode (MP_PRIO) for active connections =

[enhancement] [iproute2] @dcaratti

   134  Checksum support [enhancement] @geliangtang :
       - RFC patches have been shared

   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
       - patches have been shared

    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    53  MP_TCPRST support [enhancement] @fw-strlen

    52  MP_FAIL support [enhancement] @geliangtang
       - RFC patches have been shared


     Recently closed (since last week)

   168  [syzkaller] WARNING in dst_release [bug] [syzkaller]
   166  iproute2: ADD_ADDR: ports support [enhancement] [iproute2] @pabeni
   156  [syzkaller] WARNING: refcount bug in __tcp_transmit_skb [bug] =

[syzkaller]
   153  [syzkaller] WARNING: refcount bug in mptcp_incoming_options =

[bug] [syzkaller]
   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): =

https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



TopGit tree has been re-created:
     - removing old refs
     - moved commits:
         - one of Geliang series was split in 2 =E2=86=92 now back together
         - BPF patches at the end
     - new Git Markup for us and scripts (CI)



Patches to send to netdev:
     - net:
         - one patch to send
         - Mat is going to do that

     - net-next: (now open)
         - maybe better to wait for the ones linked to the sockopts
         - many others to send in the tree, e.g. =E2=86=93
         - Max 15 for the bot, first:

a4101da4b3a5c selftests: mptcp: add testcases for removing addrs
685fe8b66e42a selftests: mptcp: set addr id for removing testcases
d5d25a8d8f398 selftests: mptcp: add invert argument for chk_rm_nr
07876d7463004 mptcp: remove a list of addrs when flushing
90ef847bd22a3 mptcp: remove multi addresses and subflows in PM
36053c7035e75 mptcp: remove multi subflows in PM
6c9d8edc9334e mptcp: remove multi addresses in PM
1968574ef8a22 mptcp: add rm_list_rx in mptcp_pm_data
c3bd6ec8a59a8 mptcp: add rm_list in mptcp_options_received
a58326a355c54 mptcp: add rm_list_tx in mptcp_pm_data
1d33189486aa5 mptcp: add rm_list in mptcp_out_options

         - After:

20a09f718f161 selftests: mptcp: timeout testcases for multi addresses
f90eb60003759 selftests: mptcp: add cfg_do_w for cfg_remove
ffddb115a77d3 mptcp: move to next addr when timeout
c1a91e3969cc6 mptcp: drop unused subflow in mptcp_pm_subflow_established
4cb5e98ec7ec1 mptcp: skip connecting the connected address
a4d44afce8205 mptcp: drop argument port from mptcp_pm_announce_addr

         - Mat is going to do that



Sockopts:
     - script to monitor missing sockopts?:
         - grep in .h file + grep in mptcp/sockopts.c
         - ran by the CI
     - but if we want that, we need to fix the ones that are already =

missing :)
     - BPF and NFT socktopts have been omitted on purpose:
         - Maybe best to continue
     - =E2=86=92 we wait to have feedback something is missing/not supporte=
d, =

more urgent topics to cover



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - some troubles that are not caused by our stuff
         - no need to worry, they are fixing that
         - report should be back soon

     - packetdrill (Davide):
         - working on RM_ADDR and ADD_ADDR with port support

     - CI (Matth):
         - Moving stuff in TopGit tree



Offload: Checksums:
     - After a discussion with Intel Ethernet Drivers team
     - We don't depend on GRO/GSO feature but it could be done also only =

in this case
     - typically would be an additional feature than TCP checksum
     - the NIC could help calculate checksum but one complex point is =

the alignment of the data: if it is between to 64 bits =E2=86=92 receiving =
side =

seems a lot more work than the transmitting side

     - For us, would be good to be helped by the NIC to do some GRO, =

re-assembling packets. Some HW can do that for TCP.

     - Idea for them would be to start doing optimisations per frame =

(e.g. checksum if possible)

     - could be done partly by the HW? e.g. checksum complete, add data =

for that in MPTCP SKB ext:
         - to be done by HW, alignment is important!
         - maybe a solution is to have different checksum flavours =

depending on the alignment but doesn't seem nice
         - (sorry, I lost the end of the discussion, maybe clearer by =

emails with schema if someone needs more details)



Offload: MPTCP frame detection:
     - Would it help? To help with TC and others to detect flows
     - Maybe to gather all MPTCP connections from different subflows and =

NICs, we could move all the MPTCP connection to the same queue =E2=86=92 =

Reducing contention
     - Useful for not so many flows and a lot of traffic
     - would be good to load-balance subflows of the same connection to =

the same queue but not really possible to implement



SW Checksum:
     - When can we drop a packet if the checksum is wrong?
     - Before giving it to the userspace! But not too late for TCP?
     - We can no longer give to userspace data that are part of DSS that =

have been received but not covering the full DSS mapping yet =E2=86=92 we n=
eed =

to validate the checksum of the whole DSS mapping



Checksum on the Internet:
     - It is important to have it, too many nasty middleboxes.
     - Fine if the network is fully controlled but most likely not often =

the case.



Next meeting:
     - On Thursday, the 18th of March.
     - /!\ *NOT* the usual UTC time: 15:00 UTC (8am PDT, 4pm CET, 11pm CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210318



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6477084798270502115==--
