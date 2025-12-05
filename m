Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA712494FE
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957478; cv=none; b=ZUCWkkf8RvV6T8qRTIa52/Lkkk/rTrFlTs+GHCen/mX03Ud2KYnDWXXxpLnHDIyW+IFJ7zlx7rLA7qK/BRY8ev01y7Ztvgn5lbzLP9JTQe6d98QpCqr4Hlx3ica9OyeTrA8QkwCw5KJxByfIre96yVrMMk71pGrXxWtn45LG+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957478; c=relaxed/simple;
	bh=W149XLkNyrhh3rqSHAZM8AoY0u6gEMwUpQU9Z7M0LCo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=pQMFQ0cT/slrasIK8fGVwM7Q/ceziJiEArnM3iQsE9vV+DZMOtqSHRw2fA8Ual2WuMAtDWgRQpMdPrBnVzLfliK6QSOE4Eozsv5i2YQ3MZ697CuL5OQ8Q0BWz1dBgl0baZ1scJvOFCHQZakJM3OphJB1pj4hLGt4KczTFopmHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQMult/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQMult/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5706C116B1
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764957478;
	bh=W149XLkNyrhh3rqSHAZM8AoY0u6gEMwUpQU9Z7M0LCo=;
	h=Date:From:To:Subject:From;
	b=MQMult/wDo3fqkFybBojNCvAN1usPjJBAvEKJ9h4uJbUhe5zVi9eeEDSBRLwwPxlb
	 UjVdeRihZ9fEuj/15pviVKXLnnpJhsQVsEYNDgDsvWN0grfGTO6mWbN5bjwufRfeD4
	 MlwHG1sLYhnsbEsefrc7ncaVwrBLJq0Ht+fD2b1b9XTVxLvmjbc0v6sa1MA7vIXMhw
	 K7lQiOn7eRzlHWQFiZCCT+TAEliSE+ch4KWrCvR49dH6hxNTabGadIPhTmUqbUun0J
	 flqxbykks5pRv/Lg67h17Q6AQrARWisXK/pLbSVIxH7EZFrMxxXunzt9VkkvZhm7pA
	 6Z09NMrFyQ6Dg==
Message-ID: <813834d4-42ac-4007-a5d7-aa3331d1fb56@kernel.org>
Date: Fri, 5 Dec 2025 18:57:54 +0100
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
Subject: [Weekly meetings] MoM - 19th of November 2025
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


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14307018: [net,1/6] selftests: mptcp: connect: fix fallback note due to OoO
14307019: [net,2/6] selftests: mptcp: join: rm: set backup flag
14307020: [net,3/6] selftests: mptcp: join: endpoints: longer transfer
14307021: [net,4/6] selftests: mptcp: join: userspace: longer transfer
14307022: [net,5/6] selftests: mptcp: connect: trunc: read all recv data
14307023: [net,6/6] selftests: mptcp: join: properly kill background tasks:
    - Series: selftests: mptcp: join: fix some flaky tests
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1021738&state=*&archive=both

14315201: [net-next,1/8] selftests: mptcp: lib: introduce 'nstat_{init,get}'
14315202: [net-next,2/8] selftests: mptcp: lib: remove stats files args
14315203: [net-next,3/8] selftests: mptcp: lib: stats: remove nstat rate columns
14315204: [net-next,4/8] selftests: mptcp: join: dump stats from history
14315205: [net-next,5/8] selftests: mptcp: lib: get counters from nstat history
14315206: [net-next,6/8] selftests: mptcp: connect: avoid double packet traces
14315207: [net-next,7/8] selftests: mptcp: wait for port instead of sleep
14315208: [net-next,8/8] selftests: mptcp: get stats just before timing out:
    - Series: selftests: mptcp: counter cache & stats before timeout
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1023688&state=*&archive=both

14312890: [5.15.y] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251113152256.3075806-2-matttbe@kernel.org/

14308042: [net,v5,1/3] mptcp: disallow MPTCP subflows from sockmap
14308041: [net,v5,2/3] net,mptcp: fix proto fallback detection with BPF
14308043: [net,v5,3/3] selftests/bpf: Add mptcp test with sockmap:
    - Series: mptcp: Fix conflicts between MPTCP and sockmap
    - Submitter: Jiayuan Chen
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1021867&state=*&archive=both
    - Applied in BPF repo


    our repo (by: Gang Yan, Matthieu Baerts, Paolo Abeni):

14301430: [mptcp-next] selftests: mptcp: Add a check for 'add_addr_accepted':
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251106075457.41025-1-gang.yan@linux.dev/

14303218: [mptcp-net] mptcp: fix ack generation for fallback msk:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com/

14303411: [v2,mptcp-net,1/2] mptcp: decouple mptcp fastclose from tcp close
14303412: [v2,mptcp-net,2/2] mptcp: fix duplicate reset on fastclose:
    - Series: mptcp: fix duplicate reset
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1020769&state=*&archive=both

14303480: [v3,mptcp-next,2/7] mptcp: avoid unneeded subflow-level drops.
14304576: [mptcp-net,1/3] net: factor-out _sk_charge() helper
14304577: [mptcp-net,2/3] mptcp: factor-out cgroup data inherit helper
14304578: [mptcp-net,3/3] mptcp: fix memcg accounting for passive sockets:
    - Series: mptcp: fix memcg accounting for passive sockets
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1021093&state=*&archive=both

14304956: [mptcp-next,1/4] selftests: mptcp: join: properly kill background tasks
14304957: [mptcp-next,2/4] selftests: mptcp: connect: avoid double packet traces
14304958: [mptcp-next,3/4] selftests: mptcp: wait for port instead of sleep
14304959: [mptcp-next,4/4] selftests: mptcp: get stats just before timing out:
    - Series: selftests: mptcp: get stats just before timing out
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1021197&state=*&archive=both

14308982: [mptcp-net] selftests: mptcp: join: fastclose: remove flaky marks:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251111121516.141312-2-matttbe@kernel.org/

14310290: [mptcp-net,1/2] selftests: mptcp: join: endpoints: longer timeout
14310291: [mptcp-net,2/2] selftests: mptcp: join: userspace: longer timeout:
    - Series: selftests: mptcp: join: longer timeout
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1022413&state=*&archive=both

14312334: [mptcp-next] Squash to "selftests: mptcp: get stats just before timing out":
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251113-slft-timeout-stats-kill-v1-1-9a09d8f46392@kernel.org/

14313537: [mptcp-net,1/3] mptcp: fix premature close in case of fallback
14313538: [mptcp-net,2/3] mptcp: do not fallback when OoO is present
14313539: [mptcp-net,3/3] mptcp: do not drop partial packets.:
    - Series: mptcp: a few random fixes
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1023207&state=*&archive=both

14314181: [v4,mptcp-next,1/3] mptcp: grafting MPJ subflow earlier
14314182: [v4,mptcp-next,2/3] Squash-to: "mptcp: fix memcg accounting for passive sockets"
14314183: [v4,mptcp-next,3/3] Squash-to: "mptcp: leverage the backlog for RX packet processing":
    - Series: mptcp: cg and backlog follow-up
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1023415&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jiayuan Chen, Matthieu Baerts):

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


    our repo (by: Christoph Paasch, Gang Yan, Geliang Tang, Gregory Detal, Matthieu Baerts, Paolo Abeni):

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

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR between server and client:
    - State: Under review
    - Series: only remove entry from local_addr_list when sending a REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - status: same as last time

14102233: [mptcp-next,v3,1/3] selftests/bpf: Add sndbuf for send_recv_data
14102235: [mptcp-next,v3,2/3] Squash to "selftests/bpf: Add bpf scheduler test"
14102234: [mptcp-next,v3,3/3] DO-NOT-MERGE: selftests/bpf: Increase total_bytes of bpf sched tests:
    - State: Rejected
    - Series: send() fails with EAGAIN in blocking IO mode "487
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=967210&state=*&archive=both
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

14280548: [mptcp-next,v13,1/8] mptcp: add eat_recv_skb helper
14280549: [mptcp-next,v13,2/8] mptcp: implement .read_sock
14280550: [mptcp-next,v13,3/8] tcp: add recv_should_stop helper
14280551: [mptcp-next,v13,4/8] mptcp: use recv_should_stop helper
14280552: [mptcp-next,v13,5/8] tcp: export tcp_splice_state
14280553: [mptcp-next,v13,6/8] mptcp: implement .splice_read
14280554: [mptcp-next,v13,7/8] selftests: mptcp: add splice io mode
14280555: [mptcp-next,v13,8/8] selftests: mptcp: connect: cover splice mode:
    - State: Needs ack
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1014823&state=*&archive=both
    - status: same as last time
    - Mat will try to look at it

14299674: [mptcp-next,v6,1/7] tcp: md5: remove redundant l3flag variable
14299675: [mptcp-next,v6,2/7] mptcp: handle TCP_MAXSEG getsockopt in common case
14299676: [mptcp-next,v6,3/7] mptcp: setsockopt support for TCP_MD5SIG
14299677: [mptcp-next,v6,4/7] selftests: mptcp: sockopt: add md5 argument
14299678: [mptcp-next,v6,5/7] selftests: mptcp: sockopt: implement TCP_MD5SIG support
14299679: [mptcp-next,v6,6/7] selftests: mptcp: sockopt: skip getsockopt for MD5 tests
14299680: [mptcp-next,v6,7/7] selftests: mptcp: sockopt: add TCP_MD5SIG test cases:
    - State: Needs ack
    - Series: mptcp: TCP_MD5SIG support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1019796&state=*&archive=both
    - status: same as last time

14303298: [RFC,mptcp-next,1/6] mptcp: add sock_set_nodelay
14303299: [RFC,mptcp-next,2/6] nvmet-tcp: add mptcp support
14303300: [RFC,mptcp-next,3/6] mptcp: add sock_set_reuseaddr
14303301: [RFC,mptcp-next,4/6] nvme-tcp: add mptcp support
14303302: [RFC,mptcp-next,5/6] selftests: mptcp: add NVMe-over-MPTCP test
14303303: [RFC,mptcp-next,6/6] nvmet-tcp: clear MSG_DONTWAIT for MPTCP (TODO: HELP WANTED):
    - State: New
    - Series: NVME over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1020727&state=*&archive=both

14310987: [iproute-mptcp,1/6] MAINTAINERS: add entry for mptcp
14310988: [iproute-mptcp,2/6] man: mptcp: fix minor typos
14310989: [iproute-mptcp,3/6] mptcp: add 'laminar' endpoint support
14310990: [iproute-mptcp,4/6] mptcp: monitor: add 'server side' info
14310991: [iproute-mptcp,5/6] mptcp: monitor: add 'deny join id0' info
14310992: [iproute-mptcp,6/6] mptcp: monitor: support 'server side' as a flag:
    - State: New
    - Series: mptcp: new endpoint type and info flags
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1022585&state=*&archive=both
    - Maintainers file: only Matthieu's name (usually only one person there), but mainly to have the list. Can add more if preferred.
    - Will send this by the end of the week

14318800: [mptcp-next,v2] Squash to "mptcp: implement .read_sock":
    - State: New
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/ae97ac245e5031422c18b3c2c2b37c3aad33cc23.1763451700.git.tanggeliang@kylinos.cn/

14320462: [RFC,mptcp-next,v2,1/8] tls: add MPTCP protocol support
14320463: [RFC,mptcp-next,v2,2/8] mptcp: enable TLS setsockopt
14320464: [RFC,mptcp-next,v2,3/8] mptcp: update ULP getsockopt
14320465: [RFC,mptcp-next,v2,4/8] selftests: mptcp: connect: update sock_test_tcpulp
14320466: [RFC,mptcp-next,v2,5/8] selftests: mptcp: connect: fix uninitialized peer warning
14320467: [RFC,mptcp-next,v2,6/8] selftests: mptcp: sockopt: add protocol arguments
14320468: [RFC,mptcp-next,v2,7/8] selftests: mptcp: sockopt: skip mptcp getsockopt for tcp tests
14320469: [RFC,mptcp-next,v2,8/8] selftests: mptcp: sockopt: add KTLS test cases:
    - State: New
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1025245&state=*&archive=both
    - Will try to look at it
    - That's nice to have such support!
    - We will probably need a layer of abstraction (if some indirections are accepted) or helpers/macros

14320609: [mptcp-next,v5,1/5] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
14320610: [mptcp-next,v5,2/5] mptcp: fix receive space timestamp initialization.
14320612: [mptcp-next,v5,3/5] mptcp: consolidate rcv space init
14320611: [mptcp-next,v5,4/5] mptcp: better mptcp-level RTT estimator
14320613: [mptcp-next,v5,5/5] mptcp: add receive queue awareness in tcp_rcv_space_adjust():
    - State: New
    - Series: mptcp: autotune related improvement
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1025302&state=*&archive=both
    - divide error, but probably doesn't affect the new algo and "easy" to fix
    - Matth will check why the CI reported "timeout" + no full file paths



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 596):

  600  selftests: `mptcp_connect.sh`: MPTFO, timeout with lot of `ZeroWindowAdv` [bug] [selftests]:
      - The problematic patch got reverted
      - TODO: Matth: rename the ticket: to reintroduce the fix without the issue → Done

  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]:
      - False positive (no big deal!), but should still be used
      - is it normal that MPTCP is being used?

    Recently discussed:

  595  selftests: `mptcp_connect`: MPTCP -> MPTCP timeout during closing time [bug] [selftests]
  592  Lower throughput with MPTCP vs TCP [bug]
  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug] [pm]
  480  MPTCP and KTLS support [enhancement] @geliangtang


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  600  selftests: `mptcp_connect.sh`: MPTFO, timeout with lot of `ZeroWindowAdv` [bug] [selftests]
  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]
  595  selftests: `mptcp_connect`: MPTCP -> MPTCP timeout during closing time [bug] [selftests]
  592  Lower throughput with MPTCP vs TCP [bug]
  587  in-kernel PM: Server is only using single IP to establish subflows [bug]
  586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]
  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
  581  Default scheduler under-utilizes newly restored subflows on long-lived flows after WAN failback [bug]
  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out [bug] [selftests]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  567  [syzbot] WARNING in `__mark_subflow_endp_available` [bug] [syzkaller] [reproducer]
  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug] [pm]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a subinterface [bug] [feedback-needed]
  495  [syzkaller] KASAN: slab-use-after-free Read in `__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST` are unstable [bug] [selftests]
  483  [6.1] selftests: `mptcp_connect.sh` failures with `copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug] [selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


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

  562  [performance] How much is the overhead of MPTCP？ [question]
  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question] [feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration [question] [feedback-needed]


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
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path [enhancement]
   78  notify the application (userspace) when a subflow is added/removed [enhancement]
   41  reduce indirect call usage [enhancement]


    Recently closed (since 2025-11-05)

  601  selftests: `mptcp_connect.sh`: reset, no MIB counters explaining why [bug] [selftests]
  598  WARNING in `__mptcp_move_skbs_from_subflow()` [bug] [packetdrill]
  597  mem_cg related splat on top of current export branch [bug] @pabeni
  596  selftests: `mptcp_join`: fastclose also generate "plain" RST [bug] [selftests] @pabeni
  594  selftests: `mptcp_connect`: MPTCP -> TCP timeout during closing time [bug] [selftests]
  591  in-kernel PM: not established paths when used with IPv6 link-local addresses [bug]
  298  CG Memory accounting for passive MPTCP socket [enhancement]


    Packetdrill PRs

  181  9 days ago     matttbe      mptcp: new DATA_FIN retrans tests:
      - can be merged?
      - TODO: merge? → done

  180  26 days ago    matttbe      mptcp: unskip TCP_NOTSENT_LOWAT test:
      - can be merged?
      - TODO: merge? → Done

  162  6 days ago     geliangtang  mptcp: add splice test:
      - pinged, but no pong

  52   10 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs

  71  6 days ago  matttbe  pm: small update + `laminar`


    mptcpd PRs

  326  5 days ago  matttbe  flags: add 'laminar' endpoints support:   



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.19): https://github.com/orgs/multipath-tcp/projects/17
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:

        - [43689f24380c] selftests: bpf: fix recent compilation errors (Matthieu Baerts (NGI0)):
            - still needed apparently

        - [77b02bfc4fc3] mptcp: Disallow MPTCP subflows from sockmap (Jiayuan Chen)
        - [3a5baed0f2fd] mptcp: Fix proto fallback detection with BPF (Jiayuan Chen)
        - [bc0112c2ac6e] selftests/bpf: Add mptcp test with sockmap (Jiayuan Chen):
            - applied in Linus tree, should come to us by the end of the week

    - Fixes for -net:

        - [c6baa8f48f53] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr (Gang Yan)
        - [abb36ac2ec5c] selftests: mptcp: add a check for 'add_addr_accepted' (Gang Yan)
        - [0a166bebc74b] mptcp: decouple mptcp fastclose from tcp close (Paolo Abeni)
        - [ec749a920124] mptcp: fix duplicate reset on fastclose (Paolo Abeni)
        - [1d4a85d44923] selftests: mptcp: join: fastclose: remove flaky marks (Matthieu Baerts (NGI0))
        - [dd44da1d9321] mptcp: fix ack generation for fallback msk (Paolo Abeni)
        - [02cc86bdc5a3] mptcp: avoid unneeded subflow-level drops (Paolo Abeni)
        - [4fa8551095e6] mptcp: fix premature close in case of fallback (Paolo Abeni)
        - [4d968e986442] mptcp: do not fallback when OoO is present (Paolo Abeni)
        - [2ede17bd17b6] selftests: mptcp: join: endpoints: longer timeout (Matthieu Baerts (NGI0))
        - [a816f7d4cec1] selftests: mptcp: join: userspace: longer timeout (Matthieu Baerts (NGI0)):
            - all sent

    - Fixes for net-next: /


    - Features for net-next:

        - [45911145fbce] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [380412539183] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [2582b48de439] mptcp: pm: add get_priority() interface (Geliang Tang):
            - Waiting for pm->lock refactoring

        - [98d3f2f5e9e4] net: factor-out _sk_charge() helper (Paolo Abeni)
        - [0d14005db26d] mptcp: factor-out cgroup data inherit helper (Paolo Abeni)
        - [4254ebdfce38] mptcp: grafting MPJ subflow earlier (Paolo Abeni)
        - [cc20bef68be9] mptcp: fix memcg accounting for passive sockets (Paolo Abeni)
        - [615d7d34c331] mptcp: cleanup fallback data fin reception (Paolo Abeni)
        - [c72d33fa5b18] mptcp: cleanup fallback dummy mapping generation (Paolo Abeni)
        - [3b9956beab27] mptcp: ensure the kernel PM does not take action too late (Paolo Abeni)
        - [eab10ae58605] mptcp: do not miss early first subflow close event notification (Paolo Abeni)
        - [b27779898877] mptcp: make mptcp_destroy_common() static (Paolo Abeni)
        - [b45c378f0c08] mptcp: drop the __mptcp_data_ready() helper (Paolo Abeni)
        - [d445e93656fb] mptcp: handle first subflow closing consistently (Paolo Abeni)
        - [d94e261abd8a] mptcp: borrow forward memory from subflow (Paolo Abeni)
        - [d26b87fcdce2] mptcp: introduce mptcp-level backlog (Paolo Abeni)
        - [ea55e3b346f0] mptcp: leverage the backlog for RX packet processing (Paolo Abeni):
            - can be sent by the end of the week, after net/net-next sync
            - should have some time to accept the "auto-tune related improvement" series

    - Features for net-next (next): /

    - Features for other trees:

        - [70d35803cca2] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [c6b29889f3ee] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [073241f21f05] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [8d9622a111aa] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [67709dea3ed0] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [33043b8b3ad9] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [287c15b7bc89] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [195c04a464b4] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [ebcc8daa8ca2] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [7b2c03a89754] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [ce38476ab06e] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang):
            - Waiting for sched API refactoring



Extra tests:
    - news about Syzkaller? (Matth):
        - some fixes from Eric
        - some issues linked to nbd
        - CONFIG_PREEMPT has been enabled on one of them

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - monitoring MPTCP Join "multi flows, signal, bidi, link fail" selftest
        - less flakes in the selftests, but more in the packetdrill tests :-/



NetworkManager:
    - Now support the "laminar" endpoint, and will set it by default.
    - https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/merge_requests/2314



MPTCP old fork:
    - recently got a small update with some small fixes
    - kept archived to clearly indicate it should no longer be used
    - https://github.com/multipath-tcp/mptcp



Next meeting:
    - Next one on Wednesday, the 3rd of December. → Done
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20251203



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

