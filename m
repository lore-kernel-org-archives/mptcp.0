Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8416E40845
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144324; cv=none; b=q12UWghVurXGQoeTjkGZh1DtHBvo1P+SC2s9PbWFMGFMUCTXNtWHp1fuRK++c0+QJyZWHkQ+AE15olafDA4qkB//1B+qDBgqt3Q8w5KH/gd/XqoVm5/mQB98TUtG+wdxKrRgfwJh0tasgnXA/daWLF1locAlIqgApftyM73h1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144324; c=relaxed/simple;
	bh=iW527YVTSclLqUa+78U9t4G/KnSmkvCwgTjc3t66iuE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=cjZvCZXG7TTWJR3VC0N9Hr40/VROp04FPit+GY18jgtakKKu0NrAl0z+rMvG+pPtJqVz89eStyquGvliJTnwTrjnBsd+fdQ5lEWNo9p1sReeVIL5oo1k91ZzwqkGWoKlnEBI09q78YYEBIV0IXQFgQqmeK1d/D3q5UKtRKnDGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4PrBRdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4PrBRdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35F7C43394
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 18:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709144324;
	bh=iW527YVTSclLqUa+78U9t4G/KnSmkvCwgTjc3t66iuE=;
	h=Date:From:Subject:To:From;
	b=X4PrBRdXSLdN/wYw0+0eIb6EwfgcWwIfQo7Hc/yANN467u5YzRJ4HwsB+5UpsEKVn
	 9jP7ebC9xIfCEiwOq7BoYyY/459UaXaVl3oKQS4Zo3JvdnX4Xp/xfaU35tbg22QsZF
	 7g7nh/6U9h4XiNEgaxvM1LW2hswk//rQ3sxUGhsOFuUee/gfmXJrE+f/hOZKQmzFN+
	 gJmfyJfpH+hYy+l4N4zVJ1Y3dOW7TZr0O0fceuhZylDV9YGzZBBNIxqfSn0GH9LOG4
	 oF2HeGjRTRryxBXyhKiP51MPn+1rCDywOeK+IvTmEUKjxscm4TXUExJ+yJSHukoiC7
	 Rt+Ikzd4PQwPQ==
Message-ID: <cb248851-adc1-4d38-bca9-d3ec4e73c21c@kernel.org>
Date: Wed, 28 Feb 2024 19:18:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 28th of February 2024
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


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13569447: [net,01/10] mptcp: map v4 address to v6 when destroying subflow
13569448: [net,02/10] selftests: mptcp: rm subflow with v4/v4mapped addr
13569449: [net,03/10] mptcp: avoid printing warning once on client side
13569450: [net,04/10] mptcp: push at DSS boundaries
13569451: [net,05/10] mptcp: fix snd_wnd initialization for passive socket
13569452: [net,06/10] mptcp: fix potential wake-up event loss
13569453: [net,07/10] selftests: mptcp: join: add ss mptcp support check
13569454: [net,08/10] mptcp: fix double-free on socket dismantle
13569455: [net,09/10] mptcp: fix possible deadlock in subflow diag
13569456: [net,10/10] selftests: mptcp: explicitly trigger the listener
diag code-path:
      - Series: mptcp: more misc. fixes for v6.8
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=829169&state=*&archive=both

13569920: [net-next,1/8] selftests: mptcp: lib: catch duplicated subtest
entries
13569921: [net-next,2/8] mptcp: token kunit: set protocol
13569922: [net-next,3/8] mptcp: check the protocol in tcp_sk() with
DEBUG_NET
13569923: [net-next,4/8] mptcp: check the protocol in mptcp_sk() with
DEBUG_NET
13569924: [net-next,5/8] selftests: mptcp: netlink: drop duplicate var ret
13569925: [net-next,6/8] selftests: mptcp: simult flows: define missing vars
13569926: [net-next,7/8] selftests: mptcp: join: change capture/checksum
as bool
13569927: [net-next,8/8] selftests: mptcp: diag: change timeout_poll to 30:
      - Series: mptcp: various small improvements
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=829284&state=*&archive=both

      ↓ A lot of backports have been done recently, some had conflicts ↓

13572695: [6.7.y] selftests: mptcp: join: stop transfer when check is
done (part 1):
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226185015.446712-2-matttbe@kernel.org/

13572696: [6.7.y] selftests: mptcp: join: stop transfer when check is
done (part 2):
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226185155.448681-2-matttbe@kernel.org/

13572720: [6.7.y] selftests: mptcp: add mptcp_lib_get_counter:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226190513.459358-2-matttbe@kernel.org/

13572959: [6.6.y] mptcp: userspace pm send RM_ADDR for ID 0:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226215340.754643-2-matttbe@kernel.org/

13572960: [6.6.y] selftests: mptcp: join: stop transfer when check is
done (part 1):
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226215457.756126-2-matttbe@kernel.org/

13572961: [6.6.y] selftests: mptcp: join: stop transfer when check is
done (part 2):
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226215534.756867-2-matttbe@kernel.org/

13572962: [6.6.y] mptcp: add needs_id for netlink appending addr:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226215620.757784-2-matttbe@kernel.org/

13572963: [6.6.y] selftests: mptcp: add mptcp_lib_get_counter:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240226215724.759032-2-matttbe@kernel.org/


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

13565954: [mptcp-net] mptcp: fix double-free on socket dismantle:
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com/

13566053: [v3,mptcp-net,1/2] mptcp: fix possible deadlock in subflow diag
13566054: [v3,mptcp-net,2/2] selftests: mptcp: explicitly trigger the
listener diag code-path:
      - Series: mptcp: fix another deadlock issue
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828396&state=*&archive=both

13566739: [mptcp-next,v4,1/4] selftests: mptcp: add local variables rndh
13566740: [mptcp-next,v4,2/4] selftests: mptcp: add
mptcp_lib_ns_init/exit helpers
13566741: [mptcp-next,v4,3/4] selftests: mptcp: more operations in
ns_init/exit
13566742: [mptcp-next,v4,4/4] selftests: mptcp: add mptcp_lib_events helper:
      - Series: add helpers and vars in mptcp_lib.sh, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828526&state=*&archive=both

13566820: [mptcp-next,v2,1/7] mptcp: make pm_remove_addrs_and_subflows
static
13566821: [mptcp-next,v2,2/7] mptcp: drop duplicate header inclusions
13566822: [mptcp-next,v2,3/7] mptcp: update set_flags interfaces
13566823: [mptcp-next,v2,4/7] mptcp: set error messages for set_flags
13566824: [mptcp-next,v2,5/7] mptcp: drop lookup_by_id in lookup_addr:
      - Series: some cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828557&state=*&archive=both

13567587: [mptcp-next,1/6] selftests: mptcp: diag: fix shellcheck warnings
13567588: [mptcp-next,2/6] selftests: mptcp: connect: fix shellcheck
warnings
13567589: [mptcp-next,3/6] selftests: mptcp: sockopt: fix shellcheck
warnings
13567590: [mptcp-next,4/6] selftests: mptcp: pm netlink: fix shellcheck
warnings
13567591: [mptcp-next,5/6] selftests: mptcp: simult flows: fix
shellcheck warnings
13567592: [mptcp-next,6/6] selftests: userspace pm: avoid relaunching pm
events:
      - Series: selftests: mptcp: fix shellcheck warnings
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828760&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


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


    our repo (by: Geliang Tang, Matthieu Baerts):

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
      - status: same as last time

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - status: same as last time

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
      - status: same as last time

13566818: [mptcp-net] selftests: mptcp: don't exit when a symbol not found:
      - State: Rejected
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn/
      - We do want to exit when a symbol is not found *if*
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set (only set in our
CI and when using 'mptcp-upstream-virtme-docker')

13566825: [mptcp-next,v2,6/7] mptcp: add check_id for
lookup_anno_list_by_saddr
13566826: [mptcp-next,v2,7/7] selftests: mptcp: flush userspace addrs list:
      - State: Changes requested
      - Series: some cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828557&state=*&archive=both
      - We can simplify patch 6/7 with one extra var
      - patch 7/7 doesn't seem to validate more things and "harder" to
maintain (behaviour is quite different depending on the kernel version)

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
      - The series has been split in two

13574956: [mptcp-next,v6,1/9] selftests: mptcp: add
mptcp_lib_pr_ok/skip/fail/info
13574957: [mptcp-next,v6,2/9] selftests: mptcp: print test results with
colors
13574958: [mptcp-next,v6,3/9] selftests: mptcp: connect: fix misaligned
output
13574959: [mptcp-next,v6,4/9] selftests: mptcp: simult_flows: fix
misaligned output
13574960: [mptcp-next,v6,5/9] selftests: mptcp: sockopt: print every
test result
13574961: [mptcp-next,v6,6/9] selftests: mptcp: connect: print out ping
tests info
13574962: [mptcp-next,v6,7/9] selftests: mptcp: add more print_title helpers
13574963: [mptcp-next,v6,8/9] selftests: mptcp: connect: add dedicated
port counter
13574964: [mptcp-next,v6,9/9] selftests: mptcp: print test results with
counters:
13575026: [mptcp-next] Squash to "selftests: mptcp: connect: print out
ping tests info":
      - State: Changes requested
      - Series: add helpers and vars in mptcp_lib.sh, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=830565&state=*&archive=both
      - Matth did a review: some modifications needed here

      - In general, it might help other reviewers to keep series small
and avoid having multiple "active" series in //, it is hard to follow
and "add pressure" on readers/reviewers.

13575170: [6.1.y] mptcp: continue marking the first subflow as UNCONNECTED:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240228095858.4117568-2-matttbe@kernel.org/
      - also linked by the patch introducing the regressions:
          - https://github.com/multipath-tcp/packetdrill/pull/134
      - if there are no objections, Matth can send the patch to stable
and merge the PR:
          - seems needed, no objections then, can be sent and applied



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

  477  Client: fallback to TCP after X MPC [bug]:
      - Try 5 times, then remove the options
      - TFO was caching issues per destination, using tcp-metrics, but
now it just stop for a period of time "the issues are certainly on the
client side"
      - it seems really needed in some places where any packets having
unknown options are dropped.

  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]:
      - trying to imitate "tcp coalescing", not GRO
      - but nobody has a fix for that

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


    Recently closed (since 2024-02-21)

  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]
  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [d596710fb20c4] x86: Fixup from the removed INT3 if it is
unhandled (Masami Hiramatsu):
            - Workaround for QEmu
            - A new version with the fix should come soon in Ubuntu
23.10: we will be able to drop this patch soon
            - https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2051965

    - Fixes for -net:

        - [2fb3c53b7de07] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - Waiting for more investigations

    - Fixes for net-next: /

    - Features for net-next:

        - [de9e44a88349c] selftests: mptcp: stop forcing iptables-legacy
(Matthieu Baerts (NGI0)):
            - Conflicts with -net

        - [2046321b70f52] mptcp: cleanup writer wake-up (Paolo Abeni)
        - [936c2b8ce8d5f] mptcp: avoid some duplicate code in socket
option handling (Paolo Abeni)
        - [94b9851fcfe50] mptcp: implement TCP_NOTSENT_LOWAT support
(Paolo Abeni)
        - [055c1aafe2be0] mptcp: cleanup SOL_TCP handling (Paolo Abeni):
            - Depend on patches queued for -net

        - [4e8cd58017783] selftests: mptcp: add mptcp_lib_check_tools
helper (Geliang Tang):
            - Conflicts with -net

        - [15e09e9542f3b] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr (Geliang Tang)
        - [f8ff886989997] mptcp: implement mptcp_userspace_pm_dump_addr
(Geliang Tang)
        - [c7cf1a01ff4b0] mptcp: add token for get-addr in yaml (Geliang
Tang)
        - [9b95810dee614] mptcp: dump addrs in userspace pm list
(Geliang Tang)
        - [61394ad8f7802] mptcp: check userspace pm flags (Geliang Tang)
        - [2e4943f274a34] selftests: mptcp: add userspace pm subflow
flag (Geliang Tang)
        - [2ac39ee4040d6] selftests: mptcp: add token for dump_addr
(Geliang Tang)
        - [4b7eb8cec1344] selftests: mptcp: add mptcp_lib_check_output
helper (Geliang Tang)
        - [87db8bd842a00] selftests: mptcp: dump userspace addrs list
(Geliang Tang)
        - [88520ab23a745] mptcp: add userspace_pm_lookup_addr_by_id
helper (Geliang Tang)
        - [46621d4ee68e1] mptcp: implement mptcp_userspace_pm_get_addr
(Geliang Tang)
        - [902ee790b206f] mptcp: get addr in userspace pm list (Geliang
Tang)
        - [d65b25615c826] selftests: mptcp: add token for get_addr
(Geliang Tang)
        - [c26a177c589cd] selftests: mptcp: userspace pm get addr tests
(Geliang Tang):
            - Selftests conflicts with -net

        - [6030669992721] selftests: mptcp: add local variables rndh
(Geliang Tang)
        - [71bfdd416d3f0] selftests: mptcp: add mptcp_lib_ns_init/exit
helpers (Geliang Tang)
        - [2929903252171] selftests: mptcp: more operations in
ns_init/exit (Geliang Tang)
        - [0bdfdd49450b2] selftests: mptcp: add mptcp_lib_events helper
(Geliang Tang):
            - "Depends" (context) on patches above

        - [2d3b3c574a6ea] selftests: mptcp: diag: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [283baf1895077] selftests: mptcp: connect: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [d298f376acd5d] selftests: mptcp: sockopt: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [4ddd4c2312050] selftests: mptcp: pm netlink: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [cedd4e760bc6a] selftests: mptcp: simult flows: fix shellcheck
warnings (Matthieu Baerts (NGI0))
        - [1a2748676643f] selftests: userspace pm: avoid relaunching pm
events (Matthieu Baerts (NGI0)):
            - Same

        - [dc60c144cc614] mptcp: make pm_remove_addrs_and_subflows
static (Geliang Tang)
        - [20de07c8496ca] mptcp: drop duplicate header inclusions
(Geliang Tang)
        - [f63d6094757da] mptcp: update set_flags interfaces (Geliang Tang)
        - [10f2b595db0a6] mptcp: set error messages for set_flags
(Geliang Tang)
        - [0025ecc11e80d] mptcp: drop lookup_by_id in lookup_addr
(Geliang Tang):
            - Last patch depending on other patches from ↑

        - TODO: Matth: send as most patches as possible on Friday, after
the net and net-next sync, and the rest when patches are applied.


    - Features for net-next (next): /

    - Features for other trees:

        - [0950e71219db1] mptcp: add sched_data helpers (Geliang Tang)
        - [f11b5b92c3481] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [59cad635ad450] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [0d3fc650ecaa5] selftests/bpf: Add mptcp sched structs
(Geliang Tang)
        - [abc09bf7d456c] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [1675cdd0e8e60] selftests/bpf: Add bpf_first scheduler
(Geliang Tang)
        - [3e6f76c0ff94a] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [5e3b68133311f] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [ca3212b7da7d4] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [c4beed7d7e0d0] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [49b85ea39dd52] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [06ca22da43c6a] selftests/bpf: Add bpf_red scheduler (Geliang
Tang)
        - [b20921c7ab667] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [510f48b0fbf51] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [139e50f04827d] selftests/bpf: Add bpf_burst scheduler
(Geliang Tang)
        - [ea0e2c643e5ed] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - Status: same: waiting for sched refactoring


Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill/pull/134
        - can be applied

    - Patchew (Davide):
        - No longer re-applying series when a Reviewed-by tag is shared
on the ML → save CI limited resources \o/

    - CI (Matth):
        - On netdev, subtests are no longer tracked:
            - temp workaround: results json is growing really fast
            - it means we will only see results for selftests:
                - mptcp_join.sh and simult_flows.sh are considered as
unstable
                - no more details per subtest for the moment :'(

        - shellcheck status are now reported on patchwork \o/
            - e.g.
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8036972621



Next meeting:
    - Next one on *Wednesday*, the 6th of March.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240306



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
