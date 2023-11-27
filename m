Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AD15AD2
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6jbT8jM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105BC433C7
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701105750;
	bh=OOqjyLJIcTyR5IYOu4MAVchzFJ36EHv5pn41+xBtwLA=;
	h=Date:From:Subject:To:From;
	b=E6jbT8jM1pXNJSOZmDSoc7MU00MtA27h7aCH/7nxzP2Kc+YimLYMPFM3wKguaJYYU
	 wS2oTlX/1MHliqzBO4eIXbPUKPWus/P325SWCJZbgMaNrlYdmXOgT3wugiOLIr0OIg
	 exM6hScjIA7+3RU9CqIrxiCahKSDeXfbNYISG0h1ZhSwiz6eRrZRK9UD0/2gh2ICM7
	 rwDAFU9orrdmc9DZq3MC+TKtN1sxTtO3t5XNrPe0f/BmVU5Gaqmr/fY7HTnlAbt3YF
	 9OBZwZsBaNulEhzubDkAhTExTadp0UtHtajNBtqsQNWH4AagONWmlKNscgZUfRE8wJ
	 ZOw20VOy277/w==
Message-ID: <9f88e6e0-6989-4641-9c20-0b803e213846@kernel.org>
Date: Mon, 27 Nov 2023 18:22:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 22nd of November 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 263rd meeting with Davide, Paolo (Redhat) and
myself (self-employed).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


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


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13457423: [net-next,v3,01/15] mptcp: add mptcpi_subflows_total counter
13457424: [net-next,v3,02/15] selftests: mptcp: add evts_get_info helper
13457425: [net-next,v3,03/15] selftests: mptcp: add chk_subflows_total
helper
13457426: [net-next,v3,04/15] selftests: mptcp: update userspace pm test
helpers
13457427: [net-next,v3,05/15] selftests: mptcp: userspace pm create id 0
subflow
13457429: [net-next,v3,06/15] mptcp: userspace pm rename remove_err to out
13457428: [net-next,v3,07/15] selftests: mptcp: userspace pm remove
initial subflow
13457430: [net-next,v3,08/15] selftests: mptcp: userspace pm send
RM_ADDR for ID 0
13457431: [net-next,v3,09/15] selftests: mptcp: add mptcp_lib_kill_wait
13457432: [net-next,v3,10/15] selftests: mptcp: add mptcp_lib_is_v6
13457434: [net-next,v3,11/15] selftests: mptcp: add mptcp_lib_get_counter
13457433: [net-next,v3,12/15] selftests: mptcp: add missing oflag=append
13457435: [net-next,v3,13/15] selftests: mptcp: add mptcp_lib_make_file
13457436: [net-next,v3,14/15] selftests: mptcp: add mptcp_lib_check_transfer
13457437: [net-next,v3,15/15] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
      - Series: mptcp: More selftest coverage and code cleanup for net-next
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=801472&state=*&archive=both
      - Same series as what was sent before net-next closed
      - v2 was missing a squash-to patch that has been applied in our
tree in betwee
      - v3 has a small issue spot by Geliang: v4 needed
      - Matth can look at sending the v4 (if he can do all the
validation on his temp working setup -- HW issues)

13460311: [net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules:
      - State: New
      - Submitter: Jakub Kicinski
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231119033006.442271-1-kuba@kernel.org/
      - Quickly applied but nothing to say
      - We also have 2 test modules missing this description:
net/mptcp/crypto_test.c and token_test.c
      - TODO: add this description, not urgent → Done


    our repo (by: Davide Caratti, Geliang Tang, Jakub Kicinski, Matthieu
Baerts, Maxim Galaganov, Paolo Abeni):

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
      - Status: same as last week

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as last week

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
      - Status: same as last week

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/
      - Status: same as last week

13397528: [mptcp-next,v3,20/29] selftests: mptcp: add userspace pm
fullmesh tests:
      - Archived

13441631: [mptcp-next] net/mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk():
      - State: Changes requested
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com/
      - Status: same as last week

13455483: [mptcp-net,v2] selftests: mptcp: join: fix subflow_send_ack
lookup:
      - State: Needs ack
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com/

13459840: [mptcp-next] Squash to "selftests: mptcp: add
chk_subflows_total helper":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/4bcf528d5ec4163c0ed64bc62566d8574e7f09d1.1700277365.git.geliang.tang@suse.com/
      - Matth: TODO: check, apply, send to netdev

13462700: [mptcp-next,v12,01/28] mptcp: export pm_nl_get_pernet_from_msk
13462701: [mptcp-next,v12,02/28] mptcp: drop mptcp_pm_get_* helpers
13462702: [mptcp-next,v12,03/28] mptcp: use pernet id_bitmap in userspace pm
13462703: [mptcp-next,v12,04/28] mptcp: add
userspace_pm_lookup_addr_by_id helper
13462704: [mptcp-next,v12,05/28] mptcp: drop lookup_by_id parameter in
lookup_addr
13462705: [mptcp-next,v12,06/28] mptcp: dump addrs in userspace pm list
13462706: [mptcp-next,v12,07/28] mptcp: check userspace pm subflow flag
13462707: [mptcp-next,v12,08/28] selftests: mptcp: add userspace pm
subflow flag
13462708: [mptcp-next,v12,09/28] selftests: mptcp: add mptcp_lib_cleanup
13462709: [mptcp-next,v12,10/28] selftests: mptcp: add mptcp_lib_check
helper
13462710: [mptcp-next,v12,11/28] selftests: mptcp: dump userspace addrs list
13462711: [mptcp-next,v12,12/28] mptcp: set set_id flag when parsing addr
13462712: [mptcp-next,v12,13/28] mptcp: use set_id flag when appending addr
13462713: [mptcp-next,v12,14/28] mptcp: check addrs list in
userspace_pm_get_local_id
13462714: [mptcp-next,v12,15/28] selftests: mptcp: dump after creating
id 0 subflow
13462715: [mptcp-next,v12,16/28] mptcp: make
pm_remove_addrs_and_subflows static
13462716: [mptcp-next,v12,17/28] mptcp: add a prefix for
free_local_addr_list
13462717: [mptcp-next,v12,18/28] mptcp: add mptcp_pm_remove_subflows helper
13462718: [mptcp-next,v12,19/28] mptcp: rm addrs and subflows before
free local list
13462719: [mptcp-next,v12,20/28] mptcp: flush userspace pm addrs list
13462720: [mptcp-next,v12,21/28] selftests: mptcp: flush userspace addrs
list
13462721: [mptcp-next,v12,22/28] mptcp: add use_id parameter for
addresses_equal
13462722: [mptcp-next,v12,23/28] mptcp: add check_id for
lookup_anno_list_by_saddr
13462723: [mptcp-next,v12,24/28] mptcp: add userspace_pm_get_entry helper
13462724: [mptcp-next,v12,25/28] mptcp: drop addr_match and id_match
13462725: [mptcp-next,v12,26/28] mptcp: dup an entry when removing it
13462726: [mptcp-next,v12,27/28] mptcp: add userspace pm addr entry refcount
13462738: [mptcp-next,v12,28/28] selftests: mptcp: rm userspace addr
with random order:
      - State: New
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=802797&state=*&archive=both
      - Matth: TODO: look at the new version

13463906: [mptcp-next] Squash to "selftests/bpf: Add bpf_burst scheduler":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/14a1120c9bc792ead2b926208ce85b5f10cb99fd.1700624540.git.geliang.tang@suse.com/
      - Matth: TODO: review and apply

13464611: [mptcp-next,v4,01/33] selftests: mptcp: add mptcp_lib_evts_*
helpers
13464612: [mptcp-next,v4,02/33] selftests: mptcp: userspace: capitalize
test_name
13464613: [mptcp-next,v4,03/33] selftests: mptcp: userspace: print
colored output
13464615: [mptcp-next,v4,04/33] selftests: mptcp: capitalize ok/fail/skip
13464616: [mptcp-next,v4,05/33] selftests: mptcp: netlink: drop
duplicate var ret
13464617: [mptcp-next,v4,06/33] selftests: mptcp: export ret into mptcp_lib
13464618: [mptcp-next,v4,07/33] selftests: mptcp: extract
mptcp_lib_check_expected
13464619: [mptcp-next,v4,08/33] selftests: mptcp: export event macros in
mptcp_lib
13464620: [mptcp-next,v4,09/33] selftests: mptcp: add
mptcp_lib_verify_listener_events
13464621: [mptcp-next,v4,10/33] selftests: mptcp: unify namespace names
13464622: [mptcp-next,v4,11/33] selftests: mptcp: add mptcp_lib_ns_* helpers
13464623: [mptcp-next,v4,12/33] selftests: mptcp: diag: print colored output
13464624: [mptcp-next,v4,13/33] selftests: mptcp: connect: print colored
output
13464625: [mptcp-next,v4,14/33] selftests: mptcp: sockopt: print every
test result
13464626: [mptcp-next,v4,15/33] selftests: mptcp: sockopt: print colored
output
13464627: [mptcp-next,v4,16/33] selftests: mptcp: simult flows: print
colored output
13464628: [mptcp-next,v4,17/33] selftests: mptcp: connect: add PORT
instead of TEST_COUNT
13464629: [mptcp-next,v4,18/33] selftests: mptcp: connect: print out
test counter
13464630: [mptcp-next,v4,19/33] selftests: mptcp: rename test_cnt to
TEST_COUNT
13464631: [mptcp-next,v4,20/33] selftests: mptcp: diag: print out test
counter
13464632: [mptcp-next,v4,21/33] selftests: mptcp: simult flows: print
out test counter
13464633: [mptcp-next,v4,22/33] selftests: mptcp: sockopt: print out
test counter
13464634: [mptcp-next,v4,23/33] selftests: mptcp: netlink: print out
test counter
13464635: [mptcp-next,v4,24/33] selftests: mptcp: userspace: print out
test counter
13464636: [mptcp-next,v4,25/33] selftests: mptcp: export TEST_NAME/COUNT
to mptcp_lib
13464637: [mptcp-next,v4,26/33] selftests: mptcp: simult flows: define
missing vars
13464638: [mptcp-next,v4,27/33] selftests: mptcp: export
cin/cout/sin/sout vars
13464639: [mptcp-next,v4,28/33] selftests: mptcp: join: change
capture/checksum as bool
13464640: [mptcp-next,v4,29/33] selftests: mptcp: export
capture/checksum vars
13464641: [mptcp-next,v4,30/33] selftests: mptcp: diag: change
timeout_poll to 30
13464642: [mptcp-next,v4,31/33] selftests: mptcp: export timeout_test to
mptcp_lib
13464643: [mptcp-next,v4,32/33] selftests: mptcp: use KSFT_SKIP instead
ksft_skip
13464644: [mptcp-next,v4,33/33] selftests: mptcp: netlink: fix positions
of newline:
      - State: New
      - Series: add helpers and vars in mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=803239&state=*&archive=both
      - Matth: TODO: look at the new version when possible
      - Note that Hangbin (RedHat) is working on uniforming the creation
of netns for the net selftests: it might conflict a bit with this but it
should be fine because the creation of the different netns should
already be the same in all the different selftests. Hangbin will contact
Geliang if needed

13465105: [mptcp-next,2/2] selftests/net: add MPTCP coverage for
IP_LOCAL_PORT_RANGE:
      - State: New
      - Series: more sockopts for ephemeral ports
      - Submitter: Maxim Galaganov
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=803356&state=*&archive=both
      - (Note: Patch 1/2 was delayed but it is there now)

13465106: [mptcp-net,v2] mptcp: fix inconsistent state on fastopen race:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7237df51ca90d9692f133823a3a6071ee87ba02d.1700667812.git.pabeni@redhat.com/
      - v2 is applying some comments from Mat.
      - Not all: Paolo replied on the ML explaining why they are
relevant but the modifications are not needed

13465107: [mptcp-net-next] mptcp: cleanup state propagation.:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com/
      - Follow-up of the previous one ↑
      - But done in another patch not to increase the size of it.
      - It also depends on it.
      - TODO: Matth: manually apply it on top of ↑ to have the CI
validating it. → Done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 459):

  460  Add `MPTCP_MIB_CURRESTAB` similar to TCP:
      - In the fork, it was done by modifying TCP code:
https://github.com/multipath-tcp/mptcp/commit/b0b64e79bff79aaeefba51d90d6f24b90d458d65
      - Likely not OK to do that in the upstream version, we should do
that on MPTCP side
      - Best here to create a new mptcp_set_state() and do this
check there, then calling socket functions
      - The rest would be the same

   TODO: Matth: open a new ticket for the one reported by syzbot:
       - "Done": there is already a patch from an external contributor,
should not be needed

    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti:
      - Not related to MPTCP

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  458  syzkaller: `WARNING` in `subflow_data_ready` [bug] [syzkaller]
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]
  447  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  445  MPTCP Info counters: start seq numbers ones from 0 [bug]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
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

  460  Add `MPTCP_MIB_CURRESTAB` similar to TCP
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


    Recently closed (since 20231114)

None.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.8):
https://github.com/orgs/multipath-tcp/projects/6
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [cad2b6e7b1f6] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [3ffe780f86b3] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [0d7a862601de] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [823e272915ba] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [b8f725aa16be] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang)
        - [256b36fb5057] mptcp: userspace pm rename remove_err to out
(Geliang Tang)
        - [35eb0b78d6ad] selftests: mptcp: userspace pm remove initial
subflow (Geliang Tang)
        - [dca90fdd27e1] selftests: mptcp: userspace pm send RM_ADDR for
ID 0 (Geliang Tang)
        - [955a952fe208] selftests: mptcp: add mptcp_lib_kill_wait
(Geliang Tang)
        - [264ee6d6f872] selftests: mptcp: add mptcp_lib_is_v6 (Geliang
Tang)
        - [d5f2bef96ac9] selftests: mptcp: add mptcp_lib_get_counter
(Geliang Tang)
        - [c13afcc06d50] selftests: mptcp: add missing oflag=append
(Geliang Tang)
        - [346698dda4bf] selftests: mptcp: add mptcp_lib_make_file
(Geliang Tang)
        - [c9d7b63f3104] selftests: mptcp: add mptcp_lib_check_transfer
(Geliang Tang)
        - [55e82f362a3a] selftests: mptcp: add
mptcp_lib_wait_local_port_listen (Geliang Tang):
            - Matth can send a v4 to netdev with Geliang's fix

    - Features for net-next (next): /

    - Features for other trees:

        - [2bfa8b59c58a] mptcp: add sched_data helpers (Geliang Tang)
        - [91b1aadf20b5] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [24c95473b02c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [1cecd65380d3] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [29efb1530124] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [1fb0fc2e282a] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [ec61b3d50812] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [5b1e69657126] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [45e4ad9cf0d0] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [1469f08661f6] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [1ed1318e2353] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [a0a4f995bb6a] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [b90451502dca] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [6b41ce7bc4aa] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [6c4a1bbcd722] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [d8c6407180ad] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - same as the previous week: waiting for a refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - Note: it looks like we are rate limited by Cirrus-CI: today,
we are at -1.5 credits.
        - So we probably need another solution
        - TODO: Matth: look at GH action and/or tuxsuite
        - Maybe with tuxsuite, we can track when an issue happened
        - Or look at publishing results somewhere else






Next meeting:
    - Next one on Wednesday, the 29th of November.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231129



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
