Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0D3E493
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJKuJtlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2071C433C7
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700756195;
	bh=97KxjwtJA9LovNa8nL3gWw60F3LBYWObz2KX/As8gXI=;
	h=Date:From:Subject:To:From;
	b=iJKuJtlQkxF74i9o0/u1T9LCcsQoeSTDeBorjejOTSk85vwLqQP6v5cx569lP+NmZ
	 s44MeB1NdKnQ88Z0NpISTrM2sAPcrIKzbcuCJaJ4vbI6tDuGmmVPrt2iezX2MAWiC5
	 v5k5qYK42GRs85rA6Cx0crV1QbL1gbu7++/yaqG8We+rPHC7e/toec6yusy8HuUk0x
	 AgYyQE17spotjumyju9xWqKrgKbT8ySgnuiRcEe2PGrOp+4OnGfog/0+wR4XlBf79B
	 M3JY8miD3XMmNFSJzQE9bRxsL8TQBybVMa2E1QYozuww3eBb5Vfmbf3pgodrHefE/L
	 9ZrQFNjzRDVIg==
Message-ID: <07eaee9f-7a52-4ed3-ae2d-1fb62af3e1a3@kernel.org>
Date: Thu, 23 Nov 2023 17:16:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 14th of November 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 262nd meeting with Christoph (Apple), Davide
(Redhat), Mat (Cruise) and myself (self-employed).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Paolo Abeni):

13449523: [mptcp-next,v2] Squash to "selftests: mptcp: add
mptcp_lib_get_counter":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a345cc5ff04729307b7b5b3a26f81e4e653dbefb.1699408002.git.geliang.tang@suse.com/

13450388: [mptcp-net] mptcp: fix setsockopt(IP_TOS) subflow locking:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com/

13452767: [mptcp-net] selftests: mptcp: fix fastclose with csum failure:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13454570: [net,1/5] mptcp: deal with large GSO size
13454571: [net,2/5] mptcp: fix possible NULL pointer dereference on close
13454572: [net,3/5] mptcp: add validity check for sending RM_ADDR
13454573: [net,4/5] mptcp: fix setsockopt(IP_TOS) subflow locking
13454574: [net,5/5] selftests: mptcp: fix fastclose with csum failure:
      - Series: mptcp: misc. fixes for v6.7
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=800839&state=*&archive=both


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
            - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
IPV6_UNICAST_HOPS:
      - State: Changes requested
      - Series: mptcp: sockopt: uniform code to get/set values
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/

13397528: [mptcp-next,v3,20/29] selftests: mptcp: add userspace pm
fullmesh tests:
      - TODO: archive it: Matth → Done

13441631: [mptcp-next] net/mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk():
      - State: Changes requested
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com/
      - Davide will send a new version

13454839: [mptcp-next,v9,01/21] mptcp: export pm_nl_get_pernet_from_msk
13454840: [mptcp-next,v9,02/21] mptcp: drop mptcp_pm_get_* helpers
13454841: [mptcp-next,v9,03/21] mptcp: use pernet id_bitmap in userspace pm
13454842: [mptcp-next,v9,04/21] mptcp: add
userspace_pm_lookup_addr_by_id helper
13454843: [mptcp-next,v9,05/21] mptcp: drop lookup_by_id parameter in
lookup_addr
13454844: [mptcp-next,v9,06/21] mptcp: dump addrs in userspace pm list
13454845: [mptcp-next,v9,07/21] mptcp: check userspace pm subflow flag
13454846: [mptcp-next,v9,08/21] selftests: mptcp: add userspace pm
subflow flag
13454847: [mptcp-next,v9,09/21] selftests: mptcp: add mptcp_lib_cleanup
13454848: [mptcp-next,v9,10/21] selftests: mptcp: add mptcp_lib_check helper
13454849: [mptcp-next,v9,11/21] selftests: mptcp: dump userspace addrs list
13454850: [mptcp-next,v9,12/21] mptcp: add a prefix for free_local_addr_list
13454851: [mptcp-next,v9,13/21] mptcp: flush userspace pm addrs list
13454852: [mptcp-next,v9,14/21] selftests: mptcp: flush userspace addrs list
13454854: [mptcp-next,v9,15/21] mptcp: add use_id parameter for
addresses_equal
13454855: [mptcp-next,v9,16/21] mptcp: add check_id for
lookup_anno_list_by_saddr
13454856: [mptcp-next,v9,17/21] mptcp: add userspace_pm_get_entry helper
13454857: [mptcp-next,v9,18/21] mptcp: drop addr_match and id_match
13454858: [mptcp-next,v9,19/21] mptcp: dup an entry when removing it
13454859: [mptcp-next,v9,20/21] mptcp: add userspace pm addr entry refcount
13454860: [mptcp-next,v9,21/21] selftests: mptcp: rm userspace addr with
random order:
      - State: New
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=800906&state=*&archive=both
      - Matth can look at it but not before next week (or likely the
week after)

13455066: [mptcp-next,v3,01/33] selftests: mptcp: add mptcp_lib_evts_*
helpers
13455067: [mptcp-next,v3,02/33] selftests: mptcp: userspace: capitalize
test_name
13455068: [mptcp-next,v3,03/33] selftests: mptcp: userspace: print
colored output
13455069: [mptcp-next,v3,04/33] selftests: mptcp: capitalize ok/fail/skip
13455070: [mptcp-next,v3,05/33] selftests: mptcp: netlink: drop
duplicate var ret
13455071: [mptcp-next,v3,06/33] selftests: mptcp: export ret into mptcp_lib
13455072: [mptcp-next,v3,07/33] selftests: mptcp: extract
mptcp_lib_check_expected
13455073: [mptcp-next,v3,08/33] selftests: mptcp: export event macros in
mptcp_lib
13455074: [mptcp-next,v3,09/33] selftests: mptcp: add
mptcp_lib_verify_listener_events
13455075: [mptcp-next,v3,10/33] selftests: mptcp: unify namespace names
13455076: [mptcp-next,v3,11/33] selftests: mptcp: add mptcp_lib_ns_* helpers
13455077: [mptcp-next,v3,12/33] selftests: mptcp: diag: print colored output
13455078: [mptcp-next,v3,13/33] selftests: mptcp: connect: print colored
output
13455079: [mptcp-next,v3,14/33] selftests: mptcp: sockopt: print every
test result
13455080: [mptcp-next,v3,15/33] selftests: mptcp: sockopt: print colored
output
13455081: [mptcp-next,v3,16/33] selftests: mptcp: simult flows: print
colored output
13455082: [mptcp-next,v3,17/33] selftests: mptcp: connect: add PORT
instead of TEST_COUNT
13455083: [mptcp-next,v3,18/33] selftests: mptcp: connect: print out
test counter
13455084: [mptcp-next,v3,19/33] selftests: mptcp: rename test_cnt to
TEST_COUNT
13455085: [mptcp-next,v3,20/33] selftests: mptcp: diag: print out test
counter
13455086: [mptcp-next,v3,21/33] selftests: mptcp: simult flows: print
out test counter
13455087: [mptcp-next,v3,22/33] selftests: mptcp: sockopt: print out
test counter
13455088: [mptcp-next,v3,23/33] selftests: mptcp: netlink: print out
test counter
13455089: [mptcp-next,v3,24/33] selftests: mptcp: userspace: print out
test counter
13455090: [mptcp-next,v3,25/33] selftests: mptcp: export TEST_NAME/COUNT
to mptcp_lib
13455091: [mptcp-next,v3,26/33] selftests: mptcp: simult flows: define
missing vars
13455092: [mptcp-next,v3,27/33] selftests: mptcp: export
cin/cout/sin/sout vars
13455093: [mptcp-next,v3,28/33] selftests: mptcp: join: change
capture/checksum as bool
13455094: [mptcp-next,v3,29/33] selftests: mptcp: export
capture/checksum vars
13455095: [mptcp-next,v3,30/33] selftests: mptcp: diag: change
timeout_poll to 30
13455096: [mptcp-next,v3,31/33] selftests: mptcp: export timeout_test to
mptcp_lib
13455097: [mptcp-next,v3,32/33] selftests: mptcp: use KSFT_SKIP instead
ksft_skip
13455098: [mptcp-next,v3,33/33] selftests: mptcp: netlink: fix positions
of newline:
      - State: New
      - Series: add helpers and vars in mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=800965&state=*&archive=both
      - Matth can look at it but not before next week (or the week after)
      - TODO: Matth: apply the patch manually because patchew was not
able to apply them (depend on the prev series) → done (v4)

13455483: [mptcp-net,v2] selftests: mptcp: join: fix subflow_send_ack
lookup:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com/
      - In theory, the CI should report an error if a test is being
skipped while it should not
      - Or something not seen by our CI? Due to kconfig options?
      - Matth can look at it



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 457):

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]:
      - Matth already replied: maybe due to the kernel 5.15?

  458  syzkaller: `WARNING` in `subflow_data_ready` [bug] [syzkaller]:
      - Christoph didn't manage to reproduce it

    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti:
      - Not related to MPTCP
      - Davide has a patch to fix false positives (but not real one,
known issue, bigger work needed)
      - We can keep the ticket open until the patch is sent so TC people
can see the issue is still active and there are more info in the ticket

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe


    Bugs (opened and flagged as "bug" and not assigned)

  458  syzkaller: `WARNING` in `subflow_data_ready` [bug] [syzkaller]
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]
  447  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  445  MPTCP Info counters: start seq numbers ones from 0 [bug]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti:
      - See patches above

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang:
      - See patches above

  353  sockopt: uniform code to get/set values [enhancement] @matttbe:
      - See patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang:
      - See patches above

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  446  MPTCP Info counters: display "last time" actions info [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  425  syzkaller: validate all MPTCP Netlink API [enhancement] [syzkaller]
  406  Compile and run mptcp bpf selftests in CI [enhancement] [selftests]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  394  selftests: ability to track subtests [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement] [pm]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement] [pm]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm]
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path
[enhancement]
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-11-07)

  457  `mptcp_setsockopt_v4_set_tos()`: lock needed around
`__ip_sock_set_tos()` [bug]
  454  syzkaller: NULL dereference in `__mptcp_propagate_sndbuf()` [bug]
@pabeni
  450  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller] [reproducer] [bisected] @pabeni



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.8):
https://github.com/orgs/multipath-tcp/projects/6
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [2a39c5e70494] mptcp: deal with large GSO size (Paolo Abeni)
        - [159ab79e1a40] mptcp: fix possible NULL pointer dereference on
close (Paolo Abeni)
        - [dba83f5fede1] mptcp: add validity check for sending RM_ADDR
(Geliang Tang)
        - [c86a249e44fb] mptcp: fix setsockopt(IP_TOS) subflow locking
(Paolo Abeni)
        - [548f00520278] selftests: mptcp: fix fastclose with csum
failure (Paolo Abeni):
            - Already sent to netdev

    - Fixes for net-next: /

    - Features for net-next:
        - Now open: https://patchwork.hopto.org/net-next.html
        - TODO: Matth: check lei config why I didn't get the message:

https://lore.kernel.org/netdev/20231113113013.2ad9817c@kernel.org/T/
            → Done: needed "loginctl enable-linger" to start the systemd
user timers without login after a reboot

        - [695f677e48a2] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [103946697d3d] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [9c778819a5d8] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [edd8dd57ff87] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [f5beab7616f7] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang)
        - [d15963442bf9] mptcp: userspace pm rename remove_err to out
(Geliang Tang)
        - [680a4bfb48dc] selftests: mptcp: userspace pm remove initial
subflow (Geliang Tang)
        - [6978e082524a] selftests: mptcp: userspace pm send RM_ADDR for
ID 0 (Geliang Tang)
        - [8f9f5a492390] selftests: mptcp: add mptcp_lib_kill_wait
(Geliang Tang)
        - [c8f400d376ed] selftests: mptcp: add mptcp_lib_is_v6 (Geliang
Tang)
        - [abfdede14fae] selftests: mptcp: add mptcp_lib_get_counter
(Geliang Tang)
        - [285007ea999d] selftests: mptcp: add missing oflag=append
(Geliang Tang)
        - [9077ddc4e17c] selftests: mptcp: add mptcp_lib_make_file
(Geliang Tang)
        - [95d066bb55ad] selftests: mptcp: add mptcp_lib_check_transfer
(Geliang Tang)
        - [a14c5de1f769] selftests: mptcp: add
mptcp_lib_wait_local_port_listen (Geliang Tang):
            - The series can be re-sent to netdev
            - Mat will send the v2 → done

    - Features for net-next (next): /

    - Features for other trees:

        - [27e3469d4647] mptcp: add sched_data helpers (Geliang Tang)
        - [ac3bd7490596] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [23b70a13a6ac] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [050dd0bc9f57] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [24efce610504] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [4a38b2ee42d7] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [6417e401c453] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [61ad05edb645] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [83d7c670c6dd] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5050840bc872] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [58476825e61b] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [d3fb29a4d2f1] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [6339621cc748] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [30cfd198adca] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [5b8c59bd41d2] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [dda5af23950a] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for packet sched API refactorisation



Extra tests:
    - news about Syzkaller? (Christoph):
        - everything is OK so far

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - We used 51 and 52 credits the previous months, not clear
what's the limit: 50?
        - Was it not supposed to be 70?
        - If it is limiting, we still have alternatives: GH actions,
TuxSuite, or a paid account



GRO/GSO >64k and MPTCP Data-Level Length:
    - should be OK to have an extension to TCP re-using the bytes of the
checksum
    - checksum is not needed if we have TLS (and perf impact)
    - checksum is taking 16bits (we don't need to add 16 bits, maybe one
byte is already more than enough)
    - there are some flags available in the MPCapable:

https://datatracker.ietf.org/doc/html/rfc8684#name-connection-initiation
    - And even in data packet if needed:
      https://datatracker.ietf.org/doc/html/rfc8684#tcpm_dsn
    -
    - Matth will do the follow-up with Olivier Bonaventure



EDO:
    - not upstream? → Probably not if GRO/GSO is not supported
    - could it be still useful? (why Kuniyuki added support for it?
https://github.com/q2ven/linux/commits/edo)
    - Not clear: support seems complete but unlikely to be upstreamed if
GRO/GSO is not



TCP Timestamps:
    - https://github.com/multipath-tcp/mptcp_net-next/issues/448
    - Two solutions:
        - disable the TS on this specific packet:
            - some middleboxes could drop the packet (not good but OK)
or reject the connection (bad)
            - the TCP stack and ConnTrack should be OK with that
            - should be easier to do that
        - re-order TS:
            - also here, some middleboxes could drop the packet / reject
it but OK for Linux
            - we save 2B (padding) while keeping all info
    - Or always re-order?
        - why not always putting the TS after: could we not avoid a
double padding (4B) in all MPTCP packets with data?
        - but maybe more risks to hit middleboxes not finding the TS at
a "fixed spot"?
        - or maybe OK if it is controlled by a sysctl knob?



Next meeting:
    - Next one on *Wednesday*, the 22nd of November.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231122



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
