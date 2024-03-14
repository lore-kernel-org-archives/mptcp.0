Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3266E5F6
	for <mptcp@lists.linux.dev>; Thu, 14 Mar 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417913; cv=none; b=Hb8uXiUFKWebUUOXP24UIazDziM9cqlEmz0OzCcEngwkpmGX4r3xHPqZaEKyC9udSEH0WWgF4TVbeAyVv2QVaYvGgm8ld02oeeBCxHbvMT00q4NOzcrJHIjHUPL32/9INAG9q1gT5fFn/OqxY+CbCIFH0F5lcq1pFdLedju7zN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417913; c=relaxed/simple;
	bh=psudt4pw/s5I6iLi4YAMNpuBv60mjFyfxgI9HZ90fag=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=rqLfbn55SW2zNvZcYAf995wK+DpRr3C6w/eVn19IKM/C8A4PxyjFEzA/Zsdsyu2LsXaLFQ+xNKwdSkeUnyQOAdyjwRQvX+XDYsyjyj/mMWZ0/BjWceqWqAeBKk9dzAmHLPs3y9N9xdA1FzfYVhjm7FR+rd+BkWt1zTeqYWvGYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5j+MMrH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5j+MMrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B835FC43390
	for <mptcp@lists.linux.dev>; Thu, 14 Mar 2024 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710417913;
	bh=psudt4pw/s5I6iLi4YAMNpuBv60mjFyfxgI9HZ90fag=;
	h=Date:From:Subject:To:From;
	b=u5j+MMrHh5j/S6I6k0u68KP3yW9OZjPA2ERQeDbuxbnhUyQFYf61Hj3dAj8Keo5Bn
	 XisCczePbc+CS6aGvF7MZCVLzWJuJGpWf57cbAtLoFOWRb2sXPHZhalUbn5QvY6uX8
	 Q3/wx3J3Hbkj0QbLcmE+Uhvmw0dOt3sLPDywvn68+y2o0fhm5easa3a8i1SrGd8CM+
	 rm7l/mNEuT5BeluC+6FYXnmdUQMGAihbhuBtJ51Dn+yVjIqSyqOubGxa8/fv+RXOLw
	 7m8DIgFsBn7QzhgozNa84qbKog6dITIzfPnb1G+iHz+85R8C6VNikXtceEojp5qS8i
	 gSSwIlqy3JIPA==
Message-ID: <c72b0c3a-f0a0-4749-b0f6-9b1948e113c2@kernel.org>
Date: Thu, 14 Mar 2024 13:05:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 13th of March 2024
Content-Language: en-US
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Paolo (Red Hat),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (by: Jason Xing, Matthieu Baerts):

13582108: [net-next,1/4] mptcp: drop duplicate header inclusions
13582109: [net-next,2/4] mptcp: update set_flags interfaces
13582110: [net-next,3/4] mptcp: set error messages for set_flags
13582111: [net-next,4/4] mptcp: drop lookup_by_id in lookup_addr:
      - Series: mptcp: some clean-up patches
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=832474&state=*&archive=both

13583679: [net-next,v2,01/12] selftests: mptcp: stop forcing iptables-legacy
13583680: [net-next,v2,02/12] selftests: mptcp: add
mptcp_lib_check_tools helper
13583681: [net-next,v2,03/12] selftests: mptcp: add local variables rndh
13583682: [net-next,v2,04/12] selftests: mptcp: add
mptcp_lib_ns_init/exit helpers
13583683: [net-next,v2,05/12] selftests: mptcp: more operations in
ns_init/exit
13583684: [net-next,v2,06/12] selftests: mptcp: add mptcp_lib_events helper
13583685: [net-next,v2,07/12] selftests: mptcp: diag: fix shellcheck
warnings
13583686: [net-next,v2,08/12] selftests: mptcp: connect: fix shellcheck
warnings
13583687: [net-next,v2,09/12] selftests: mptcp: sockopt: fix shellcheck
warnings
13583688: [net-next,v2,10/12] selftests: mptcp: pm netlink: fix
shellcheck warnings
13583689: [net-next,v2,11/12] selftests: mptcp: simult flows: fix
shellcheck warnings
13583690: [net-next,v2,12/12] selftests: userspace pm: avoid relaunching
pm events:
      - Series: selftests: mptcp: share code and fix shellcheck warnings
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=832874&state=*&archive=both

13586719: [net-next,1/2] mptcp: annotate a data-race around
sysctl_tcp_wmem[0]:
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240308112504.29099-2-kerneljasonxing@gmail.com/

13587353: [net-next,01/15] selftests: mptcp: print all error messages to
stdout
13587354: [net-next,02/15] selftests: mptcp: connect: add dedicated port
counter
13587355: [net-next,03/15] selftests: mptcp: connect: fix misaligned output
13587356: [net-next,04/15] selftests: mptcp: sockopt: print every test
result
13587357: [net-next,05/15] selftests: mptcp: export TEST_COUNTER variable
13587358: [net-next,06/15] selftests: mptcp: add print_title in mptcp_lib
13587359: [net-next,07/15] selftests: mptcp: print test results with
counters
13587360: [net-next,08/15] selftests: mptcp: use += operator to append
strings
13587361: [net-next,09/15] selftests: mptcp: print test results with colors
13587362: [net-next,10/15] selftests: mptcp: call test_fail without argument
13587363: [net-next,11/15] selftests: mptcp: extract
mptcp_lib_check_expected
13587364: [net-next,12/15] selftests: mptcp: print_test out of
verify_listener_events
13587365: [net-next,13/15] selftests: mptcp: add
mptcp_lib_verify_listener_events
13587366: [net-next,14/15] selftests: mptcp: declare event macros in
mptcp_lib
13587367: [net-next,15/15] selftests: mptcp: use
KSFT_SKIP/KSFT_PASS/KSFT_FAIL:
      - Series: selftests: mptcp: various improvements
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=833927&state=*&archive=both

13588598: [6.1.y] selftests: mptcp: decrease BW in simult flows:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240311111224.1421344-2-matttbe@kernel.org/

13588599: [5.15.y] selftests: mptcp: decrease BW in simult flows:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240311111530.1425144-2-matttbe@kernel.org/


    our repo (by: Geliang Tang):

13584950: [mptcp-next,2/2] Squash to "selftests: mptcp: connect: use +=
operator to append strings":
      - Series: squash-to patches for "add helpers in mptcp_lib.sh"
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=833183&state=*&archive=both

13585080: [mptcp-next] Squash to "selftests: mptcp: print test results
with colors":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn/

13586473: [mptcp-next,v2,1/7] selftests: mptcp: call test_fail without
argument
13586474: [mptcp-next,v2,2/7] selftests: mptcp: extract
mptcp_lib_check_expected
13586475: [mptcp-next,v2,3/7] selftests: mptcp: print_test out of
verify_listener_events
13586476: [mptcp-next,v2,4/7] selftests: mptcp: add
mptcp_lib_verify_listener_events
13586477: [mptcp-next,v2,5/7] selftests: mptcp: declare event macros in
mptcp_lib
13586478: [mptcp-next,v2,6/7] selftests: mptcp: use
KSFT_SKIP/KSFT_PASS/KSFT_FAIL
13586479: [mptcp-next,v2,7/7] selftests: mptcp: join: use += operator to
append strings:
      - Series: add helpers and vars in mptcp_lib.sh, part 4
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=833661&state=*&archive=both
      - already sent and applied in netdev

13590939: [mptcp-next,1/2] selftests: mptcp: add tc check for check_tools
13590940: [mptcp-next,2/2] selftests: mptcp: add ms units for tc-netem
delay:
      - Series: two tc related patches
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=834831&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

/

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
      - Skip: status is the same

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
      - Skip: status is the same

13566825: [mptcp-next,v2,6/7] mptcp: add check_id for
lookup_anno_list_by_saddr
13566826: [mptcp-next,v2,7/7] selftests: mptcp: flush userspace addrs list:
      - State: Changes requested
      - Series: some cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828557&state=*&archive=both
      - Skip: status is the same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Needs ack
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/

      - What is important before sending any changes to netdev, is to
have a "performance environment":
          - to measure the differences, see the impact, etc.
          - Might be good to add such tests in the selftests:
              - We can depend on external tools, e.g. TCP Big selftests
uses netperf
              - But maybe not bigger tools like transperf even if it
would analyse already a few things for us
              - udpgso_bench_[rt]x.c: might be extended
          - Matth is going to look at that

      - It should run on HW devices and virtual ones:
          - not the same utilisation of the CPU
          - some ideas: using RPS in RX, and adding netem delay in TX,
to force not having the same context being reused, different usage of
the CPU

      - It looks like this work on the scheduler is challenging, and it
would be better to prepare this work, split it, etc.:
          - So if someone wants to work on that, best to come up with a
plan, with the different steps, what will be changed in the
architecture, etc.

      - → TODO: Matth: add info in the GH tickets. → Done

13584949: [mptcp-next,1/2] Squash to "selftests: mptcp: connect: add
dedicated port counter":
      - Submitter: Geliang Tang
      - State: Rejected
      - It was not handling error cases, best to keep it simple

13588227: [mptcp-next,01/10] selftests: mptcp: export ip_mptcp to mptcp_lib
13588228: [mptcp-next,02/10] selftests: mptcp: get support for limits
13588229: [mptcp-next,03/10] selftests: mptcp: id support for show_endpoints
13588230: [mptcp-next,04/10] selftests: mptcp: addr support for
change_endpoint
13588231: [mptcp-next,05/10] selftests: mptcp: netlink: fix positions of
newline
13588232: [mptcp-next,06/10] selftests: mptcp: netlink: add outputs for
ip_mptcp
13588233: [mptcp-next,07/10] selftests: mptcp: add endpoint_ops API helper
13588234: [mptcp-next,08/10] selftests: mptcp: use mptcp_lib_endpoint_ops
13588235: [mptcp-next,09/10] selftests: mptcp: add ip_mptcp option for
more scripts
13588236: [mptcp-next,10/10] selftests: mptcp: netlink: drop disable=SC2086:
      - State: Under review
      - Series: add helpers and vars in mptcp_lib.sh, final
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=834175&state=*&archive=both
      - Matth is reviewing it: → Done
          - Best not to add tests that doesn't validate new code path

13588322: [iperf3,v3] add MPTCPv1 support:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org/
      - New version addressing comments from
https://github.com/esnet/iperf/pull/1166:
          - Paolo just closed it
      - New version in https://github.com/esnet/iperf/pull/1661
      - TODO: Matth: archive this patch on patchwork → Done

13589158: [mptcp-net,v3] mptcp: don't account accept() of non-MPC client
as fallback to TCP:
      - State: New
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a5f63fbcf13323d8cf293f42849673093d1bf45b.1710179839.git.dcaratti@redhat.com/
      - Mat will look at it

13589441: [mptcp-next] selftests: mptcp: iperf mptcp tests:
      - State: Rejected
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8f95589ded2c77edbc5086a808703c63b4641e60.1710206580.git.tanggeliang@kylinos.cn/

13589477: [virtme-docker] docker: install iperf:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/27fc057073806f67eb30b20ad732a1d3ccaf05e1.1710210140.git.geliang@kernel.org/



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 477):

  478  A hypothesis [question] @geliangtang:
      - Can be closed? TODO Matth

    Bugs (opened, flagged as "bug" and assigned)

  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti:
      - See patches above

  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  477  Client: fallback to TCP after X MPC [bug]
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

  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe
  446  MPTCP Info counters: display "last time" actions info
[enhancement] @geliangtang
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

  478  A hypothesis [question] @geliangtang


    Open questions (opened, questions and not assigned)

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

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


    Recently closed (since 2024-03-06)

  474  CI: use non CPU limited runners with KVM support [enhancement]
[CI] @matttbe
  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests] @matttbe
  406  Compile and run mptcp bpf selftests in CI [enhancement]
[selftests] [bpf] [CI] @matttbe



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - ChangeLog has been updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog
    - TODO: update links for the next meeting → Matth → Done



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [6e124211c7e2] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - see the analysis on GitHub:
                https://github.com/multipath-tcp/mptcp_net-next/issues/475
            - Maybe OK to send this patch as it is, as a first step,
because it helps (shorter transfer)?
            - If we want to do more, it looks like it will take more time:
                - is it normal to do some reinjection, and have this impact?
                - maybe the losses are normal and we need to change the
max time?
            → wait a bit more

    - Fixes for net-next: /

    - Features for net-next:

        - [8d08155864b9] selftests: mptcp: add tc check for check_tools
(Geliang Tang)
        - [6df3a1077d3c] selftests: mptcp: add ms units for tc-netem
delay (Geliang Tang):
            - net-next is closed for the moment

    - Features for net-next (next): /

    - Features for other trees:

        - [0c549aaa04d4] mptcp: add sched_data helpers (Geliang Tang)
        - [de72211e494e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [768f9624934e] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [33d5d3198807] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [39e843bfe71c] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [07422f0baaeb] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [57c37110d9a9] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [00006120e0c5] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [8ada9c194c98] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [3680a0192118] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [e3c00e4e4c90] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [6f613d424f2f] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [a0777d7f19a7] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [c5d599a099d0] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [bfdbc4f80b2f] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [80893f8003df] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status: same as last week



Extra tests:
    - news about Syzkaller? (Christoph):
        - We don't have syzbot coverage for the moment

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - We are no longer using Cirrus-CI (CPU time limited), now
everything is on GitHub Actions
        - BPF tests are now validated in //
        - KVM support has been added:
           - there was a workaround to use it
           - so we can run tests with a debug kconfig
           - more details:
https://github.com/multipath-tcp/mptcp_net-next/issues/474
           - the workaround we had for QEmu has been removed, see #471
        - Emails: please check everything is still OK: now they should
be sent to the cover-letter (if any) with "Re: " + full subject, not
breaking some emails clients
        - workflows in GH Actions have been reduced: now easier to find
info: https://github.com/multipath-tcp/mptcp_net-next/actions
        - To get all tests of one commit, got to:

https://github.com/multipath-tcp/mptcp_net-next/commit/<FULL-SHA>/checks



Misc.:
    - In-kernel QUIC implementation with Userspace handshake:

https://lore.kernel.org/netdev/cover.1710173427.git.lucien.xin@gmail.com/T/



Next meeting:
    - Next one on *Wednesday*, the 20th of March.
    - 16:30 UTC (*9*.30am PDT, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240320



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.


