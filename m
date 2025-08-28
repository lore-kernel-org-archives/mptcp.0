Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03930DD25
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378788; cv=none; b=RkdfueLBf+fI28KOc6p33lnpKEwzhsJ93f7ldA3br0KDE902dj7IsF5V/yn28x0QJnPvGNjx74b5nVt5rAXNrkvVAzRpFjg8fnJ7A5+Bvo4hUZeEetRojkuOJ4QNAWI8TKhUnbdoHAVky38o8BRIHZDhuCIUptjERrZC/uR/DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378788; c=relaxed/simple;
	bh=NfUx28QEVlAmTF6OpqVb4fasjEscD0bq5RI2mQDdx3E=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=d1FfsO8nSb7YUamInfBKAwHPKDftMl4Goo1c0o7ZzVj2rsFJaBtae/FL9J8jAAo9+NSOOIsUyxiMe2oH/0mqIOkXSHlaSz/92JRGL9PQDwLaZiVWtonDQibKGiRuis8RLQ49ZkZRxLdmcCqUO87k3TSAh9IPIhuq4Os5BX+69t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpH7b47w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpH7b47w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D6AC4CEF5
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378787;
	bh=NfUx28QEVlAmTF6OpqVb4fasjEscD0bq5RI2mQDdx3E=;
	h=Date:From:To:Subject:From;
	b=tpH7b47wyeJ6jWEdAkSP4E5Op8ecfK4Zvy1RHVK0cVAJ0oYi1//hHo0DPYxR9OI3I
	 HdtIoNsxmBc0/pmy4SAzM7CGa0iBmsDhcY3hV3HC3CxwUiuOVsniqSOQihoaxOH0GF
	 C5mpwJ2xspjC1QZaNSII+x0j++SPRMdoR5LCvmzDhqWumT+eh/iL+LIrSPzoSCeMgg
	 DCTfj7ms0UapNvW8d8ascAtcI5HSiL5EEAj4iP3uB7XVRr+ahjr3FhyADzUR8kM5cx
	 boACYn65sQzxLlnAXIDBZ9+rF9afOcNKSLCOuqROz1HVgSgBPzUtdM5Y0Tzw+YFdSd
	 3ZiXQOVuOSEkw==
Message-ID: <4b5f337a-5dd9-4bec-8e1f-cf12dff83473@kernel.org>
Date: Thu, 28 Aug 2025 12:59:45 +0200
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
Subject: [Weekly meetings] MoM - 13th of August 2025
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


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Eric Biggers, Matthieu Baerts):

14173851: [net] mptcp: use HMAC-SHA256 library instead of open-coded HMAC:
    - Submitter: Eric Biggers
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250731195054.84119-1-ebiggers@kernel.org/

14176011: [mptcp-net,1/2] selftests: mptcp: connect: fix C23 extension
warning
14176012: [mptcp-net,2/2] selftests: mptcp: sockopt: fix C23 extension
warning:
    - Series: selftests: mptcp: connect: fix C23 extension warning
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=987949&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Kuniyuki Iwashima, Matthieu Baerts):

14170814: [6.1.y,1/3] mptcp: make fallback action and fallback decision
atomic
14170813: [6.1.y,2/3] mptcp: plug races between subflow fail and subflow
creation
14170815: [6.1.y,3/3] mptcp: reset fallback status gracefully at
disconnect() time:
    - Series: mptcp: fix recent failed backports (20250721)
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=986428&state=*&archive=both

14172571: [5.15.y,1/3] selftests: mptcp: make sendfile selftest work
14172572: [5.15.y,2/3] selftests: mptcp: connect: also cover alt modes
14172573: [5.15.y,3/3] selftests: mptcp: connect: also cover checksum:
    - Series: mptcp: fix recent failed backports (20250728)
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=987003&state=*&archive=both

14172662: [5.10.y] selftests: mptcp: connect: also cover alt modes:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250730111805.1659125-2-matttbe@kernel.org/

14173483: [5.15.y,1/6] selftests: mptcp: add missing join check
14173484: [5.15.y,2/6] mptcp: fix error mibs accounting
14173485: [5.15.y,3/6] mptcp: introduce MAPPING_BAD_CSUM
14173486: [5.15.y,4/6] selftests: mptcp: Initialize variables to quiet
gcc 12 warnings
14173487: [5.15.y,5/6] mptcp: drop unused sk in mptcp_push_release
14173488: [5.15.y,6/6] mptcp: do not queue data on closed subflows:
    - Series: Old missing backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=987338&state=*&archive=both

14186076: [v3,net-next,01/12] mptcp: Fix up subflow's memcg when
CONFIG_SOCK_CGROUP_DATA=n.
14186077: [v3,net-next,02/12] mptcp: Use tcp_under_memory_pressure() in
mptcp_epollin_ready().
14186078: [v3,net-next,03/12] tcp: Simplify error path in inet_csk_accept().
14186079: [v3,net-next,04/12] net: Call trace_sock_exceed_buf_limit()
for memcg failure with SK_MEM_RECV.
14186080: [v3,net-next,05/12] net: Clean up __sk_mem_raise_allocated().
14186081: [v3,net-next,06/12] net-memcg: Introduce mem_cgroup_from_sk().
14186082: [v3,net-next,07/12] net-memcg: Introduce mem_cgroup_sk_enabled().
14186083: [v3,net-next,08/12] net-memcg: Pass struct sock to
mem_cgroup_sk_(un)?charge().
14186084: [v3,net-next,09/12] net-memcg: Pass struct sock to
mem_cgroup_sk_under_memory_pressure().
14186085: [v3,net-next,10/12] net: Define sk_memcg under CONFIG_MEMCG.
14186086: [v3,net-next,11/12] net-memcg: Store MEMCG_SOCK_ISOLATED in
sk->sk_memcg.
14186087: [v3,net-next,12/12] net-memcg: Decouple controlled memcg from
global protocol memory accounting.:
    - Series: net-memcg: Decouple controlled memcg from
sk->sk_prot->memory_allocated.
    - Submitter: Kuniyuki Iwashima
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=990685&state=*&archive=both


    our repo (by: Christoph Paasch, Gang Yan, Geliang Tang, Gregory
Detal, Harshvardhan Jha, Matthieu Baerts):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - Status: same

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
    - Status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same

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
    - Status: same

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - Status: same

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
    - Status: same

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
    - Status: same

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
    - Status: same

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
    - Status: same

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
14159714: [mptcp-next] Squash to "selftests: mptcp: connect: cover
splice mode":
    - State: Needs ack
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=981808&state=*&archive=both
    - Status: same
    - @Paolo: by chance, can you continue the review on this one please? :)

14161022: [mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec:
    - State: Needs ack
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org/
    - Probably not needed with Geliang's work on the ADD_ADDR timeout

14165759: [mptcp-next,1/7] Add MPTCP support for socket creation
14165760: [mptcp-next,2/7] Add MPTCP server socket creation support
14165761: [mptcp-next,3/7] Add MPTCP client socket creation support
14165762: [mptcp-next,4/7] Add MPTCP support to NioSocketImpl
14165763: [mptcp-next,5/7] Add MPTCP support to ServerSocket class
14165764: [mptcp-next,6/7] Add MPTCP support to Socket class
14165765: [mptcp-next,7/7] Add test cases for MPTCP socket functionality:
    - State: Awaiting upstream
    - Series: Add MPTCP support to Java Networking API
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=984964&state=*&archive=both
    - TODO: @Geliang: did you start the upstreaming work? → v2 is coming

14167004: [mptcp-next] mptcp: remove redundant orig_offset in
carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
    - Best to avoid single patch doing some refactoring

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
    - TODO: Matth: check with Christoph what he prefers to do. → Done

14177421: [mptcp-next] selftests: net: mptcp: add a check for dss fallback:
    - State: Changes requested
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250805092317.103514-1-yangang@kylinos.cn/
    - Best to check on all subtests

14178618: [mptcp-net,1/2] mptcp: pm: kernel: flush: do not reset
ADD_ADDR limit
14178619: [mptcp-net,2/2] selftests: mptcp: pm: check flush doesn't
reset limits:
    - State: New
    - Series: mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=988782&state=*&archive=both
    - To be reviewed

14179259: [mptcp-net,v2,1/3] mptcp: remove duplicate sk_reset_timer call
14179260: [mptcp-net,v2,2/3] mptcp: disable add_addr retransmission when
timeout is 0
14179261: [mptcp-net,v2,3/3] selftests: mptcp: disable add_addr retrans
in endpoint_tests:
    - State: Queued
    - Series: mptcp: disable add_addr retrans
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=988945&state=*&archive=both
    - can be applied to "net"

14179283: BPF selftest: mptcp subtest failing:
    - State: Rejected
    - Series: BPF selftest: mptcp subtest failing
    - Submitter: Harshvardhan Jha
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=988960&state=*&archive=both

14179926: [mptcp-net] mptcp: drop skb if MPTCP skb extension allocation
fails:
    - State: Under Review
    - Submitter: Christoph Paasch
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250807-mptcp_fixes-v1-1-adfd79a88b5e@openai.com/

14179928: [mptcp-next] mptcp: record subflows in RPS table:
    - State: Under Review
    - Submitter: Christoph Paasch
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com/
    - TODO: Matth: or maybe set the RPS when scheduling packets? (but we
might be on another CPU)

14180589: [mptcp-next,v2,1/9] selftests: mptcp: sockopt: use getrandom
for initialization
14180590: [mptcp-next,v2,2/9] selftests: mptcp: sockopt: add protocol
arguments
14180591: [mptcp-next,v2,3/9] selftests: mptcp: sockopt: add inq argument
14180592: [mptcp-next,v2,4/9] selftests: mptcp: sockopt: set TCP_INQ on
accepted sockets
14180593: [mptcp-next,v2,5/9] selftests: mptcp: sockopt: rename pipefd
to ipcfd
14180594: [mptcp-next,v2,6/9] selftests: mptcp: sockopt: add TCP_INQ
client processing
14180595: [mptcp-next,v2,7/9] selftests: mptcp: sockopt: add TCP_INQ
server connection
14180596: [mptcp-next,v2,8/9] selftests: mptcp: sockopt: replace
mptcp_inq with sockopt
14180597: [mptcp-next,v2,9/9] selftests: mptcp: sockopt: remove obsolete
mptcp_inq:
14181836: [mptcp-next] Squash to "selftests: mptcp: sockopt: set TCP_INQ
on accepted sockets":
    - State: New
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=989429&state=*&archive=both

14181837: [mptcp-next,v5,1/8] mptcp: handle TCP_MAXSEG getsockopt in
common case
14181838: [mptcp-next,v5,2/8] mptcp: setsockopt support for TCP_MD5SIG
14181839: [mptcp-next,v5,3/8] selftests: mptcp: sockopt: set REUSEADDR
opt helper
14181840: [mptcp-next,v5,4/8] selftests: mptcp: sockopt: add md5 argument
14181841: [mptcp-next,v5,5/8] selftests: mptcp: sockopt: implement
TCP_MD5SIG support
14181842: [mptcp-next,v5,6/8] selftests: mptcp: sockopt: extend MD5
support for TCP_MD5SIG_EXT
14181843: [mptcp-next,v5,7/8] selftests: mptcp: sockopt: handle MD5 in
connection processing
14181844: [mptcp-next,v5,8/8] selftests: mptcp: sockopt: add TCP_MD5SIG
test cases:
    - State: New
    - Series: mptcp: TCP_MD5SIG support
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=989716&state=*&archive=both
    - TODO: Matth will have a look

14181849: [mptcp-next] tcp: md5: remove redundant l3flag variable:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/93d3186f303d1242a0bde737aeda97959c1eb5cc.1754840319.git.tanggeliang@kylinos.cn/
    - To be sent to netdev directly

14185125: [mptcp-next,1/6] mptcp: add helper for setsockopt on first
subflow only
14185126: [mptcp-next,2/6] mptcp: handle SOL_SOCKET options on first
subflow only
14185128: [mptcp-next,3/6] mptcp: refactor IP socket option handling for
first subflow
14185127: [mptcp-next,4/6] mptcp: extract IPv6 socket option handling
for first subflow
14185129: [mptcp-next,5/6] mptcp: handle SOL_TCP options on all subflows
14185130: [mptcp-next,6/6] mptcp: handle IP socket options on all subflows:
    - State: New
    - Series: refactor MPTCP socket option handling
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=990414&state=*&archive=both
    - TODO: Matth: look at that

14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option support
14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket option
support:
    - State: New
    - Series: mptcp: add more sockopts
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
    - TODO: Matth: look at that

14185293: [mptcp-next,v4,1/2] mptcp: make ADD_ADDR retransmission
timeout adaptive
14185294: [mptcp-next,v4,2/2] selftests: mptcp: remove add_addr_timeout
settings:
    - State: New
    - Series: mptcp: improve ADD_ADDR timeout handling
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=990438&state=*&archive=both
    - TODO: Matth: look at that



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 574):

  581  Default scheduler under-utilizes newly restored subflows on
long-lived flows after WAN failback; needs penalize/probe/stale
integration (related to #345, #348, #349) [bug] [triage]:
      - To be checked, but it seems to just point to tickets that are
already there for a while

  579  "ip mptcp endpoint flush" sets add_addr_accepted to 0 [bug] @matttbe:
      - Linked to patches above

  578  sockopt: support `SO_MAX_PACING_RATE` to limit the whole MPTCP
connection [enhancement]:
      - Linked to patches above

  577  MPTCP fails to establish subflows over more than 2 networks [bug]
[triage]:
      - special case, maybe the client was not listening?
      - TODO: Matth: check status → Done, but no replies so far


    Recently discussed:

  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]:
      - TODO: Matth: check with Paolo → WIP

  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]:
      - new debug added

  571  selftests: check new MIB FALLBACK counters [enhancement] [selftests]:
      - linked to patches above

  568  socket option: support `IPV6_TCLASS` [enhancement] @geliangtang:
      - linked to patches above


    Bugs (opened, flagged as "bug" and assigned)

  579  "ip mptcp endpoint flush" sets add_addr_accepted to 0 [bug] @matttbe
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

  581  Default scheduler under-utilizes newly restored subflows on
long-lived flows after WAN failback; needs penalize/probe/stale
integration (related to #345, #348, #349) [bug] [triage]
  577  MPTCP fails to establish subflows over more than 2 networks [bug]
[triage]
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

  576  ADD_ADDR: more reactive ADD_ADDR retransmit [enhancement]
@geliangtang
  568  socket option: support `IPV6_TCLASS` [enhancement] @geliangtang
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

  578  sockopt: support `SO_MAX_PACING_RATE` to limit the whole MPTCP
connection [enhancement]
  571  selftests: check new MIB FALLBACK counters [enhancement] [selftests]
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


    Recently closed (since 2025-07-30)

  580  Mptcp out-of-tree v0.96 working with bbr problem [question] [triage]
  564  Types of Schedulers available [question] @matttbe
  514  Add MIB counters for fallback to TCP [enhancement] @geliangtang


    Packetdrill PRs

  162  1 month ago   geliangtang  mptcp: add splice test
  52   6 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /

    mptcpd PRs: /



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.18):
https://github.com/orgs/multipath-tcp/projects/16
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: changelog + project → Done



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [57e35cef8458] selftests: mptcp: connect: fix C23 extension
warning (Matthieu Baerts (NGI0))
        - [fb925ae74e1d] selftests: mptcp: sockopt: fix C23 extension
warning (Matthieu Baerts (NGI0))

    - Fixes for net-next: /


    - Features for net-next:

        - [8ae76f91eeee] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [8143aa6bed5d] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [a337485813cd] mptcp: pm: add get_priority() interface
(Geliang Tang)
        - [4998536d53e6] mptcp: use HMAC-SHA256 library instead of
open-coded HMAC (Eric Biggers)

    - Features for net-next (next):


    - Features for other trees:

        - [fa82238d4fbd] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [2818a3166514] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [12060bd7b833] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [375251cbbe14] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [0265e6683e16] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [0385236fb319] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [fd27a83dedb6] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [4b8304b02c69] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [56a0725bee9d] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [3b0e73080364] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [24cc27953284] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Matth):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - issues: mptcp_connect.sh
        - fix: code coverage was broken



Next meeting:
    - Next one on Wednesday, the 27th of August.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250827



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

