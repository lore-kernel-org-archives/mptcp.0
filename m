Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3916F8E5
	for <mptcp@lists.linux.dev>; Tue,  3 Jun 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973718; cv=none; b=CII/nDsp/cfEFdTruh6oLQbopqvzvcYcNrgpwnPvfuxlsjxfUYMRgRaC0lH0DYw9wPTMBeFa4FlOavbwQggZqCoVEQSv0U+tgBPDlJyIu/uXvXdlu0S1W2eLyo6pDLMOkb+bGjao57kFdrKo+6S8kXRmwF0am3oD9JgTP4yIdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973718; c=relaxed/simple;
	bh=vAHO4hPhXGKev0i7LMWffriXYaUp/v9xmiB794WBCGo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KHjcIj0EDHCTb9PNB8i0VAETES7yJ5x7Pp14c6ae/x2s9IUEWHlVV5+7cLcCn7f1UpphGkLo8AyUhQ3EY7aUUoypH2oWu6COIUAHFFiK3ywUBlXuwBoiGJkBOZX7aInkE6AjdSG5PlMXJmgZk4QHSJhvlXOqfD1AxCcB4k82Z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB0w5zwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB0w5zwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF5EC4CEED
	for <mptcp@lists.linux.dev>; Tue,  3 Jun 2025 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748973717;
	bh=vAHO4hPhXGKev0i7LMWffriXYaUp/v9xmiB794WBCGo=;
	h=Date:From:To:Subject:From;
	b=bB0w5zwHoAuK0qSdwIg7p67RYzXQrs3WWzyMpQFvRBQOnw258QsONmbfGV3Fje528
	 zOUQj2sXZW6zvYMag749i1Ms3rNimkDBWlcfuUtNnn5CWhMQoTzfRtsq4Q5Zpl1Zq0
	 TgWc/SWfbsCDQw405cdEoEHId1+DCYIAeV1RYpJXkbiwtHpFYEvfe/CTbGh3weqmNT
	 pX9AJO3CHVw2ZiQj+Ty80ljOLT08NdaRRVAVVz/24kdU6JDoKpf/CixVude9tBHXq6
	 GEvZtDcGa6/pDkWACtnof2Is9LHzGAT1lpZ9Mz+A0kN68n2BgWsfwmiOxqOslX7/4E
	 q7heKqL/MULKQ==
Message-ID: <8406b234-0aa8-4382-b9ac-254598d07074@kernel.org>
Date: Tue, 3 Jun 2025 20:01:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 21st of May 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Two weeks ago, we had our new meeting with Mat (Cruise) and myself (NGI0
Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:

Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Hangbin Liu):

14080690: [PATCHv2,net-next,1/6] selftests: net: disable rp_filter after
namespace initialization
14080691: [PATCHv2,net-next,2/6] selftests: net: remove redundant
rp_filter configuration
14080692: [PATCHv2,net-next,3/6] selftests: net: use setup_ns for
bareudp testing
14080693: [PATCHv2,net-next,4/6] selftests: net: use setup_ns for SRv6
tests and remove rp_filter configuration
14080694: [PATCHv2,net-next,5/6] selftests: netfilter: remove rp_filter
configuration
14080695: [PATCHv2,net-next,6/6] selftests: mptcp: remove rp_filter
configuration:
    - Series: selftests: net: configure rp_filter in setup_ns
    - Submitter: Hangbin Liu
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=960799&state=*&archive=both


14084770: [net-next,v4,12/15] mptcp: Use nested-BH locking for hmac_storage:
    - Reviewed by Paolo on netdev


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14024259: [bpf-next/net,v3,1/5] bpf: Register mptcp common kfunc set
14024260: [bpf-next/net,v3,2/5] bpf: Add mptcp_subflow bpf_iter
14024261: [bpf-next/net,v3,3/5] selftests/bpf: More endpoints for
endpoint_init
14024262: [bpf-next/net,v3,4/5] selftests/bpf: Add mptcp_subflow
bpf_iter subtest
14024263: [bpf-next/net,v3,5/5] selftests/bpf: Drop cgroup_fd of
run_mptcpify:
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946008&state=*&archive=both
    - the mptcp_subflow bpf_iter looks OK, but not for the CGroup
sockopt prog type
    - the new selftest is not useful, better to show it with a
struct_ops example (not ready yet)
    - So:
        - we can drop patch 4
        - patch 2 can be adapted: remove CGROUP sockopt prog type,
        - + the fix for trusted arg


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu
Baerts, Sebastian Andrzej Siewior):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
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
    - status: same as before

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
    - status: same as before

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same as before

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm
subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - status: same as before

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop
delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace
dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR
between server and client:
    - State: Queued
    - Series: only remove entry from local_addr_list when sending a
REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - TODO: Mat: check in a VM and do some tests with mptcpd
    - TODO: Matth: check this series

14077448: [mptcp-next,v7,1/5] mptcp: pm: call pm worker handler without
pm lock
14077447: [mptcp-next,v7,2/5] mptcp: pm: add accept_new_subflow() interface
14077449: [mptcp-next,v7,3/5] mptcp: pm: add established() interface
14077450: [mptcp-next,v7,4/5] mptcp: pm: add subflow_established() interface
14077451: [mptcp-next,v7,5/5] mptcp: pm: drop is_userspace in
subflow_check_next:
    - State: Needs ack
    - Series: BPF path manager, part 6
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=959912&state=*&archive=both
    - status: same as before

14093857: [mptcp-next,1/2] Squash to "selftests/bpf: Add mptcp_subflow
bpf_iter subtest"
14093858: [mptcp-next,2/2] Squash to "bpf: Export mptcp packet scheduler
helpers":
    - State: Changes requested
    - Series: Squash to "BPF packet scheduler"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=964483&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 558):

  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]:
      - the WARNING is there because it is strange to be in this case,
but this case is handled.
      - still, would be good to avoid the warning

  559  Adapt `mptcp_rcv_space_adjust()` after the recent TCP
modifications (`tcp: receive side improvements`) [bug] [enhancement]:
      - We should follow what is done in TCP side, an improvement


    Recently discussed:

  555  [syzbot] WARNING in `mptcp_do_fallback` [bug] [syzkaller]:
      - Didn't manage to reproduce it for one month, then one week
after, the bug got reproduced, but without reproducers

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang:
       - See:
https://github.com/multipath-tcp/mptcp_net-next/issues/74#issuecomment-2890266943
       - QDisc kfuncs have a filter to be used only from QDisc ops, and
some kfunc's can only be called from some specific callbacks


    Bugs (opened, flagged as "bug" and assigned)

  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm] @geliangtang
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

  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  559  Adapt `mptcp_rcv_space_adjust()` after the recent TCP
modifications (`tcp: receive side improvements`) [bug] [enhancement]
  555  [syzbot] WARNING in `mptcp_do_fallback` [bug] [syzkaller]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
[selftests] [pm]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
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

  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  556  Implement all required bits to C/R MPTCP connections from
user-space (CRIU) [enhancement]
  552  pm: in-kernel: delay before creating new subflows [enhancement]
  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]
  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each
connection [enhancement] [pm]
  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm]
  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement]
  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
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


    Recently closed (since 2025-05-07)

  560  Regarding the MPTCP Burst Scheduler Issue [question]
  558  [syzkaller] BUG: unable to handle kernel paging request in
`tcp_v6_connect` [bug] [syzkaller]
  557  mptcp stops working after v6.9 -> v6.14 upgrade [question]
  554  Observing significant delays (>30 seconds) on "handover" to
subflow [bug] [pm]
  418  Packet scheduler , Path Manager and Congestion Control [question]


    Packetdrill PRs

  161  13 days ago   geliangtang  packetdrill: validate maxseg sockopt:
      - Some modifications needed there to properly validate the new
feature (and maybe some modifications are needed on the kernel side)

  52   4 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /



    mptcpd PRs: /



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.16):
https://github.com/orgs/multipath-tcp/projects/14
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net: /


    - Fixes for net-next: /


    - Features for net-next:

        - [b0b4e85d1127] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [ed829784d84d] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [db6c1e6ce842] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - Waiting for the pm lock refactoring

        - [2237bb9a9e74] mptcp: sockopt: drop redundant tcp_getsockopt
(Geliang Tang)
        - [3ca69aad9ef0] tcp: add tcp_sock_set_maxseg (Geliang Tang)
        - [3ae6728500af] mptcp: add TCP_MAXSEG sockopt support (Geliang
Tang):
            - Waiting for the test

    - Features for net-next (next): /

    - Features for other trees:

        - [a54b56d82776] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [4aa5490a5ae3] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [5a76bb4657e8] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [030ddb763f1b] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [455e760d99a8] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang):
            - blocked, waiting for a struct_ops (and update needed, see
above)

        - [105c7c693d40] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [f161c5caca76] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [ff0f849359ff] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [65174c010267] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [d2bcac1d357f] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [291178283094] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [542aaf35e532] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [ce6e9a2f66a1] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Matth):
        - Found 2 bugs \o/ but they need to be fixed /o\ (but not urgent)

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Next one on Wednesday, the 4th of June.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250604



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

