Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E566E2BE
	for <mptcp@lists.linux.dev>; Mon,  1 Jul 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816104; cv=none; b=fnKPY5Xxpo7aEhXl4kQMsyQ1mzjCYaJxNTMkKIDr9fNzNZLj2d8FsbBk62dKqcq9FeWymuhwTfxfMn2L59eKrrlxjJBQggtak/yHp1nKPthG1L3r+2TZSG54oHJjZnJ31EbbPTSZR9/B91MDINMy6FMYbF6V1wANqGqkiZIVqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816104; c=relaxed/simple;
	bh=m2UrKVLODESmyb2xUbDZGYskYCIJdUx4ciZTXx8mlTo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=rn/k2JxO5tV+HL1rhgPes7BiXyF1lUBmyZlmyuaDgsOf39E363jP2bP+shTp5ZTWJCvXcwtCyRdfeXn0my5yhC7/UNEuTs1JtYyYBPuX3/U/HoOLouBfXq25gZ5/1MZapOcHwuNPp2qYCMqKF7VlqcGvzLZmD5tLYIBSs9q/y7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3SAcEGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3SAcEGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E169FC116B1
	for <mptcp@lists.linux.dev>; Mon,  1 Jul 2024 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719816104;
	bh=m2UrKVLODESmyb2xUbDZGYskYCIJdUx4ciZTXx8mlTo=;
	h=Date:From:Subject:To:From;
	b=O3SAcEGgXs1OPiNHHeWdZN+rxVtmN4hAsEZ8gZL3B4TDI8QYPNxpagSUcnRiQ5UvD
	 55rHfSpXhwJMUiodufcmHrOVfcFf0wVl21aYMprkR0Qz/veuOPoxqlMwA7nt6BURW9
	 fS43m1JJZRtrFZ4eIXzFJhcTO8Z0TvRlrW0nCJ1E+xkXZjcRwyhrTbDcKZEVpwflXr
	 TXjx+It1SfUHJV2PmEPEuwGWL7RS11c2zy4B/alLAmbat8f02sGvc9kqlHL2wYEKp1
	 bur0VWEX5QA2oWg/ej0JGGeWv79b8rGD0LTH9+jaAhivC/w11M22S2ng93aCnQcDxz
	 +gchD2+TEQg+w==
Message-ID: <f65d4b8b-f3d9-4b7a-8cd9-f8bfd019fa47@kernel.org>
Date: Mon, 1 Jul 2024 08:41:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 26th of June 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts (NGI0)):

13698975: [net] selftests: mptcp: userspace_pm: fixed subtest names:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org/

13702040: [6.1.y] mptcp: pm: update add_addr counters after connect:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240618100543.347011-2-matttbe@kernel.org/

13702115: [5.15.y] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240618105651.469961-2-matttbe@kernel.org/

13702116: [5.15.y] mptcp: pm: update add_addr counters after connect:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240618105750.471201-2-matttbe@kernel.org/

13702189: [5.10.y] mptcp: ensure snd_una is properly initialized on connect:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240618122444.640369-2-matttbe@kernel.org/

13702190: [5.10.y] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240618122511.640963-2-matttbe@kernel.org/

13702191: [5.10.y] mptcp: pm: update add_addr counters after connect:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240618122531.641433-2-matttbe@kernel.org/


    our repo (by: Matthieu Baerts (NGI0)):

13698969: [mptcp-net] selftests: mptcp: userspace_pm: fixed subtest names:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-b5cb8274627d@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts
(NGI0), Yunsheng Lin):

13659842: [bpf-next,v2,1/2] selftests/bpf: Add mptcp subflow example
13659843: [bpf-next,v2,2/2] selftests/bpf: Add mptcp subflow subtest:
      - Series: selftests/bpf: new MPTCP subflow subtest
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851945&state=*&archive=both

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

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/

13700621: [net-next,v8,11/13] net: replace page_frag with page_frag_cache
13711215: [net-next,v9,11/13] net: replace page_frag with page_frag_cache

13711610: [6.6.y,1/2] selftests: mptcp: print_test out of
verify_listener_events
13711611: [6.6.y,2/2] selftests: mptcp: userspace_pm: fixed subtest names:
      - State: New
      - Series: Backport of "selftests: mptcp: userspace_pm: fixed
subtest names"
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=865413&state=*&archive=both


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

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
      - State: Changes requested
      - Series: fixes for create_netns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both

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

13687445: [mptcp-iproute,1/4] man: mptcp: document 'dev IFNAME'
13687446: [mptcp-iproute,2/4] man: mptcp: clarify 'signal' and 'subflow'
flags
13687447: [mptcp-iproute,3/4] mptcp: warn if 'signal' and 'subflow'
flags are set
13687448: [mptcp-iproute,4/4] mptcp: warn if 'signal' or 'subflow' flag
is not set:
      - State: Changes requested
      - Series: mptcp: guide the user to avoid mistakes
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=859237&state=*&archive=both
      - we can drop patches 3 and 4/4, maybe we still need a warning
when 'fullmesh' is not set with 'subflow', TODO Matth

13707351: [mptcp-next,1/4] mptcp: fully established after ADD_ADDR echo
on MPJ
13707352: [mptcp-next,2/4] mptcp: split id_avail_bitmap per target:
    - when we remove a subflow, the Id was used either for Signal or
Subflow.
13707353: [mptcp-next,3/4] selftests: mptcp: join: ability to invert
ADD_ADDR check
13707354: [mptcp-next,4/4] selftests: mptcp: join: test both signal &
subflow:
      - State: Changes requested
      - Series: mptcp: fix endpoints with 'signal' and 'subflow' flags
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=864250&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 499):

  505  Subflows won't be used when the interface for the main flow is a
subinterface
  504  [Question] Bi-directional MPTCP (signal endpoints on both ends):
      - TODO: to be checked

  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [pm]:
      - For the moment, we cannot easily force which endpoint will be
used for to established new subflows when ADD_ADDR are received: the
routing table is used.
      - UC: using one subflow per address, e.g. both the client and
server have 2 addresses: A, B and A', B', we want A-A' and B-B' subflows

  502  Question for ip-mptcp command [question]
  501  Why do endpoint tcp connections close? [bug]
  500  cleanup rbuf bug [bug]:
      - TODO: to be checked


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

  501  Why do endpoint tcp connections close? [bug]
  500  cleanup rbuf bug [bug]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
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

  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  505  Subflows won't be used when the interface for the main flow is a
subinterface
  504  [Question] Bi-directional MPTCP (signal endpoints on both ends)
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [pm]
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


    Recently closed (since 20240612)

None.


    Packetdrill PRs

  52  2 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  14  1 day ago   matttbe  contributing: add missing refs
  12  5 days ago  matttbe  New dedicated PM page, with a new "Behavior"
section
  11  6 days ago  matttbe  setup: limits: for who and defaults:
      - Matth will look at that




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:


    - Fixes for -net:


    - Fixes for net-next:


    - Features for net-next:


    - Features for net-next (next):


    - Features for other trees:

        - [9d44538d2c32] mptcp: add sched_data helpers (Geliang Tang)
        - [681035d2b049] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [d5c7de0dec33] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [349a1ca2cc18] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski):
            - Waiting for Geliang's v3 on a conflicting change (netns)
        - [7e2e3092f992] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [16cc0b7612ed] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [9050729e9a8b] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [3b1a392b7eed] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [d76999195ac8] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [83e166415049] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [320103c42684] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [e274913bc090] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [c48ca063354e] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - Waiting for refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - /



Next meeting:
    - Next one on Wednesday, the 3rd of July.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240703



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

