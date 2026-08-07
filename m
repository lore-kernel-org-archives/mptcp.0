Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10792285CAA
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125744; cv=none; b=fgU+UcxZJH1dEpxehbiSPSxPFHE7bYGRdsqmpq7QghFWaNK2GumJCA2yoL1BLyuFQoJwvnActeMtNVGaDBsOOyNHwxzqHZ7k9DAXdosIhlR4fnjb7K/3oK3H+LizF6k8zsF8DjQMqXM8SuIJq0SwxcPr+tNX9T0txGKBJyjkUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125744; c=relaxed/simple;
	bh=edKC6VxeU7gez95IZobdTeSEoRyMxlw3IXejdyOih8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=TciGwJzWFrzpRQiRrtLFdYbk6HrVniyRqih758EWLYrilov1IZYG9ew+n5V0cv9u/UdlTfZ0XZf3hzuXrIfIHvpxj3UBqyIzwL1qBsbEjgXvE+8KZnkmYQvb+9IBnmVVCSfRMUPgcbDdjBfMWGysdnkWiOgUORLWFQi2HYD/QwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCzFYHee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCzFYHee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B5D1F000E9
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125741;
	bh=sE1co5/OEabopgtQnUV0uYosi4VeEWWxBHALBnR/NOk=;
	h=Date:From:Subject:To;
	b=WCzFYHeepz3BxdFNF+pIzxzJvrFf/hFeq328Y3/fJPPhjSoLL7MxUVe87G0VvkANT
	 vLJRER8H4P4mKsP2Wg9vnuxxkHzsrJx79uzUUQVPW8WmgNIThEBv2RiJd63sVcz705
	 VGehhdAVKfOQVabxM6V0UuEjqdnECQhyCv/1oYVqUDT4z0e3afslSls3mB/deHxGem
	 kPxjcO+jcvVrbT1dWPaW2DK+0lvRaq03WWrveZ4gI36Qp7VTWkAwg0bEYAw+tgpAa2
	 nEmv6/VoGkEH4xPnjuQNBuB1EpgislnbR71GXYsstWb+nOMxqGlGr7HBa0VWVtHQ6f
	 JZsOYIbtmiVbg==
Message-ID: <1cecb443-cc27-4bb0-966c-52af48df58d5@kernel.org>
Date: Fri, 7 Aug 2026 20:02:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Subject: [Weekly meetings] MoM - 21st of May 2026
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had a meeting with Mat (Cruise), Geliang and Gang
(Kylin) and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14555777: [net,01/11] mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
14555778: [net,02/11] mptcp: pm: ADD_ADDR rtx: allow ID 0
14555779: [net,03/11] mptcp: pm: ADD_ADDR rtx: fix potential data-race
14555780: [net,04/11] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
14555781: [net,05/11] mptcp: pm: ADD_ADDR rtx: free sk if last
14555782: [net,06/11] mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
14555783: [net,07/11] mptcp: pm: ADD_ADDR rtx: skip inactive subflows
14555784: [net,08/11] mptcp: pm: ADD_ADDR rtx: return early if no retrans
14555785: [net,09/11] mptcp: pm: prio: skip closed subflows
14555786: [net,10/11] selftests: mptcp: check output: catch cmd errors
14555787: [net,11/11] selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl:
    - Series: mptcp: pm: misc. fixes for v7.1-rc3
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1089968&state=*&archive=both

14562153: [net-next,1/8] mptcp: pm: in-kernel: explicitly limit batches to array size
14562154: [net-next,2/8] mptcp: pm: in-kernel: increase all limits to 64
14562156: [net-next,3/8] mptcp: pm: kernel: allow flushing more than 8 endpoints
14562155: [net-next,4/8] mptcp: pm: in-kernel: increase endpoints limit
14562157: [net-next,5/8] selftests: mptcp: join: allow changing ifaces nr per test
14562159: [net-next,6/8] selftests: mptcp: join: validate 8x8 subflows
14562158: [net-next,7/8] selftests: mptcp: pm: validate new limits
14562160: [net-next,8/8] selftests: mptcp: pm: use simpler send/recv forms:
    - Series: mptcp: pm: in-kernel: increase limits
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1091759&state=*&archive=both

14573969: [net,v2,1/6] mptcp: do not drop partial packets
14573970: [net,v2,2/6] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
14573971: [net,v2,3/6] selftests: mptcp: join: cover ADD_ADDR tx drop and list progress
14573972: [net,v2,4/6] mptcp: reset rcv wnd on disconnect
14573973: [net,v2,5/6] mptcp: update window_clamp on subflows when SO_RCVBUF is set
14573974: [net,v2,6/6] selftests: mptcp: drop nanoseconds width specifier:
    - Series: mptcp: misc fixes for v7.1-rc4
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1095118&state=*&archive=both

14550145: [mptcp-net] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow():
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org/

14557143: [6.18.y] mptcp: sync the msk->sndbuf at accept() time:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260506112040.3503275-2-matttbe@kernel.org/



    our repo (by: Gang Yan, Li Xiasong, Matthieu Baerts, Paolo Abeni):

14557080: [mptcp-net,v3] mptcp: update window_clamp on subflows when SO_RCVBUF is set:
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260506-window_clamp-v3-1-ade82fbbebb2@kylinos.cn/

14559261: [mptcp-net,v3,1/2] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
14559262: [mptcp-net,v3,2/2] selftests: mptcp: join: cover ADD_ADDR tx drop and list progress:
    - Series: mptcp: pm: fix ADD_ADDR timer infinite retry on option space shortage
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1091028&state=*&archive=both

14562187: [mptcp-net,1/3] selftests: mptcp: simult_flows: disable GSO
14562188: [mptcp-net,2/3] selftests: mptcp: simult_flows: adapt limits
14562189: [mptcp-net,3/3] selftests: mptcp: simult_flows: disable 'flaky' mark:
    - Series: selftests: mptcp: simult_flows: reduce bufferbloat
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1091768&state=*&archive=both

14564251: [mptcp-next,v5,01/12] mptcp: do not drop partial packets
14573890: [mptcp-net] selftests: mptcp: drop nanoseconds width specifier:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260515-mptcp-sft-uutils-0-8-0-v1-1-4801c8e16485@kernel.org/

14561328: [mptcp-net] mptcp: reset rcv wnd on disconnect:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/71899029874998e8436cab708b41cbc029772ad9.1778233686.git.pabeni@redhat.com/

14573894: [mptcp-net] Squash to "mptcp: update window_clamp on subflows when SO_RCVBUF is set":
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260515022332.55392-2-matttbe@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts, Ren Wei):

14563920: [net,v2,1/1] mptcp: fix request ownership when cloning reqsk:
    - State: Changes requested
    - Series: [net,v2,1/1] mptcp: fix request ownership when cloning reqsk
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1092284&state=*&archive=both
    - Paolo and Sashiko reviewed it, new version needed

14530439: [v2] selftests: harness: fix pidfd leak in __wait_for_test:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn/
    - Geliang sent a message because nobody is taking it.
    - Worst case, we can send it as part of other net fixes at some points, when this patch will be needed for new MPTCP tests.


    our repo (by: Christoph Paasch, David CARLIER, Gang Yan, Geliang Tang, Gregory Detal, Kalpan Jani, Kuniyuki Iwashima, Matthieu Baerts, Paolo Abeni, Ren Wei, Shardul Bankar, Tao Cui):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - status: same as last time

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
    - status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - status: same as last time

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - status: same as last time

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same as last time

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - status: same as last time

14167004: [mptcp-next] mptcp: remove redundant orig_offset in carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
    - status: same as last time

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
    - status: same as last time

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
    - status: same as last time

14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option support
14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket option support:
    - State: Needs ack
    - Series: mptcp: add more sockopts
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
    - status: same as last time

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
    - status: same as last time

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
    - status: same as last time

14332026: [RFC,mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt:
    - State: Changes requested
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org/
    - status: same as last time

14413156: [mptcp-net,1/3] mptcp: add backlog_list bug reproducer test
14413157: [mptcp-net,2/3] mptcp: fix receive stalls when 'ack_seq' in backlog_list
14478733: [RESEND,mptcp-next,v2,1/3] tcp: export do_tcp_splice_eof
14478734: [RESEND,mptcp-next,v2,2/3] mptcp: implement .splice_eof
14478735: [RESEND,mptcp-next,v2,3/3] selftests: mptcp: connect: trigger splice_eof:
    - State: Changes requested
    - Series: implement .splice_eof
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1067870&state=*&archive=both
    - status: same as last time

14478884: [mptcp-net,v2] mptcp: fix data-race in __mptcp_retrans / mptcp_incoming_options:
    - State: Queued
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org/
    - status: same as last time

14481348: [mptcp-next,v3,1/2] mptcp: implement psock_update_sk_prot
14481349: [mptcp-next,v3,2/2] selftests/bpf: Update sockmap tests for MPTCP:
    - State: Changes requested
    - Series: implement psock_update_sk_prot
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1068551&state=*&archive=both
    - status: same as last time

14529011: [mptcp-next,v4,1/3] mptcp: pm: userspace: drop delete_local_addr helper
14529012: [mptcp-next,v4,2/3] selftests: mptcp: join: update userspace dump_addr outputs
14529013: [mptcp-next,v4,3/3] selftests: mptcp: userspace: send RM_ADDR between server and client:
    - State: Needs ack
    - Series: only remove entry from local_addr_list when sending a REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1082700&state=*&archive=both
    - status: same as last time

14546480: [RFC,mptcp-next,v18,01/15] tls: add per-protocol cache to support mptcp
14546481: [RFC,mptcp-next,v18,02/15] tls: introduce struct tls_prot_ops
14546482: [RFC,mptcp-next,v18,03/15] tls: add tls_prot_ops pointer to tls_proto
14546483: [RFC,mptcp-next,v18,04/15] mptcp: update mptcp_check_readable
14546484: [RFC,mptcp-next,v18,05/15] mptcp: implement tls_mptcp_ops
14546485: [RFC,mptcp-next,v18,06/15] tls: disable device offload for mptcp sockets
14546486: [RFC,mptcp-next,v18,07/15] mptcp: update ulp getsockopt for tls support
14546487: [RFC,mptcp-next,v18,08/15] mptcp: enable ulp setsockopt for tls support
14546488: [RFC,mptcp-next,v18,09/15] selftests: mptcp: connect: use espintcp for ulp test
14546521: [RFC,mptcp-next,v18,10/15] selftests: tls: add mptcp variant for testing
14546522: [RFC,mptcp-next,v18,11/15] selftests: tls: increase pollin timeouts for mptcp
14546523: [RFC,mptcp-next,v18,12/15] selftests: tls: increase nonblocking data size for mptcp
14546525: [RFC,mptcp-next,v18,13/15] selftests: tls: wait close in shutdown_reuse for mptcp
14546526: [RFC,mptcp-next,v18,14/15] selftests: tls: add mptcp test cases
14546527: [RFC,mptcp-next,v18,15/15] selftests: mptcp: cover mptcp tls tests:
    - State: Needs ack
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1087410&state=*&archive=both
    - status: same as last time

14551088: [mptcp-next,1/3] selftests: mptcp: connect: test name in pcap file
14551089: [mptcp-next,2/3] selftests: mptcp: simult_flow: test name in pcap file
14551090: [mptcp-next,3/3] selftests: mptcp: pcap: drop most of the payload:
    - State: Needs ack
    - Series: selftests: mptcp: small pcap-related improvements
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1088610&state=*&archive=both

14552287: [v2] mptcp: Clear mptcp_out_options in mptcp_{syn,synack,established}_options().:
    - State: Needs ack
    - Submitter: Kuniyuki Iwashima
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260504044051.3725846-1-kuniyu@google.com/
    - Paolo sent a new version to syzbot, but syzbot found another issues in KMSAN. But Paolo's patch looks OK.
    - TODO: Matth: ask Paolo if he plans to send it → Done

14562644: [mptcp-net,v4,1/2] mptcp: use sockopt_lock(release)_sock in sockopt
14562643: [mptcp-net,v4,2/2] mptcp: use sockopt_ns_capable() in setsockopt congestion control:
    - State: Changes requested
    - Series: mptcp: convert to sockopt_lock_sock
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1091935&state=*&archive=both
    - Reviewed by Paolo

14563266: [mptcp-next,v7,1/4] mptcp: sockopt: factor inet_flags propagation into a mask
14563267: [mptcp-next,v7,2/4] mptcp: propagate RECVERR sockopts to subflows
14563268: [mptcp-next,v7,3/4] mptcp: support MSG_ERRQUEUE on the parent socket
14563269: [mptcp-next,v7,4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation:
    - State: New
    - Series: mptcp: MSG_ERRQUEUE support on the parent socket
    - Submitter: David CARLIER
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1092123&state=*&archive=both
    - TODO: Matth: check this new version → Done

14568182: [v3,1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
14568183: [v3,2/2] selftests: mptcp: extend chk_rst_nr to validate per-event RST counters:
    - State: New
    - Series: mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1093458&state=*&archive=both
    - TODO: Matth: check this new version → done

14572928: [mptcp-next,v3,1/2] mptcp: pm: fix extra_subflows underflow on userspace PM connect failure
14572929: [mptcp-next,v3,2/2] mptcp: pm: fix extra_subflows leak on userspace PM subflow close race:
    - State: Changes requested
    - Series: mptcp: pm: fix extra_subflows underflow for userspace PM
    - Submitter: Tao Cui
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1094801&state=*&archive=both
    - Matth reviewed it

14581282: [net,v3] mptcp: fix stale skb->sk reference on subflow close:
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com/
    - Sashiko Gemini and Claude found issues
    - TODO: Matth: forward them → done

14581352: [mptcp-net] selftests: mptcp: sockopt: set EXIT trap earlier:
    - State: New
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/b681d1061e68faeb0d4fd68c23c09852d90385da.1779185611.git.tanggeliang@kylinos.cn/
    - TODO: review: Matth → done

14582457: [v7,mptcp-next,1/7] mptcp: fix missing wakeups in edge scenarios
14582458: [v7,mptcp-next,2/7] mptcp: explicitly drop over memory limits
14582459: [v7,mptcp-next,3/7] mptcp: enforce hard limit on backlog flushing
14582461: [v7,mptcp-next,4/7] mptcp: implemented OoO queue pruning
14582460: [v7,mptcp-next,5/7] mptcp: track prune recovery status
14582463: [v7,mptcp-next,6/7] mptcp: move the retrans loop to a separate helper
14582462: [v7,mptcp-next,7/7] mptcp: let the retrans scheduler do its job.:
    - State: New
    - Series: mptcp: address stall under memory pressure
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1097528&state=*&archive=both
    - Some perf issues, but likely in very specific conditions, when we are in memory pressure → which is fine
    - To be checked, and reviewed

14582594: [net] mptcp: pm: fix memory leak from alloc-during-teardown race:
    - State: New
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260519191207.1110003-1-shardul.b@mpiricsoftware.com/
    - To be reviewed

14582720: [mptcp-net,mptcp-next,v3,01/16] mptcp: pm: avoid sleeping while holding rcu_read_lock
14582721: [mptcp-next,v3,02/16] mptcp: options: ADD_ADDR size can be negative
14582722: [mptcp-next,v3,03/16] mptcp: pm: avoid computing rm_addr size twice
14582723: [mptcp-next,v3,04/16] mptcp: pm: avoid computing add_addr size twice
14582724: [mptcp-next,v3,05/16] mptcp: introduce add_addr_v6_port_drop_ts sysctl knob:
    - maybe this patch can be dropped: only sent for ADD_ADDRv6 + port → MPTCP endpoint, so that's explicit
    - TODO: Matth: send a msg on the ML → done
14582725: [mptcp-next,v3,06/16] tcp: allow mptcp to drop TS for some packets
14582726: [mptcp-next,v3,07/16] mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
14582727: [mptcp-next,v3,08/16] selftests: mptcp: validate ADD_ADDRv6 + TS + port
14582728: [mptcp-next,v3,09/16] selftests: mptcp: always check sent/dropped ADD_ADDRs
14582729: [mptcp-next,v3,10/16] mptcp: pm: use for_each_subflow helper
14582730: [mptcp-next,v3,11/16] mptcp: pm: rename add_entry structure to add_addr
14582731: [mptcp-next,v3,12/16] mptcp: pm: uniform announced addresses helpers
14582732: [mptcp-next,v3,13/16] mptcp: pm: remove add_ prefix from timer
14582733: [mptcp-next,v3,14/16] mptcp: pm: make mptcp_pm_add_addr_send_ack static
14582734: [mptcp-next,v3,15/16] mptcp: pm: avoid using del_timer directly
14582735: [mptcp-next,v3,16/16] mptcp: pm: avoid confusing check_id in del_timer:
    - State: New
    - Series: mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1097625&state=*&archive=both

14582986: [RFC,mptcp-next,v15,01/10] nvmet-tcp: define target tcp_proto struct
14582987: [RFC,mptcp-next,v15,02/10] nvmet-tcp: register target mptcp transport
14582988: [RFC,mptcp-next,v15,03/10] nvmet-tcp: implement target mptcp proto
14582989: [RFC,mptcp-next,v15,04/10] nvme-tcp: define host tcp_proto struct
14582990: [RFC,mptcp-next,v15,05/10] nvme-tcp: register host mptcp transport
14582991: [RFC,mptcp-next,v15,06/10] nvme-tcp: implement host mptcp proto
14582992: [RFC,mptcp-next,v15,07/10] selftests: mptcp: add nvme over mptcp test
14582993: [RFC,mptcp-next,v15,08/10] selftests: mptcp: nvme: add iopolicy tests
14582994: [RFC,mptcp-next,v15,09/10] nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
14582995: [RFC,mptcp-next,v15,10/10] nvme-tcp: add RCU protection for host_iface validation:
    - State: New
    - Series: NVME over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1097717&state=*&archive=both
    - Sashiko has some comments, but either not interesting ones, or linked to possible pre-existing issues




Extra, just in case



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 622):

  623  [sashiko] possible use-after-free in `mptcp_pm_del_add_timer` [bug]
  
  
    Recently discussed:
  
  622  [sashiko] NULL pointer dereferences and Use-After-Free in `bpf_mptcp_sock_from_subflow` [bug]:
      - another explanation has been given
      
  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]:
      - syzbot also hit it
      - no reproducer


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  623  [sashiko] possible use-after-free in `mptcp_pm_del_add_timer` [bug]
  622  [sashiko] NULL pointer dereferences and Use-After-Free in `bpf_mptcp_sock_from_subflow` [bug]
  621  [syzkaller] WARNING in `inet_sock_destruct`: `atomic_read(&sk->sk_rmem_alloc)` [bug] [syzkaller]
  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
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
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps are enabled [enhancement] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill] @dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  562  [performance] How much is the overhead of MPTCP？ [question]


    For later (opened and not assigned)

  618  `TCP_RTO_MIN`/`MAX`: used configured values if any [enhancement]
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


    Recently closed (since 2026-05-07)

  619  mptcp: update window_clamp when `SO_RCVBUF` is set [bug]
  600  mptcp: avoid dropping partial packets [bug]
  492  userspace pm: subflows counter: not updated when a subflows is removed from the other end [bug]:
      - closed, thanks to Shardul Bankar: it was apparently already fixed


    Packetdrill PRs

  162  3 months ago  geliangtang  mptcp: add splice test
  52   1 year ago    dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcp-upstream-virtme-docker PRs: /


    mptcpd PRs /





FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (7.2): https://github.com/orgs/multipath-tcp/projects/20
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [6b76a5e3ff66] selftests: mptcp: simult_flows: disable GSO (Matthieu Baerts (NGI0))
        - [721aac12b865] selftests: mptcp: simult_flows: adapt limits (Matthieu Baerts (NGI0)):
            - can be sent

    - Fixes for net-next: /

    - Features for net-next:

        - [b1e1cb30457f] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [77e7aa5135b4] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [c83eb4020ab3] mptcp: pm: add get_priority() interface (Geliang Tang):
            - blocked: waiting for a refactoring of the pm->lock

    - Features for net-next (next): /

    - Features for other trees:

        - [fa4376a7d214] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [4f1b0e0394d6] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [f149ce968704] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [a575bfbed0cc] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [a2673d75226e] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [a2222c9b8b88] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [a44c3eb69191] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [68de63eb26fe] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [6f1214ef00e6] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [41c337ff4ef8] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [730abd03ac73] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang)
            - blocked: waiting for a refactoring of sched API



Extra tests:
    - news about Syzkaller? (Matth):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - got one series that didn't get applied, but first time.

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Every two weeks, on Wednesday.
    - 15:30 UTC (8.30am PST, 5.30pm CEST, 12.30am CST)
    - Still open to everyone!
    - https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings


Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

