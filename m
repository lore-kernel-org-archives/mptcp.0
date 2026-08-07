Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA5282F21
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126638; cv=none; b=FONKG6Wb5M+55k+6Tn0QRbDnZu2MxCz9JCqoeGWCQQoEo1Svj87PK0QgtIVJvYz5OjjPnkJ5/ps5KL2IUwyB6VNPSVhXOrDqOmYz3eBIv99AOZHZ7zrNuMt49TKMB1iUpUH4DSZ1MRf0bPAB2mA0pzW8AqlbKBlPXsBKrJUWAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126638; c=relaxed/simple;
	bh=xkFrMhB2HXvOmijsTcXK1hwp7Q50PbGDXqUqU+wnzcM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=lQxP9Zgf8azSIGgxpaClz5j4zKPPc+NiAeiNfhlzXx7mhGAi/hmysHN8u7h79rLHae0I2IJSFCCcs4RzLo7x/4A6vV1weofyVL2pF6T66EdEujAQRGUYDroEHlYKsvDQeohvYm0iOcRhYXJyZG0GUEVxSxoaprkxUhjirF3SrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIVsNyLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIVsNyLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE6B1F000E9
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786126635;
	bh=PQmjpWTcLhtRvacKezpJ7aQ4+U9+aoQnlRh8RmEZVEA=;
	h=Date:From:To:Subject;
	b=RIVsNyLNw70kGGZrvKArm8X7Jaa2/BrHUgS2aq7+kCRcFSQgP3SmMUK97ONvX239q
	 EW71bw9+Eu645/ZinF49W8qHGOr12FS/qNSdgqmy4hR/7jrQ8Vmpo7M1WY2S5RhyoJ
	 qw65nBc/PVF72exQoXOqJF024qO6PwAlG+NMEP4fs/PlGzleWd+lq3s6DUTxnqHe73
	 Ofc1f/F+sUuzgecbpUNj7quDJU2jV1c4hTnqAK0VHvx0783kfPcDzt00gU3Gigl8kU
	 MJ0jPKerJREXsxle6wbPfqGMitGm48tdZRgtQVprnR2TKBbHciMF0OGGn9QylMIkle
	 0DG/xwVhO2QnQ==
Message-ID: <c4348f04-b680-4637-8edb-8fce0ade9c3c@kernel.org>
Date: Fri, 7 Aug 2026 20:17:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 17th of June 2026
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had a meeting with Mat (Cruise), Gang (Kylin),
Shardul (mpiric) and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14585647: [6.12.y,1/4] mptcp: sync the msk->sndbuf at accept() time
14585648: [6.12.y,2/4] mptcp: pm: ADD_ADDR rtx: allow ID 0
14585649: [6.12.y,3/4] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
14585650: [6.12.y,4/4] mptcp: pm: ADD_ADDR rtx: free sk if last:
    - Series: mptcp: fix recent failed backports (20260521)
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1098411&state=*&archive=both

14585671: [6.6.y,1/4] mptcp: sync the msk->sndbuf at accept() time
14585672: [6.6.y,2/4] mptcp: pm: ADD_ADDR rtx: allow ID 0
14585673: [6.6.y,3/4] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
14585674: [6.6.y,4/4] mptcp: pm: ADD_ADDR rtx: free sk if last:
    - Series: mptcp: fix recent failed backports (20260521)
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1098418&state=*&archive=both

14606956: [net,v2,01/11] mptcp: fix missing wakeups in edge scenarios
14606957: [net,v2,02/11] mptcp: fix retransmission loop when csum is enabled
14606958: [net,v2,03/11] mptcp: close TOCTOU race while computing rcv_wnd
14606959: [net,v2,04/11] mptcp: allow subflow rcv wnd to shrink
14606960: [net,v2,05/11] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
14606961: [net,v2,06/11] selftests: mptcp: add test for extra_subflows underflow on userspace PM
14606962: [net,v2,07/11] mptcp: sockopt: check timestamping ret value
14606963: [net,v2,08/11] mptcp: sockopt: set sockopt on all subflows
14606964: [net,v2,09/11] mptcp: check desc->count in read_sock
14606965: [net,v2,10/11] mptcp: fix uninit-value in mptcp_established_options
14606966: [net,v2,11/11] mptcp: add-addr: always drop other suboptions:
    - Series: mptcp: misc fixes for v7.1-rc7
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1104607&state=*&archive=both

14613040: [net-next,v2,01/15] mptcp: options: suboptions sizes can be negative
14613041: [net-next,v2,02/15] mptcp: pm: avoid computing rm_addr size twice
14613042: [net-next,v2,03/15] mptcp: pm: avoid computing add_addr size twice
14613043: [net-next,v2,04/15] mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
14613044: [net-next,v2,05/15] tcp: allow mptcp to drop TS for some packets
14613045: [net-next,v2,06/15] mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
14613046: [net-next,v2,07/15] selftests: mptcp: validate ADD_ADDRv6 + TS + port
14613047: [net-next,v2,08/15] selftests: mptcp: always check sent/dropped ADD_ADDRs
14613048: [net-next,v2,09/15] mptcp: pm: use for_each_subflow helper
14613049: [net-next,v2,10/15] mptcp: pm: rename add_entry structure to add_addr
14613050: [net-next,v2,11/15] mptcp: pm: uniform announced addresses helpers
14613051: [net-next,v2,12/15] mptcp: pm: remove add_ prefix from timer
14613052: [net-next,v2,13/15] mptcp: pm: make mptcp_pm_add_addr_send_ack static
14613053: [net-next,v2,14/15] mptcp: pm: avoid using del_timer directly
14613054: [net-next,v2,15/15] mptcp: options: rst: drop unused skb parameter:
    - Series: mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1106483&state=*&archive=both


    our repo (by: Gang Yan, Geliang Tang, Matthieu Baerts, Paolo Abeni, Tao Cui):

14581352: [mptcp-net] selftests: mptcp: sockopt: set EXIT trap earlier:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/b681d1061e68faeb0d4fd68c23c09852d90385da.1779185611.git.tanggeliang@kylinos.cn/

14588783: [mptcp-net,v4,1/2] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
14588784: [mptcp-net,v4,2/2] selftests: mptcp: add test for extra_subflows underflow on userspace PM:
    - Series: mptcp: pm: fix extra_subflows underflow for userspace PM
    - Submitter: Tao Cui
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1099222&state=*&archive=both

14588785: [mptcp-next] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow:
    - Submitter: Tao Cui
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260522085049.1896537-1-cuitao@kylinos.cn/

14590443: [v8,mptcp-next,1/9] mptcp: fix missing wakeups in edge scenarios
14590444: [v8,mptcp-next,2/9] mptcp: fix retransmission loop when csum is enabled
14590445: [v8,mptcp-next,3/9] mptcp: close TOCTOU race while computing rcv_wnd
14594528: [mptcp-next] mptcp: remove unused data_ack from struct mptcp_ext:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn/

14596308: [mptcp-net] mptcp: sockopt: check timestamping ret value:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260527-mptcp-sockopt-timestamping-ret-v1-1-8eda97e24562@kernel.org/

14596603: [mptcp-net] mptcp: sockopt: set sockopt on all subflows:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260527-mptcp-sockopt-all-sf-no-break-v1-1-4318be7b1e22@kernel.org/

14597067: [v9,mptcp-next,1/6] mptcp: allow subflow rcv wnd to shrink
14597068: [v9,mptcp-next,2/6] mptcp: explicitly drop over memory limits
14597069: [v9,mptcp-next,3/6] mptcp: enforce hard limit on backlog flushing
14597070: [v9,mptcp-next,4/6] mptcp: implemented OoO queue pruning

14600209: [mptcp-net,mptcp-next,v4,01/15] mptcp: pm: avoid sleeping while holding rcu_read_lock

14600210: [mptcp-next,v4,02/15] mptcp: options: suboptions sizes can be negative
14600211: [mptcp-next,v4,03/15] mptcp: pm: avoid computing rm_addr size twice
14600213: [mptcp-next,v4,04/15] mptcp: pm: avoid computing add_addr size twice
14600214: [mptcp-next,v4,05/15] mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
14600212: [mptcp-next,v4,06/15] tcp: allow mptcp to drop TS for some packets
14600215: [mptcp-next,v4,07/15] mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
14600216: [mptcp-next,v4,08/15] selftests: mptcp: validate ADD_ADDRv6 + TS + port
14600217: [mptcp-next,v4,09/15] selftests: mptcp: always check sent/dropped ADD_ADDRs
14600218: [mptcp-next,v4,10/15] mptcp: pm: use for_each_subflow helper
14600219: [mptcp-next,v4,11/15] mptcp: pm: rename add_entry structure to add_addr
14600220: [mptcp-next,v4,12/15] mptcp: pm: uniform announced addresses helpers
14600221: [mptcp-next,v4,13/15] mptcp: pm: remove add_ prefix from timer
14600222: [mptcp-next,v4,14/15] mptcp: pm: make mptcp_pm_add_addr_send_ack static
14600223: [mptcp-next,v4,15/15] mptcp: pm: avoid using del_timer directly:
    - Series: mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1102593&state=*&archive=both

14600615: [mptcp-net,v3] mptcp: check desc->count in read_sock:
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260529-read_sock_fix-v3-1-bb3fc3f44b22@kylinos.cn/

14600621: [mptcp-net] mptcp: fix uninit-value in mptcp_established_options:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/d776e14d19a313dd697e3715121f4e42e915287d.1780045909.git.pabeni@redhat.com/

14600838: [v10,mptcp-next,1/3] Squash-to: "mptcp: implemented OoO queue pruning"
14602906: [mptcp-next] Squash-to: "mptcp: implemented OoO queue pruning":
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com/

14604413: [mptcp-next,1/4] Squash to: "mptcp: introduce add_addr_v6_port_drop_ts sysctl knob"
14604414: [mptcp-next,2/4] Squash to "tcp: allow mptcp to drop TS for some packets"
14604415: [mptcp-next,3/4] Squash to "mptcp: pm: drop TCP TS with ADD_ADDRv6 + port"
14604653: [net-next] mptcp: change mptcp_established_options() to return opt_size:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org/

14606321: [mptcp-net,1/2] mptcp: add-addr: always drop other suboptions
14606322: [mptcp-net,2/2] mptcp: options: rst: drop unused skb parameter:
    - Series: mptcp: add-addr: always drop other suboptions + unused param
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1104427&state=*&archive=both

14609066: [v12,mptcp-next,1/2] mptcp: move the retrans loop to a separate helper
14609067: [v12,mptcp-next,2/2] mptcp: let the retrans scheduler do its job.:
    - Series: mptcp: address stall under memory pressure
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1105193&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts):

14530439: [v2] selftests: harness: fix pidfd leak in __wait_for_test:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn/

14597303: [net,1/3] selftests: mptcp: simult_flows: disable GSO
14597304: [net,2/3] selftests: mptcp: simult_flows: adapt limits
14597305: [net,3/3] selftests: mptcp: sockopt: set EXIT trap earlier:
    - Series: selftests: mptcp: reduce bufferbloat and cleanup
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1101626&state=*&archive=both

14613468: [net] tls: restore sk_prot before calling original destructor:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn/


    our repo (by: Christoph Paasch, David Carlier, Gang Yan, Geliang Tang, Gregory Detal, Kalpan Jani, Kuniyuki Iwashima, Li Xiasong, Matthieu Baerts, Ren Wei, Shardul Bankar, Tao Cui):

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

14552287: [v2] mptcp: Clear mptcp_out_options in mptcp_{syn,synack,established}_options().:
    - State: Needs ack
    - Submitter: Kuniyuki Iwashima
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260504044051.3725846-1-kuniyu@google.com/
    - Superseded

14562644: [mptcp-net,v4,1/2] mptcp: use sockopt_lock(release)_sock in sockopt
14562643: [mptcp-net,v4,2/2] mptcp: use sockopt_ns_capable() in setsockopt congestion control:
    - State: Changes requested
    - Series: mptcp: convert to sockopt_lock_sock
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1091935&state=*&archive=both
    - status: same as last time

14563920: [net,v2,1/1] mptcp: fix request ownership when cloning reqsk:
    - State: Changes requested
    - Series: [net,v2,1/1] mptcp: fix request ownership when cloning reqsk
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1092284&state=*&archive=both
    - TODO: Matth: check if a new version is needed → done

14572928: [mptcp-next,v3,1/2] mptcp: pm: fix extra_subflows underflow on userspace PM connect failure
14572929: [mptcp-next,v3,2/2] mptcp: pm: fix extra_subflows leak on userspace PM subflow close race:
    - State: Changes requested
    - Series: mptcp: pm: fix extra_subflows underflow for userspace PM
    - Submitter: Tao Cui
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1094801&state=*&archive=both
    - status: same as last time

14588804: [mptcp-next,v5,1/6] mptcp: replace lock_sock_fast with lock_sock in sockopt
14588805: [mptcp-next,v5,2/6] mptcp: use sockopt_lock/release_sock in sockopt
14588806: [mptcp-next,v5,3/6] mptcp: use sockopt_ns_capable in congestion control
14588807: [mptcp-next,v5,4/6] mptcp: reject sockopt requiring ssks' lock in BPF context
14588808: [mptcp-next,v5,5/6] DO-NOT-MERGE: mptcp: allow set some sockopt in BPF context
14588809: [mptcp-next,v5,6/6] DO-NOT-MERGE: selftest: bpf: set mptcp sockopt in BPF context:
    - State: New
    - Series: mptcp: convert to sockopt_lock_sock
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1099233&state=*&archive=both
    - To be reviewed: Paolo reviewed a previous version, TODO: check with him → done

14593230: mptcp: pm: don't WARN on re-announced addr in kernel PM:
    - State: New
    - Series: mptcp: pm: don't WARN on re-announced addr in kernel PM
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1100453&state=*&archive=both
    - TODO: Matth: check if there is a new version with a different title → done

14593680: [mptcp-net,v3] mptcp: fix divide-by-zero in __mptcp_push_pending close path:
    - State: New
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260525194828.1137119-1-shardul.b@mpiricsoftware.com/
    - TODO: Matth: review and / or check with Paolo → done

14594661: [mptcp-net,1/2] net: add sk_shutdown_timer_sync() helper
14594662: [mptcp-net,2/2] mptcp: use sk_shutdown_timer_sync() for add_addr timer teardown:
    - State: New
    - Series: mptcp: prevent add_addr timer rearm during teardown
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1100863&state=*&archive=both
    - Was there a new version suggested by someone else?

14598366: [01/11] nvmet-tcp: define accept tcp_proto struct
14598367: [02/11] nvmet-tcp: implement accept mptcp proto
14598368: [03/11] nvmet-tcp: define listen socket ops
14598369: [04/11] nvmet-tcp: register target mptcp transport
14598370: [05/11] nvmet-tcp: implement mptcp listen socket ops
14598371: [06/11] nvme-fabrics: compare transport in ip_options_match
14598372: [07/11] nvme-tcp: define host tcp_proto struct
14598373: [08/11] nvme-tcp: register host mptcp transport
14598374: [09/11] nvme-tcp: implement host mptcp proto
14598375: [10/11] selftests: mptcp: add nvme over mptcp test
14598376: [11/11] selftests: mptcp: nvme: add iopolicy tests:
    - State: New
    - Series: NVMe over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1101939&state=*&archive=both
    - TODO: check the comments → done?

14600446: [mptcp-next] mptcp: add TCP ULP module alias:
    - State: Rejected
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/c7f74bd00fd5073d39fae2818aaa12da102a3ad4.1780039666.git.tanggeliang@kylinos.cn/

14600597: [net,v3] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint:
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com/
    - TODO: Matth: check this → done

14602587: [mptcp-next,1/5] tls: add clone callback to prevent NULL crash case
14602588: [mptcp-next,2/5] tls: init mixed SW/TOE proto to prevent NULL call
14602589: [mptcp-next,3/5] tls: fix concurrency in TOE device list iterations
14602590: [mptcp-next,4/5] tcp: add socket lock to TCP_ULP getsockopt safely
14602591: [mptcp-next,5/5] tcp: fix ULP diag race by RCU read locks properly:
    - State: New
    - Series: Fixes for TLS and ULP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103235&state=*&archive=both
    - New version needed, can be sent to netdev directly if it is not directly related to MPTCP

14603782: [mptcp-next,v11,1/4] mptcp: sockopt: factor inet_flags propagation into a mask
14603783: [mptcp-next,v11,2/4] mptcp: propagate RECVERR sockopts to subflows
14603784: [mptcp-next,v11,3/4] mptcp: support MSG_ERRQUEUE on the parent socket
14603785: [mptcp-next,v11,4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation:
    - State: New
    - Series: mptcp: MSG_ERRQUEUE support on the parent socket
    - Submitter: David Carlier: don't WARN on re-announced addr in
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103609&state=*&archive=both
    - TODO: Matth: check this → done

14604416: [mptcp-next,4/4] mptcp: use READ_ONCE() over sysctls:
    - State: New
    - Series: Fixes for "mptcp: pm: drop TCP TS with ADD_ADDRv6 + port"
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103837&state=*&archive=both
    - TODO: Matth: open a new issue to continue this patch → TODO

14604419: [net,v4] mptcp: fix stale skb->sk reference on subflow close:
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260601083010.924938-1-kalpan.jani@mpiricsoftware.com/
    - v4 should have the same diff, but a new commit description
    - TODO: Matth: check this → Done

14609302: [mptcp-net] mptcp: pm: use timer_shutdown_sync() on free paths:
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260603115634.2292342-1-kalpan.jani@mpiricsoftware.com/
    - Linked to "mptcp: prevent add_addr timer rearm during teardown"

14614582: [mptcp_net-next,1/1] mptcp: fastopen: only mark MPTFO subflows with SYN data:
    - State: New
    - Series: [mptcp_net-next,1/1] mptcp: fastopen: only mark MPTFO subflows with SYN data
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1106932&state=*&archive=both
    - Matth has a reproducer
    - TODO: Matth: check the patch → Done

14618202: [mptcp-next,v4,1/2] mptcp: implement .splice_eof
14618203: [mptcp-next,v4,2/2] selftests: mptcp: connect: trigger splice_eof:
    - State: New
    - Series: implement .splice_eof
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1108212&state=*&archive=both
    - TODO: to be reviewed → TODO!!

14618211: [RFC,mptcp-next,v25,01/22] mptcp: add sendmsg_locked to proto_ops
14618212: [RFC,mptcp-next,v25,02/22] tls: use sendmsg_locked from the underlying socket
14618213: [RFC,mptcp-next,v25,03/22] mptcp: implement peek_len for proto_ops
14618214: [RFC,mptcp-next,v25,04/22] tls: replace tcp_inq with socket peek_len
14618215: [RFC,mptcp-next,v25,05/22] tls: store original poll for non-TCP sockets
14618216: [RFC,mptcp-next,v25,06/22] tls: store original read_sock for non-TCP sockets
14618217: [RFC,mptcp-next,v25,07/22] tls: add per-protocol cache for mptcp support
14618218: [RFC,mptcp-next,v25,08/22] tls: introduce tls protocol ops structure
14618219: [RFC,mptcp-next,v25,09/22] tls: store protocol ops pointer in tls_proto
14618220: [RFC,mptcp-next,v25,10/22] mptcp: implement mptcp-specific tls protocol ops
14618221: [RFC,mptcp-next,v25,11/22] tls: disable device offload for mptcp sockets
14618222: [RFC,mptcp-next,v25,12/22] mptcp: update mptcp_check_readable helper
14618223: [RFC,mptcp-next,v25,13/22] mptcp: implement ulp getsockopt for tls support
14618224: [RFC,mptcp-next,v25,14/22] mptcp: implement ulp setsockopt for tls support
14618225: [RFC,mptcp-next,v25,15/22] selftests: mptcp: connect: use espintcp for ulp test
14618226: [RFC,mptcp-next,v25,16/22] selftests: tls: add mptcp variant for testing
14618227: [RFC,mptcp-next,v25,17/22] selftests: tls: increase pollin timeouts for mptcp
14618228: [RFC,mptcp-next,v25,18/22] selftests: tls: increase nonblocking data size for mptcp
14618229: [RFC,mptcp-next,v25,19/22] selftests: tls: retry bind for mptcp in shutdown_reuse
14618230: [RFC,mptcp-next,v25,20/22] selftests: tls: set timeout for multi_chunk_sendfile
14618231: [RFC,mptcp-next,v25,21/22] selftests: tls: add mptcp test cases
14618232: [RFC,mptcp-next,v25,22/22] selftests: mptcp: cover mptcp tls tests:
    - State: New
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1108217&state=*&archive=both
    - TODO: to be reviewed → TODO

14623068: [net,v3] mptcp: pm: fix memory leak from alloc-during-teardown race:
    - State: New
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260611003613.3184956-1-shardul.b@mpiricsoftware.com/
    - TODO: Matth: send to the CI + review → Done

14624989: [v4,1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
14624990: [v4,2/2] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters:
    - State: New
    - Series: mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1110277&state=*&archive=both
    - TODO: Matth: to be reviewed → Done

14625441: [mptcp-next] mptcp: bpf: fix NULL derefs in bpf_mptcp_sock_from_subflow():
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com/
    - A fix for net, to be reviewed

14632676: [mptcp-next] mptcp: fix lockdep splat in mptcp_subflow_create_socket:
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com/
    - To be reviewed → Done

14633593: [mptcp-next,v3] mptcp: honour configured min/max RTO in retransmit paths:
    - State: New
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260617114508.253716-1-kalpan.jani@mpiricsoftware.com/
    - To be reviewed → Done

14633653: [mptcp-next] Squash to "bpf: Export mptcp packet scheduler helpers":
    - State: New
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/10a30ed6484cc4d48009625f1ed8e12802e78e94.1781699193.git.tanggeliang@kylinos.cn/
    - To be reviewed → done

14633827: [mptcp-next,v2,1/9] DO-NOT-MERGE: mptcp: test IPV6=m in docker-virtme
14633828: [mptcp-next,v2,2/9] selftests: mptcp: mptcp_lib add runtime IPv6 availability detection helper
14633829: [mptcp-next,v2,3/9] selftests: mptcp: mptcp_connect.sh degrades to v4-only when MPTCP IPv6 is missing
14633830: [mptcp-next,v2,4/9] selftests: mptcp: mptcp_connect.sh don't fail because of nft rules in IPV6-less kernel
14633831: [mptcp-next,v2,5/9] selftests: mptcp: mptcp_sockopt.sh skips v6 paths when MPTCP IPv6 is missing
14633832: [mptcp-next,v2,6/9] selftests: mptcp: simult_flows.sh skips v6 setup when MPTCP IPv6 is missing
14633833: [mptcp-next,v2,7/9] selftests: mptcp: mptcp_join.sh: pick v4 bind default when MPTCP IPv6 is missing
14633834: [mptcp-next,v2,8/9] selftests: mptcp: mptcp_join.sh skips v6 subtests when MPTCP IPv6 is missing
14633835: [mptcp-next,v2,9/9] selftests: mptcp: userspace_pm.sh skips v6 paths when MPTCP IPv6 is missing:
    - State: New
    - Series: selftests: mptcp: skip the v6 subtests when CONFIG_MPTCP_IPV6=n
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1112987&state=*&archive=both
    - It might not be accepted on netdev now that we can no longer have CONFIG_IPV6=m




Extra, just in case



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 623):
        
        /

    Recently discussed:

  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]


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
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST` are unstable [bug] [selftests]
  483  [6.1] selftests: `mptcp_connect.sh` failures with `copyfd_io_poll: poll timed out` errors [bug] [selftests]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug] [selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]


    In Progress (opened, new feature and assigned)

  568  socket option: support `IPV6_TCLASS` [enhancement] @geliangtang
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support [enhancement] [bpf] @geliangtang
  480  MPTCP and KTLS support [enhancement] @geliangtang
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


    Recently closed (since 20260520)

  492  userspace pm: subflows counter: not updated when a subflows is removed from the other end [bug]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps are enabled [enhancement] @matttbe


    Packetdrill PRs

  162  4 months ago  geliangtang  mptcp: add splice test
  52   1 year ago    dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs



    mptcp-upstream-virtme-docker PRs



    mptcpd PRs





FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (7.2): https://github.com/orgs/multipath-tcp/projects/20
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:
    see list-exported-commits.sh
    
    - net-next is closed



Extra tests:
    - news about Syzkaller? (Matth):
        - no news

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

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

