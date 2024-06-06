Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833F1870
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671959; cv=none; b=lMOy9aTtBP3m9BVeyxIifw9jlcpnfDrsG6EmtCa2AussCuDcG38+DghIbHEZKM4PmPBgqPrbseCNPnzfpyW1Oh60go1ASmu/2vlAz+0tQ1/8Eqrq4VeLcFHj/0U5qiTna5NrRxPDPX1BwEe+jbze5GVwnyq/1qVQgd+2Z8eCwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671959; c=relaxed/simple;
	bh=UHx+XruTOW35weJJ/rUQjAGtXzfMlhoJX9j+E639Xzg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qOU9XJVSLv0ZuYsTk3Tv9H3dgQp5Qc9iwGiFye89DZjoWVkchEbLus8delU6Kqbj/cJsCChgiKEq8qT3gcu4NWqe4R3y8kSHr41eBWVLfoaWzXWxjMCKyNouSc67Z5/e8xWVnb0E4fBwPwA5LF1Lut+0Szg4q8v+VfQhptKQQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0nAiG/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0nAiG/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA49C3277B
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717671959;
	bh=UHx+XruTOW35weJJ/rUQjAGtXzfMlhoJX9j+E639Xzg=;
	h=Date:To:From:Subject:From;
	b=R0nAiG/+c+VSOWG6mwr/k0twS3BRL6X8NrGCjrrUXvOttcmSYhWPjWUpjynRBko2P
	 ok+hNQL9FBSsM4rCsZSB0yWr5tiCV8qWUiDho5O/4N6jdVeUQrOw3GifibF5e5s0dU
	 suKOjgXDPqKPAS5+AjWkXhXnoPQ+gjExFN8rmPyoximAcVwIjA78WHc8dpPp+xyetg
	 GpSzXvSbo8Ho74WvjMqeDndeMHKp5e1JsfT1+bQoI3IEN3idEkSPtEQV2klb17X2gv
	 H7+0Gp5IWr15EwPAwD7AsJI7ivsMhn+KAAu1m0IcEyje6zGbirplDNhkDm8Cm6XLdP
	 5hRQG4TG3Bq2g==
Message-ID: <b9d12018-79cb-4964-8e2c-5eed851661ed@kernel.org>
Date: Thu, 6 Jun 2024 13:05:56 +0200
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
Subject: [Weekly meetings] MoM - 5th of June 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Christoph (Apple),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Jason Xing):

13683994: [net,v5,1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
13683995: [net,v5,2/2] mptcp: count CLOSE-WAIT sockets for
MPTCP_MIB_CURRESTAB:
      - Series: tcp/mptcp: count CLOSE-WAIT for CurrEstab
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=858351&state=*&archive=both

13680460: [net-next,v3,1/3] doc: mptcp: add missing
'available_schedulers' entry
13680461: [net-next,v3,2/3] doc: mptcp: alphabetical order
13680462: [net-next,v3,3/3] doc: new 'mptcp' page in 'networking':
      - Series: doc: mptcp: new general doc and fixes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=857380&state=*&archive=both
      - Now available online:
https://docs.kernel.org/next/networking/mptcp.html

13680948: [net-next,1/3] tcp: wrap mptcp and decrypted checks into
tcp_skb_can_collapse_rx()
13680950: [net-next,2/3] tcp: add a helper for setting EOR on tail skb
13680951: [net-next,3/3] net: skb: add compatibility warnings to
skb_shift():
      - Series: tcp: refactor skb_cmp_decrypted() checks
      - Submitter: Jakub Kicinski
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=857501&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13675031: [mptcp-next,v6,1/9] selftests: net: lib: set 'i' as local
13675032: [mptcp-next,v6,2/9] selftests: net: lib: support errexit with
busywait
13675033: [mptcp-next,v6,3/9] selftests: net: lib: avoid error removing
empty netns name
13675034: [mptcp-next,v6,4/9] selftests: net: lib: ignore possible error
13675035: [mptcp-next,v6,5/9] selftests: net: lib: remove ns from list
after clean-up
13675036: [mptcp-next,v6,6/9] selftests: net: lib: do not set ns var as
readonly
13675037: [mptcp-next,v6,7/9] selftests: net: lib: remove 'ns' var in
setup_ns
13675038: [mptcp-next,v6,8/9] selftests: mptcp: lib: use
setup/cleanup_ns helpers
13675039: [mptcp-next,v6,9/9] selftests: mptcp: lib: use
wait_local_port_listen helper:
      - Series: use helpers in lib.sh and net_helpers.sh
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856116&state=*&archive=both

13675549: [mptcp-next,v2] mptcp: increment RmAddr MIB counter once per
RM_ADDR:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org/

13681068: [mptcp-next] mailmap: map Geliang's new email address:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/58464660b9d2f74d45c0c91663fd71132749db90.1717119915.git.geliang@kernel.org/

13685500: [mptcp-net] mptcp: ensure snd_una is properly initialized on
connect:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/61aae3730b8c35c2e0b8b70f5f2fe5170067f5c8.1717512099.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Jakub Kicinski,
Matthieu Baerts, Yunsheng Lin):

13659842: [bpf-next,v2,1/2] selftests/bpf: Add mptcp subflow example
13659843: [bpf-next,v2,2/2] selftests/bpf: Add mptcp subflow subtest:
      - Series: selftests/bpf: new MPTCP subflow subtest
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851945&state=*&archive=both
      - waiting for "add netns helpers" to be applied first

13665604: [v2] checkpatch: skip warnings for symbol links:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8e5cdb8e4eb6d964ec3ffe961ab8e65b8788584f.1715815795.git.tanggeliang@kylinos.cn/
      - status: same: maybe it needs to be re-sent? (not urgent anyway)

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
      - v3 is needed, not urgent

13678590: [6.6.y,1/3] mptcp: avoid some duplicate code in socket option
handling
13678591: [6.6.y,2/3] mptcp: cleanup SOL_TCP handling
13678592: [6.6.y,3/3] mptcp: fix full TCP keep-alive support:
      - Series: Backport of "mptcp: fix full TCP keep-alive support"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856924&state=*&archive=both
      - backports: status is the same: waiting from the stable team

13678594: [6.1.y,1/3] mptcp: avoid some duplicate code in socket option
handling
13678595: [6.1.y,2/3] mptcp: cleanup SOL_TCP handling
13678596: [6.1.y,3/3] mptcp: fix full TCP keep-alive support:
      - Series: Backport of "mptcp: fix full TCP keep-alive support"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856925&state=*&archive=both
      - backports: status is the same: waiting from the stable team

13678600: [5.15.y] mptcp: fix full TCP keep-alive support:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240529100130.3375226-2-matttbe@kernel.org/
      - backports: status is the same: waiting from the stable team

13686269: [net-next,1/3] mptcp: use mptcp_win_from_space helper
13686270: [net-next,2/3] mptcp: add mptcp_space_from_win helper
13686271: [net-next,3/3] mptcp: refer to 'MPTCP' socket in comments:
      - Series: mptcp: misc. cleanups
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=858934&state=*&archive=both
      - waiting to be applied

13686457: [net,1/3] selftests: net: lib: support errexit with busywait
13686458: [net,2/3] selftests: net: lib: avoid error removing empty
netns name
13686459: [net,3/3] selftests: net: lib: set 'i' as local:
      - Series: selftests: net: lib: small fixes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=858985&state=*&archive=both
      - waiting to be applied

13686941: [net-next,v6,13/15] net: replace page_frag with page_frag_cache:
    - still OK


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts, YonglongLi):

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
      - status: same

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
      - status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - status: same

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
      - status: same

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
      - State: Changes requested
      - Series: fixes for create_netns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both
      - status: same

13672978: mptcp: update add_addr_accepted and accept_add after subflow
added:
      - State: Changes requested
      - Series: mptcp: update add_addr_accepted and accept_add after
subflow added
      - Submitter: YonglongLi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=855647&state=*&archive=both
      - status: fixing one issue, not all, see below

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
      - status: to be reviewed: not blocking Gregory who will
investigate the alternative discussed last week.



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 494):

/


    Bugs (opened, flagged as "bug" and assigned)

  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [bpf] @geliangtang
      - renamed: not linked to BPF selftests / schedulers

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

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
      - maybe the endpoints in v6 are added too early? e.g. DAD is still
in progress?

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

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


    Recently closed (since 2024-05-29)

  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [0730402405f8] selftests: net: lib: set 'i' as local (Matthieu
Baerts (NGI0))
        - [2495e5090f75] selftests: net: lib: support errexit with
busywait (Matthieu Baerts (NGI0))
        - [dff65b6a26ca] selftests: net: lib: avoid error removing empty
netns name (Matthieu Baerts (NGI0)):
            - sent today

        - [2075a2c9c803] mptcp: increment RmAddr MIB counter once per
RM_ADDR (YonglongLi)
        - [c8b84401068c] mailmap: map Geliang's new email address
(Geliang Tang)
        - [1dffbe08dd6d] mptcp: ensure snd_una is properly initialized
on connect (Paolo Abeni):
            - can be sent by the end of the week?
            - TODO: Matth

    - Fixes for net-next: /

    - Features for net-next:

        - [4fad76929b63] mptcp: use mptcp_win_from_space helper (Geliang
Tang)
        - [78b913315331] mptcp: add mptcp_space_from_win helper (Geliang
Tang)
        - [e658bdfa2bfb] mptcp: refer to 'MPTCP' socket in comments
(Davide Caratti):
            - sent today

        - [c8ab83a1b624] selftests: net: lib: ignore possible error
(Matthieu Baerts (NGI0))
        - [72a922ff4b48] selftests: net: lib: remove ns from list after
clean-up (Matthieu Baerts (NGI0))
        - [3c0e0d479afb] selftests: net: lib: do not set ns var as
readonly (Matthieu Baerts (NGI0))
        - [8045233493fb] selftests: net: lib: remove 'ns' var in
setup_ns (Geliang Tang)
        - [8e9c3b11334d] selftests: mptcp: lib: use setup/cleanup_ns
helpers (Geliang Tang)
        - [c9ec64646e53] selftests: mptcp: lib: use
wait_local_port_listen helper (Geliang Tang):
            - depend on patches sent to -net, not applied yet
            - wait for them to be in net-next, then send

    - Features for net-next (next): /

    - Features for other trees:

        - [16bd30985021] mptcp: add sched_data helpers (Geliang Tang)
        - [27dd337fca7e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [6fa31dc077b0] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [de47c13e8817] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [763e64d9815b] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [835b7947273b] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [1fc26a81a8ec] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [6b5d61cc0d92] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [452e8692f518] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [586550cddc0f] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [c969f2bdd6e7] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [dec7a304cbcc] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [bee2f6a62b6b] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - status: same: wait



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        -

    - Packetdrill (Davide):
        - 2 weeks ago, we said it might be good to re-trigger the failed
packetdrill tests
        - Instead, Matt recently fixed all reported issues that seemed
to be caused by too aggressive retransmissions
        - Here are more fixes to prevent future issues:
https://github.com/multipath-tcp/packetdrill/pull/148
        - @Davide: the PR is a bit big, but the modifications are
similar a bit everywhere: do you need some help to review it?

    - Patchew (Davide):
        - Was not accepting new patches on Monday/Tuesday, fixed now

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - Looks good: hopefully soon there will be only very rare issues
with Packetdrill


in-kernel PM: addresses management:
    - linked to:
        -
https://lore.kernel.org/mptcp/9baca944-9777-445b-8344-d6755c65a509@chinatelecom.cn/T/
        - [PATCH] mptcp: update add_addr_accepted and accept_add after
subflow added

    - currently, when an ADD_ADDR is received, new subflows are
potentially created (depending on the limit), ADD_ADDR are somehow
stored there, in the 'conn_list'

    - limits:
        - if subflows are removed from the list from different reasons
(error, etc. or not added because of an error before: what the patch is
fixing here), we potentially lose the linked address
        - it means: the add_addr_accepted counter will no longer be
decremented, even after having received a RM_ADDR
        - hard to have the PM creating another subflow

    - idea: storing received ADD_ADDR instead of relying on the conn_list:
        - it would ease this case, but it should also simplify the code
in pm_netlink, no?

    - TODO: Matth: document that in a new ticket: → Done #496
        - note: when this has been designed, Paolo preferred to rely on
the conn_list to store the ADD_ADDR: check with him if it is OK to change

    - linked to that:
        - when a subflow is destroyed, it might be interesting to create
a new subflow (depending on the limits)
        - BUT: we should make sure not to loop: subflow between
addresses (a) and (b) could not be established, maybe best to not
recreate it → storing a bitmap of errors?
        → It is not the first time someone reports that subflows are not
created even if the limits are, according to the number of established
subflows -- not what they can see with ss -M --, not reached.
        → TODO: create ticket: Done #497



Other topics:
    - https://github.com/curl/curl/pull/13278:
        - curl --mptcp is finally coming.



Next meeting:
    - Next one on Wednesday, the 12th of June.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240612



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

