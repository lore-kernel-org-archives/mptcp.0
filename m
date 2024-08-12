Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64F17C23D
	for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475486; cv=none; b=MhcgUdN/lwYXp+j1hqou7ofxxlBEK3C/N0ulyG6/dpsf+e279Op8E0tauC2femmDRghQy8O6s827DXuNguPYmFiVT3SPCUQFTRcRx2mH+UisTYvelpA7UuRFyFaBOzhvRZ/TiVO9/YUtJvLMcOfCZncFKuwGFSpZ60BaX3jLyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475486; c=relaxed/simple;
	bh=4K9BE9Py544t9m18/JxZcyEG43GsXbPUCXFfBE4IP/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=XN2CdOj1dQAfPayC/S4vQ7N9GNHddSWVLZlxbVp4UzY10+cTvKj/jK3+wtGyE4qEoiZx7zAbZ7/HY4VO1ustj9/LUFzx81KA6eCsBiR2AUSkF3ePlAFsRa3B/B+rTxCqQXyNiIgIwZX+ilT83bT8CHl4fPrnHLcvA9w9sCpNj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHpb2NgO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHpb2NgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D19CC32782
	for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475486;
	bh=4K9BE9Py544t9m18/JxZcyEG43GsXbPUCXFfBE4IP/E=;
	h=Date:From:Subject:To:From;
	b=RHpb2NgONuRBBppknRci5W/zq89AM5f/SfKLqPEsfpAFQLxkg5JfbHMg1Uijtt2Qk
	 6qiWxf9xcntpRg1/z6f+Mn92/VSTc1X8SwG/wxyvwQUpdfLdMcjgMUo+irK5PHkryv
	 HmiaEqaW9eIcxuqPejjoCFQNL3xH3Yn5nYSIE5NSbk4ZC8VvDH1uaF4KYH0JIljmxE
	 Xa9cblMdorAl6kO0RJkBm6exygtQfOsgmrT/tUfmKXrANbwAi1Xeqfh7Jcf+BBz2fU
	 O7opGooh+Mqycy+Iy4X2tyf/mCl3U5G5eCX2ktRfJrJJAdQsuoaknRrH3p2eHndDQK
	 IBncVa47SQjRA==
Message-ID: <86ec57e6-4caf-405d-b08a-2d528204dad2@kernel.org>
Date: Mon, 12 Aug 2024 17:11:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 7th of August 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise), Christoph (Apple),
Davide (Redhat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:

    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts (NGI0)):

13748430: [net,1/2] mptcp: fix bad RCVPRUNED mib accounting
13748431: [net,2/2] mptcp: fix duplicate data handling:
    - Series: mptcp: fix duplicate data handling
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875404&state=*&archive=both

13748531: [net,1/7] mptcp: fully established after ADD_ADDR echo on MPJ
13748532: [net,2/7] mptcp: pm: deny endp with signal + subflow + port
13748533: [net,3/7] mptcp: pm: reduce indentation blocks
13748534: [net,4/7] mptcp: pm: don't try to create sf if alloc failed
13748535: [net,5/7] mptcp: pm: do not ignore 'subflow' if 'signal' flag
is also set
13748536: [net,6/7] selftests: mptcp: join: ability to invert ADD_ADDR check
13748537: [net,7/7] selftests: mptcp: join: test both signal & subflow:
    - Series: mptcp: fix endpoints with 'signal' and 'subflow' flags
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875429&state=*&archive=both

13743697: [iproute2-net,1/7] man: mptcp: document 'dev IFNAME'
13743698: [iproute2-net,2/7] man: mptcp: clarify 'signal' and 'subflow'
flags
13743699: [iproute2-net,3/7] man: mptcp: 'port' has to be used with 'signal'
13743700: [iproute2-net,4/7] man: mptcp: 'backup' flag also affects
outgoing data
13743701: [iproute2-net,5/7] man: mptcp: 'fullmesh' has to be used with
'subflow'
13743702: [iproute2-net,6/7] man: mptcp: clarify the 'ID' parameter
13743703: [iproute2-net,7/7] ip: mptcp: 'id 0' is only for 'del':
    - Series: mptcp: improve man pages to avoid confusions
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874238&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts (NGI0)):

13750455: [mptcp-next,v2,1/3] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13750456: [mptcp-next,v2,2/3] Squash to "selftests/bpf: Add bpf
scheduler test"
13750457: [mptcp-next,v2,3/3] Squash to "selftests/bpf: Add bpf_first
scheduler & test":
    - Series: skip test if ip mptcp not support
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875915&state=*&archive=both

13751568: [mptcp-net] selftests: net: lib: kill PIDs before del netns:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts
(NGI0)):

13665648: [bpf-next,v2,1/8] selftests/bpf: Add unshare_netns helper
13665649: [bpf-next,v2,2/8] selftests/bpf: Use unshare_netns helper
13665650: [bpf-next,v2,3/8] selftests/bpf: Drop duplicate create_netns
13665651: [bpf-next,v2,4/8] selftests/bpf: Export create_netns helper
13665652: [bpf-next,v2,5/8] selftests/bpf: Use create_netns helper
13665653: [bpf-next,v2,6/8] selftests/bpf: Export cleanup_netns helper
13665654: [bpf-next,v2,7/8] selftests/bpf: Use cleanup_netns helper
13665655: [bpf-next,v2,8/8] selftests/bpf: Use netns helpers in lwt tests:
    - Series: add netns helpers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853539&state=*&archive=both
    - Matt asked what to do with this one, no urgency.

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/
    - Matt asked the checkpatch maintainers/reviewers, but no replies so far

13750754: [net-next] tcp: limit wake-up for crossed SYN cases with SYN-ACK:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org/
    - Should be useful in theory, but can be dropped.
    - Marked as Under Review in Netdev's patchwork

13753375: [bpf-next,v4,1/2] selftests/bpf: Add mptcp subflow example
13753376: [bpf-next,v4,2/2] selftests/bpf: Add mptcp subflow subtest:
    - Series: selftests/bpf: new MPTCP subflow subtest
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=876648&state=*&archive=both


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts, Matthieu
Baerts (NGI0)):

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

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - status: same as last time

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
    - status: same as last time

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule
chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - status: same as last time

13729347: [mptcp-next,1/3] mptcp: add mptcp_snd_nxt helper
13729348: [mptcp-next,2/3] Squash to "bpf: Export more bpf_burst related
functions"
13729349: [mptcp-next,3/3] Squash to "selftests/bpf: Add bpf_burst
scheduler":
    - State: Changes requested
    - Series: get msk->snd_nxt with READ_ONCE
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=870130&state=*&archive=both
    - status: same as last time

13750069: [mptcp-next,1/4] selftests: mptcp: add cfg_timeo for mptcp_connect
13750070: [mptcp-next,2/4] selftests: mptcp: add io thread mode for
mptcp_connect
13750071: [mptcp-next,3/4] selftests: mptcp: enable io thread mode
13750072: [mptcp-next,4/4] selftests: mptcp: join: add io thread tests:
    - State: Changes requested
    - Series: add io thread mode tests
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875830&state=*&archive=both

13751831: [mptcp-net,v6,01/11] Squash to "mptcp: pm: re-using ID of
unused removed ADD_ADDR"
13751832: [mptcp-net,v6,02/11] Squash to "mptcp: pm: fullmesh: select
the right ID later"
13751833: [mptcp-net,v6,03/11] mptcp: pm: fix RM_ADDR ID for the initial
subflow
13751834: [mptcp-net,v6,04/11] selftests: mptcp: join: check removing ID
0 endpoint
13751835: [mptcp-net,v6,05/11] mptcp: pm: send ACK on an active subflow
13751836: [mptcp-net,v6,06/11] mptcp: pm: skip connecting to already
established sf
13751837: [mptcp-net,v6,07/11] mptcp: pm: reset MPC endp ID when re-added
13751838: [mptcp-net,v6,08/11] selftests: mptcp: join: check re-adding
init endp with != id
13751839: [mptcp-net,v6,09/11] mptcp: close subflow when receiving TCP+FIN
13751840: [mptcp-net,v6,10/11] selftests: mptcp: join: cannot rm sf if
closed
13751841: [mptcp-net,v6,11/11] mptcp: pm: send ACK on non stale subflows:
    - State: Under review
    - Series: mptcp: pm: more fixes around the ID 0
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=876308&state=*&archive=both
    - Mat will have a look

13754668: [mptcp-next,v3,1/8] selftests: mptcp: join: no extra msg if no
counter
13754669: [mptcp-next,v3,2/8] mptcp: MIB counters for sent MP_JOIN
13754670: [mptcp-next,v3,3/8] selftests: mptcp: join: reduce join_nr params
13754671: [mptcp-next,v3,4/8] selftests: mptcp: join: one line for join
check
13754672: [mptcp-next,v3,5/8] selftests: mptcp: join: validate MPJ SYN
TX MIB counters
13754673: [mptcp-next,v3,6/8] selftests: mptcp: join: more explicit
check name
13754674: [mptcp-next,v3,7/8] selftests: mptcp: join: specify host being
checked
13754675: [mptcp-next,v3,8/8] selftests: mptcp: join: mute errors when
ran in the background:
    - State: Under review
    - Series: mptcp: MIB counters for sent MP_JOIN
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=877027&state=*&archive=both
    - v3 addresses comments from Geliang

13756369: Squash to "mptcp: pm: send ACK on non stale subflows":
    - State: New
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=877450&state=*&archive=both




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 512):

  513  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow`:
      - Also seen by Christoph, but no reproducers

    Recently active

  512  Primary flow re-establishes as a subflow but immediately closes
[bug] [feedback-needed]
  509  Add MIB counters for sent MPJ [enhancement] @matttbe
  508  Divide error on device removal [bug] [feedback-needed]
  506  Cannot create backup subflows to remote endpoints? [bug]
[feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]


    Bugs (opened, flagged as "bug" and assigned)

  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  512  Primary flow re-establishes as a subflow but immediately closes
[bug] [feedback-needed]
  508  Divide error on device removal [bug] [feedback-needed]
  506  Cannot create backup subflows to remote endpoints? [bug]
[feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  509  Add MIB counters for sent MPJ [enhancement] @matttbe
  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
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

  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  513  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow`
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
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
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
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
  334  in-kernel PM: send >1 ADD_ADDR before the establishment of a new
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
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-07-31)

  500  cleanup rbuf bug [bug] [feedback-needed]
  493  [syzkaller] WARNING in `__mptcp_clean_una` [bug] [syzkaller]


    Packetdrill PRs

  # 153  6 days ago   matttbe   mptcp: tfo: inject DFIN without delay
  52   2 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  # 19  1 hour ago  Aperence  added swift + objective-c example to
implementation guide
  18  6 days ago  matttbe   pm: describe the 'port' option
  17  6 days ago  matttbe   pm: check the man page for more details

    Mat will look at them




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.12):
https://github.com/orgs/multipath-tcp/projects/10
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - Changelog updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [dcb91881b057] tcp: limit wake-up for crossed SYN cases to
SYN-ACK (Matthieu Baerts (NGI0)):
            - already sent

        - [3ed1542bd356] mptcp: pm: re-using ID of unused removed
ADD_ADDR (Matthieu Baerts (NGI0))
        - [e6f2aac158c4] selftests: mptcp: join: check re-using ID of
unused ADD_ADDR (Matthieu Baerts (NGI0))
        - [54df96f7f534] mptcp: pm: re-using ID of unused removed
subflows (Matthieu Baerts (NGI0))
        - [9f60fbfa60e4] selftests: mptcp: join: check re-using ID of
closed subflow (Matthieu Baerts (NGI0))
        - [670ea46242db] mptcp: pm: re-using ID of unused flushed
subflows (Matthieu Baerts (NGI0))
        - [a634a057920b] selftests: mptcp: join: test for flush/re-add
endpoints (Matthieu Baerts (NGI0))
        - [bf1354d4b368] mptcp: pm: remove mptcp_pm_remove_subflow()
(Matthieu Baerts (NGI0))
        - [3f00605fdacf] mptcp: pm: only mark 'subflow' endp as
available (Matthieu Baerts (NGI0))
        - [da145c2c472f] mptcp: pm: only decrement add_addr_accepted for
MPJ req (Matthieu Baerts (NGI0))
        - [432ff155c3f0] mptcp: pm: check add_addr_accept_max before
accepting new ADD_ADDR (Matthieu Baerts (NGI0))
        - [91f46fd71b0e] mptcp: pm: only in-kernel cannot have entries
with ID 0 (Matthieu Baerts (NGI0))
        - [6c14bb827112] mptcp: pm: fullmesh: select the right ID later
(Matthieu Baerts (NGI0))
        - [679d207b9d64] selftests: mptcp: join: validate fullmesh endp
on 1st sf (Matthieu Baerts (NGI0))
        - [81c19d800519] mptcp: pm: avoid possible UaF when selecting
endp (Matthieu Baerts (NGI0))
        - [64e48f4feebc] mptcp: pm: reuse ID 0 after delete and re-add
(Matthieu Baerts (NGI0)):
            - can wait a bit, there are two Squash-to patches that are
pending

        - [39df2d9d0170] selftests: net: lib: kill PIDs before del netns
(Matthieu Baerts (NGI0)):
            - TODO: Matth: can be sent separately

    - Fixes for net-next: /

    - Features for net-next:

        - [44faf9aaee73] selftests: mptcp: join: simplify checksum_tests
(Geliang Tang):
            - can wait to be sent with other patches

        - [e55d707fd3f3] mptcp: pm: rename helpers linked to 'flush'
(Matthieu Baerts (NGI0))
        - [3f32ab1c1e2e] mptcp: pm: reduce entries iterations on connect
(Matthieu Baerts (NGI0)):
            - depend on patches queued for -net

    - Features for net-next (next):


    - Features for other trees:

        - [89f5708a74fd] mptcp: add sched_data helpers (Geliang Tang)
        - [6e14994e1894] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [2eec01b945b7] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [4de6c2c0d055] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [82535ab770b1] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang):
            - sent, waiting for feedback from BPF devs

        - [c3876c16d40c] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [0cb49b9ae15d] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [5072f1582809] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [70cf30a5a63c] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [cd82eeb7bb46] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [eb8716d4944f] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [b988f6348897] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [abf954718c8c] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - waiting for the sched API refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - syzkaller on Christoph side is currently broken. Christoph is
looking at fixing it.

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - /



Next meeting:
    - *Not next week (14th of August)*
    - Next one on Wednesday, the 21st of August.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240821



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

