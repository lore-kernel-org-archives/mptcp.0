Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730D320A22
	for <mptcp@lists.linux.dev>; Tue, 10 Feb 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742748; cv=none; b=OmWnKNcpHHAyGSZdEuBifi3Qt8bkXp6GEIAlaJFoQ7y1cPzQq8ihAn/2s4p+hAI+PSq0vtNQsaGlcqxhfs2z2Z11A4KGqi5yImHNh/7bHTtetbik6Qd8QNgefvSuplCw0cPFNDuT/mugZSWkO3Nywegd21XleLfuZ7v09iRB4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742748; c=relaxed/simple;
	bh=qbCF6la6pa55E/qyWRmsImDHfo26fHfgZXzCwRrI8cI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=JmY9ehVBN/ARLyZAWc+3R7bC9Kl8vpDID4xvLZzSF3aZld2LPD9Tx8BpxBKJ4Mum6BbW6KRrtVpE/RweGn2BsjJXJMe0mefsSsoioQ/8q2OcXv/bhBh18ohH2QaHDkDeAEqcRUWpu6hrjIbvpk+VdkRgtWjG6hXhrqqkvxr3c7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrySdxV3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrySdxV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFC7C116C6
	for <mptcp@lists.linux.dev>; Tue, 10 Feb 2026 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770742748;
	bh=qbCF6la6pa55E/qyWRmsImDHfo26fHfgZXzCwRrI8cI=;
	h=Date:From:To:Subject:From;
	b=BrySdxV3xTqtrS2C8Hc7WYLCSbZ2X+04nWXRbD0mXQWl0o0pCBtmMaQnIcoZOK4Ql
	 0fc4hETJFadTSvH2zbmpDQ3FsGn35gqGInu/kH/GwQmPrrGbqxbCrhuNwWdA/jpqoS
	 B2hJ5xcySuTHhkoIcQwIrlOGt2j0XpxqaIEzlYTz7t9DVj2Jd8SK8CD1YQwHwZJdsR
	 VznFR+XmL6ecRi11a4AibqzGhbstr9irjzIRhvQRxTE2G/UNiRiHtkESbfkUM/kKgM
	 DPfDwsus6IO2LiATO9oKB6SonKyE+93Y6bSdSeRTjReSx3XtrrgRbR6h3PCpJzOvui
	 G0eM9PlgjbalQ==
Message-ID: <0bd86581-1c61-4a9e-a1ef-bfb5be56efb7@kernel.org>
Date: Tue, 10 Feb 2026 17:59:04 +0100
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
Subject: [Weekly meetings] MoM - 28th of January 2026
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Two weeks ago, we had our new meeting with Mat (Cruise), and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

14397354: [net,v3] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit():
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org/



    our repo (by: Matthieu Baerts (NGI0)):

14345568: [mptcp-next] selftests: mptcp: join: no SKIP mark for group checks:
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org/

14357713: [mptcp-net] selftests: mptcp: join: fix local endp not being tracked:
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251222-sft-5-15-signal-race-test-v1-1-a9b67c49af15@kernel.org/

14399979: [mptcp-net,v2,01/11] mptcp: avoid dup SUB_CLOSED events after disconnect
14399980: [mptcp-net,v2,02/11] selftests: mptcp: check no dup close events after error
14399981: [mptcp-net,v2,03/11] mptcp: only reset subflow errors when propagated
14399982: [mptcp-net,v2,04/11] selftests: mptcp: check subflow errors in close events
14399983: [mptcp-net,v2,05/11] selftests: mptcp: join: wait for estab event instead of MPJ
14399984: [mptcp-net,v2,06/11] selftests: mptcp: join: fix wait_mpj helper
14399985: [mptcp-net,v2,07/11] selftests: mptcp: join: userspace: wait for new events
14399986: [mptcp-net,v2,08/11] selftests: mptcp: join chk_stale_nr: avoid dup stats
14399987: [mptcp-net,v2,09/11] selftests: mptcp: join: avoid declaring i if not used
14399988: [mptcp-net,v2,10/11] selftests: mptcp: connect: fix maybe-uninitialize warn
14399989: [mptcp-net,v2,11/11] selftests: mptcp: connect cleanup TFO setup:
    - Series: mptcp: avoid dup events + error + misc.
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1047262&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts (NGI0), Thomas Weißschuh):

14390237: [net-next,v2,1/4] selftests: net: Move some UAPI header inclusions after libc ones
14390236: [net-next,v2,2/4] selftests/landlock: Move some UAPI header inclusions after libc ones
14390238: [net-next,v2,3/4] samples/bpf: Move some UAPI header inclusions after libc ones
14390239: [net-next,v2,4/4] net: uapi: Provide an UAPI definition of 'struct sockaddr':
    - Series: net: uapi: Provide an UAPI definition of 'struct sockaddr'
    - Submitter: Thomas Weißschuh
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1044679&state=*&archive=both

14401808: [net,1/5] mptcp: avoid dup SUB_CLOSED events after disconnect
14401809: [net,2/5] selftests: mptcp: check no dup close events after error
14401810: [net,3/5] mptcp: only reset subflow errors when propagated
14401811: [net,4/5] selftests: mptcp: check subflow errors in close events
14401812: [net,5/5] selftests: mptcp: join: fix local endp not being tracked:
    - Series: mptcp: avoid dup NL events and propagate error
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1047756&state=*&archive=both


    our repo (by: Christoph Paasch, Gang Yan, GangYan, Geliang Tang, Gregory Detal, Matthieu Baerts, Matthieu Baerts (NGI0)):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - Status: same as last time

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL & IPV6_UNICAST_HOPS:
    - State: Changes requested
    - Series: mptcp: sockopt: uniform code to get/set values
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
    - Status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same as last time

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - Status: same as last time

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - Status: same as last time

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - Status: same as last time

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR between server and client:
    - State: Under review
    - Series: only remove entry from local_addr_list when sending a REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - Status: same as last time

14167004: [mptcp-next] mptcp: remove redundant orig_offset in carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
    - Status: same as last time

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
    - Status: same as last time

14185125: [mptcp-next,1/6] mptcp: add helper for setsockopt on first subflow only
14185126: [mptcp-next,2/6] mptcp: handle SOL_SOCKET options on first subflow only
14185128: [mptcp-next,3/6] mptcp: refactor IP socket option handling for first subflow
14185127: [mptcp-next,4/6] mptcp: extract IPv6 socket option handling for first subflow
14185129: [mptcp-next,5/6] mptcp: handle SOL_TCP options on all subflows
14185130: [mptcp-next,6/6] mptcp: handle IP socket options on all subflows:
    - State: Needs ack
    - Series: refactor MPTCP socket option handling
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=990414&state=*&archive=both
    - Status: same as last time

14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option support
14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket option support:
    - State: Needs ack
    - Series: mptcp: add more sockopts
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
    - Status: same as last time

14197780: [mptcp-next,v2,01/10] selftests: mptcp: sockopt: improve test output clarity
14197781: [mptcp-next,v2,02/10] selftests: mptcp: sockopt: add SO_REUSEADDR test helper
14197782: [mptcp-next,v2,03/10] selftests: mptcp: sockopt: add SO_REUSEPORT test
14197783: [mptcp-next,v2,04/10] selftests: mptcp: sockopt: add SO_BINDTODEVICE test
14197784: [mptcp-next,v2,05/10] selftests: mptcp: sockopt: add SO_BINDTOIFINDEX test
14197785: [mptcp-next,v2,06/10] selftests: mptcp: sockopt: add IP_FREEBIND tests
14197786: [mptcp-next,v2,07/10] selftests: mptcp: sockopt: add IP_TRANSPARENT tests
14197787: [mptcp-next,v2,08/10] selftests: mptcp: sockopt: add IP_BIND_ADDRESS_NO_PORT test
14197788: [mptcp-next,v2,09/10] selftests: mptcp: sockopt: add IP_LOCAL_PORT_RANGE test
14197789: [mptcp-next,v2,10/10] selftests: mptcp: sockopt: add IPV6_V6ONLY test:
    - State: Changes requested
    - Series: selftests: cover more MPTCP socket options
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=993905&state=*&archive=both
    - Status: same as last time

14215849: [mptcp-net,v2,1/3] selftests: mptcp: close server file descriptor
14215850: [mptcp-net,v2,2/3] selftests: mptcp: close IPC descriptor on server side
14229120: [mptcp-next,v4,1/9] selftests: mptcp: sockopt: replace /dev/urandom with getrandom
14229121: [mptcp-next,v4,2/9] selftests: mptcp: sockopt: add protocol arguments
14229122: [mptcp-next,v4,3/9] selftests: mptcp: sockopt: add inq argument
14229123: [mptcp-next,v4,4/9] selftests: mptcp: sockopt: rename pipefd to ipcfd
14229124: [mptcp-next,v4,5/9] selftests: mptcp: sockopt: set TCP_INQ sockopt
14229125: [mptcp-next,v4,6/9] selftests: mptcp: sockopt: handle INQ on server side
14229126: [mptcp-next,v4,7/9] selftests: mptcp: sockopt: handle INQ on client side
14229127: [mptcp-next,v4,8/9] selftests: mptcp: sockopt: replace mptcp_inq with sockopt
14229128: [mptcp-next,v4,9/9] selftests: mptcp: sockopt: remove obsolete mptcp_inq:
    - State: Changes requested
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1001827&state=*&archive=both
    - Status: same as last time

14330153: [RFC,mptcp-next,v2,1/7] mptcp: allow overridden write_space to be invoked
14330154: [RFC,mptcp-next,v2,2/7] mptcp: add sock_set_reuseaddr
14330155: [RFC,mptcp-next,v2,3/7] mptcp: add sock_set_nodelay
14330156: [RFC,mptcp-next,v2,4/7] nvmet-tcp: add mptcp support
14330157: [RFC,mptcp-next,v2,5/7] mptcp: add sock_set_syncnt
14330158: [RFC,mptcp-next,v2,6/7] nvme-tcp: add mptcp support
14330159: [RFC,mptcp-next,v2,7/7] selftests: mptcp: add NVMe-over-MPTCP test:
    - State: Needs ack
    - Series: NVME over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1027779&state=*&archive=both
    - Status: same as last time

14332026: [RFC,mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt:
    - State: Changes requested
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org/
    - Status: same as last time

14332838: [mptcp-net] mptcp: sync the msk->sndbuf at accept() time:
    - State: Changes requested
    - Submitter: GangYan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251128094417.14463-1-gang.yan@linux.dev/
    - Status: same as last time

14346887: [mptcp-next,1/3] tcp: add recv_should_stop helper
14346888: [mptcp-next,2/3] mptcp: use recv_should_stop helper
14346889: [mptcp-next,3/3] tls: use recv_should_stop helper:
    - State: Changes requested
    - Series: add tcp_recv_should_stop helper
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1032825&state=*&archive=both
    - Status: same as last time

14348921: [mptcp-net,1/2] mptcp: pm: in-kernel: always set as unavail when removing addr
14348922: [mptcp-net,2/2] mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr():
    - State: Changes requested
    - Series: mptcp: pm: in-kernel: fix issue 606
    - Submitter: Matthieu Baerts (NGI0)
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1033402&state=*&archive=both
    - Matth will look at a v2

14365754: [mptcp-next,v2,1/3] mptcp: implement psock_update_sk_prot
14365755: [mptcp-next,v2,2/3] mptcp: allow overridden write_space to be invoked
14365756: [mptcp-next,v2,3/3] selftests/bpf: Update sockmap tests for MPTCP:
    - State: Needs ack
    - Series: implement psock_update_sk_prot
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1038151&state=*&archive=both
    - Status: same as last time

14378488: [RFC,mptcp-next,v8,1/9] selftests: mptcp: add tcp tls tests
14378489: [RFC,mptcp-next,v8,2/9] tls: introduce struct tls_prot_ops
14378490: [RFC,mptcp-next,v8,3/9] tls: add ops in tls_context
14378491: [RFC,mptcp-next,v8,4/9] mptcp: allow overridden write_space to be invoked
14378492: [RFC,mptcp-next,v8,5/9] mptcp: update mptcp_check_readable
14378493: [RFC,mptcp-next,v8,6/9] mptcp: implement tls_mptcp_ops
14378494: [RFC,mptcp-next,v8,7/9] mptcp: update ULP getsockopt
14378495: [RFC,mptcp-next,v8,8/9] mptcp: enable TLS setsockopt
14378496: [RFC,mptcp-next,v8,9/9] selftests: mptcp: add mptcp tls tests:
    - State: Needs ack
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1041671&state=*&archive=both
    - Status: same as last time

14382486: [net-next,v2] selftests: tls: use mkstemp instead of open(O_TMPFILE):
    - State: Rejected
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn/



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 610):

/

   Recently discussed:

  610  MPTCP tree in `linux-next` [enhancement]


    Bugs (opened, flagged as "bug" and assigned)

  606  [syzkaller] WARNING in `mptcp_pm_nl_set_flags` [bug] [syzkaller] [reproducer] @matttbe
  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  609  [6.17] soft lockup in `mptcp_sendmsg_frag` [bug]
  608  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow (2)` [bug] [syzkaller]
  607  selftests: `simult_flows`: "unbalanced bwidth with opposed, unbalanced delay" (+ "reverse direction") are unstable [bug] [selftests] [reproducer] [bisected]
  605  [syzkaller]  KASAN: stack-out-of-bounds Read in `mptcp_pm_kernel_get_priority` [bug] [syzkaller]
  600  mptcp: avoid dropping partial packets [bug]
  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]
  592  Lower throughput with MPTCP vs TCP [bug]
  587  in-kernel PM: Server is only using single IP to establish subflows [bug]
  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
  581  Default scheduler under-utilizes newly restored subflows on long-lived flows after WAN failback [bug]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug] [pm]
  492  userspace pm: subflows counter: not updated when a subflows is removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST` are unstable [bug] [selftests]
  483  [6.1] selftests: `mptcp_connect.sh` failures with `copyfd_io_poll: poll timed out` errors [bug] [selftests]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug] [selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]


    In Progress (opened, new feature and assigned)

  568  socket option: support `IPV6_TCLASS` [enhancement] @geliangtang
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support [enhancement] [bpf] @geliangtang
  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill] @dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  602  A query about the update of 'msk->sk_sndbuf' [question]
  562  [performance] How much is the overhead of MPTCP？ [question]


    For later (opened and not assigned)

  610  MPTCP tree in `linux-next` [enhancement]
  590  in-kernel PM: use either `subflow` or `signal` depending on connector/listener app [enhancement]
  588  in-kernel PM: support NUMA awareness [enhancement] [feedback-needed]
  584  [syzkaller] improve coverage [syzkaller]
  578  sockopt: support `SO_MAX_PACING_RATE` to limit the whole MPTCP connection [enhancement]
  566  pm: use `signal` + `subflow` + `fullmesh` [enhancement] [pm]
  556  Implement all required bits to C/R MPTCP connections from user-space (CRIU) [enhancement]
  552  pm: in-kernel: delay before creating new subflows [enhancement]
  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]
  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each connection [enhancement] [pm]
  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  525  tests: cover more MPTCP socket options [enhancement] [packetdrill] [selftests]
  519  Reset the connection once "MPTCP has been verified" instead of a fallback [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  497  in-kernel PM: check to create new subflows when some are destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
  467  Scheduler: add redundant scheduler support in BPF [enhancement] [sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps are enabled [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors [enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases [enhancement] [packetdrill]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data [enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement] [sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case  [enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial address and port [enhancement] [pm]
  334  in-kernel PM: send >1 ADD_ADDR before the establishment of a new subflow [enhancement] [pm]
  332  scheduler: implement a "opportunistic retransmission" [enhancement] [sched]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement] [packetdrill]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path [enhancement]
   78  notify the application (userspace) when a subflow is added/removed [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2026-01-14)

  611  [syzbot] KASAN: stack-out-of-bounds Read in `mptcp_pm_nl_get_local_id` [bug] [syzkaller]
  603  Repeated MPTCP_EVENT_SUB_CLOSED events with corrupted addresses (0.0.0.0) [bug] @matttbe


    Packetdrill PRs

  162  2 months ago  geliangtang  mptcp: add splice test
  52   1 year ago    dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /



    mptcpd PRs: /


    TODO: track mptcp-upstream-virtme-docker repo → Done



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.20/7.0): https://github.com/orgs/multipath-tcp/projects/18
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:


    - Fixes for other trees: /

    - Fixes for -net:

        - [76f15f869c88] selftests: mptcp: join: fix local endp not being tracked (Matthieu Baerts (NGI0))
        - [f0eeb24a3c4b] mptcp: avoid dup SUB_CLOSED events after disconnect (Matthieu Baerts (NGI0))
        - [732bf4eb2d58] selftests: mptcp: check no dup close events after error (Matthieu Baerts (NGI0))
        - [7035ef8c7153] mptcp: only reset subflow errors when propagated (Matthieu Baerts (NGI0))
        - [8ffb2618e7c1] selftests: mptcp: check subflow errors in close events (Matthieu Baerts (NGI0)):
            - sent, not applied yet


    - Fixes for net-next: /

    - Features for net-next:

        - [7f09dc74e8f3] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [b6e675e9eaa4] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [f5c999333502] mptcp: pm: add get_priority() interface (Geliang Tang):
            - blocked by pm->lock refactoring required

        - [477f617987cc] mptcp: pm: align endpoint flags size with the NL specs (Matthieu Baerts (NGI0)):
            - can be sent, TODO: Matth → done

        - [fdff189ee93c] trace: mptcp: add mptcp_rcvbuf_grow tracepoint (Paolo Abeni):
            - can be sent

        - [53e63c7e3ff9] mptcp: do not account for OoO in mptcp_rcvbuf_grow() (Paolo Abeni)
        - [c7819e1fae3d] mptcp: fix receive space timestamp initialization (Paolo Abeni)
        - [f67f7ea87a27] mptcp: consolidate rcv space init (Paolo Abeni):
            - can probably be sent, to be checked

        - [158cc3ee759d] mptcp: better mptcp-level RTT estimator (Paolo Abeni):
            - TODO: Matth: check with Paolo if it can be temporarily reverted. → done (mark as "flaked")

        - [3864d9b42b32] mptcp: add receive queue awareness in tcp_rcv_space_adjust() (Paolo Abeni):
            - cannot be sent: the first one is causing issues with the selftests (simult_flows)

        - [bfc394d92547] mptcp: add eat_recv_skb helper (Geliang Tang)
        - [263520b73a77] mptcp: implement .read_sock (Geliang Tang)
        - [2fdaabe839e1] tcp: export tcp_splice_state (Geliang Tang)
        - [8958bbb2ebc1] mptcp: implement .splice_read (Geliang Tang)
        - [771eca97f3f2] selftests: mptcp: add splice io mode (Geliang Tang)
        - [45b253e0bfde] selftests: mptcp: connect: cover splice mode (Geliang Tang):
            - can be sent

        - [ac4fe3058722] mptcp: Change some dubious min_t(int, ...) to min() (David Laight):
            - can be sent

        - [5cd52ee558da] selftests: mptcp: join: wait for estab event instead of MPJ (Matthieu Baerts (NGI0))
        - [b55296b69436] selftests: mptcp: join: fix wait_mpj helper (Matthieu Baerts (NGI0))
        - [56280a2e8534] selftests: mptcp: join: userspace: wait for new events (Matthieu Baerts (NGI0))
        - [bfb81d49140f] selftests: mptcp: join chk_stale_nr: avoid dup stats (Matthieu Baerts (NGI0))
        - [2f4db1afbf48] selftests: mptcp: join: avoid declaring i if not used (Matthieu Baerts (NGI0))
        - [01d6bf2a7aea] selftests: mptcp: connect: fix maybe-uninitialize warn (Matthieu Baerts (NGI0))
        - [b983062dcb68] selftests: mptcp: connect cleanup TFO setup (Matthieu Baerts (NGI0))
        - [acab45b18646] selftests: mptcp: join: no SKIP mark for group checks (Matthieu Baerts (NGI0)):
            - can be sent, but they depend on patches queued for -net

    - Features for net-next (next): /

    - Features for other trees:

        - [69f9d0c6114e] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [cc3c756f1ced] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [cad19e0c2481] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [f860444ce6f3] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [55f1706fb677] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [15723c3aacaa] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [c8deb3f68738] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [7453c629fc4f] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [73a33291d93c] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [fec239f1ed3f] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [b954185f79a1] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang):
            - same status as before: waiting for a refactoring on the sched side




Extra tests:
    - news about Syzkaller? (Matth):
        - TODO, Matth, Check → Done

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - TODO: Matth: ignore calltraces seen before starting the tests, e.g.
        https://github.com/multipath-tcp/mptcp_net-next/actions/runs/21427201548/job/61698588927
          → done, now in orange in flakes.html
        → rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
        → TODO: check if it has not been already reported, and maybe report that somewhere
        - It might be related to VSOCK and the other issues that have been seen! → maybe but no
        - TODO: trigger GDB to check what's going on when there is a stall that early. → done



Next meeting:
    - Next one on Wednesday, the 11th of February.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20260211



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

