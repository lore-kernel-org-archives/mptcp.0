Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2132FDC52
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959118; cv=none; b=BKCs58bh3UWGCaujrk+gWUr5w16Yhcxxm9RfwF03dcl/EPidWBoB/oyIzzXN4kW0S5V1b5Vd51gOSmqoMnZ5KB6puyyGqahmWORV5SaJlXgT2kPzoW2sRuBM3jvciXhStRHF/02HbgOK+3/K93LkMPdmuUT0/4ZmBC34VuWUGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959118; c=relaxed/simple;
	bh=5HAtWcZg/vkk/JBYiF4/VvFWsfSO9kAfrJxwgQ56x7s=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=QkwlUCN9pbNsI5qfP8K4ymewJjJzIKBK+b4S26MK4N3uL2TiDm0SOuG3ay+ywDZ/dMrE5wcsNsIvSwEE6qmlRnvejpwZjTfPT7YSYBAM8wVLhUkbLgtGe62zSUdwqnM9AZ82Fl+WdK2irZwPkiA+xEgqUdIDoSVO6WtMRHMO6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY350DNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY350DNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF5DC4CEF1
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764959117;
	bh=5HAtWcZg/vkk/JBYiF4/VvFWsfSO9kAfrJxwgQ56x7s=;
	h=Date:From:To:Subject:From;
	b=uY350DNXCFysNczmX0IyrXYHTmDAXrFH/t94y8+V700h1sNkLgWxn+U82/lxiW/Av
	 TvDrcoPaLy/oCLilxj/GywrQwi+qax7wZBvs9ij7nx6N9x7dxd/x39/LipnTUsnsBz
	 bhSTskwx2MrfpfSEmBjWjOAPIFKS2g5GSPmi6DALVI4TLuZ64ECNt1mm/w1hBx0WS1
	 4rv/1aXlTNxA0q9apjRasHJtbdpErqUGDnERnWyleTM2L5dIiVMkYAlsyAJKgUQgwz
	 OTcw7+erHxxHq3ABb0bKruhqh/1t0HXTRwqRheCpOhZAwpeQX+pWPNGC77z/sTSlv3
	 lX/LHm4Z25a5A==
Message-ID: <c4088783-0c32-4cbf-827d-4fa0811e5512@kernel.org>
Date: Fri, 5 Dec 2025 19:25:15 +0100
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
Subject: [Weekly meetings] MoM - 3rd of December 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
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

14298196: [6.12.y] mptcp: fix MSG_PEEK stream corruption:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251104121515.1093006-2-matttbe@kernel.org/

14318742: [net,01/11] mptcp: fix ack generation for fallback msk
14318743: [net,02/11] mptcp: avoid unneeded subflow-level drops
14318744: [net,03/11] mptcp: fix premature close in case of fallback
14318745: [net,04/11] mptcp: do not fallback when OoO is present
14318746: [net,05/11] mptcp: decouple mptcp fastclose from tcp close
14318747: [net,06/11] mptcp: fix duplicate reset on fastclose
14318748: [net,07/11] selftests: mptcp: join: fastclose: remove flaky marks
14318749: [net,08/11] selftests: mptcp: join: endpoints: longer timeout
14318750: [net,09/11] selftests: mptcp: join: userspace: longer timeout
14318751: [net,10/11] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr
14318752: [net,11/11] selftests: mptcp: add a check for 'add_addr_accepted':
    - Series: mptcp: misc fixes for v6.18-rc7
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1024685&state=*&archive=both

14325528: [net-next,01/14] net: factor-out _sk_charge() helper
14325529: [net-next,02/14] mptcp: factor-out cgroup data inherit helper
14325530: [net-next,03/14] mptcp: grafting MPJ subflow earlier
14325531: [net-next,04/14] mptcp: fix memcg accounting for passive sockets
14325532: [net-next,05/14] mptcp: cleanup fallback data fin reception
14325533: [net-next,06/14] mptcp: cleanup fallback dummy mapping generation
14325534: [net-next,07/14] mptcp: ensure the kernel PM does not take action too late
14325535: [net-next,08/14] mptcp: do not miss early first subflow close event notification
14325536: [net-next,09/14] mptcp: make mptcp_destroy_common() static
14325537: [net-next,10/14] mptcp: drop the __mptcp_data_ready() helper
14325538: [net-next,11/14] mptcp: handle first subflow closing consistently
14325539: [net-next,12/14] mptcp: borrow forward memory from subflow
14325540: [net-next,13/14] mptcp: introduce mptcp-level backlog
14325541: [net-next,14/14] mptcp: leverage the backlog for RX packet processing:
    - Series: mptcp: memcg accounting for passive sockets & backlog processing
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1026445&state=*&archive=both

14329194: [net] mptcp: clear scheduled subflows on retransmit:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad2165f@kernel.org/

14327388: [iproute2-net,1/6] MAINTAINERS: add entry for mptcp
14327389: [iproute2-net,2/6] man: mptcp: fix minor typos
14327390: [iproute2-net,3/6] mptcp: add 'laminar' endpoint support
14327391: [iproute2-net,4/6] mptcp: monitor: add 'server side' info
14327392: [iproute2-net,5/6] mptcp: monitor: add 'deny join id0' info
14327393: [iproute2-net,6/6] mptcp: monitor: support 'server side' as a flag:
    - Series: mptcp: new endpoint type and info flags
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1026908&state=*&archive=both

14323749: [net-next,1/2] tools: ynl-gen: add function prefix argument
14323748: [net-next,2/2] tools: ynl-gen: add regeneration comment:
    - State: New
    - Series: tools: ynl-gen: regeneration comment + function prefix
    - Submitter: Asbjørn Sloth Tønnesen
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1025958&state=*&archive=both

14332241: [6.6.y] mptcp: fix duplicate reset on fastclose:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127182741.3577840-2-matttbe@kernel.org/

14332242: [6.6.y] selftests: mptcp: join: properly kill background tasks:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127182810.3578622-2-matttbe@kernel.org/

14333963: [6.1.y] selftests: mptcp: join: endpoints: longer transfer:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251129165510.2124040-2-matttbe@kernel.org/

14333964: [6.1.y] mptcp: fix duplicate reset on fastclose:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251129165612.2125498-2-matttbe@kernel.org/

14333965: [5.15.y] selftests: mptcp: join: rm: set backup flag:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251129165729.2127525-2-matttbe@kernel.org/

14333966: [5.15.y] mptcp: avoid unneeded subflow-level drops:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251129165825.2129168-2-matttbe@kernel.org/

14334750: [6.1.y] mptcp: Fix proto fallback detection with BPF:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251201104459.3440448-2-matttbe@kernel.org/

14334838: [5.15.y] mptcp: Fix proto fallback detection with BPF:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251201112712.3573321-2-matttbe@kernel.org/

14334874: [5.10.y] mptcp: Fix proto fallback detection with BPF:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251201113457.3641925-2-matttbe@kernel.org/


    our repo (by: Ankit Khushwaha, Matthieu Baerts, Paolo Abeni):

14322543: [v7,mptcp-next,1/6] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
14322544: [v7,mptcp-next,2/6] mptcp: do not account for OoO in mptcp_rcvbuf_grow()
14322546: [v7,mptcp-next,3/6] mptcp: fix receive space timestamp initialization.
14322545: [v7,mptcp-next,4/6] mptcp: consolidate rcv space init
14322547: [v7,mptcp-next,5/6] mptcp: better mptcp-level RTT estimator
14322548: [v7,mptcp-next,6/6] mptcp: add receive queue awareness in tcp_rcv_space_adjust():
    - Series: mptcp: autotune related improvement
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1025709&state=*&archive=both

14324060: [mptcp-net] mptcp: clear scheduled subflows on retransmit:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com/

14324638: [mptcp-net] mptcp: schedule rtx timer only after pushing data:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com/

14330673: selftests: mptcp: initialize raw_addr to Null:
    - Submitter: Ankit Khushwaha
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251126163046.58615-1-ankitkhushwaha.linux@gmail.com/

14330887: [mptcp-net,1/3] mptcp: pm: ignore unknown endpoint flags
14330888: [mptcp-net,2/3] selftests: mptcp: pm: ensure unknown flags are ignored
14330889: [mptcp-net,3/3] mptcp: pm: align endpoint flags size with the NL specs:
    - Series: mptcp: pm: ignore unknown endpoint flags
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1027994&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14321880: [44/44] net/mptcp: Change some dubious min_t(int, ...) to min():
    - State: New
    - Series: Change a lot of min_t() that might mask high bits
    - Submitter: David Laight
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1025544&state=*&archive=both
    - TODO: Matt: check status

14333645: [net-next,v2] selftests: mptcp: Mark xerror __noreturn:
    - State: Changes requested
    - Submitter: Ankit Khushwaha
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251129043808.16714-1-ankitkhushwaha.linux@gmail.com/
    - new version expected in January


    our repo (by: Ankit Khushwaha, Asbjørn Sloth Tønnesen, Christoph Paasch, David Laight, Gang Yan, GangYan, Geliang Tang, Gregory Detal, Matthieu Baerts, Paolo Abeni):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - Status: same as before

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
    - Status: same as before

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same as before

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - Status: same as before

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - Status: same as before

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - Status: same as before

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR between server and client:
    - State: Under review
    - Series: only remove entry from local_addr_list when sending a REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - Status: same as before

14167004: [mptcp-next] mptcp: remove redundant orig_offset in carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
    - Status: same as before

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
    - Status: same as before

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
    - Status: same as before

14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option support
14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket option support:
    - State: Needs ack
    - Series: mptcp: add more sockopts
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
    - Status: same as before

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
    - Status: same as before

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
    - Status: same as before

14326164: [RFC,mptcp-next,v3,1/8] selftests: mptcp: sockopt: add protocol arguments
14326165: [RFC,mptcp-next,v3,2/8] selftests: mptcp: sockopt: enhance compatibility with TCP tests
14326166: [RFC,mptcp-next,v3,3/8] selftests: mptcp: sockopt: implement TCP TLS tests
14326167: [RFC,mptcp-next,v3,4/8] tls: add MPTCP protocol support
14326168: [RFC,mptcp-next,v3,5/8] mptcp: update ULP getsockopt
14326169: [RFC,mptcp-next,v3,6/8] mptcp: enable TLS setsockopt
14326170: [RFC,mptcp-next,v3,7/8] selftests: mptcp: connect: update sock_test_tcpulp
14326171: [RFC,mptcp-next,v3,8/8] selftests: mptcp: sockopt: cover MPTCP KTLS test cases:
    - State: New
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1026573&state=*&archive=both
    - Depends on the "mptcp read_sock" one, will be reviewed after

14327146: [mptcp-next,v14,1/8] mptcp: add eat_recv_skb helper
14327147: [mptcp-next,v14,2/8] mptcp: implement .read_sock
14327148: [mptcp-next,v14,3/8] tcp: add recv_should_stop helper
14327149: [mptcp-next,v14,4/8] mptcp: use recv_should_stop helper
14327150: [mptcp-next,v14,5/8] tcp: export tcp_splice_state
14327151: [mptcp-next,v14,6/8] mptcp: implement .splice_read
14327152: [mptcp-next,v14,7/8] selftests: mptcp: add splice io mode
14327153: [mptcp-next,v14,8/8] selftests: mptcp: connect: cover splice mode:
    - State: New
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1026854&state=*&archive=both
    - To be reviewed

14330153: [RFC,mptcp-next,v2,1/7] mptcp: allow overridden write_space to be invoked
14330154: [RFC,mptcp-next,v2,2/7] mptcp: add sock_set_reuseaddr
14330155: [RFC,mptcp-next,v2,3/7] mptcp: add sock_set_nodelay
14330156: [RFC,mptcp-next,v2,4/7] nvmet-tcp: add mptcp support
14330157: [RFC,mptcp-next,v2,5/7] mptcp: add sock_set_syncnt
14330158: [RFC,mptcp-next,v2,6/7] nvme-tcp: add mptcp support
14330159: [RFC,mptcp-next,v2,7/7] selftests: mptcp: add NVMe-over-MPTCP test:
    - State: New
    - Series: NVME over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1027779&state=*&archive=both
    - Depends on the "mptcp read_sock" one, will be reviewed after

14331259: libnvme: add mptcp trtype:
    - State: New
    - Series: libnvme: add mptcp trtype
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1028094&state=*&archive=both
    - one question for libnvme maintainer

14332026: [RFC,mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt:
    - State: RFC
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org/
    - we should share more code with TCP not to have to adapt MPTCP each time TCP is being modified.

14332838: [mptcp-net] mptcp: sync the msk->sndbuf at accept() time:
    - State: Changes requested
    - Submitter: GangYan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251128094417.14463-1-gang.yan@linux.dev/
    - might be due to WIP patches?

14332987: [mptcp-net] mptcp: fallback earlier on simult connection:
    - State: New
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com/
    - Matth can still reproduce his issue, which seems to have a slightly different root cause, probably a v2 or an  extra fix will be needed

14332999: [net-next] tls: check return value of strp_load_anchor_with_queue:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn/
    - Looks like the issue is due to WIP code, probably the fix should be in these other patches.



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 601):

  602  A query about the update of 'msk->sk_sndbuf' [question]:
      - See the patch that has been sent about that: maybe an issue in the WIP patches?


    Recently discussed:

  600  mptcp: avoid dropping partial packets [bug]:
      - renamed: goal now is to reapply a fix and... fix it

  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]:
      - more details about the issue has been added

  586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]:
      - Paolo sent a patch

  581  Default scheduler under-utilizes newly restored subflows on long-lived flows after WAN failback [bug]

  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST` are unstable [bug] [selftests]:
      - still happening

  213  add MPTCP man page [enhancement]:
      - some new hints for those who want to look at it


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  600  mptcp: avoid dropping partial packets [bug]
  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]
  592  Lower throughput with MPTCP vs TCP [bug]
  587  in-kernel PM: Server is only using single IP to establish subflows [bug]
  586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]
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
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support [enhancement]
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
  396  ci: periodically run selftests from the export branch on stable kernels [enhancement] [selftests]
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


    Recently closed (since 2025-11-19)

  595  selftests: `mptcp_connect`: MPTCP -> MPTCP timeout during closing time [bug] [selftests]
  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out [bug] [selftests]
  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question] [feedback-needed]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a subinterface [bug] [feedback-needed]
  495  [syzkaller] KASAN: slab-use-after-free Read in `__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  476  packetdrill: coalescing feature doesn't take into account MPTCP options [bug] [packetdrill]
  412  shadowsocks-libev not working, need guidance for PM configuration [question] [feedback-needed]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose server test` are sometimes failing [bug] [selftests] @matttbe
  315  Issues with backup flow [bug]
  197  more mibs needed [enhancement]


    Packetdrill PRs

  184  2 days ago     matttbe      mptcp: fallback earlier on simult connection:
      - Linked to Paolo's patch

  162  20 days ago    geliangtang  mptcp: add splice test
  52   10 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcpd PRs:

  329  5 days ago  matttbe  flags: define "implicit":
      - merged!




FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.19): https://github.com/orgs/multipath-tcp/projects/17
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: update changelog + new projects + change links → Done
        https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees:

        - [2505e1b4bea4] selftests: bpf: fix recent compilation errors (Matthieu Baerts (NGI0))
        - [08d7b3f6fe89] selftests: mptcp: initialize raw_addr to Null (Ankit Khushwaha)

    - Fixes for -net:

        - [5a048c302a7a] mptcp: schedule rtx timer only after pushing data (Paolo Abeni):
            - was delayed after a request from Paolo, can be sent now.

        - [197a6e0e0dda] mptcp: pm: ignore unknown endpoint flags (Matthieu Baerts (NGI0))
        - [f5661a6157d5] selftests: mptcp: pm: ensure unknown flags are ignored (Matthieu Baerts (NGI0)):
            - can be sent


    - Fixes for net-next: /


    - Features for net-next:

        - [e2716470e392] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [1d6e4e112d0a] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [42bbbc6012e1] mptcp: pm: add get_priority() interface (Geliang Tang)
        - [83dde12cadbe] mptcp: pm: align endpoint flags size with the NL specs (Matthieu Baerts (NGI0))
        - [d2108181d983] trace: mptcp: add mptcp_rcvbuf_grow tracepoint (Paolo Abeni)
        - [ff42ffc6c36e] mptcp: do not account for OoO in mptcp_rcvbuf_grow() (Paolo Abeni)
        - [f78d06d9dca9] mptcp: fix receive space timestamp initialization (Paolo Abeni)
        - [e626c5eb154b] mptcp: consolidate rcv space init (Paolo Abeni)
        - [710614b1f552] mptcp: better mptcp-level RTT estimator (Paolo Abeni)
        - [bee53f521f91] mptcp: add receive queue awareness in tcp_rcv_space_adjust() (Paolo Abeni):
            - net-next is closed


    - Features for net-next (next): /


    - Features for other trees:

        - [33e6f24a7ddd] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [5c216569692b] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [74d3e560d5bc] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [cbee01cd828c] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [3150383b5113] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [ae9aa73c9e11] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [c4e0a40004ba] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [729063f85404] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [4a35b1194f96] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [dab71ebd7228] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [12152a05a4c6] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang)



Extra tests:
    - news about Syzkaller? (Matth):
        - New issues found, Matth will try to sort that out

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - Jakub's message → Done
        - Some issues with simult flows
        - Also issues with packetdrill:
            - TODO Matth → Done



Next meeting:
    - Next one on Wednesday, the 17th of December.
    - /!\ Note: this meeting will maybe be cancelled: net-next will still be closed, post LPC, pre holiday period, etc.
    - /!\ The one on the 31st of December will be cancelled. Next one on the 14st of January
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20251217
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20260114



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

