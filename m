Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164D2BE03C
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076438; cv=none; b=OS5HdLtFw59FgRFR491badpWO9zhlyfiw+wsclhYscYgSCTOxFP8artlG0OKFRUq/bOOerM9ufX37q3NqyiLZhdDe2yBONSRuvGdgiFDx1Z2MKHq4UQtrFIfm7fgYX7KmCC4IX+6boSzYADYjQMeLa4nbFKHs6oSQCE9JT1S2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076438; c=relaxed/simple;
	bh=t0jnRdsoP7s3ilZhPUHE90dVp/YYjG+3Rhe/fP4AbYw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=QeNV5TVDhzLMxXrzJgf1vKbttX97IYcSDHRU5Ev9eqpmo7o0GDIJy4Lte0O8YDrzOzIqHjkg9nagOmgYmOwytoJdu3z057ZOUr8hAtec8mbViXEfUIdnjRYqz51Ms2XsVEQMOOrnESXt0AAYxaSXei8wRwHmC2gof7bM6d/F95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMAd3p8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMAd3p8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE40C4CEEB
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755076438;
	bh=t0jnRdsoP7s3ilZhPUHE90dVp/YYjG+3Rhe/fP4AbYw=;
	h=Date:From:Subject:To:From;
	b=UMAd3p8PIEmhyv3BfuNoLxYE91SJ3FaiC/QYTBOp/nGmqzvc2Ov3hlsmL7yZa1y+1
	 EBlJQfwz9yZLq2jUX6QyPaqmt2j6G15gY+6QhHtG/T2fZsqZA8FjZ9Ha6PUl67DUGo
	 V1IU6brbdxSRymaYPoo8EjnY1JELlwDyvxVbNEW2btF0KPCm3qjDlbuDRijwvnEXpx
	 FZz2+I8ipUP6J0BKsiM+63v/wIyz82m6jNsNWq9xL2YOW3POqRTxbYkksHRvI9vdwu
	 ZLv/ncwQdGeDTZaq5Nuzss7kpw07hb+k7T/u+hZ+tURQExJoCx8UJLlpJUbKh4eju/
	 VUe+OENG9QvCw==
Message-ID: <537be435-989d-4beb-88a7-ca33deb6b8f2@kernel.org>
Date: Wed, 13 Aug 2025 11:13:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 16th of July 2025
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last month, we had our new meeting with Mat (Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14156269: [net,1/3] mptcp: make fallback action and fallback decision atomic
14156270: [net,2/3] mptcp: plug races between subflow fail and subflow
creation
14156271: [net,3/3] mptcp: reset fallback status gracefully at
disconnect() time:
    - Series: mptcp: fix fallback-related races
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=982156&state=*&archive=both


    our repo (by: Matthieu Baerts, Paolo Abeni):

14148179: [mptcp-net,1/2] selftests: mptcp: connect: also cover alt modes
14148180: [mptcp-net,2/2] selftests: mptcp: connect: also cover checksum:
    - Series: selftests: mptcp: connect: cover alt modes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=980142&state=*&archive=both

14153129: [v4,mptcp-net,1/5] mptcp: make fallback action and fallback
decision atomic
14153128: [v4,mptcp-net,2/5] mptcp: plug races between subflow fail and
subflow creation
14153131: [v4,mptcp-net,3/5] mptcp: reset fallback status gracefully at
disconnect() time
14153132: [v4,mptcp-net,4/5] mptcp: track fallbacks accurately via mibs
14153130: [v4,mptcp-net,5/5] mptcp: remove pr_fallback():
    - Series: mptcp: fix fallback-related races
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=981434&state=*&archive=both

14157428: [mptcp-net,1/2] Squash to "selftests: mptcp: connect: also
cover alt modes"
14157429: [mptcp-net,2/2] Squash to "selftests: mptcp: connect: also
cover checksum":
    - Series: Fixes for "selftests: mptcp: connect: cover alt modes"
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=982450&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14158089: [net,v2,1/2] selftests: mptcp: connect: also cover alt modes
14158090: [net,v2,2/2] selftests: mptcp: connect: also cover checksum:
    - Series: selftests: mptcp: connect: cover alt modes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=982641&state=*&archive=both

14158894: [net-next,1/4] mptcp: sockopt: drop redundant tcp_getsockopt
14158895: [net-next,2/4] tcp: add tcp_sock_set_maxseg
14158896: [net-next,3/4] mptcp: add TCP_MAXSEG sockopt support
14158897: [net-next,4/4] mptcp: fix typo in a comment:
    - Series: mptcp: add TCP_MAXSEG sockopt support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=982905&state=*&archive=both


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu Baerts):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
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

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same as last time

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
    - status: same as last time

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop
delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace
dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR
between server and client:
    - State: Under review
    - Series: only remove entry from local_addr_list when sending a
REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - TODO: Mat & Matth: check this and validate that
    - status: same as last time

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
    - status: same as last time

14102233: [mptcp-next,v3,1/3] selftests/bpf: Add sndbuf for send_recv_data
14102235: [mptcp-next,v3,2/3] Squash to "selftests/bpf: Add bpf
scheduler test"
14102234: [mptcp-next,v3,3/3] DO-NOT-MERGE: selftests/bpf: Increase
total_bytes of bpf sched tests:
    - State: Changes requested
    - Series: send() fails with EAGAIN in blocking IO mode "487
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=967210&state=*&archive=both
    - Next step: Geliang sending a patch with the 2nd approach, and we
can continue the discussions there

14154882: [mptcp-next,v9,1/9] mptcp: add eat_recv_skb helper
14154883: [mptcp-next,v9,2/9] mptcp: implement .read_sock
14154884: [mptcp-next,v9,3/9] tcp: drop release and lock again in
splice_read
14154885: [mptcp-next,v9,4/9] tcp: export splice_state and splice_data_recv
14154886: [mptcp-next,v9,5/9] tcp: add recv_should_stop helper
14154887: [mptcp-next,v9,6/9] mptcp: use recv_should_stop helper
14154888: [mptcp-next,v9,7/9] mptcp: implement .splice_read
14154889: [mptcp-next,v9,8/9] selftests: mptcp: add splice io mode
14154890: [mptcp-next,v9,9/9] selftests: mptcp: connect: cover splice mode:
    - State: New
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=981808&state=*&archive=both
    - It would be nice if Paolo can have a look at the new version



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 570):

  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]:
      - mostly visible on NIPA, needs to be investigated

  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]:
      - mostly seeing this warning with TCP code path, but a few times
with MPTCP

  571  selftests: check new MIB FALLBACK counters [enhancement] [selftests]:
      - to catch unexpected fallback/reset


    Recently discussed:

  566  How to maintain extra subflows for redundancy when client and
server are reversible? [question]:
      - idea is to remove the limitation (signal | fullmesh), validate
that, and that's it.

  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe:
      - we should be able to increase it


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

  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  567  [syzbot] WARNING in `__mark_subflow_endp_available` [bug]
[syzkaller] [reproducer]
  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  559  Adapt `mptcp_rcv_space_adjust()` after the recent TCP
modifications (`tcp: receive side improvements`) [bug] [enhancement]
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

  566  How to maintain extra subflows for redundancy when client and
server are reversible? [question]
  562  [performance] How much is the overhead of MPTCP？ [question] [triage]
  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  571  selftests: check new MIB FALLBACK counters [enhancement] [selftests]
  568  socket option: support `IPV6_TCLASS` [enhancement]
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


    Recently closed (since 2025-07-02)

  573  [selftests] BUG: KASAN: slab-use-after-free in
`tcp_prune_ofo_queue` [bug] [selftests]
  570  [syzkaller] WARNING in `mptcp_incoming_options` [bug] [syzkaller]
  565  Testing Custom Scheduler on Newer Kernel Versions with MPTCP
[question]
  555  [syzbot] WARNING in `mptcp_do_fallback` [bug] [syzkaller]


    Packetdrill PRs

  162  15 days ago   geliangtang  mptcp: add splice test:
      - reviewed, waiting for a new version

  52   6 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcpd PRs: /



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.17):
https://github.com/orgs/multipath-tcp/projects/15
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:
    - Fixes for other trees:


    - Fixes for -net:

        - [2fdfed0048c6] selftests: mptcp: connect: also cover alt modes
(Matthieu Baerts (NGI0))
        - [5d4adeb290c6] selftests: mptcp: connect: also cover checksum
(Matthieu Baerts (NGI0)):
            - delayed: showing existing issues

    - Fixes for net-next:

        - [429da647ab60] tcp: fix UaF in tcp_prune_ofo_queue() (Paolo Abeni)

    - Features for net-next:

        - [d982d8a6b5be] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [8e283ac688e2] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [a31110928dda] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - blocked: waiting for a pm->lock refactoring

        - [c1c545b895ad] mptcp: sockopt: drop redundant tcp_getsockopt
(Geliang Tang)
        - [1825cbef4d6c] tcp: add tcp_sock_set_maxseg (Geliang Tang)
        - [11d27e1ca73c] mptcp: add TCP_MAXSEG sockopt support (Geliang
Tang):
            - sent

        - [3676a2d8b88b] mptcp: fix typos in comments (moyuanhao):
            - sent

        - [52f444d7106e] mptcp: track fallbacks accurately via mibs
(Paolo Abeni)
        - [4916adc15fbb] mptcp: remove pr_fallback() (Paolo Abeni):
            - to be sent, maybe on Friday

    - Features for net-next (next): /

    - Features for other trees:

        - [24bde62c3240] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [a1995d17695f] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [fcfb43d7170e] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [aa1b6be6aae4] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [79fc91a06e79] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [762ad679893e] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [b78e508e18e6] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [c0a5ffa00835] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [7fbcdf33b62f] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [a468bc034d2d] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [e90ce428189d] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - blocked: waiting for a sched API refactoring



Extra tests:
    - news about Syzkaller? (Matth):
        - found some issues, going well

    - Packetdrill (Davide):
        - New tests added for TCP_MAXSEGS
        - One other PR in progress

    - Patchew (Davide):
        - was down for a few days, fixed now

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Next one on Wednesday, the 30th of July.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250730



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.
