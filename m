Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF82C6AA
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597627; cv=none; b=eeby3rWq3Oy6VJFitEVhkrSSa7ty+pqIXvkYMBxkOhcTKjSTqGIuYaFhTdIJ70RGHGR4EedssbqlT5q75xLm64p9+PzjE79/6e+IgMdg2RAzaFYZ/w3ilrLGyx7RW8X2djxzu/+H+k8HuqDy81PsbAKzFgISVA4JwGMqgTcRJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597627; c=relaxed/simple;
	bh=ZL3GHiAvIhwLPnqqQOaBx1fB9GM6l4z1sTtPn3XFcxs=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Autocrypt:Organization:
	 Content-Type:Content-Transfer-Encoding; b=TZLNzOeaazMB9sqjtMFwafZJMPZEdI8lPSz47gT/y1haYXQjuIcq996S4H0jfJ4uHaXzD/PeDse4+4+XV12GiMri5ydqyIIQccGnsLnFD+N9WCcHle879ZmkuTL9ihTWS/LKu4CC1YEdd8G38aKsSqDAVg/B8FW1E1ns78fnFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2EDbmRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2EDbmRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE4C43390
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597627;
	bh=ZL3GHiAvIhwLPnqqQOaBx1fB9GM6l4z1sTtPn3XFcxs=;
	h=Date:To:From:Subject:From;
	b=k2EDbmRuVkFvxiKwR7y7r687wtDx9FTn2lIJZwsuV/KM9PnQIY98dhNIYwN2H6Ib7
	 zS8lmU3XRYth3JnbWjW0puDNFUZID9cXTIY3pCEcREmdVUE7cRh0LjCvhUJ95KDWkj
	 yDF7xVOlHQcRA9mDKmCyi+vrGFg4briIB/OXKHBK/ChkXDqBkuE+9K6L4x57Xgt2zV
	 10se4gvNf42R+/Jazhj+4eiBnGd4N8EeY6CwH6z4l1RWgzQ29sx0vPD5yEovYCFLpV
	 s/mJltoZRIM7GFz3ovclJZLg5NZM7aTIrhKC+2DZDh7Xmsi49+a/jiDS03L4znEjhN
	 +yQXf7QgljdnA==
Message-ID: <74bb9971-5d80-4af0-a56b-f5d9b9850b0f@kernel.org>
Date: Thu, 18 Jan 2024 18:07:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 17th of January 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 269th meeting with Mat (Cruise), Christoph
(Apple), Davide (Red Hat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Paolo Abeni):

13520981: [net] mptcp: relax check on MPC passive fallback:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com/


    our repo (by: Paolo Abeni):

13519763: [mptcp-net,1/4] mptcp: drop the push_pending field
13519761: [mptcp-net,2/4] mptcp: fix rcv space initialization
13519760: [mptcp-net,3/4] mptcp: fix more tx path fields initialization
13519762: [mptcp-net,4/4] mptcp: corner case locking for rx path fields
initialization:
      - Series: mptcp: locking cleanup
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=816953&state=*&archive=both

13520065: [v2,mptcp-net] mptcp: relax check on MPC passive fallback:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d97d56012abb6e277c4ffc5042ff2f414dbe7959.1705343249.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

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
      - status: same as before

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - status: same as before

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
      - status: same as before

13485156: [mptcp-next,v14,05/25] mptcp: drop lookup_by_id parameter in
lookup_addr
13485169: [mptcp-next,v14,19/25] mptcp: add use_id parameter for
addresses_equal
13485170: [mptcp-next,v14,20/25] mptcp: add check_id for
lookup_anno_list_by_saddr
13485171: [mptcp-next,v14,21/25] mptcp: add userspace_pm_get_entry helper
13485172: [mptcp-next,v14,22/25] mptcp: drop addr_match and id_match
13485173: [mptcp-next,v14,23/25] mptcp: dup an entry when removing it
13485174: [mptcp-next,v14,24/25] mptcp: add userspace pm addr entry refcount
13485175: [mptcp-next,v14,25/25] selftests: mptcp: rm userspace addr
with random order:
      - State: Changes requested
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=808195&state=*&archive=both
      - status: same as before: Matth will look at it

13501732: [mptcp-next,v6,01/15] selftests: mptcp: add mptcp_lib_evts_*
helpers
13501733: [mptcp-next,v6,02/15] selftests: mptcp: userspace: capitalize
test_name
13501734: [mptcp-next,v6,03/15] selftests: mptcp: userspace: print
colored output
13501735: [mptcp-next,v6,04/15] selftests: mptcp: capitalize ok/fail/skip
13501736: [mptcp-next,v6,05/15] selftests: mptcp: netlink: drop
duplicate var ret
13501737: [mptcp-next,v6,06/15] selftests: mptcp: export ret into mptcp_lib
13501738: [mptcp-next,v6,07/15] selftests: mptcp: extract
mptcp_lib_check_expected
13501739: [mptcp-next,v6,08/15] selftests: mptcp: export event macros in
mptcp_lib
13501740: [mptcp-next,v6,09/15] selftests: mptcp: add
mptcp_lib_verify_listener_events
13501741: [mptcp-next,v6,10/15] selftests: mptcp: unify namespace names
13501742: [mptcp-next,v6,11/15] selftests: mptcp: add mptcp_lib_ns_* helpers
13501743: [mptcp-next,v6,12/15] selftests: mptcp: add ss mptcp support
checks
13501744: [mptcp-next,v6,13/15] selftests: mptcp: add
mptcp_lib_check_tools helper
13501745: [mptcp-next,v6,14/15] selftests: mptcp: add mptcp_lib_cleanup
helper
13501746: [mptcp-next,v6,15/15] selftests: mptcp: add
mptcp_lib_check_output helper:
      - State: Needs ack
      - Series: add helpers and vars in mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=812150&state=*&archive=both
      - status: same as before: Matth will look at it

13520372: [mptcp-next,v9,01/23] mptcp: add pm_has_addr_attr_id helper
13520374: [mptcp-next,v9,02/23] mptcp: add needs_id for userspace
appending addr
13520375: [mptcp-next,v9,03/23] mptcp: add needs_id for netlink
appending addr
13520378: [mptcp-next,v9,04/23] mptcp: map v4 address to v6 when
destroying subflow
13520380: [mptcp-next,v9,05/23] selftests: mptcp: rm subflow with
v4/v4mapped addr
13520376: [mptcp-next,v9,06/23] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13520377: [mptcp-next,v9,07/23] mptcp: implement
mptcp_userspace_pm_dump_addr
13520379: [mptcp-next,v9,08/23] mptcp: add token for get-addr in yaml
13520381: [mptcp-next,v9,09/23] mptcp: dump addrs in userspace pm list
13520382: [mptcp-next,v9,10/23] mptcp: check userspace pm subflow flag
13520383: [mptcp-next,v9,11/23] selftests: mptcp: add userspace pm
subflow flag
13520384: [mptcp-next,v9,12/23] selftests: mptcp: add token for dump_addr
13520385: [mptcp-next,v9,13/23] selftests: mptcp: add check_output helper
13520386: [mptcp-next,v9,14/23] selftests: mptcp: dump after creating id
0 subflow
13520387: [mptcp-next,v9,15/23] selftests: mptcp: dump userspace addrs list
13520388: [mptcp-next,v9,16/23] mptcp: add
userspace_pm_lookup_addr_by_id helper
13520389: [mptcp-next,v9,17/23] mptcp: implement mptcp_userspace_pm_get_addr
13520390: [mptcp-next,v9,18/23] mptcp: get addr in userspace pm list
13520391: [mptcp-next,v9,19/23] selftests: mptcp: add token for get_addr
13520395: [mptcp-next,v9,20/23] selftests: mptcp: userspace pm get addr
tests
13520392: [mptcp-next,v9,21/23] mptcp: update set_flags interfaces
13520393: [mptcp-next,v9,22/23] mptcp: set error messages for set_flags
13520394: [mptcp-next,v9,23/23] selftests: mptcp: flush userspace addrs
list:
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=817092&state=*&archive=both
      - intel's kbuild bot reported an issue with patch 7 (maybe we
cannot have this issue, but still better to silence it)

13521002: [mptcp-next,1/5] mptcp: annotate access for msk keys
13521003: [mptcp-next,2/5] mptcp: annotate lockless access for the tx path
13521004: [mptcp-next,3/5] mptcp: annotate lockless access for RX path
fields.
13521005: [mptcp-next,4/5] mptcp: annotate lockless access for token
13521006: [mptcp-next,5/5] mptcp: annotate lockless accesses around
read-mostly fields:
      - State: Needs ack
      - Series: mptcp: annotate lockless access
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=817295&state=*&archive=both
      - CI tests have not been started because the series was depending
on another one (now applied)
      - tests have been restarted manually



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 470):

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests]:
      - Closed because it's not due to MPTCP
      - Hard to reproduce, Matth managed to do it once, without KVM,
after a lot of attempts
      - TODO: Matth: because it is still impacting, would be nice to try
to launch a git bisect. → reopening the issue


    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  468  selftests: `mptcp_join`: 22 and 23 `backup flow used (...) link
fail` tests are unstable [bug] [selftests]:
      - We still need a solution for this test (having the test "slower"
didn't help)
      - Might be good to run the selftest with perf, with and without
the blame commit and compare the traces (+ flamegraph?) to see if there
is no another issues elsewhere.
      - TODO: Matth: report that on the ticket → Done

  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]:
      - trying with a RHEL kernel but not compiling with CLANG
      - maybe a specific kconfig is needed.
      - Christoph will continue the tests, he will check with Davide
online if it is not possible to compile the RHEL kernel for syzkaller.

  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
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

  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
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


  469  CI: add code coverage support [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  446  MPTCP Info counters: display "last time" actions info [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
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


    Recently closed (since 2024-01-10)

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests]:
      - Not due to MPTCP, but impacting us → reopening it



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [0db9c9b0b364] kasan: avoid resetting aux_lock (Andrey Konovalov):
            - From another tree, needed for our debug kconfig

    - Fixes for -net:

        - [09f9f79e4cae] mptcp: check addrs list in
userspace_pm_get_local_id (Geliang Tang):
            - Not urgent, can wait for other patches

        - [3776d0fcdc2f] mptcp: relax check on MPC passive fallback
(Paolo Abeni):
            - already sent because fixing an issue that has just been
introduced

        - [5db703dbea55] mptcp: drop the push_pending field (Paolo Abeni)
        - [eea7a6e7bc34] mptcp: fix rcv space initialization (Paolo Abeni)
        - [f4f67f4e411a] mptcp: fix more tx path fields initialization
(Paolo Abeni)
        - [b24a5b54e8c9] mptcp: corner case locking for rx path fields
initialization (Paolo Abeni):
            - best to wait before sending them

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [a1495c213e74] mptcp: add sched_data helpers (Geliang Tang)
        - [75f8a8822242] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [1d7ee5869ccb] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [e8fbe338f759] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [428d575407ac] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [159cdd3de15c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [b330ae838bf6] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [f40daade62aa] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [61f9ea7ae016] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [2e48212e5da3] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [88a45edd6e9b] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [d71a3480290c] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [dcdba722dcfb] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [8614cd870638] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [ea535df3e44d] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [fcca4a2efae7] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status: same as before: waiting for new sched api



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
        - Improvements in the results that are shared:
            - ex:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7555323209
            - from there, we can get more details about the issues by
clicking on "checks" in the tests results:
                - link:
https://github.com/multipath-tcp/mptcp_net-next/runs/20571903689
            - By cling on "Tests" from the first link, it is possible to
access the console log:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7555323209/job/20570055915#step:7:1

        - Trying to stabilise somes tests, e.g. packetdrill by running
less tests in // when KVM is not used.

        - On Netdev side: https://netdev.bots.linux.dev/status.html
            - Using virtme-ng (what we should use as well)
            - now running MPTCP tests as well!
            - Matth already has fixes for the timeout issue: to be shared



Next meeting:
    - Next one on *Wednesday*, the 24th of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240124



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
