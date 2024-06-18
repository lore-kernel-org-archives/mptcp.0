Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076D15534B
	for <mptcp@lists.linux.dev>; Tue, 18 Jun 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702235; cv=none; b=qeYr5Lr1oPJ2xGBtd7jAEUX0GxIWCgmF/IoJMZjPHnrX0VfXi2JK7cTIFhYeFM73kiQrU3AioykalRA3pA1LV5aDDq9XBBxlnsLkyf2LAMATTXQ7HXvsLDcAJlgbXqf8Kdf0ZqhA2JjjT1l/SMD0lzrpVkkI33uCzMcM22NTyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702235; c=relaxed/simple;
	bh=e6HYoVH1axwyEwhBmQtTcbHg50Dia4qlLBYKNd/0cYw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IkFH/qy0akfQ6ZeOwAyNJ1NgDtinK2+S5c6Fbazo3T7aeRDnv9KLPnQkGgakyyXWPMVssEcVI+9VMDrDnb5t2bnzXeQgQyUJoFODbBPtw3NJe9Dp1iFSv+BVUNu1uT4iBxk8+LC0hZb1EK7c1/haWVd0naalxMJuSlVfVk7LqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJXkL+gN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJXkL+gN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6E2C3277B
	for <mptcp@lists.linux.dev>; Tue, 18 Jun 2024 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702235;
	bh=e6HYoVH1axwyEwhBmQtTcbHg50Dia4qlLBYKNd/0cYw=;
	h=Date:To:From:Subject:From;
	b=YJXkL+gNEId58035fLBpQHNuXRYbtk29e85dp7UADM4mbuOvk+u3s29RgBUbIhKZK
	 aN/LdzRdlp5KQHHuC8HIzx6oJ6TB3axUBIy8ndw/dr0FIMdx7Nk6lcCaFR2iY4cyGK
	 NFSwWQP2t7oiZOiuMd7Ahh7kfLb3NMFf+zFVFo1c4jxDwdfYKS8W3pmi5blL0ojQjj
	 hCHh73+FXdffUJZUiP8sIHadnzwuQpr9lNEbOZWjMsIlYaHY4PYau8TQ7E4vVguCuY
	 Ja7XNCvrLMIJ9HJCzVbYBbG5dh9wSU0tQv8wWSbAf3OH1sR9m9BpAZmtFJdgZHj3Ft
	 ecOPCxkmF9Hdw==
Message-ID: <0a1ea191-e0cb-4132-908a-6a272cdacd78@kernel.org>
Date: Tue, 18 Jun 2024 11:17:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 12th of June 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise), Christoph (Apple),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13678590: [6.6.y,1/3] mptcp: avoid some duplicate code in socket option
handling
13678591: [6.6.y,2/3] mptcp: cleanup SOL_TCP handling
13678592: [6.6.y,3/3] mptcp: fix full TCP keep-alive support:
      - Series: Backport of "mptcp: fix full TCP keep-alive support"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856924&state=*&archive=both

13678594: [6.1.y,1/3] mptcp: avoid some duplicate code in socket option
handling
13678595: [6.1.y,2/3] mptcp: cleanup SOL_TCP handling
13678596: [6.1.y,3/3] mptcp: fix full TCP keep-alive support:
      - Series: Backport of "mptcp: fix full TCP keep-alive support"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856925&state=*&archive=both

13678600: [5.15.y] mptcp: fix full TCP keep-alive support:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240529100130.3375226-2-matttbe@kernel.org/

13686269: [net-next,1/3] mptcp: use mptcp_win_from_space helper
13686270: [net-next,2/3] mptcp: add mptcp_space_from_win helper
13686271: [net-next,3/3] mptcp: refer to 'MPTCP' socket in comments:
      - Series: mptcp: misc. cleanups
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=858934&state=*&archive=both

13686457: [net,1/3] selftests: net: lib: support errexit with busywait
13686458: [net,2/3] selftests: net: lib: avoid error removing empty
netns name
13686459: [net,3/3] selftests: net: lib: set 'i' as local:
      - Series: selftests: net: lib: small fixes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=858985&state=*&archive=both

13690356: [net,1/4] mptcp: ensure snd_una is properly initialized on connect
13690357: [net,2/4] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
13690358: [net,3/4] mptcp: pm: update add_addr counters after connect
13690359: [net,4/4] mailmap: map Geliang's new email address:
      - Series: mptcp: various fixes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=859994&state=*&archive=both

13690536: [net-next,1/6] selftests: net: lib: ignore possible errors
13690537: [net-next,2/6] selftests: net: lib: remove ns from list after
clean-up
13690538: [net-next,3/6] selftests: net: lib: do not set ns var as readonly
13690539: [net-next,4/6] selftests: net: lib: remove 'ns' var in setup_ns
13690540: [net-next,5/6] selftests: mptcp: lib: use setup/cleanup_ns helpers
13690541: [net-next,6/6] selftests: mptcp: lib: use
wait_local_port_listen helper:
      - Series: selftests: mptcp: use net/lib.sh to manage netns
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=860035&state=*&archive=both


    our repo (by: Matthieu Baerts):

13688831: [mptcp-net,v2] mptcp: pm: update add_addr counters after connect:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240606-mptcp-pm-inc-cnt-sf-create-v2-1-67c4759a4885@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts,
Yunsheng Lin):

13659842: [bpf-next,v2,1/2] selftests/bpf: Add mptcp subflow example
13659843: [bpf-next,v2,2/2] selftests/bpf: Add mptcp subflow subtest:
      - Series: selftests/bpf: new MPTCP subflow subtest
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851945&state=*&archive=both
      - status: same as before

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
      - status: same as before

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/
      - no news, we need to wait

13689841: [net-next,v7,13/15] net: replace page_frag with page_frag_cache:
      - status: same as before


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts):

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

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - status: same as before

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
      - status: same as before

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
      - State: Changes requested
      - Series: fixes for create_netns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both
      - status: same as before

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule
chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
each subflow:
      - State: Needs ack
      - Series: mptcp: update scheduler API
      - Submitter: Gregory Detal
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
      - status: same as before

13687445: [mptcp-iproute,1/4] man: mptcp: document 'dev IFNAME'
13687446: [mptcp-iproute,2/4] man: mptcp: clarify 'signal' and 'subflow'
flags
13687447: [mptcp-iproute,3/4] mptcp: warn if 'signal' and 'subflow'
flags are set
13687448: [mptcp-iproute,4/4] mptcp: warn if 'signal' or 'subflow' flag
is not set:
      - State: Changes requested
      - Series: mptcp: guide the user to avoid mistakes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=859237&state=*&archive=both
      - See the discussions below (last topic)



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 494):

  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]:
      - happened only once, to be monitored

  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]:
      - linked to "mptcp: pm: update add_addr counters after connect",
and to #496
      - the patch is not fixing this bug

  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]:
      - linked to #496 and #440

  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]:
      - linked to the discussions from last week: it might help to fix
bug #498, and simplify the code on the in-kernel PM side

  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]:


    Bugs (opened, flagged as "bug" and assigned)

  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [bpf] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]

  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]:
      - Christoph will try Florian's v2.
(https://lore.kernel.org/netdev/20240608221057.16070-1-fw@strlen.de/)

  493  [syzkaller] WARNING in `__mptcp_clean_una` [bug] [syzkaller]
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

  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

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
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-06-05)

None.


    Packetdrill PRs

52  2 years ago  dcaratti  Add initial coverage for RM_ADDR



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [1c38643c3604] mptcp: add sched_data helpers (Geliang Tang)
        - [4b54f7da7384] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [50a3720ccb95] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang):
            - waiting for Geliang's "add netns helpers" v3, not urgent

        - [fa086f56d9b2] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [c884ca19db36] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [2c75152dcfee] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [e334d47da8c7] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [5d6753fe86b8] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [d9394ff61fb4] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [84721e576eec] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [452ef5ceacab] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [d5d3f99c991e] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [d4e93bbd3bf3] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - Packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill/pull/148:
            - merged, thanks for the review!
            - with fixes and modifications to prevent issues
            - looks OK so far

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - very green!



Regression tests:
    - Would it be OK with (only) 1 server?:
        - CPU: AMD EPYC 7402P 24-Core Processor:
            - 1 CPU socket, using 2 NUMA nodes (NPS 2)
            - NUMA & NPS:
https://www.amd.com/system/files/documents/dell-emc-dfd-numa-amd-epyc-2ndgen.pdf
            - Opti ref doc:
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/2019-amd-epyc-7002-tg-linux-network-56739.pdf
        - 128GB RAM (4x32)
        - NICs:
            - Intel X710 2x10G
            - Mellanox MCX4621A-ACAB Dual-port ConnectX-4 2x10G (or 25?)

    - OK using one link with 2 IPs or 2 VLANs (or SR-IOV with different
VF for the tagging?) to have 2 subflows?:
        - We need at least one port to connect to Internet
        - or I need a 10G switch
        → Simpler solution: maybe good to add a simple 1GB NIC for the
management iface, and keep the other ones just for the tests

    - OK to use netem for the shaping?:
        - Or required to have a 2nd server?
        - Or no shaping needed?
        - Netem changes the behaviour of TCP: orphan, no pacing, not
TSQ, etc.
        - probably better with a second machine (if available...)
        - but maybe fine without delays for the kind of test we want to run?

    - What kind of test? Netperf?:
        - https://github.com/borkmann/stuff/blob/master/super_netperf
        - https://github.com/network-quality/goresponsiveness ?



in-kernel PM: should we allow:
    - endpoint with both 'signal' and 'subflow':
        - the PM will first announce address, then clear the
corresponding bit from "id_avail_bitmap"
        - then it will check if it can use it to create a subflow:
select_local_address() will not pick it, because it is marked as
unavailable according to "id_avail_bitmap"
        - so it looks like in case of "signal" + "subflow", "subflow" is
ignored:
            - a bug? If yes:
                - fix it by using a dedicated bitmap → could be a
solution ; in this case we don't need a warning on iproute2 side
                - or modify the PM to refuse accepting endpoints with
both "signal" and "subflow" flags
                → try the fix first

        - (the endpoint could be picked when an ADD_ADDR is received,
depending on the routing, but's there are no checked of the endpoints here)

    - endpoint without neither 'signal' and 'subflow' flags: should we
allow that?:
        - to reserve an ID?:
            - But still, we will need to remove the endpoint and re-add
it to add "signal" or "subflow"
            - It could make "sense" not to announce an address, because
it is known by the other peer, but force an ID for a specific address,
to be "filtered" (LB?)
        - it only makes sense to set the backup flag on the initial subflow
        - → kernel side: maybe easier to refuse no flags → but maybe
there are weird uses: reserving an ID, but not advertising an address?
        - → userspace side: can be use to guide the users, e.g. when
signal and subflow flags are not set.

    - Allow only this?
        - ("signal" or "subflow") + [ "fullmesh" and/or "backup" ]
        - or only "backup"
        → sounds safer *not* to add these restrictions on the kernel
side, just in case there are weird usages

    - Can we backport that?:
        - if it is a fix, definitively yes.
        - new restrictions: for cases we don't support and can bring
bugs: yes ; otherwise (not to have states that don't make sense), maybe
(to help the users), with a delay, but probably best to avoid



Next meeting:
    - Next one on Wednesday, the 19th of June.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240619



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

