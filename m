Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705545BEB
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809777; cv=none; b=C53LDSlwCm4KL8rZrRdXOCT+ze5OKUANmhAHm8RFH12zJeQw0ZLETI2fvqbQT0qdVrieBToc8uT9iG8KtEuxifuGVobmqHD0gMjP6RSDmJBWd6kIbuf8ZEVmTMzLaRLK9Fv0UbzdzA7i1vMBpqgTAVR0IcHIwCd0xI3LhBPq/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809777; c=relaxed/simple;
	bh=TRNpLQEYWrEQqdMymev1bW/Fcb1x6NriLa4nSG6UAVw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Br47WA/hC6WkMApge22rmnvalbsyuUc/hTiS+7kq11H/tZR4WIPSggzJQOEsEfhHVRbCMdI3FojzsAljwCOU5/7pnuJWcpPVdhB8lB2iPBDnQd9+WUyy8+so8UrIko7h1mqyKzUmrZWc3qGUdmIpkjtWf6gA08eoJw1bdmMguGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1Izi7Ey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1Izi7Ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2F8C433F1
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709809777;
	bh=TRNpLQEYWrEQqdMymev1bW/Fcb1x6NriLa4nSG6UAVw=;
	h=Date:From:Subject:To:From;
	b=o1Izi7EyLUJli1ylz9JHmgQO14S5yFhwLH2PLlK9+vUCEIVU+u8w1knGU6YQ397Ju
	 e758Vi9WtgPJLQ7uHMYnazk2gAl85VaCjDYdJzUDVlbUrMHwNHqmkzghr2NG+Xq9zA
	 O5JClnGka0n2VmaAsanwwJzZ8L9XgOx82dt58J00mHJhQobSAhnDXncX8UJ0txO073
	 oa8IjhsFvtRALZzJlzozVQArrzeh/SDbBQ5iaEiFKr5HgX6YM6QWjmInmoEcHQrhbV
	 lMuldBgmiQpD7CTUIFvV7+1AN5zuBEpU9C4FvOudAiUWa4THDzzAe9pn/qYQTRw3Iz
	 93CUCtpRVzA5A==
Message-ID: <715a0a2c-93f0-4b40-af44-9da4f49d7ef0@kernel.org>
Date: Thu, 7 Mar 2024 12:09:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 7th of March 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Paolo, Davide
(Red Hat), Christoph (Apple) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13574251: [6.1.y] mptcp: fix data races on local_id:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240227175850.4026403-2-matttbe@kernel.org/

13574252: [6.1.y] mptcp: fix data races on remote_id:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240227180033.4028616-2-matttbe@kernel.org/

13574253: [6.1.y] mptcp: fix duplicate subflow creation:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240227180142.4029958-2-matttbe@kernel.org/

13575779: [6.1.y] mptcp: continue marking the first subflow as UNCONNECTED:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228172121.243458-2-matttbe@kernel.org/

13575792: [5.15.y] mptcp: move __mptcp_error_report in protocol.c:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228173157.255719-2-matttbe@kernel.org/

13575793: [5.15.y] mptcp: process pending subflow error on close:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228173317.257282-2-matttbe@kernel.org/

13575795: [5.15.y] mptcp: rename timer related helper to less confusing
names:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228173355.258080-2-matttbe@kernel.org/

13575796: [5.15.y] selftests: mptcp: add missing kconfig for NF Filter:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228173435.258891-2-matttbe@kernel.org/

13575797: [5.15.y] selftests: mptcp: add missing kconfig for NF Filter
in v6:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228173522.259824-2-matttbe@kernel.org/

13575798: [5.15.y,1/2] mptcp: clean up harmless false expressions
13575799: [5.15.y,2/2] mptcp: add needs_id for netlink appending addr:
      - Series: [5.15.y,1/2] mptcp: clean up harmless false expressions
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=830801&state=*&archive=both

13578819: [net,1/2] selftests: mptcp: diag: return KSFT_FAIL not test_cnt
13578820: [net,2/2] selftests: mptcp: diag: avoid extra waiting:
      - Series: selftests: mptcp: fixes for diag.sh
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=831618&state=*&archive=both

13578867: [net-next,1/4] mptcp: cleanup writer wake-up
13578868: [net-next,2/4] mptcp: avoid some duplicate code in socket
option handling
13578869: [net-next,3/4] mptcp: implement TCP_NOTSENT_LOWAT support
13578870: [net-next,4/4] mptcp: cleanup SOL_TCP handling:
      - Series: mptcp: add TCP_NOTSENT_LOWAT sockopt support
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=831634&state=*&archive=both

13578920: [net-next,01/15] mptcp: make pm_remove_addrs_and_subflows static
13578921: [net-next,02/15] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13578922: [net-next,03/15] mptcp: implement mptcp_userspace_pm_dump_addr
13578923: [net-next,04/15] mptcp: add token for get-addr in yaml
13578924: [net-next,05/15] mptcp: dump addrs in userspace pm list
13578925: [net-next,06/15] mptcp: check userspace pm flags
13578926: [net-next,07/15] selftests: mptcp: add userspace pm subflow flag
13578927: [net-next,08/15] selftests: mptcp: add token for dump_addr
13578928: [net-next,09/15] selftests: mptcp: add mptcp_lib_check_output
helper
13578929: [net-next,10/15] selftests: mptcp: dump userspace addrs list
13578930: [net-next,11/15] mptcp: add userspace_pm_lookup_addr_by_id helper
13578931: [net-next,12/15] mptcp: implement mptcp_userspace_pm_get_addr
13578932: [net-next,13/15] mptcp: get addr in userspace pm list
13578967: [net-next,14/15] selftests: mptcp: add token for get_addr
13578968: [net-next,15/15] selftests: mptcp: userspace pm get addr tests:
      - Series: mptcp: userspace pm: 'dump addrs' and 'get addr'
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=831650&state=*&archive=both

13580615: [6.7.y,1/5] selftests: mptcp: add evts_get_info helper
13580616: [6.7.y,2/5] selftests: mptcp: add chk_subflows_total helper
13580617: [6.7.y,3/5] selftests: mptcp: update userspace pm test helpers
13580618: [6.7.y,4/5] selftests: mptcp: add mptcp_lib_is_v6
13580619: [6.7.y,5/5] selftests: mptcp: rm subflow with v4/v4mapped addr:
      - Series: mptcp: dependences for "selftests: mptcp: rm subflow
with v4/v4mapped addr"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=832100&state=*&archive=both

13580658: [6.6.y,1/5] selftests: mptcp: add evts_get_info helper
13580659: [6.6.y,2/5] selftests: mptcp: add chk_subflows_total helper
13580660: [6.6.y,3/5] selftests: mptcp: update userspace pm test helpers
13580661: [6.6.y,4/5] selftests: mptcp: add mptcp_lib_is_v6
13580662: [6.6.y,5/5] selftests: mptcp: rm subflow with v4/v4mapped addr:
      - Series: mptcp: dependences for "selftests: mptcp: rm subflow
with v4/v4mapped addr"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=832117&state=*&archive=both

13580856: [5.15.y] mptcp: fix double-free on socket dismantle:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240304162517.2505910-2-matttbe@kernel.org/

13580943: [5.10.y] mptcp: fix double-free on socket dismantle:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240304170614.2608800-2-matttbe@kernel.org/


    our repo (by: Geliang Tang, Matthieu Baerts):

13576905: [mptcp-net,v7,1/8] selftests: mptcp: diag: return KSFT_FAIL
not test_cnt
13578709: selftests: mptcp: diag: avoid extra waiting:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240301163846.1370114-2-matttbe@kernel.org/

13581819: [mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/93e203493c3ce7a0c7b4e17146baa37a9db2f568.1709626306.git.geliang@kernel.org/

13583187: [mptcp-next,v13,1/9] selftests: mptcp: print all error
messages to stdout
13583188: [mptcp-next,v13,2/9] selftests: mptcp: connect: add dedicated
port counter
13583189: [mptcp-next,v13,3/9] selftests: mptcp: connect: fix misaligned
output
13583190: [mptcp-next,v13,4/9] selftests: mptcp: sockopt: print every
test result
13583191: [mptcp-next,v13,5/9] selftests: mptcp: export TEST_COUNTER
variable
13583192: [mptcp-next,v13,6/9] selftests: mptcp: add print_title in
mptcp_lib
13583193: [mptcp-next,v13,7/9] selftests: mptcp: print test results with
counters
13583194: [mptcp-next,v13,8/9] selftests: mptcp: connect: use +=
operator to append strings
13583195: [mptcp-next,v13,9/9] selftests: mptcp: print test results with
colors:
      - Series: add helpers and vars in mptcp_lib.sh, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=832769&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

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
      - skip: same status

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
      - skip: same status

13566825: [mptcp-next,v2,6/7] mptcp: add check_id for
lookup_anno_list_by_saddr
13566826: [mptcp-next,v2,7/7] selftests: mptcp: flush userspace addrs list:
      - State: Changes requested
      - Series: some cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828557&state=*&archive=both
      - skip: same status

13571733: [mptcp-next,v5,08/12] selftests: mptcp: move test_fail out of
check_expected_one
13571734: [mptcp-next,v5,09/12] selftests: mptcp: extract
mptcp_lib_check_expected
13571735: [mptcp-next,v5,10/12] selftests: mptcp: export event macros in
mptcp_lib
13571736: [mptcp-next,v5,11/12] selftests: mptcp: add
mptcp_lib_verify_listener_events
13571737: [mptcp-next,v5,12/12] selftests: mptcp: use
KSFT_SKIP/KSFT_PASS/KSFT_FAIL:
      - State: Changes requested
      - Series: add helpers and vars in mptcp_lib.sh, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=829774&state=*&archive=both
      - skip: same status

13582545: [mptcp-net,v2] mptcp: don't account accept() of non-MPC client
as fallback to TCP:
      - State: New
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com/
      - to be reviewed

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - to be reviewed

13583313: [iperf3,v2] add MPTCPv1 support:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/487902825fa971916541b59e43ed25c7525b60e0.1709695652.git.geliang@kernel.org/
      - a new PR on IPerf3 side should be opened
      - the original PR from Paolo should be closed:
        https://github.com/esnet/iperf/pull/1166
      - This one as well: https://github.com/esnet/iperf/pull/1615



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 477):

/


    Bugs (opened, flagged as "bug" and assigned)

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests] @matttbe
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
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
[selftests]:
      - Matth did some tests:
          - Without the patch from our tree (selftests: mptcp: simult
flows: re-adapt BW), it is easier to reproduce the issues seen on NIPA:
~10% vs 2% on my side, when doing 100 tests
          - When there is an issue, it looks like the traffic dropped a
bit in the middle
          - Matth has MIBs counters and PCAP
          - If we want to increase MIBs counters
          - TODO: add info on the ticket → Matth → Done

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


    Recently closed (since 2024-02-28)

None.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [b59673901203] x86: Fixup from the removed INT3 if it is
unhandled (Masami Hiramatsu):
            - workaround for Qemu

    - Fixes for -net:

        - [fb3ec257dd6e] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - check Matth's analyses

    - Fixes for net-next: /

    - Features for net-next:

        - [9f67b69b23b7] selftests: mptcp: stop forcing iptables-legacy
(Matthieu Baerts (NGI0))
        - [40a1227fe149] selftests: mptcp: add mptcp_lib_check_tools
helper (Geliang Tang)
        - [a237fac22f28] selftests: mptcp: add local variables rndh
(Geliang Tang)
        - [5ee1a739de9f] selftests: mptcp: add mptcp_lib_ns_init/exit
helpers (Geliang Tang)
        - [b700d5e6c3e3] selftests: mptcp: more operations in
ns_init/exit (Geliang Tang)
        - [09d84eaef93f] selftests: mptcp: add mptcp_lib_events helper
(Geliang Tang)
        - [78ae03eb4299] selftests: mptcp: diag: fix shellcheck warnings
(Matthieu Baerts (NGI0))
        - [f10e57404296] selftests: mptcp: connect: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [3b3957cef181] selftests: mptcp: sockopt: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [aa230c59bfe8] selftests: mptcp: pm netlink: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [57e439f69f5c] selftests: mptcp: simult flows: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [22b694695e54] selftests: userspace pm: avoid relaunching pm
events (Matthieu Baerts (NGI0)):
            - sent to netdev (v2)

        - [271ab33039f1] mptcp: drop duplicate header inclusions
(Geliang Tang)
        - [358bb426e980] mptcp: update set_flags interfaces (Geliang Tang)
        - [056856fc088a] mptcp: set error messages for set_flags
(Geliang Tang)
        - [21be1b2e6a14] mptcp: drop lookup_by_id in lookup_addr
(Geliang Tang):
            - sent to netdev → applied after the meeting

        - [c0285de9849e] selftests: mptcp: print all error messages to
stdout (Geliang Tang)
        - [1c8c806c64ac] selftests: mptcp: connect: add dedicated port
counter (Geliang Tang)
        - [3218d4c4528a] selftests: mptcp: connect: fix misaligned
output (Geliang Tang)
        - [24171c8f55e8] selftests: mptcp: sockopt: print every test
result (Geliang Tang)
        - [a78bb0e0d1c0] selftests: mptcp: export TEST_COUNTER variable
(Geliang Tang)
        - [d5a66350fa60] selftests: mptcp: add print_title in mptcp_lib
(Geliang Tang)
        - [a07a74d0c59a] selftests: mptcp: print test results with
counters (Geliang Tang)
        - [727c478fd91d] selftests: mptcp: connect: use += operator to
append strings (Geliang Tang)
        - [1ee9ede715c3] selftests: mptcp: print test results with
colors (Geliang Tang):
            - just added today, can be sent when the other one modifying
the selftests ↑ has been accepted
            - TODO: Matth → scheduled that on Friday

    - Features for net-next (next): /

    - Features for other trees:

        - [fc2cd2fa2085] mptcp: add sched_data helpers (Geliang Tang)
        - [8862cabaf94e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [8ad1ac8249ce] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [83e20d87718c] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [f78822afa3cc] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [1e01ac76a61d] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [c760d62d86ba] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [e675dd29310e] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [93d3bb4e5845] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5c0e28060d49] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [39a5f88a4dd9] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [bf000a10898e] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [c004b374cd30] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [fcc39715c6ba] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [f5b5efd3ca57] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [620906376460] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status: same as last time: waiting for sched refactoring


Extra tests:
    - news about Syzkaller? (Christoph):
        - Christoph is not validating the export branch for the moment,
trying the RHEL kernel but has some issues to compile a kernel with the
required kconfig
        - Maybe someone else can also run a syzkaller instance
validating the export branch?

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - cirrus-ci is back (beginning of the month)
        - Matth is adding a new job to run the MPTCP BPF tests


Backports:
    - Sasha selected "mptcp: let the in-kernel PM use mixed IPv4 and
IPv6 addresses" for v6.1:
        - but it changes the behaviour: we can have a mix of subflows in
v4 and v6
        - (even if the PM should have accepted that from the beginning)
        - or do we want to take this opportunity to change the behaviour?
        - → best not to change the behaviour on the stable version: the
patch has been removed



Conferences:
    - NetdevConf 0x18:
        - July 15-19th
        - California, USA
        - seems hard to go for people in EU
    - LPC 2024:
        - September 18-20th
        - Vienna, Austria
        - maybe there will be more people there
    - Kernel Recipes 2024:
        - September 23-25th
        - Paris, France
        - just after LPC :-/



Matth's grant:
    - Matth is having issues with the tax services in Belgium, not
considering the grant as it should be
    - the result might be that the grant will cover less work than what
was expected :(



Next meeting:
    - Next one on *Wednesday*, the 13th of March.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240313



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
