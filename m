Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8383C9EE0
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752795; cv=none; b=Sw9MQWZAaGfnyRQx8c4nboTsy0DP0cwo1ashtYxgWYk0e/J7JJUcjw98zzeoa0ddUdhdxFVxpblzEBzkkIvi+kSCkDwkkPzsoszmjjQvTJafjzZlEU7LoysfqDgT2M7iWpMTyN7uJPfOvoShqI7uW3zimLqyDuJUH0wvz/FfFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752795; c=relaxed/simple;
	bh=3L1noPM0xCj1JTw7DQppkZK6XQODp0kQ3LvRsnA4vcg=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=RBr+Yoyfiopxi3zBGzEc4Z8RU+dB2rATbraSATvO6W07QFpJfBHBy7tRkbvONzo1mfmRsLG/yuuPTQo6zTiGTR5cnTz1Wk83c5PXyuhwG9BBtP19n+schyyE7/m2lhmyDXHdmj+ECeE5d4pF/sAH32XUesUzYmDb/G6naBkIZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMvulgLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMvulgLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92FE1F000E9
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752784;
	bh=gKY7IFQzyr5RgYVPZCXKPMd6K+Fx0WqIPpw3bh7zYZE=;
	h=Date:From:To:Subject;
	b=fMvulgLSm91/nU+P/tPBim+iYRy26wwbDfIUxG+wqAvR68DrgNRxxwA7uIp1HRPjY
	 c0VZtk7nZ5Fz+1Gp1WiBQn6Ch7aOSzdlVJRV/rBiDEwLyWCLaeTBfQ3ona6GIoHigj
	 TwBoUrFh8+zrozhmy4bHvfFxOIyDCl1aUObVEWcPS6outgbAPoTZ0gn3WL/GQFe7F2
	 8y7Q+k9sIpG48k9MMHtwAnCIjblEobX1/Nd6ds1ce67SiNOUAZbJjSukARwrHjeAx9
	 JvlgoMGogOiuxMtvvNctbSYBbYemmP0Gl2wpeu6nUySSiMocdUpz6yHRLH6ZaWNRRh
	 Kc+R/W49MsflQ==
Message-ID: <f040042e-a9af-4030-a5ee-fa142e1e38f6@kernel.org>
Date: Wed, 26 Aug 2026 15:59:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 12th of August 2026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had a meeting with Mat (Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:


    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14737490: [net-next,v3,1/7] mptcp: move the retrans loop to a separate helper
14737489: [net-next,v3,2/7] mptcp: move the stale logic out of retrans scheduler
14737493: [net-next,v3,3/7] mptcp: let the retrans scheduler do its job
14737492: [net-next,v3,4/7] mptcp: explicitly drop over memory limits
14737491: [net-next,v3,5/7] mptcp: enforce hard limit on backlog flushing
14737494: [net-next,v3,6/7] mptcp: avoid code duplication in __mptcp_move_skb()
14737495: [net-next,v3,7/7] mptcp: implemented OoO queue pruning:
    - Series: mptcp: out-of-order queue pruning
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1142231&state=*&archive=both
g@kylinos.cn/

14728036: [net,v2,1/8] mptcp: options: reset DSS fields in case of unexpected size
14728037: [net,v2,2/8] mptcp: avoid combining some incoming suboptions
14728039: [net,v2,3/8] mptcp: remove MPC && MPJ check
14728038: [net,v2,4/8] mptcp: pm: fix data race in add_addr timer callback
14728040: [net,v2,5/8] selftests: mptcp: join: mark tests with data corruption as failed
14728041: [net,v2,6/8] mptcp: pm: fix memory leak from alloc-during-teardown race
14728042: [net,v2,7/8] mptcp: fastopen: only mark MPTFO subflows with SYN data
14728043: [net,v2,8/8] mptcp: reclaim forward-allocated memory on RX path errors:
    - State: New
    - Series: mptcp: misc fixes for v7.2-rc6
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1139537&state=*&archive=both


    our repo (by: David Carlier, Geliang Tang, Jiangshan Yi, Kalpan Jani, luoqing, Matthieu Baerts, Paolo Abeni, Shardul Bankar):

14624989: [v4,1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
14624990: [v4,2/2] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters:
    - Series: mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1110277&state=*&archive=both

14637688: [mptcp-next,2/2] mptcp: pm: fix memory leak from alloc-during-teardown race:
    - Series: mptcp: pm: net-next port of the alloc-during-teardown leak fix
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1114146&state=*&archive=both

14654288: [net,v5,1/2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint:
    - Series: mptcp: pm: fix stale ADD_ADDR anno_list entry on id 0 removal
    - Incomplete series
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1119114&state=*&archive=both

14658326: [mptcp-next,v3] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info():
    - Submitter: Jiangshan Yi
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260702062909.4147641-1-yijiangshan@kylinos.cn/

14719992: [mptcp-next,v12,1/4] mptcp: support MSG_ERRQUEUE on the parent socket
14719993: [mptcp-next,v12,2/4] mptcp: sockopt: factor inet_flags propagation into a mask
14719994: [mptcp-next,v12,3/4] mptcp: propagate RECVERR sockopts to subflows
14719995: [mptcp-next,v12,4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation:
    - Series: mptcp: MSG_ERRQUEUE support on the parent socket
    - Submitter: David Carlier
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1137167&state=*&archive=both

14722856: [mptcp-next,v2,1/2] Squash to "mptcp: explicitly drop over memory limits"
14722857: [mptcp-next,v2,2/2] Squash to "mptcp: implemented OoO queue pruning":
    - Series: Squash to "mptcp: out-of-order queue pruning"
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1138063&state=*&archive=both

14723222: [mptcp-net,1/4] Squash to "mptcp: avoid combining some incoming suboptions"
14723223: [mptcp-net,2/4] Squash to "mptcp: reclaim forward-allocated memory on RX path errors"
14723224: [mptcp-net,3/4] mptcp: options: reset DSS fields in case of unexpected size
14723225: [mptcp-next,mptcp-net,4/4] mptcp: remove MPC && MPJ check:
    - Series: Squash to "mptcp: misc fixes for v7.2-rc6"
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1138152&state=*&archive=both

14726094: [mptcp-next] Squash to "selftests: mptcp: cover IP_RECVERR sockopt propagation":
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260802-mptcp-squash-sft-recverr-v1-1-df5f5e366e7a@kernel.org/

14731540: [mptcp-next,v4] mptcp: honour configured min/max RTO in retransmit paths:
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com/

14733991: [mptcp-next,1/2] Squash to "bpf: Export mptcp packet scheduler helpers"
14733992: [mptcp-next,2/2] Squash to "selftests/bpf: Add bpf_burst scheduler & test":
    - Series: Drop mptcp_pm_subflow_chk_stale in bpf
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1141341&state=*&archive=both

14734745: [v2,mptcp-next,1/7] mptcp: move the retrans loop to a separate helper
14734740: [v2,mptcp-next,2/7] mptcp: move the stale logic out of retrans scheduler
14734744: [v2,mptcp-next,3/7] mptcp: let the retrans scheduler do its job
14734741: [v2,mptcp-next,4/7] mptcp: explicitly drop over memory limits
14734742: [v2,mptcp-next,5/7] mptcp: enforce hard limit on backlog flushing
14734743: [v2,mptcp-next,6/7] mptcp: avoid code duplication in __mptcp_move_skb()
14734746: [v2,mptcp-next,7/7] mptcp: implemented OoO queue pruning:
    - Series: mptcp: address stall under memory pressure
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1141577&state=*&archive=both

14736372: [mptcp-net,v4] mptcp: pm: fix userspace PM address ID overflow when all IDs are exhausted:
    - Submitter: luoqing
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260807074110.566170-1-l1138897701@163.com/

14736887: [next,mptcp-next] mptcp: pm: userspace: make remove_addr_entry static:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260807-mptcp-pm-user-remove_addr_entry-v1-1-c080a8a30e40@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Harshit Varu, Matthieu Baerts, Ren Wei):

14716134: [net,1/5] mptcp: avoid combining some incoming suboptions
14716135: [net,2/5] mptcp: pm: fix data race in add_addr timer callback
14716136: [net,3/5] selftests: mptcp: join: mark tests with data corruption as failed
14716137: [net,4/5] mptcp: fastopen: only mark MPTFO subflows with SYN data
14716138: [net,5/5] mptcp: reclaim forward-allocated memory on RX path errors:
    - Series: mptcp: misc fixes for v7.2-rc6
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1136101&state=*&archive=both

14744384: [v2] mptcp: restore full join state in syncookie MP_JOIN reconstruction:
    - Submitter: Harshit Varu
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260811222325.90426-1-harshitvaru666@gmail.com/
    - Stop cc security

14744838: [net,v4,1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
14744839: [net,v4,2/2] mptcp: fix MP_CAPABLE token migration when cloning reqsk:
    - Series: mptcp: fix request migration ownership
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1144501&state=*&archive=both

14745960: [net-next,01/11] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow
14745962: [net-next,02/11] mptcp: remove unused data_ack from struct mptcp_ext
14745961: [net-next,03/11] mptcp: pm: userspace: make remove_addr_entry static
14745963: [net-next,04/11] mptcp: honour configured min/max RTO in retransmit paths
14745964: [net-next,05/11] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
14745965: [net-next,06/11] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters
14745967: [net-next,07/11] selftests: mptcp: connect: test name in pcap file
14745966: [net-next,08/11] selftests: mptcp: simult_flow: test name in pcap file
14745968: [net-next,09/11] selftests: mptcp: pcap: drop most of the payload
14745969: [net-next,10/11] selftests: mptcp: fix const qualifier warnings in strchr usage
14745970: [net-next,11/11] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info():
    - Series: mptcp: misc. features for v7.3
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1144806&state=*&archive=both


    our repo (by: Chenguang Zhao, Christoph Paasch, David Lee, Gang Yan, Geliang Tang, Gregory Detal, Jun Yang, Kalpan Jani, luoqing, Matthieu Baerts, Ren Wei, Shardul Bankar, Zihan Xi):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both

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

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both

14167004: [mptcp-next] mptcp: remove redundant orig_offset in carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both

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

14215849: [mptcp-net,v2,1/3] selftests: mptcp: close server file descriptor
14215850: [mptcp-net,v2,2/3] selftests: mptcp: close IPC descriptor on server side:
    - State: Changes requested
    - Series: misc fixes for sockopt selftests
    - Incomplete series
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=998230&state=*&archive=both

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

14332026: [RFC,mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt:
    - State: Changes requested
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org/

14413156: [mptcp-net,1/3] mptcp: add backlog_list bug reproducer test
14413157: [mptcp-net,2/3] mptcp: fix receive stalls when 'ack_seq' in backlog_list:
    - State: Changes requested
    - Series: Fix the transmission stall due to backlog
    - Incomplete series
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1051012&state=*&archive=both

14478884: [mptcp-net,v2] mptcp: fix data-race in __mptcp_retrans / mptcp_incoming_options:
    - State: Queued
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org/

14481348: [mptcp-next,v3,1/2] mptcp: implement psock_update_sk_prot
14481349: [mptcp-next,v3,2/2] selftests/bpf: Update sockmap tests for MPTCP:
    - State: Changes requested
    - Series: implement psock_update_sk_prot
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1068551&state=*&archive=both

14562644: [mptcp-net,v4,1/2] mptcp: use sockopt_lock(release)_sock in sockopt
14562643: [mptcp-net,v4,2/2] mptcp: use sockopt_ns_capable() in setsockopt congestion control:
    - State: Changes requested
    - Series: mptcp: convert to sockopt_lock_sock
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1091935&state=*&archive=both

14593680: [mptcp-net,v3] mptcp: fix divide-by-zero in __mptcp_push_pending close path:
    - State: Changes requested
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260525194828.1137119-1-shardul.b@mpiricsoftware.com/
    - TODO: still needed?

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
    - State: Changes requested
    - Series: NVMe over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1101939&state=*&archive=both

14604416: [mptcp-next,4/4] mptcp: use READ_ONCE() over sysctls:
    - State: Queued
    - Series: Fixes for "mptcp: pm: drop TCP TS with ADD_ADDRv6 + port"
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103837&state=*&archive=both

14618202: [mptcp-next,v4,1/2] mptcp: implement .splice_eof
14618203: [mptcp-next,v4,2/2] selftests: mptcp: connect: trigger splice_eof:
    - State: Needs ack
    - Series: implement .splice_eof
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1108212&state=*&archive=both

14639185: [RFC,net-next,01/17] tls: make tls_ctx_create and update_sk_prot static
14639186: [RFC,net-next,02/17] tls: factor out __tls_build_proto for mptcp support
14639187: [RFC,net-next,03/17] tls: add protocol dimension to tls operation cache
14639188: [RFC,net-next,04/17] mptcp: add sendmsg_locked to proto_ops
14639189: [RFC,net-next,05/17] tls: use sendmsg_locked from the underlying socket
14639190: [RFC,net-next,06/17] mptcp: implement peek_len for proto_ops
14639191: [RFC,net-next,07/17] tls: replace tcp_inq with socket peek_len
14639192: [RFC,net-next,08/17] tls: store original read_sock for non-tcp sockets
14639193: [RFC,net-next,09/17] tls: introduce tls protocol ops structure
14639194: [RFC,net-next,10/17] tls: use protocol ops via tls_context
14639195: [RFC,net-next,11/17] mptcp: implement mptcp-specific tls protocol ops
14639196: [RFC,net-next,12/17] tls: add mptcp support for sk_poll
14639197: [RFC,net-next,13/17] tls: disable device offload for mptcp sockets
14639198: [RFC,net-next,14/17] mptcp: update mptcp_check_readable helper
14639199: [RFC,net-next,15/17] mptcp: implement ulp getsockopt for tls support
14639220: [RFC,net-next,16/17] mptcp: implement ulp setsockopt for tls support
14639221: [RFC,net-next,17/17] selftests: mptcp: connect: use espintcp for ulp test:
    - State: Changes requested
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1114686&state=*&archive=both

14647853: [mptcp-next,v6,1/3] mptcp: pm: userspace: drop delete_local_addr helper
14647854: [mptcp-next,v6,2/3] selftests: mptcp: join: explicitly remove userspace pm addresses
14647855: [mptcp-next,v6,3/3] selftests: mptcp: userspace: send RM_ADDR between server and client:
    - State: Needs ack
    - Series: only remove entry from local_addr_list when sending a REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1117313&state=*&archive=both

14650263: [mptcp-net,v3] mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow():
    - State: Needs ack
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com/

14654289: [net,v5,2/2] selftests: mptcp: add id 0 stale ADD_ADDR regression test:
    - State: Rejected
    - Series: mptcp: pm: fix stale ADD_ADDR anno_list entry on id 0 removal
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1119114&state=*&archive=both

14655183: [mptcp-net,v3] mptcp: pm: userspace: unify entry free path via RCU callback:
    - State: Needs ack
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn/
     => Mat will looking
     => TODO: also tell Geliang that we shouldn't extend the size of 
mptcp_pm_addr_entry, also used by the in-kernel PM → at least a union or reusing lsk? → done

14662629: [mptcp-next,v2,1/5] Squash to "bpf: Export mptcp packet scheduler helpers"
14662630: [mptcp-next,v2,2/5] Squash to "bpf: Export mptcp packet scheduler helpers"
14662631: [mptcp-next,v2,3/5] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
14662632: [mptcp-next,v2,4/5] DO-NOT-MERGE: selftests/bpf: mptcp: verify scheduler rejects non-msk socket to set_timeout
14662633: [mptcp-next,v2,5/5] DO-NOT-MERGE: selftests/bpf: mptcp: extend bad scheduler test to the kfunc type contract:
    - State: Changes requested
    - Series: mptcp: bpf: fix scheduler kfunc socket type confusion
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1121285&state=*&archive=both

14680441: [mptcp-next,1/3] Squash to "mptcp: pm: init and release mptcp_pm_ops"
14680442: [mptcp-next,2/3] Squash to "mptcp: pm: add get_local_id() interface"
14680443: [mptcp-next,3/3] Squash to "mptcp: pm: add get_priority() interface":
    - State: Needs ack
    - Series: mptcp: pm: guard the lockless MP_JOIN path against a NULL pm.ops
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1125769&state=*&archive=both

14685430: mptcp: pm: Fix address ID overflow when all IDs are exhausted:
    - State: Changes requested
    - Submitter: luoqing
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260714080356.805839-1-l1138897701@163.com/

14688538: [mptcp-next,1/2] mptcp: sched: add subflow avoid flag and kfunc
14688539: [mptcp-next,2/2] selftests: mptcp: bpf: exercise the subflow avoid flag:
    - State: Needs ack
    - Series: mptcp: sched: let schedulers mark a subflow to avoid
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1128052&state=*&archive=both

14692583: [mptcp-next,v7,1/9] ipv4: fix uninitialized memory in zerocopy cmsg
14692584: [mptcp-next,v7,2/9] mptcp: use local variable tp in sendmsg_frag
14692585: [mptcp-next,v7,3/9] mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
14692586: [mptcp-next,v7,4/9] mptcp: remove redundant orig_offset in carve_data_frag
14692587: [mptcp-next,v7,5/9] mptcp: add MSG_ZEROCOPY support
14692588: [mptcp-next,v7,6/9] mptcp: handle SO_ZEROCOPY in setsockopt
14692589: [mptcp-next,v7,7/9] selftests: mptcp: connect: add zerocopy io mode
14692590: [mptcp-next,v7,8/9] selftests: mptcp: connect: cover zerocopy mode
14692591: [mptcp-next,v7,9/9] selftests: mptcp: connect: close listensock deterministically:
    - State: Needs ack
    - Series: mptcp: add MSG_ZEROCOPY support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1129243&state=*&archive=both
    - To be review, interesting feature, but we need to understand that, Mat will try to help

14699528: [mptcp-next,v2,2/7] mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_val:
    - State: Changes requested
    - Series: mptcp: add bpf_setsockopt support
    - Incomplete series
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1131261&state=*&archive=both

14710799: [mptcp-next,1/3] mptcp: sched: penalise a slow subflow by halving its cwnd
14710800: [mptcp-next,2/3] mptcp: sched: do not penalise when receive-window-limited
14710801: [mptcp-next,3/3] DO-NOT-MERGE: mptcp: sched: penalise counters:
    - State: Changes requested
    - Series: mptcp: sched: penalise a slow subflow ("345, first cut for your lab)
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1134545&state=*&archive=both

14711775: [mptcp-next,v3,1/7] mptcp: drop unused @max arg of __mptcp_setsockopt_set_val
14711776: [mptcp-next,v3,2/7] mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_val
14711777: [mptcp-next,v3,3/7] mptcp: use sockopt_lock/release_sock in sockopt
14711778: [mptcp-next,v3,4/7] mptcp: reject sockopt requiring ssks' lock in BPF context
14711779: [mptcp-next,v3,5/7] mptcp: enable bpf_setsockopt on the master socket
14711780: [mptcp-next,v3,6/7] mptcp: add TCP_CONNECT_CB sock_ops hook
14711781: [mptcp-next,v3,7/7] selftests: bpf: verify mptcp bpf_setsockopt from TCP_CONNECT_CB:
    - State: Changes requested
    - Series: mptcp: add bpf_setsockopt support
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1134827&state=*&archive=both

14718129: [net,1/2] tcp: diag: fix unbounded bucket lock hold in tcp_diag_dump()
14718130: [net,2/2] mptcp: diag: fix unbounded listener bucket lock hold:
    - State: Needs ack
    - Series: tcp: diag: fix unbounded bucket lock hold in diag dump paths
    - Submitter: Zihan Xi
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1136597&state=*&archive=both
    - rejected for TCP

14719705: [mptcp-next,v14,01/12] selftests: mptcp: sockopt: reseed RNG after fork
14719706: [mptcp-next,v14,02/12] selftests: mptcp: sockopt: use exact length in connect_one_server
14719707: [mptcp-next,v14,03/12] selftests: mptcp: sockopt: add check_stat_equal helper
14719708: [mptcp-next,v14,04/12] selftests: mptcp: sockopt: use size_t for byte counters
14719709: [mptcp-next,v14,05/12] selftests: mptcp: sockopt: add is_mptcp_socket helper
14719710: [mptcp-next,v14,06/12] selftests: mptcp: sockopt: add tx/rx protocol options
14719711: [mptcp-next,v14,07/12] selftests: mptcp: sockopt: add TCP_INQ test option
14719712: [mptcp-next,v14,08/12] selftests: mptcp: sockopt: use unix socket instead of pipe
14719713: [mptcp-next,v14,09/12] selftests: mptcp: sockopt: use recvmsg instead of read
14719714: [mptcp-next,v14,10/12] selftests: mptcp: sockopt: get and verify TCP_INQ
14719715: [mptcp-next,v14,11/12] selftests: mptcp: sockopt: add huge data transfer tests
14719716: [mptcp-next,v14,12/12] selftests: mptcp: sockopt: replace mptcp_inq with sockopt:
    - State: New
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1137065&state=*&archive=both

14722114: [mptcp-next] Squash to "selftests: mptcp: sockopt: add is_mptcp_socket helper":
    - State: New
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/1b103d397cf4a506c608d9ade586e98db770daec.1785460213.git.tanggelian

14728873: [v2,MPTCP-net] pm: userspace: fix address ID overflow when all IDs exhausted:
    - State: Changes requested
    - Submitter: luoqing
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260804022350.181323-1-l1138897701@163.com/

14728872: [MPTCH-next] selftests: add test for userspace PM address ID overflow:
    - State: Changes requested
    - Submitter: luoqing
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260804022350.181323-2-l1138897701@163.com/

14729550: [net] mptcp: hold msk reference when cloning request sockets:
    - State: Under review
    - Submitter: David Lee
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260804095051.715355-1-david.lee@trailofbits.com/

14732434: [mptcp-net] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused:
    - State: New
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260805-mptcp-pm-reset-retrans_time-v1-1-19efbe17046d@kernel.org/

14732563: [mptcp-net,v2] mptcp: options: handle MPC data + csum reqd + no csum:
    - State: New
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org/

14734297: [net,v3,1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
14734298: [net,v3,2/2] mptcp: fix MP_CAPABLE token migration when cloning reqsk:
    - State: New
    - Series: mptcp: fix request migration ownership
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1141434&state=*&archive=both

14736582: [mptcp-net,v3,1/8] mptcp: pm: userspace: properly handle the ID0 case
14736583: [mptcp-net,v3,2/8] mptcp: pm: userspace: lookup: match port in priority
14736584: [mptcp-net,v3,3/8] mptcp: pm: userspace: ID0 is not part of local_addr_used
14736585: [mptcp-net,v3,4/8] mptcp: pm: userspace: allow announcing ID0 addr
14736589: [mptcp-net,v3,5/8] mptcp: pm: userspace: no ID0 exception for RM_ADDR
14736586: [mptcp-net,v3,6/8] mptcp: pm: userspace: don't dump initial ID0
14736587: [mptcp-net,v3,7/8] selftests: mptcp: join: new ID0 subflow from the right IP
14736588: [mptcp-net,v3,8/8] mptcp: pm: restrict in-kernel worker actions to this PM:
    - State: New
    - Series: mptcp: pm: userspace: properly deal with the ID0 case
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1142037&state=*&archive=both

14738508: [mptcp-next,v5,01/11] mptcp: handle TCP_MAXSEG getsockopt in common case
14738509: [mptcp-next,v5,02/11] mptcp: take TCP_MAXSEG handling into setsockopt_set_val
14738510: [mptcp-next,v5,03/11] mptcp: inherit sk_reuse/sk_reuseport and fix dev bind override
14738511: [mptcp-next,v5,04/11] mptcp: add TCP_SYNCNT setsockopt/getsockopt
14738512: [mptcp-next,v5,05/11] mptcp: skip ip6 options on v4-mapped clone
14738513: [mptcp-next,v5,06/11] mptcp: report v4-mapped subflow addrs as IPv4
14738514: [mptcp-next,v5,07/11] ipv6: extract and export ip6_sock_set_tclass helpers
14738515: [mptcp-next,v5,08/11] mptcp: sockopt: implement IPV6_TCLASS
14738516: [mptcp-next,v5,09/11] mptcp: copy the subflow's tos/tclass to the msk on accept
14738517: [mptcp-next,v5,10/11] nvme-tcp: support IPv6 traffic class
14738518: [mptcp-next,v5,11/11] nvmet-tcp: support IPv6 traffic class:
    - State: New
    - Series: Fix socket options used by NVMe over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1142524&state=*&archive=both

14738584: [v2,1/3] ipv6: extract and export ip6_sock_set_tclass helpers
14738585: [v2,2/3] nvme-tcp: support IPv6 traffic class
14738586: [v2,3/3] nvmet-tcp: support IPv6 traffic class:
    - State: New
    - Series: nvme-tcp: add IPv6 traffic class support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1142555&state=*&archive=both

14740697: [net] mptcp: reject a DSS option that follows an incompatible suboption:
    - State: New
    - Submitter: Jun Yang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260810114616.2709245-1-fouriezhang@tencent.com/

14743277: [mptcp-next,v3,1/7] mptcp: drop the mptcp_ooo_try_coalesce() helper
14743278: [mptcp-next,v3,2/7] mptcp: drop the cant_coalesce CB field
14743279: [mptcp-next,v3,3/7] mptcp: remove CB offset field
14743282: [mptcp-next,v3,4/7] mptcp: sync mptcp skb cb layout with tcp one
14743280: [mptcp-next,v3,5/7] mptcp: defer read_sock cleanup to mptcp_worker
14743281: [mptcp-next,v3,6/7] mptcp: track app-limited state in mptcp_sendmsg
14743283: [mptcp-next,v3,7/7] selftests: mptcp: sockopt: check app_limited:
    - State: New
    - Series: Reduce the differences between TCP and MPTCP for TLS usage
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1144100&state=*&archive=both

14744714: [export,v3,1/4] mptcp: add MPFailFallback MIB
14744715: [export,v3,2/4] mptcp: reject joins after fallback in mptcp_is_fully_established
14744716: [export,v3,3/4] mptcp: reset subflow on MP_FAIL when OoO queue is non-empty
14744717: [export,v3,4/4] mptcp: fallback to TCP on MP_FAIL with a single subflow:
    - State: New
    - Series: mptcp: fix TCP fallback on single-subflow MP_FAIL
    - Submitter: Chenguang Zhao
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1144463&state=*&archive=both
    - TODO: remove token when fallback? or only fully_established?

14745264: [mptcp-next,1/2] mptcp: pass net namespace to options parser
14745265: [mptcp-next,2/2] mptcp: add MIB counter for received invalid options:
    - State: New
    - Series: mptcp: MIB counter for invalid option
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1144623&state=*&archive=both




Extra, just in case: /



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 623):

  628  mptcp: incoming options: add a MIB counter for received invalid options @matttbe
  627  Fix data-race in `__mptcp_retrans` / `mptcp_incoming_options` [bug]
  626  Use `READ_ONCE()` over sysctls [bug]
  625  Reduce `struct mptcp_options_received` size [enhancement]
  624  [6.6.y]: warning in `__mptcp_move_skbs_from_subflow` [bug]
  
  Recently discussed:
  
  483  [6.1] selftests: `mptcp_connect.sh` failures with `copyfd_io_poll: poll timed out` errors [bug] [selftests]


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  627  Fix data-race in `__mptcp_retrans` / `mptcp_incoming_options` [bug]
  626  Use `READ_ONCE()` over sysctls [bug]
  624  [6.6.y]: warning in `__mptcp_move_skbs_from_subflow` [bug]
  622  [sashiko] NULL pointer dereferences and Use-After-Free in `bpf_mptcp_sock_from_subflow` [bug]
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

  625  Reduce `struct mptcp_options_received` size [enhancement]
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


    Recently closed (since 2026-07-29)

  623  [sashiko] possible use-after-free in `mptcp_pm_del_add_timer` [bug]
  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  618  `TCP_RTO_MIN`/`MAX`: used configured values if any [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]


    Packetdrill PRs

  205  6 hours ago   Dwyane-Yan          mptcp: validate MPTcpExtInvalidOptionRx on MP_CAPABLE fallback paths
  200  1 day ago     chrisocean716-star  mptcp: add sync_join_fail packetdrill test
  162  6 months ago  geliangtang         mptcp: add splice test
  52   1 year ago    dcaratti            Add initial coverage for RM_ADDR


    mptcp.dev PRs



    mptcp-upstream-virtme-docker PRs

  54  12 days ago  geliangtang  run_frozen: cache script body, ignore later edits:
      - TODO: still needed? → asked


    mptcpd PRs

  336  10 hours ago  Dwyane-Yan  tests: check the plugin's behaviour in namespaces
  335  8 hours ago   Dwyane-Yan  UserPM: Implement per-token get_addr/dump_addrs for userspace path manager




FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (7.3): https://github.com/orgs/multipath-tcp/projects/21
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:


    - Fixes for -net:

        - [bf48d771928e] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0 (Kalpan Jani)
        - [8a1b3cadbbc0] mptcp: pm: userspace: fix address ID overflow (Qing Luo)

    - Fixes for net-next:


    - Features for net-next:

        - [fa6b96397134] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [bfc851e9d104] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [30b0f1e6c768] mptcp: pm: add get_priority() interface (Geliang Tang):
            - wait for PM->lock refact

        - [9799bd21dccd] selftests: mptcp: connect: test name in pcap file (Matthieu Baerts (NGI0))
        - [62b475bb8909] selftests: mptcp: simult_flow: test name in pcap file (Matthieu Baerts (NGI0))
        - [7a81dd96a459] selftests: mptcp: pcap: drop most of the payload (Matthieu Baerts (NGI0))
        - [5a3b1a1cc2af] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow (Tao Cui)
        - [5403d4518602] mptcp: remove unused data_ack from struct mptcp_ext (Geliang Tang)
        - [0c5c4107e987] selftests: mptcp: fix const qualifier warnings in strchr usage (Geliang Tang):
            - sent

        - [3d3a3ba8b47d] mptcp: support MSG_ERRQUEUE on the parent socket (David Carlier)
        - [4d9816a719dc] mptcp: sockopt: factor inet_flags propagation into a mask (David Carlier)
        - [6898dfca15f3] mptcp: propagate RECVERR sockopts to subflows (David Carlier)
        - [d75978c244d5] selftests: mptcp: cover IP_RECVERR sockopt propagation (David Carlier):
            - To be send at the next window

        - [6f68ee709620] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info() (Jiangshan Yi)
        - [b6c35cc81b61] mptcp: honour configured min/max RTO in retransmit paths (Kalpan Jani)
        - [6aaa40230d62] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets (Shardul Bankar)
        - [480a9ed0665a] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters (Shardul Bankar)
        - [85a5d858eebc] mptcp: pm: userspace: make remove_addr_entry static (Matthieu Baerts (NGI0)):
            - sent

    - Features for net-next (next):


    - Features for other trees:

        - [c56f25ef55c8] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [b63c02112730] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [7c30ada371b1] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [81d24e098120] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [98380d0d200c] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [f11ed86f02e6] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [d20fe0cddf4f] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [137006c9ab48] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [fa64ebea99cc] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [0482ba13e3e9] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [8d48f7b6a631] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang):
            - wait Sched api refact




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

