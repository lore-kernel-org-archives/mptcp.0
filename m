Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7E1D63F2
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395884; cv=none; b=PCuOCu3Fb0Dc3LSmBzXiG5L9Ucm+5sZYDmU0uw4yzEZgj0vithmWMVj16Occ/qVeJ3A1TcY/JWXOvbGKIUODg0rMFIkL++ayKsOJgYVjivuABq8dTEAtYQMU5S4Nd/HvrHnyfx3fIgmqAooGyCgoQv8gd7L2VqNL7ZbRHUQDJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395884; c=relaxed/simple;
	bh=/fL1tuJy1NdVu9UNUS0cftz+VQ1e28YDNT6mBKfj6ok=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Cc0qrxN7RZWXooRqoWpQ8GDunR147xvfBubsQrCmRaCZS07nCOZN/z0H6WrKY1H1Xi2Dt9wu4ujJgOe+XOcdk46t+su0hyIwkydOMGv6rE+yKVXwUSNbMX8vO8MzOyTXurTcVlE40povXsBzF3CRqLhRbeoBxvdBfMrWrKP7O8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3vRYtnj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3vRYtnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632B8C4CED1
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395884;
	bh=/fL1tuJy1NdVu9UNUS0cftz+VQ1e28YDNT6mBKfj6ok=;
	h=Date:To:From:Subject:From;
	b=F3vRYtnjGEMPlyrO/oFEKFw3++Ry7wssNchJ3CbZUHqhf6gseGEyUvNq7mfjcAK17
	 Z7gzpyF/GiEsNLCU8eIaFyLr839QJopNcLLxA5d/qfvjbtIIq91bt2Lvp9M01/JWDh
	 wQnH8YJfPuhbEptpYZNuTpedARnOCJ1a6yD0mrZk71htaanMJP/hggh3gvC5TU/R3c
	 RP2y6stR0OTVA6lEfTI30Ja3eeVDbcmuSwc3lFdfbQmqQr4BdBVe67sz3yyi/oac6z
	 rdfnU/ziMw3xMwcV0EvoUGq3USsjBeo+6RfNWh38yGRqYRB356tzSZjpHOOIWki9F6
	 WoH0yJ7T9Wazw==
Message-ID: <9afb4c78-f13f-410f-a532-8a57499ff3cd@kernel.org>
Date: Thu, 5 Dec 2024 11:51:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 4th of December 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Yunsheng Lin):

13875089: [net-next,v1,09/10] net: replace page_frag with page_frag_cache:

13884930: [6.6.y] mptcp: fix possible integer overflow in
mptcp_reset_tout_timer:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241125140450.3752859-2-matttbe@kernel.org/
    - backport: applied but not released yet.

13884931: [6.1.y] mptcp: fix possible integer overflow in
mptcp_reset_tout_timer:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241125140524.3753666-2-matttbe@kernel.org/
    - backport: applied but not released yet.


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts, Paolo
Abeni):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
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
    - status: same

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
    - status: same

13845402: [mptcp-next,v2,29/36] mptcp: define struct mptcp_pm_ops
13845403: [mptcp-next,v2,30/36] mptcp: implement userspace pm interfaces
13845404: [mptcp-next,v2,31/36] mptcp: register default userspace pm
13845405: [mptcp-next,v2,32/36] bpf: Add mptcp path manager struct_ops
13845406: [mptcp-next,v2,33/36] bpf: Register mptcp struct_ops kfunc set
13845407: [mptcp-next,v2,34/36] Squash to "bpf: Export mptcp packet
scheduler helpers"
13845408: [mptcp-next,v2,35/36] selftests/bpf: Add mptcp userspace pm
subtest
13845409: [mptcp-next,v2,36/36] selftests/bpf: Add mptcp bpf path
manager subtest:
    - State: Under review
    - Series: BPF path manager
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901761&state=*&archive=both
    - status: same

13855939: [mptcp-next,v9,01/13] mptcp: check sk_stream_memory_free in loop
13855940: [mptcp-next,v9,02/13] mptcp: make mptcp_subflow_set_scheduled
inline
13855941: [mptcp-next,v9,03/13] mptcp: add mptcp_validate_scheduler helper
13855942: [mptcp-next,v9,04/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
13855943: [mptcp-next,v9,05/13] Squash to "selftests/bpf: Add bpf
scheduler test"
13855944: [mptcp-next,v9,06/13] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13855945: [mptcp-next,v9,07/13] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13855946: [mptcp-next,v9,08/13] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13855947: [mptcp-next,v9,09/13] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13855948: [mptcp-next,v9,10/13] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13855949: [mptcp-next,v9,11/13] Squash to "bpf: Export mptcp packet
scheduler helpers"
13855950: [mptcp-next,v9,12/13] Revert "mptcp: add sched_data helpers"
13855951: [mptcp-next,v9,13/13] mptcp: drop subflow contexts in
mptcp_sched_data:
    - State: Changes requested
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=904507&state=*&archive=both
    - status: same

13865804: [mptcp-next,v3,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13865805: [mptcp-next,v3,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13865806: [mptcp-next,v3,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13865807: [mptcp-next,v3,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13865808: [mptcp-next,v3,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: Needs ack
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907195&state=*&archive=both
    - status: same

13865898: [mptcp-next,v3,1/9] mptcp: add mptcp_userspace_pm_lookup_addr
helper
13865899: [mptcp-next,v3,2/9] mptcp: add
mptcp_for_each_userspace_pm_addr macro
13865900: [mptcp-next,v3,3/9] mptcp: add mptcp_userspace_pm_get_sock helper
13865901: [mptcp-next,v3,4/9] mptcp: move mptcp_pm_remove_addrs into
pm_userspace
13865902: [mptcp-next,v3,5/9] mptcp: drop free_list for deleting entries
13865904: [mptcp-next,v3,7/9] mptcp: drop struct mptcp_pm_add_entry
13865905: [mptcp-next,v3,8/9] mptcp: change local addr type of
subflow_destroy
13865906: [mptcp-next,v3,9/9] mptcp: drop useless "err = 0" in
subflow_destroy:
    - State: Needs ack
    - Series: BPF path manager, part 1
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907218&state=*&archive=both
    - Matth is looking at this

13868390: [bpf-next/net,1/5] bpf: Register mptcp common kfunc set
13868391: [bpf-next/net,2/5] bpf: Add mptcp_subflow bpf_iter
13868392: [bpf-next/net,3/5] bpf: Acquire and release mptcp socket
13868393: [bpf-next/net,4/5] selftests/bpf: More endpoints for endpoint_init
13868416: [bpf-next/net,5/5] selftests/bpf: Add mptcp_subflow bpf_iter
subtest:
    - State: Changes requested
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907856&state=*&archive=both
    - Geliang is looking at the fixes.

13881593: [mptcp-next,1/8] mptcp: split get_subflow interface into two
13881594: [mptcp-next,2/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13881595: [mptcp-next,3/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13881596: [mptcp-next,4/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13881597: [mptcp-next,5/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13881598: [mptcp-next,6/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13881599: [mptcp-next,7/8] Squash to "bpf: Export mptcp packet scheduler
helpers"
13881600: [mptcp-next,8/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - State: New
    - Series: split get_subflow interface into two
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=911397&state=*&archive=both

13881804: [mptcp-next,v2,1/3] Squash to "bpf: Register mptcp common
kfunc set"
13881805: [mptcp-next,v2,2/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
13881806: [mptcp-next,v2,3/3] Squash to "selftests/bpf: Add
mptcp_subflow bpf_iter subtest":
    - State: Changes requested
    - Series: Squash to "Add mptcp_subflow bpf_iter support"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=911467&state=*&archive=both
    - patch 2:
        - maybe this helper will always be called when the msk is locked
        - but then how to check that the lock is held by the BPF
program? e.g. what if it is held by someone else?
        - or maybe enough to look around sock_owned_by_user_nocheck() or
spin_is_locked(&sk->sk_lock.slock)?
        - Maybe there are flags to add on the KFunc side?

13888905: [mptcp-next-next,1/3] mptcp: consolidate subflow cleanup
13888906: [mptcp-next-next,2/3] mptcp: move the whole rx path under msk
socket lock protection
13888907: [mptcp-next-next,3/3] mptcp: cleanup mem accounting.:
    - State: New
    - Series: mptcp: rx path refactor
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=913372&state=*&archive=both
    - Mat will have a look



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Note: now using a form:
        - because people were writing inside the HTML comments
        - e.g.
https://github.com/multipath-tcp/mptcp_net-next/issues/new?assignees=&labels=bug%2Ctriage&projects=&template=01-bug.yml

    Recently opened (latest from the last meeting: 529):

  530  about mptcp subflow creation question [question] [triage]:
      - old kernel, maybe already fixed

    Recently discussed:

  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill]


    Bugs (opened, flagged as "bug" and assigned)

  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  508  Divide error on device removal [bug] [feedback-needed]
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
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  514  Add MIB counters for fallback to TCP [enhancement] @geliangtang
  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  530  about mptcp subflow creation question [question] [triage]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  515  Add `TCP_MAXSEG` socket option support [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
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
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill]
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
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-11-20)

None.


    Packetdrill PRs

  52  3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  37  23 hours ago  matttbe  pm: various small improvements.:
      - Mat is looking at it


    mptcpd PRs

  316  12 days ago  matttbe  mptcpize: set `GODEBUG=multipathtcp=1` env var
  315  12 days ago  matttbe  mptcpize: do not override existing
LD_PRELOAD value
  314  14 days ago  matttbe  musl compat:
      - For one patch, there are 2 macros copied from GNU libC:
          - That's a macro, I guess it is fine to copy it.
          - If not, we only use it in one place, with one address in
lib, and multiple ones in the tests.
          - Maybe that's enough to hardcode the address in lib. The
tests need further modifications to support musl I think.
      - Maybe Ossama can look at them?



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.13):
https://github.com/orgs/multipath-tcp/projects/12
    - For later: https://github.com/orgs/multipath-tcp/projects/1

    - Changelog has been updated:
        https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [567cd97b6ae3] tcp: check space before adding MPTCP SYN
options (MoYuanhao)

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [1a389f0cdf92] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [c4c17ae24a05] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [0e4c409e45b6] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [e9dc2773d9b1] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [26861b0c664e] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [1038ec52dbc0] mptcp: add sched_data helpers (Geliang Tang)
        - [59555883ee6b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [f2931e1b0f57] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [532e45274bf9] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [73462a99ea7b] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [7a8940070cca] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [9fc9be86aea6] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [8919e27b3fb3] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [c9d7a038bcec] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - @Christoph: is it fixed? :)

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - Same instabilities, but really not easy to reproduce



Next meeting:
    - Next one on Wednesday, *in two weeks*, the 18th of December.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20241218



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday in two weeks,
Matt
-- 
Sponsored by the NGI0 Core fund.

