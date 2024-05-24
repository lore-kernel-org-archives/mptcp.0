Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0E12E1CA
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566142; cv=none; b=vA0qKrT4FL4XRNHAHwC/4KCcZB5NFSNf17oFvv8HN6/cPn3knSjlIIKYTopzKFfqBfTAsSUJotmRkyqc68q9KqhWCo+b0j7gvqbhOuXQuTVq7X3yw2laYKUvBbJgKxmKi62oYN3RafJagQ3aljq2ejvwQ2Ojghiqyx1bRAhlevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566142; c=relaxed/simple;
	bh=l9UB2cVRhvrMcZIc+cJxhlmTo3P0jR2jy3mGUqkAxiU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=G6i+A/iV8Es06FWWaWEjJFmV3qoDZMdpnZmfHS+KYqqHSycJX1znVzuc0cAr8xzi+GCaebF0W00gzlgk/MAvXUgNnaPlrUFP82f08yXfc/0K/BtG1396Fo+UihzEiAj/UGH28xJMRq9Imc4Wh4cYTPYbV5dX+g6kfy1YRQHYiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOX71SIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOX71SIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921DFC2BBFC
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716566142;
	bh=l9UB2cVRhvrMcZIc+cJxhlmTo3P0jR2jy3mGUqkAxiU=;
	h=Date:From:Subject:To:From;
	b=IOX71SIoGDfsYoEYIvsZ0oSD1HtAPgaZajmt+XOIR2Hg4ljWi48AGRDGo9mp/YWfy
	 QkcZGoz/CV3IsbgUv2OmBcAZWOkhkSKBK8xpdzeM5O5Xuy9z8On8YjHQwGJRuKZ+ic
	 H8ulME5tUzQSbIDEi1umJgyZR+I5HlEaIPvDeU6NzJi3G6K47/kHrpOkQ/8Z13l+rv
	 4hPAuAXU7NdV4Bp02+TabQeeuf/Y3LEYpF1qsHlHfsxDJRL8Z4oZh8YT8FhTjx/Yvt
	 bfZeHAHbdTl6RENmCpXSABk999nG8lYYJwxtrDkxqKNTa6ghmxQHPoZBa/XqdF6aDd
	 qIQ7rcVdGU8Eg==
Message-ID: <39ce02d3-9409-491d-baec-9788c7d40183@kernel.org>
Date: Fri, 24 May 2024 17:55:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 22nd of May 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Paolo (Redhat), and
myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts (NGI0)):

13662294: [mptcp-next,1/2] mptcp: use mptcp_win_from_space helper
13662295: [mptcp-next,2/2] mptcp: add mptcp_space_from_win helper:
      - Series: convert helpers for win and space
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=852503&state=*&archive=both

13665066: [mptcp-next,v6,1/2] selftests/bpf: Add mptcp pm_nl_ctl link
13665067: [mptcp-next,v6,2/2] Squash to "selftests/bpf: Add mptcp
subflow subtest":
      - Series: patches for new MPTCP subflow subtest
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853374&state=*&archive=both

13665430: [mptcp-next] mptcp: refer to 'MPTCP' socket in comments:
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/829272fc031f542c7a3d8e446eba19ee0f78dffb.1715794371.git.dcaratti@redhat.com/

13667673: [mptcp-next,v2,1/3] doc: mptcp: add missing
'available_schedulers' entry
13667674: [mptcp-next,v2,2/3] doc: mptcp: alphabetical order
13667675: [mptcp-next,v2,3/3] doc: new 'mptcp' page in 'networking':
      - Series: doc: introduce MPTCP global doc
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=854193&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*1


    netdev (if mptcp ML is in cc) (by: Edward Liaw, Geliang Tang,
Matthieu Baerts (NGI0), Yunsheng Lin):

13659842: [bpf-next,v2,1/2] selftests/bpf: Add mptcp subflow example
13659843: [bpf-next,v2,2/2] selftests/bpf: Add mptcp subflow subtest:
      - Series: selftests/bpf: new MPTCP subflow subtest
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851945&state=*&archive=both
      - waiting for the "add netns helpers" to be applied first

13670122: [v5,36/68] selftests/net: Drop define _GNU_SOURCE:
    - replaced by a simpler fix (modifying one line, not 66 patches
everywhere) → Done

13663515: [5.10.y] mptcp: ensure snd_nxt is properly initialized on connect:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240513151717.2733290-2-matttbe@kernel.org/

13665243: [RFC,v4,11/13] net: replace page_frag with page_frag_cache:
    - Reviewed by Mat

13665604: [v2] checkpatch: skip warnings for symbol links:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8e5cdb8e4eb6d964ec3ffe961ab8e65b8788584f.1715815795.git.tanggeliang@kylinos.cn/
      - waiting for checkpatch maintainers' feedback

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
      - waiting for BPF maintainers' feedback

13668121: [net,1/3] doc: mptcp: add missing 'available_schedulers' entry
13668122: [net,2/3] doc: mptcp: alphabetical order
13668123: [net,3/3] doc: new 'mptcp' page in 'networking':
      - Series: doc: mptcp: new general doc and fixes
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=854348&state=*&archive=both
      - cannot go to net (no exception for the doc about existing
features as Matth thought), will need to be resent to net-next


    our repo (by: Edward Liaw, Geliang Tang, Matthieu Baerts, Matthieu
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
      - Skip: same status

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
      - Skip: same status

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - Skip: same status

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
      - Skip: same status

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
      - State: Awaiting upstream
      - Series: fixes for create_netns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both
      - waiting for the "add netns helpers" series to be applied first

13669245: [mptcp-next,1/4] selftests: mptcp: rename ns to ns1 in diag.sh
13669246: [mptcp-next,2/4] selftests: mptcp: use setup_ns helper in lib.sh
13669247: [mptcp-next,3/4] selftests: mptcp: use cleanup_all_ns helper
in lib.sh
13669248: [mptcp-next,4/4] selftests: mptcp: use wait_local_port_listen
helper:
      - State: New
      - Series: use helpers in lib.sh and net_helpers.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=854683&state=*&archive=both
      - Matth is reviewing them → Done

13670735: [mptcp-net,v3,1/4] selftests: mptcp: lib: support flaky subtests
13670736: [mptcp-net,v3,2/4] selftests: mptcp: simult flows: mark
'unbalanced' tests as flaky
13670737: [mptcp-net,v3,3/4] selftests: mptcp: join: mark 'fastclose'
tests as flaky
13670738: [mptcp-net,v3,4/4] selftests: mptcp: join: mark 'fail' tests
as flaky:
      - State: Queued
      - Series: selftests: mptcp: mark unstable subtests as flaky
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=855015&state=*&archive=both
      - TODO: Matth: applied them → Done
      - It might be good to find a solution for the packetdrill tests:
          - restart them and check if they are failing twice in a row?
          - Usually not good to do that, but maybe an exception here for
packetdrill?
          - TODO: Matth → fixes have been sent instead:
            https://github.com/multipath-tcp/packetdrill/pull/140 and +



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 488):

  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]

  490  syzkaller: WARNING in `__inet_accept` [bug] [syzkaller]
[reproducer] [bisected] @pabeni:
      - Paolo already sent a patch to netdev (for -net), modifying TCP.
      - not MPTCP specific
      - the warning conditions have been relaxed

  489  IPv6 Rejoin Subflow:
      - we might need the 'ip mptcp' sequence
      - TODO: check that


    Bugs (opened, flagged as "bug" and assigned)

  490  syzkaller: WARNING in `__inet_accept` [bug] [syzkaller]
[reproducer] [bisected] @pabeni

  487  BPF selftests fails with EAGAIN [bug] [selftests] [bpf] @geliangtang:
      - Geliang bisected the issue and found that it is linked to
'scale_ratio' again:

https://github.com/multipath-tcp/mptcp_net-next/commit/dfa2f0483360d4d6f2324405464c9f281156bd87
       - to be investigated
       - we had to do some adaptations on MPTCP side after thisi patch,
maybe we missed something?
       - It is important to note that in the reproducer that Geliang is
using, no BPF code is used (default scheduler), in a blocking mode, and
EAGAIN is received.
       - TODO check

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

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

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  489  IPv6 Rejoin Subflow
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


    Recently closed (since 2024-05-15)

  479  when using openvpn in tcp with dco, we have a bug [question]




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - Changelog has been updated for v6.10:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees:


    - Fixes for -net:

        - [ea10e32d1bdf] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - TODO: drop it, not having it revealed an issue: Matth:
                - Done:
                    - 788dba6bf7a3: Revert "selftests: mptcp: simult
flows: re-adapt BW"
                    - d16364b20d29: conflict in
t/selftests-mptcp-simult-flows-mark-unbalanced-tests-as-flaky
                    - Results: 47bd276d110b..762c908d20c6 (export-net)
                    - Results: 958cd2318648..552e0e0ec982 (export)

            - TODO: Matth: send them at the end of the week → in progress

        - [92a0551c6ed8] doc: mptcp: add missing 'available_schedulers'
entry (Matthieu Baerts (NGI0))
        - [b01fa14e4472] doc: mptcp: alphabetical order (Matthieu Baerts
(NGI0))
        - [b34759db004a] doc: new 'mptcp' page in 'networking' (Matthieu
Baerts (NGI0)):
            - should be sent to net-next instead

    - Fixes for net-next:


    - Features for net-next:

        - [e1c43ba52943] mptcp: use mptcp_win_from_space helper (Geliang
Tang)
        - [3d93d74c7b88] mptcp: add mptcp_space_from_win helper (Geliang
Tang)
        - [ef05adc5d6b0] mptcp: refer to 'MPTCP' socket in comments
(Davide Caratti):
            - net-next is closed

    - Features for net-next (next):


    - Features for other trees:

        - [454054ff2c78] mptcp: add sched_data helpers (Geliang Tang)
        - [37b58524e7c4] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4940b339ff2d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [8e5d8e427858] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [3944441e17e0] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [be3f6d7bca1b] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [20a955f76624] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [ebe4a4095f49] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [c344c84fc7bf] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [b358b3548f3b] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [01f1c73049ed] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [9d4ad28f14b0] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [2a9ab73cf99e] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - net-next is closed



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



simult flows:
    - the unstable test helped Paolo (with the version from net)
    - patches from a few months ago to avoid EOL blocking don't seem to
be enough (related to Bless algorithm)
    - it looks like we send too much on one subflow, impacting the whole
connection



Next meeting:
    - /!\ Next one on *Tuesday* (*not* Wednesday), the 28th of May.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240528



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on *Tuesday*,
Matt
-- 
Sponsored by the NGI0 Core fund.

