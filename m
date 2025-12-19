Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFED286415
	for <mptcp@lists.linux.dev>; Fri, 19 Dec 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167402; cv=none; b=iFbI240Ut7MT1jOEvdf8VwIzohyQ44+8tyBdMRm4g8mjw4flLyaCiDFc586HUbD4jocRB28GHTc1WGA/Ha9BQlm5SAmCFgBhoZKEKObMk6j0ce8Fn2fEp3VUdNDfvYhUFC7tVtrwY9b3MRYDu3d/NWCpTzVE0y5BFV5IzJkUrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167402; c=relaxed/simple;
	bh=tlqWtZcnqEq1OJOqXOmXB5juBiep/G0pP83GIFKuItA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=oSaAvwZyxUhOqKofqBdZJNN3ZSLIU7Km67dt+jNEdKGaj/vGlNDnalyLnAybMgT/VKVqaIjH5XbhS3r+xGYSSyFTlZblzQroPHeaB4tCJ5T/YI7j+cnKFxdL/C9jbjd3IPlVOMyYa7jqVfYnsE2mcAJv1fcl7UmJNSJIUTR3eVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUB4BJ2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUB4BJ2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76590C4CEF1
	for <mptcp@lists.linux.dev>; Fri, 19 Dec 2025 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766167401;
	bh=tlqWtZcnqEq1OJOqXOmXB5juBiep/G0pP83GIFKuItA=;
	h=Date:From:Subject:To:From;
	b=nUB4BJ2SZUopGbzTdOGdo+wS8tH7RV6h/fX5178y7zafeBmNGPTQie47eTcDL3wyD
	 cFjrx1aQZIRgxlqOUxDiPuWhJN8GR1wNNyyQIhYOGaniRSadg6NKur/3HSA2QhFUkq
	 rpjgC3aXeA58N41rKLX10XoECaYs5YU1BPiaZQGof8iURrHJhagrVx834fbSgou+3s
	 4Rass44tIKdF93lMPJto7N4dPvTQTdn3OJZ9CBZjnH5j42YthP0SKN08s2Ww40rhJB
	 UaGGoxFGV+W2MjKPU3rRUmsoeODieXRzbxymPFcOGJ96JKK7ztvh4efgYQq9lWw7+H
	 R2x1uWbEIQeCA==
Message-ID: <a6bca7aa-8e0e-4c79-878d-f1eaf10e1372@kernel.org>
Date: Fri, 19 Dec 2025 19:03:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Subject: [Weekly meetings] MoM - 17th of December 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14340994: [net,1/4] mptcp: pm: ignore unknown endpoint flags
14340995: [net,2/4] selftests: mptcp: pm: ensure unknown flags are ignored
14340996: [net,3/4] mptcp: schedule rtx timer only after pushing data
14340997: [net,4/4] mptcp: avoid deadlock on fallback while reinjecting:
    - Series: mptcp: misc fixes for v6.19-rc1
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1030966&state=*&archive=both

14338067: [net] mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO:
    - Submitter: Eric Biggers
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251204054417.491439-1-ebiggers@kernel.org/


    our repo (by: Eric Biggers, Geliang Tang, Paolo Abeni):

14337786: [mptcp-net] mptcp: avoid deadlock on fallback while reinjecting:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com/

14339930: [mptcp-net,v3,1/2] mptcp: fallback earlier on simult connection
14339931: [mptcp-net,v3,2/2] mptcp: ensure context reset on disconnect():
    - Series: mptcp: fix warn on bad status
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1030787&state=*&archive=both

14341426: [mptcp-next,v15,1/6] mptcp: add eat_recv_skb helper
14341427: [mptcp-next,v15,2/6] mptcp: implement .read_sock
14341428: [mptcp-next,v15,3/6] tcp: export tcp_splice_state
14341429: [mptcp-next,v15,4/6] mptcp: implement .splice_read
14341430: [mptcp-next,v15,5/6] selftests: mptcp: add splice io mode
14341431: [mptcp-next,v15,6/6] selftests: mptcp: connect: cover splice mode:
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1031070&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: David Laight, Matthieu Baerts):

14321880: [44/44] net/mptcp: Change some dubious min_t(int, ...) to min():
    - Series: Change a lot of min_t() that might mask high bits
    - Submitter: David Laight
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1025544&state=*&archive=both
    - Looks OK, should we apply it in our tree?
    - TODO: Matth: apply it in our tree, and send it to net-next later on → done

14346229: [net,1/2] mptcp: fallback earlier on simult connection
14346230: [net,2/2] mptcp: ensure context reset on disconnect():
    - Series: mptcp: fix warn on bad status
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1032622&state=*&archive=both

14346187: subflow: relax WARN in subflow_data_ready() on teardown races:
    - State: New
    - Series: subflow: relax WARN in subflow_data_ready() on teardown races
    - Submitter: Evan Li
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1032600&state=*&archive=both
    - Rejected: ignoring WARN, Paolo already had a fix for those


    our repo (by: Ankit Khushwaha, Christoph Paasch, Evan Li, Gang Yan, GangYan, Geliang Tang, Gregory Detal, Matthieu Baerts, Paolo Abeni):

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
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org/
    - Status: same as last time

14332838: [mptcp-net] mptcp: sync the msk->sndbuf at accept() time:
    - State: Changes requested
    - Submitter: GangYan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251128094417.14463-1-gang.yan@linux.dev/
    - Questions for Paolo

14332999: [net-next] tls: check return value of strp_load_anchor_with_queue:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn/
    - Questions for Paolo

14333645: [net-next,v2] selftests: mptcp: Mark xerror __noreturn:
    - State: Changes requested
    - Submitter: Ankit Khushwaha
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251129043808.16714-1-ankitkhushwaha.linux@gmail.com/
    - New version expected when net-next will re-open

14337745: [mptcp-next] mptcp: cleanup duplicate ack suppression on fastclose.:
    - State: Changes requested
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com/
    - can be dropped

14343896: [mptcp-next,1/2] mptcp: use sk_is_tcp helper:
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:https://patchwork.kernel.org/project/mptcp/patch/f33c663ae39d50dbca2623822519f5628c04f9f0.1765354225.git.tanggeliang@kylinos.cn/
    
14345568: [mptcp-next] selftests: mptcp: join: no SKIP mark for group checks:
    - State: New
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org/
    
14345829: [RFC,mptcp-next,v4,01/10] mptcp: add sk_is_msk helper
14345830: [RFC,mptcp-next,v4,02/10] tls: switch to MPTCP_SKB_CB
14345831: [RFC,mptcp-next,v4,03/10] tls: switch to mptcp_inq
14345832: [RFC,mptcp-next,v4,04/10] tls: switch to mptcp_sendmsg_locked
14345833: [RFC,mptcp-next,v4,05/10] tls: switch to mptcp_recv_skb
14345834: [RFC,mptcp-next,v4,06/10] tls: switch to mptcp_read_done
14345835: [RFC,mptcp-next,v4,07/10] mptcp: update ULP getsockopt
14345836: [RFC,mptcp-next,v4,08/10] mptcp: enable TLS setsockopt
14345837: [RFC,mptcp-next,v4,09/10] selftests: mptcp: connect: update sock_test_tcpulp
14345838: [RFC,mptcp-next,v4,10/10] selftests: mptcp: sockopt: implement MPTCP KTLS tests:
    - State: New
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1032489&state=*&archive=both
    - It would be good to use function pointers instead of sk_is_msk() in many places: so adding a new layer, where struct tls_strparser would have new fields with function pointer to call tcp_inq() or mptcp_inq(), etc. MPTCP would only be checked once at the initialisation, not each time.
    - If adding an indirection is an issue, INDIRECT_CALL_(...) macros can be used
    - Also, it might be good to send the RFC to KTLS people, but probably best to wait for the read-sock series to be in net-next?
    - TODO: Matth: reply to Geliang → Done

14346887: [mptcp-next,1/3] tcp: add recv_should_stop helper
14346888: [mptcp-next,2/3] mptcp: use recv_should_stop helper
14346889: [mptcp-next,3/3] tls: use recv_should_stop helper:
    - State: New
    - Series: add tcp_recv_should_stop helper
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1032825&state=*&archive=both
    - Is it changing the behaviour?

14348921: [mptcp-net,1/2] mptcp: pm: in-kernel: always set as unavail when removing addr
14348922: [mptcp-net,2/2] mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr():
    - State: New
    - Series: mptcp: pm: in-kernel: fix issue 606
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1033402&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 602):

  607  selftests: `simult_flows`: "unbalanced bwidth with opposed, unbalanced delay" (+ "reverse direction") are unstable [bug] [selftests]:
      - Recent regression due to "mptcp: better mptcp-level RTT estimator", only in our tree
      - anyone to look at it?

  606  [syzkaller] WARNING in `mptcp_pm_nl_set_flags` [bug] [syzkaller] [reproducer] @matttbe:
      - there is a pending fix for that one

  605  [syzkaller]  KASAN: stack-out-of-bounds Read in `mptcp_pm_kernel_get_priority` [bug] [syzkaller]:
      - a missing RCU usage?
      - anyone to look at it?

  603  Repeated MPTCP_EVENT_SUB_CLOSED events with corrupted addresses (0.0.0.0) [bug] [triage]:
      - to be reproduced in the selftests, anyone?


    Recently discussed:

  602  A query about the update of 'msk->sk_sndbuf' [question]:
      - A question from Gang

  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]:
      - Also spot by syzkaller

  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]:
      - It seems more present than before

  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support [enhancement] [bpf] @geliangtang:
      - Geliang is looking at it.


    Bugs (opened, flagged as "bug" and assigned)

  606  [syzkaller] WARNING in `mptcp_pm_nl_set_flags` [bug] [syzkaller] [reproducer] @matttbe
  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  607  selftests: `simult_flows`: "unbalanced bwidth with opposed, unbalanced delay" (+ "reverse direction") are unstable [bug] [selftests]
  605  [syzkaller]  KASAN: stack-out-of-bounds Read in `mptcp_pm_kernel_get_priority` [bug] [syzkaller]
  603  Repeated MPTCP_EVENT_SUB_CLOSED events with corrupted addresses (0.0.0.0) [bug] [triage]
  600  mptcp: avoid dropping partial packets [bug]
  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]
  592  Lower throughput with MPTCP vs TCP [bug]
  587  in-kernel PM: Server is only using single IP to establish subflows [bug]
  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
  581  Default scheduler under-utilizes newly restored subflows on long-lived flows after WAN failback [bug]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  567  [syzbot] WARNING in `__mark_subflow_endp_available` [bug] [syzkaller] [reproducer]
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


    Recently closed (since 2025-12-03)

  604  ci: periodically validate stable kernels [enhancement] [selftests] [CI] @matttbe
  586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]
  396  ci: periodically run selftests from the export branch on stable kernels [enhancement] [selftests] [CI] @matttbe


    Packetdrill PRs

  162  1 month ago    geliangtang  mptcp: add splice test
  52   11 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcpd PRs:
        - New release? → WIP



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.20/7.0): https://github.com/orgs/multipath-tcp/projects/18
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - ChangeLog has been updated: https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees:

        - [88c90af45fb0] selftests: bpf: fix recent compilation errors (Matthieu Baerts (NGI0)):
            - TODO: Matth: update pahole and remove this patch → Done

        - [80147c55022f] selftests/bpf: Add -fms-extensions to bpf build flags (Alexei Starovoitov):
            - fix from BPF tree for BPF selftests

    - Fixes for -net:

        - [d814ea7b0ab6] mptcp: fallback earlier on simult connection (Paolo Abeni)
        - [17333a9df584] mptcp: ensure context reset on disconnect() (Paolo Abeni):
            - sent

    - Fixes for net-next: /

    - Features for net-next:

        - [291d7dd340c5] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [533a2ded6f1b] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [967779a41c27] mptcp: pm: add get_priority() interface (Geliang Tang):
            - Waiting for PM lock changes

        - [b27383b7a7ab] mptcp: pm: align endpoint flags size with the NL specs (Matthieu Baerts (NGI0))
        - [0be28db6e5c0] trace: mptcp: add mptcp_rcvbuf_grow tracepoint (Paolo Abeni)
        - [cbbb8cec1157] mptcp: do not account for OoO in mptcp_rcvbuf_grow() (Paolo Abeni)
        - [e267393aac3b] mptcp: fix receive space timestamp initialization (Paolo Abeni)
        - [034b15f7a1fa] mptcp: consolidate rcv space init (Paolo Abeni)
        - [f81cd04fd98a] mptcp: better mptcp-level RTT estimator (Paolo Abeni):
            - there is an issue with this one

        - [535742f8daa0] mptcp: add receive queue awareness in tcp_rcv_space_adjust() (Paolo Abeni)
        - [ffdf31421086] mptcp: add eat_recv_skb helper (Geliang Tang)
        - [21c8b8e93e5c] mptcp: implement .read_sock (Geliang Tang)
        - [dc1ca9ff51e7] tcp: export tcp_splice_state (Geliang Tang)
        - [e72c443e1380] mptcp: implement .splice_read (Geliang Tang)
        - [50de1ef447d6] selftests: mptcp: add splice io mode (Geliang Tang)
        - [c9fb9872ef0b] selftests: mptcp: connect: cover splice mode (Geliang Tang):
            - net-next is closed

    - Features for net-next (next): /

    - Features for other trees:

        - [dec21b2d95e5] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [0992270df862] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [f6f10b5d7ef7] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [26d56488f353] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [d561eda3823d] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [9c72643d0367] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [952efe182e33] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [21b48417f0e1] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [aac698c78573] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [fb00972fb2f3] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [9ecb1c0276c8] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang)
            - Waiting for sched API changes




Extra tests:
    - news about Syzkaller? (Matth):
        - finding issues, see the recently opened ones
        - TODO: Matth: check syzbot → done

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - New job validating stable versions:
            - https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/stable.yml
            - Results visible in "flakes" webui + IRC
            - e.g. https://ci-results.mptcp.dev/flakes.html?branch=stable-6.12
            - once a week, it is using the selftests from the export branch
            - e.g. https://ci-results.mptcp.dev/flakes.html?branch=latest-6.12
            - It is using the stable patches that have been queued but not released yet + pending MPTCP ones available in our patchwork.
            - Some tests might be failing because:
                - tests are expecting a fix which is not there yet, e.g. when using the selftests from the export branch, or when only the test got backported
                - a behaviour change but a modification is needed in stable packetdrill branches, etc.
            - TODO: we need a way to detect/list important issues: WARN, BUG, timeout → Done: the headers are now in red + check the tooltip
            - TODO: send a dedicated email on the ML about that → Done



Next meeting:
    - /!\ The next meeting on the 31st of December will be cancelled /!\
    - Next one on Wednesday, the 14th of January.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20260114



Feel free to comment on these topics and suggest new ones for the next meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

