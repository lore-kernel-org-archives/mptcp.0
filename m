Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27E2D0C71
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076463; cv=none; b=iFqK7wEjL/9cTg7kQEOAvKjOsrOjZiopkbclgKlH0kOOvKhuPbb8e/Nr5HHDNaPxdvnCtIRrxbkVcLhR14QzEFMa0+KcajEAeivtNsdUWWnddLf7xLiVNuK7d9cbeu6+Ywgz/SqeBwF+llksSoRS+N2xYnd0HebgCvKgN4mU43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076463; c=relaxed/simple;
	bh=SSNrjJ7xQ4ZfgWgId6KS7+IxWc0QJ0262puSpBRWDB4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Wt2tsSdn7vI41zfQMl1Bot2Vpvpf4auCAM8gEGi1XM37oQE0EK+vU9EZtL6TqjVY0Cql+amIYVsrwMxchyh6bE/YKIPNaIfWuxXUKGsdyiE51MJ8W1nsq2fnMgvNwqogLh2a8VZzJ1Sej0UImldjxZNdhe/HTFpE+jRbsoIggqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9iUHvNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9iUHvNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16CBC4CEEB
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755076463;
	bh=SSNrjJ7xQ4ZfgWgId6KS7+IxWc0QJ0262puSpBRWDB4=;
	h=Date:From:Subject:To:From;
	b=q9iUHvNdEmno1o21oDuUtMuaSHhvaHi+VJBHxnkdOk6lEgwOe+y6IFcv4syWUk7y1
	 jD6DNsXDVQxoPWftWVX9Q0Vf+UjnfOIOQykf1J3nr9Q9Pms3afRFyrqt977Nom0enW
	 Fq6hjTIxrkUMN9aNEkuGVW9dd4A2jbskTfUL5ATyGe3R/6HRmlyAl3I1rxQAw+X9Qr
	 FtSkiFaz3dxctrV5nGnK57G8dyqsikoEbPIsjM5EPdfj1A80qonwctzxHKwG2j7Yr4
	 x/fUtzYmW++bVgdb2/D0qhBAuUt/oDOAho8c9exbtmrnBDLnMw0JyGu69OTFsvA5Md
	 xKAdtlEMegLmQ==
Message-ID: <6db262e6-1d0b-4d51-a8cb-15b5dc0bcb08@kernel.org>
Date: Wed, 13 Aug 2025 11:14:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 30th of July 2025
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Two weeks ago, we had our new meeting with Mat (Cruise), Cheng C, and
myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts (NGI0)):

14158089: [net,v2,1/2] selftests: mptcp: connect: also cover alt modes
14158090: [net,v2,2/2] selftests: mptcp: connect: also cover checksum:
    - Series: selftests: mptcp: connect: cover alt modes
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=982641&state=*&archive=both

14162163: [net-next,v2,1/4] mptcp: sockopt: drop redundant tcp_getsockopt
14162164: [net-next,v2,2/4] tcp: add tcp_sock_set_maxseg
14162165: [net-next,v2,3/4] mptcp: add TCP_MAXSEG sockopt support
14162166: [net-next,v2,4/4] mptcp: fix typo in a comment:
    - Series: mptcp: add TCP_MAXSEG sockopt support
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=983896&state=*&archive=both

14166401: [net-next,1/2] mptcp: track fallbacks accurately via mibs
14166402: [net-next,2/2] mptcp: remove pr_fallback():
    - Series: mptcp: track more fallback cases
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=985164&state=*&archive=both

14170525: [6.6.y,1/3] mptcp: make fallback action and fallback decision
atomic
14170526: [6.6.y,2/3] mptcp: plug races between subflow fail and subflow
creation
14170527: [6.6.y,3/3] mptcp: reset fallback status gracefully at
disconnect() time:
    - Series: mptcp: fix recent failed backports (20250721)
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=986354&state=*&archive=both


    our repo (by: Geliang Tang):

14159713: [mptcp-next] Squash to "tcp: add tcp_sock_set_maxseg":
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/a1dd4d6e5774b37769645f1b415b2e843822e2b4.1752716203.git.tanggeliang@kylinos.cn/

14159715: [mptcp-next] Squash to "mptcp: add TCP_MAXSEG sockopt support":
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/ba6be90c7ee54384bc8e3ee5b35e3b0166d03aff.1752717857.git.tanggeliang@kylinos.cn/


14172662: [5.10.y] selftests: mptcp: connect: also cover alt modes:
    - State: New
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250730111805.1659125-2-matttbe@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Kuniyuki Iwashima, Matthieu
Baerts (NGI0)):

14164176: [v1,net-next,01/13] mptcp: Fix up subflow's memcg when
CONFIG_SOCK_CGROUP_DATA=n.
14164177: [v1,net-next,02/13] mptcp: Use tcp_under_memory_pressure() in
mptcp_epollin_ready().
14164178: [v1,net-next,03/13] tcp: Simplify error path in inet_csk_accept().
14164179: [v1,net-next,04/13] net: Call trace_sock_exceed_buf_limit()
for memcg failure with SK_MEM_RECV.
14164180: [v1,net-next,05/13] net: Clean up __sk_mem_raise_allocated().
14164181: [v1,net-next,06/13] net-memcg: Introduce mem_cgroup_from_sk().
14164182: [v1,net-next,07/13] net-memcg: Introduce mem_cgroup_sk_enabled().
14164184: [v1,net-next,08/13] net-memcg: Pass struct sock to
mem_cgroup_sk_(un)?charge().
14164183: [v1,net-next,09/13] net-memcg: Pass struct sock to
mem_cgroup_sk_under_memory_pressure().
14164185: [v1,net-next,10/13] net: Define sk_memcg under CONFIG_MEMCG.
14164186: [v1,net-next,11/13] net-memcg: Add memory.socket_isolated knob.
14164187: [v1,net-next,12/13] net-memcg: Store memcg->socket_isolated in
sk->sk_memcg.
14164188: [v1,net-next,13/13] net-memcg: Allow decoupling memcg from
global protocol memory accounting.:
    - Series: net-memcg: Allow decoupling memcg from
sk->sk_prot->memory_allocated.
    - Submitter: Kuniyuki Iwashima
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=984458&state=*&archive=both

14170814: [6.1.y,1/3] mptcp: make fallback action and fallback decision
atomic
14170813: [6.1.y,2/3] mptcp: plug races between subflow fail and subflow
creation
14170815: [6.1.y,3/3] mptcp: reset fallback status gracefully at
disconnect() time:
    - Series: mptcp: fix recent failed backports (20250721)
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=986428&state=*&archive=both

14172571: [5.15.y,1/3] selftests: mptcp: make sendfile selftest work
14172572: [5.15.y,2/3] selftests: mptcp: connect: also cover alt modes
14172573: [5.15.y,3/3] selftests: mptcp: connect: also cover checksum:
    - Series: mptcp: fix recent failed backports (20250728)
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=987003&state=*&archive=both


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu
Baerts, Matthieu Baerts (NGI0)):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
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

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both

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
    - State: Needs ack
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=981808&state=*&archive=both

14159714: [mptcp-next] Squash to "selftests: mptcp: connect: cover
splice mode":
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/066b5d2e87f454a33d4fdf01b76ee64ae4002436.1752716264.git.tanggeliang@kylinos.cn/

14161022: [mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec:
    - State: New
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org/

14165759: [mptcp-next,1/7] Add MPTCP support for socket creation
14165760: [mptcp-next,2/7] Add MPTCP server socket creation support
14165761: [mptcp-next,3/7] Add MPTCP client socket creation support
14165762: [mptcp-next,4/7] Add MPTCP support to NioSocketImpl
14165763: [mptcp-next,5/7] Add MPTCP support to ServerSocket class
14165764: [mptcp-next,6/7] Add MPTCP support to Socket class
14165765: [mptcp-next,7/7] Add test cases for MPTCP socket functionality:
    - State: New
    - Series: Add MPTCP support to Java Networking API
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=984964&state=*&archive=both

14167004: [mptcp-next] mptcp: remove redundant orig_offset in
carve_data_frag:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/

14171536: [mptcp-next,1/3] mptcp: rename add_addr_timeout to
add_addr_timeout_max
14171537: [mptcp-next,2/3] mptcp: make ADD_ADDR timeout adaptive to
subflow RTT
14171538: [mptcp-next,3/3] selftests: mptcp: update for
add_addr_timeout_max rename:
    - State: Changes requested
    - Series: mptcp: improve ADD_ADDR timeout handling
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=986638&state=*&archive=both

14172390: [mptcp-next,1/3] mptcp: Handle TCP_MAXSEG getsockopt in common
case
14172391: [mptcp-next,2/3] mptcp: setsockopt support for TCP_MD5SIG
14172392: [mptcp-next,3/3] selftests: mptcp: add TCP_MD5SIG tests in
sockopt:
    - State: Changes requested
    - Series: mptcp: TCP_MD5SIG support
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=986936&state=*&archive=both





Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 574):

  576  ADD_ADDR: more reactive ADD_ADDR retransmit [enhancement]
@geliangtang
     - Instead of waiting 2 min

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for
transparent integrations [bug] @geliangtang:
     - Useful when MPTCP is used by default.


     Recently discussed:

  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]:
     - Hard to reproduce

  566  pm: use `signal` + `subflow` + `fullmesh` [enhancement] [pm]:
     - Needs to be validated

  562  [performance] How much is the overhead of MPTCP？ [question] [triage]
     - To check

  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
     - To be looked at


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for
transparent integrations [bug] @geliangtang
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

  576  ADD_ADDR: more reactive ADD_ADDR retransmit [enhancement]
@geliangtang
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

  562  [performance] How much is the overhead of MPTCP？ [question] [triage]
  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  571  selftests: check new MIB FALLBACK counters [enhancement] [selftests]
  568  socket option: support `IPV6_TCLASS` [enhancement]
  566  pm: use `signal` + `subflow` + `fullmesh` [enhancement] [pm]
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


    Recently closed (since 2025-07-16)

  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]
  573  [selftests] BUG: KASAN: slab-use-after-free in
`tcp_prune_ofo_queue` [bug] [selftests]


    Packetdrill PRs

  163  2 days ago    matttbe      mptcp: sockopts: maxseg: more delay to
inject pkts
     - can be applied

  162  29 days ago   geliangtang  mptcp: add splice test
     - reviewed: waiting for a new version

  52   6 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs

/

    mptcpd PRs

/



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.17):
https://github.com/orgs/multipath-tcp/projects/15
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net: /


    - Fixes for net-next: /


    - Features for net-next:

        - [c7ef5ff8c3f2] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [7cc0f3c7cf7f] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [abc27729083e] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - net-next is closed

    - Features for net-next (next): /


    - Features for other trees:

        - [82134e1ac8b9] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [3c35d8b1b45a] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [3d9d5a3433f2] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [53cc51f0c655] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [47f684a3603b] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [6c44feaf097f] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [47dd95a5842b] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [0a4866ae78ac] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [0ac1124a421c] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [168df120fe71] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [459833fddaac] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - net-next is closed



Extra tests:
    - news about Syzkaller? (Matth):
        - see opened issues /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - down?

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - /



Next meeting:
    - Next one on Wednesday, the 13th of August.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250813



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.
