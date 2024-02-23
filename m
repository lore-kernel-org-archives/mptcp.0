Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D72E412
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700559; cv=none; b=nyeUyaROemB5usggHShxGlGjaJHwL7d9+Qp1RB+Ni1PU+Ckn5wijBlg+StjzmX77KbUfCMD8zxunyyIi8xnHv03E53mRWJBzi6bNoxe0yk7efHRPGTaHUm43uwB3OAEepNtsr7JcuDP62Pic6NDsX96IcsL0lWYXGr4yMAAMdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700559; c=relaxed/simple;
	bh=t50OGcRbD7+01ZVq0ZC6k4hIbII+8LM/FzRK/kcf/Rc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=XkFo5yQ54ifyKdNH06yO+qZGpifJUNF1lfytg9WkKXLM6AsbIutVpVrCVcXYCHCxceH/6vKRlMc858gx4o8XcCNhwIHrOKRLb77iWYSpUiaDgyoQw2vO8og7gBGpZL1rHcQp7njEYRYUrNKH9N3gm0Hvh9bmqqmvHmnZdn1547k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgBgoU+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgBgoU+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C63C433C7
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708700558;
	bh=t50OGcRbD7+01ZVq0ZC6k4hIbII+8LM/FzRK/kcf/Rc=;
	h=Date:From:Subject:To:From;
	b=pgBgoU+PbwoWQ4nPtmaaOZDW0dJkMV7pBNSE7IoChHtqYT0yiKWTh0rjhG983V+mh
	 naiBAqP9iI9BVQfiIA6/pc0Re3gRfEWrwKvWR4WZjCSvxFeKiteWmvcCnEE4PJrvh6
	 i3yG/6W5VvODMXPzps1YJNtViDUhHFxtlREwQmy/BkzjSr17IMQmG4h/Hy4M/7zfup
	 Fio6YZThO+fGXBv59s7G8QFkWL+8naen5ej+yfDPA5dZcQbX68q6teYKMCfVQBP4MU
	 TnSr6Vg3yuYjTFEf72aMNuXQK/eKNKfBCfCiqVOhS84mrMUSEU/wPLKAZSt+CN24yd
	 0r6lzIGRnex2A==
Message-ID: <089c4d23-71ce-41b6-a111-f7d458d94513@kernel.org>
Date: Fri, 23 Feb 2024 16:02:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 21st of February 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 272nd meeting with Mat (Cruise), Paolo, Davide
(Red Hat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Paolo Abeni):

13528961: [mptcp-stable] mptcp: introduce explicit flag for first
subflow disposal:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com/
      - Applied to 6.1 \o/

13552937: configs/debug: add NET debug config:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org/
      - not directly related to MPTCP, useful for the CI

13559027: [net,01/13] mptcp: add needs_id for userspace appending addr
13559028: [net,02/13] mptcp: add needs_id for netlink appending addr
13559029: [net,03/13] mptcp: fix lockless access in subflow ULP diag
13559030: [net,04/13] mptcp: fix data races on local_id
13559031: [net,05/13] mptcp: fix data races on remote_id
13559032: [net,06/13] mptcp: fix duplicate subflow creation
13559033: [net,07/13] selftests: mptcp: pm nl: also list skipped tests
13559034: [net,08/13] selftests: mptcp: pm nl: avoid error msg on older
kernels
13559035: [net,09/13] selftests: mptcp: diag: fix bash warnings on older
kernels
13559036: [net,10/13] selftests: mptcp: simult flows: fix some subtest names
13559037: [net,11/13] selftests: mptcp: userspace_pm: unique subtest names
13559038: [net,12/13] selftests: mptcp: diag: unique 'in use' subtest names
13559039: [net,13/13] selftests: mptcp: diag: unique 'cestab' subtest names:
      - Series: mptcp: misc. fixes for v6.8
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=826534&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13548914: [mptcp-next] selftests: mptcp: stop forcing iptables-legacy:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org/

13558229: [mptcp-next,v4,1/3] mptcp: token kunit: set protocol
13558230: [mptcp-next,v4,2/3] mptcp: check the protocol in tcp_sk() with
DEBUG_NET
13558231: [mptcp-next,v4,3/3] mptcp: check the protocol in mptcp_sk()
with DEBUG_NET:
      - Series: mptcp: check the protocol with DEBUG_NET
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=826337&state=*&archive=both

13558605: [mptcp-net] mptcp: avoid printing warning once on client side:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org/

13559726: [mptcp-next,v2,1/7] selftests: mptcp: netlink: drop duplicate
var ret
13559727: [mptcp-next,v2,2/7] selftests: mptcp: simult flows: define
missing vars
13559728: [mptcp-next,v2,3/7] selftests: mptcp: join: change
capture/checksum as bool
13559729: [mptcp-next,v2,4/7] selftests: mptcp: diag: change
timeout_poll to 30
13559933: [v3,net-next,1/7] mptcp: push at DSS boundaries
13559934: [v3,net-next,2/7] mptcp: fix snd_wnd initialization for
passive socket
13559935: [v3,net-next,3/7] mptcp: fix potential wake-up event loss
13559936: [v3,net-next,4/7] mptcp: cleanup writer wake-up
13559938: [v3,net-next,5/7] mptcp: avoid some duplicate code in socket
option handling
13559937: [v3,net-next,6/7] mptcp: implement TCP_NOTSENT_LOWAT support.
13559939: [v3,net-next,7/7] mptcp: cleanup SOL_TCP handling:
      - Series: mptcp: implement TCP_NOTSENT_LOWAT support
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=826742&state=*&archive=both

13559961: [mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
coverage for CI":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org/

13562327: [mptcp-next,v3,1/2] selftests: mptcp: join: add ss mptcp
support check
13562401: [mptcp-next,v4] selftests: mptcp: add mptcp_lib_check_tools
helper:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/82ff7dbbf5ba256c707e3863ebbcbdc71179de3a.1708334189.git.tanggeliang@kylinos.cn/

13563818: [mptcp-next,v14,01/14] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13563819: [mptcp-next,v14,02/14] mptcp: implement
mptcp_userspace_pm_dump_addr
13563820: [mptcp-next,v14,03/14] mptcp: add token for get-addr in yaml
13563821: [mptcp-next,v14,04/14] mptcp: dump addrs in userspace pm list
13563822: [mptcp-next,v14,05/14] mptcp: check userspace pm flags
13563823: [mptcp-next,v14,06/14] selftests: mptcp: add userspace pm
subflow flag
13563824: [mptcp-next,v14,07/14] selftests: mptcp: add token for dump_addr
13563825: [mptcp-next,v14,08/14] selftests: mptcp: add
mptcp_lib_check_output helper
13563826: [mptcp-next,v14,09/14] selftests: mptcp: dump userspace addrs list
13563827: [mptcp-next,v14,10/14] mptcp: add
userspace_pm_lookup_addr_by_id helper
13563828: [mptcp-next,v14,11/14] mptcp: implement
mptcp_userspace_pm_get_addr
13563829: [mptcp-next,v14,12/14] mptcp: get addr in userspace pm list
13563830: [mptcp-next,v14,13/14] selftests: mptcp: add token for get_addr
13563831: [mptcp-next,v14,14/14] selftests: mptcp: userspace pm get addr
tests:
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=827792&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

13556982: [v2,net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.:
      - State: Rejected
      - Submitter: Kuniyuki Iwashima
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240214195407.3175-1-kuniyu@amazon.com/
      - Not directly related to MPTCP
      - Code OK, but tool that is useful to develop new features


    our repo (by: Geliang Tang, Kuniyuki Iwashima, Matthieu Baerts,
Paolo Abeni):

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
      - skip: status: same as last week

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - skip: status: same as last week

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
      - skip: status: same as last week

13545002: [mptcp-next] mptcp: add a sk_is_tcp check for sk_is_mptcp:
      - State: Rejected
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn/

13559730: [mptcp-next,v2,5/7] selftests: mptcp: drop iptables/ip6tables
vars:
      - State: Rejected
      - Submitter: Geliang Tang
      - not really needed, noise for backports, can be useful later

13564978: [mptcp-next,1/8] mptcp: make pm_remove_addrs_and_subflows static
13564979: [mptcp-next,2/8] mptcp: drop duplicate header inclusions
13564980: [mptcp-next,3/8] mptcp: update set_flags interfaces
13564981: [mptcp-next,4/8] mptcp: set error messages for set_flags
13564982: [mptcp-next,5/8] mptcp: drop lookup_by_id in lookup_addr
13564983: [mptcp-next,6/8] mptcp: add use_id parameter for addresses_equal
13564984: [mptcp-next,7/8] mptcp: add check_id for lookup_anno_list_by_saddr
13564985: [mptcp-next,8/8] selftests: mptcp: flush userspace addrs list:
      - State: Changes requested
      - Series: some cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828113&state=*&archive=both
      - Matth just did a review, see ML

13565014: [mptcp-next,v3,1/3] selftests: mptcp: connect: add local
variable rndh
13565015: [mptcp-next,v3,2/3] selftests: mptcp: add mptcp_lib_ns_* helpers
13565016: [mptcp-next,v3,3/3] selftests: mptcp: add mptcp_lib_evts_*
helpers:
      - State: Changes requested
      - Series: add helpers and vars in mptcp_lib.sh, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828123&state=*&archive=both
      - Matth did a review today, see ML

13565719: [v2,mptcp-net,1/2] mptcp: fix possible deadlock in subflow diag
13565718: [v2,mptcp-net,2/2] selftests: mptcp: explicitly trigger the
listener diag code-path:
      - State: Queued
      - Series: mptcp: fix another deadlock issue
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828314&state=*&archive=both
      - patch 1/2 looks good, but not patch 2/2 for the CI: timeout in
slow env → v3 expected

[PATCH mptcp-net] mptcp: fix double-free on socket dismantle:
      - Submitter: Davide Caratti
      - Fixing a kasan report (no link? no reporter?)
      - Fixing an issue that is certainly there from the beginning →
"Fixes" tag needed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 474):

  477  Client: fallback to TCP after X MPC:
      - Some networks / firewall might drop all TCP packets with
"unknown" TCP options, not just modifying the packets to drop the
unknown options
      - it seems needed to do that. → can be considered as a bug maybe?

  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]:
      - see the discussion about that at the last meeting

  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]:
      - see the discussion about that at the last meeting


    Bugs (opened, flagged as "bug" and assigned)

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests] @matttbe:
      - QEmu in Ubuntu will be updated with a fix

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti:
      - can be closed

  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
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

  474  CI: GH Actions: use self-hosted runners [enhancement] [CI] @matttbe
  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe
  446  MPTCP Info counters: display "last time" actions info
[enhancement] @geliangtang
  406  Compile and run mptcp bpf selftests in CI [enhancement]
[selftests] [bpf] [CI] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
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

  477  Client: fallback to TCP after X MPC
  473  CI: tracking: publish tests results to Kernel CI [enhancement] [CI]
  469  CI: add code coverage support [enhancement] [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
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


    Recently closed (since 2024-02-14)

  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
  453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
@geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [a7e8d9704601] x86: Fixup from the removed INT3 if it is
unhandled (Masami Hiramatsu):
            - workaround for QEmu
        - [c27dd7f340b5] tracing: Inform kmemleak of saved_cmdlines
allocation (Steven Rostedt (Google)):
            - fix from upstream, not in -net yet

    - Fixes for -net:

        - [a24a59de3594] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - best to wait and look at it in more details, not to change
parameters regularly

        - [6b47048a705e] mptcp: map v4 address to v6 when destroying
subflow (Geliang Tang)
        - [83b6fbde2734] selftests: mptcp: rm subflow with v4/v4mapped
addr (Geliang Tang)

        - [62f3d5259d02] mptcp: avoid printing warning once on client
side (Matthieu Baerts (NGI0))

        - [08985020036e] mptcp: push at DSS boundaries (Paolo Abeni)
        - [82e4a860d178] mptcp: fix snd_wnd initialization for passive
socket (Paolo Abeni):
            - there is a conflict with a patch in net-next --
3f83d8a77eee ("mptcp: fix more tx path fields initialization") -- but
that can happen, we just need to document it
        - [7e823319279a] mptcp: fix potential wake-up event loss (Paolo
Abeni)

        - [8450d1cfe666] selftests: mptcp: join: add ss mptcp support
check (Geliang Tang):
            - can be sent ↑ but better to wait for the two patches from
Paolo
            - TODO: Matth: send patches on Friday/Monday → on Friday


    - Fixes for net-next: /

    - Features for net-next:

        - [442b45b3800c] selftests: mptcp: lib: catch duplicated subtest
entries (Matthieu Baerts (NGI0)):
            - can probably be sent
            - depend on patches in net, not in net-next yet → after Thursday

        - [233178e5e0de] selftests: mptcp: stop forcing iptables-legacy
(Matthieu Baerts (NGI0)):
            - can probably be sent

        - [d62e7eac734c] mptcp: token kunit: set protocol (Matthieu
Baerts (NGI0))
        - [78df01b6b3d1] mptcp: check the protocol in tcp_sk() with
DEBUG_NET (Matthieu Baerts (NGI0))
        - [be27f819019e] mptcp: check the protocol in mptcp_sk() with
DEBUG_NET (Matthieu Baerts (NGI0)):
            - can probably be sent

        - [94120481b3c2] selftests: mptcp: netlink: drop duplicate var
ret (Geliang Tang)
        - [9a43845951b8] selftests: mptcp: simult flows: define missing
vars (Geliang Tang)
        - [037497f8c58c] selftests: mptcp: join: change capture/checksum
as bool (Geliang Tang)
        - [330041a109aa] selftests: mptcp: diag: change timeout_poll to
30 (Geliang Tang):
            - can probably be sent

        - [0774d9997be6] mptcp: cleanup writer wake-up (Paolo Abeni)
        - [0d1be117a188] mptcp: avoid some duplicate code in socket
option handling (Paolo Abeni)
        - [5351d12e99dc] mptcp: implement TCP_NOTSENT_LOWAT support
(Paolo Abeni)
        - [2c6410587f09] mptcp: cleanup SOL_TCP handling (Paolo Abeni):
            - depend on patches queued for -net

        - [d372e1c6e3c1] selftests: mptcp: add mptcp_lib_check_tools
helper (Geliang Tang)
        - [aa6e2589dfeb] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr (Geliang Tang):
            - can probably be sent
            - TODO: Matth: send them → on Friday/Monday

        - [d1acbe804d90] mptcp: implement mptcp_userspace_pm_dump_addr
(Geliang Tang)
        - [e65a069256e4] mptcp: add token for get-addr in yaml (Geliang
Tang)
        - [e282f7c98d9a] mptcp: dump addrs in userspace pm list (Geliang
Tang)
        - [922958876729] mptcp: check userspace pm flags (Geliang Tang)
        - [0d66883d5fc4] selftests: mptcp: add userspace pm subflow flag
(Geliang Tang)
        - [70030b5cb16e] selftests: mptcp: add token for dump_addr
(Geliang Tang)
        - [2f94a7096c15] selftests: mptcp: add mptcp_lib_check_output
helper (Geliang Tang)
        - [3fed46fc21b2] selftests: mptcp: dump userspace addrs list
(Geliang Tang)
        - [2a5daa1e81e3] mptcp: add userspace_pm_lookup_addr_by_id
helper (Geliang Tang)
        - [cb72c8689714] mptcp: implement mptcp_userspace_pm_get_addr
(Geliang Tang)
        - [60707234f706] mptcp: get addr in userspace pm list (Geliang Tang)
        - [02629f5e557c] selftests: mptcp: add token for get_add7r
(Geliang Tang)
        - [02c311437b27] selftests: mptcp: userspace pm get addr tests
(Geliang Tang):
            - have been applied recently, can wait a bit

    - Features for net-next (next):


    - Features for other trees:

        - [646030245cfd] mptcp: add sched_data helpers (Geliang Tang)
        - [f83f4557504e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [b9887573d073] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [5195ce054434] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [ae6e83179d24] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [eff5447acbca] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [056a416f326f] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [accbd9940d34] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [3efd70dd3721] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [1591d70d9042] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [50029b91a651] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [edddebfde577] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [1bc746ac9147] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [d03e76ec778d] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [d7216727384d] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [55fbb8fb2435] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for the sched refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill/pull/132

    - Patchew (Davide):
        - Patch to avoid re-creating a new version when tags are shared
on the ML?
        - deploy this? https://github.com/matttbe/patchew/commit/for-davide
        - done

    - CI (Matth):
        - Cirrus-Ci has been disabled for the rest of the month: we
reached the monthly limit


Patchwork:
    - ask to use bot?:
        - Auto-supersede series? (yes, within NN days/no)
        - https://korg.docs.kernel.org/patchwork/index.html
    - (re)-ask to have Geliang?: → Geliang re-asked
        - we cannot assign him on patches
        - https://patchwork.kernel.org/project/mptcp/
    → Yes, ask this to helpdesk.
    - TODO: Matth → done



Next meeting:
    - Next one on *Wednesday*, the 21st of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240221



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
