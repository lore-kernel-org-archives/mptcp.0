Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C03FAE10
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750799; cv=none; b=PS0PjtlP7baNEcrmuWwC4V3zy+87mJ4N67zL5nlHUN0SWBmsZHsUQNX16zn/Pfa/bNb0C/VeMLbxmeVnYmVk0PYLzjDC3fjDbL9yBEEvmHbQhRU4/HlnwmKzL9wELaR5gMRuvl95bcZtkxVcDtuHOFAkX9qKttrw1E2fpW1m2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750799; c=relaxed/simple;
	bh=5c55lKadz+xqPK//ep0JeMq57BmdjZvoniFp1gOLGv4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=kt1J09U4FWqVZQy63+YUi7wLM/jR1sgjeyhJESJDB/0V8rVyIAvk2veQIDx/dBgVk0bL+4cJ9rRI4ZghDEDlbUwgArbehLHvmlzgU9Hcs+UPH4OhyVzMrFeEhbW12GHecgc9H0DMivH/iMzoK7M7IBfFDY+pi2BDe0dICFaiPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv1VgrMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv1VgrMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76891F000E9
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787750794;
	bh=EC1Wv2eONHDX5f85OL7m2oKBLLXZQkBC57u0/+wD3MU=;
	h=Date:From:To:Subject;
	b=lv1VgrMFmlVpf6ksOCrGcnqUZmGoi7wSId/GZQA2+Qm2ANsgk7HUneuLmBNQqpOgO
	 LArXyhq1MhHYn9hXNzDoZ1Y36D+f1zJadIiXXfpTH4iwq4hXrb6JC/OK8lFlNEQ+VW
	 MXJxAr42HFMQTZw7FM+cXJ1j7Abq4o6At9vlrLD46ZcNB7rSZrYlJ6il70m83Q2wlb
	 7ilvSddHr8IfTvvORAJf5wTsI0P/SXU/8c2j63dENwvjt2Zrhx7uqpEk0rH90jGP7J
	 TDRdgi8MmuSmjqFWknh9T6V4IktQmbOjGXGOVtN4GsMPkb83ypUtSB6Bx8DZeHKvlL
	 5ri2q5WCLxU/g==
Message-ID: <eed15df1-8533-4c32-84b5-4d58d87275a9@kernel.org>
Date: Wed, 26 Aug 2026 15:26:30 +0200
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
Subject: [Weekly meetings] MoM - 29th of July 2026
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had a meeting with Mat (Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Guillaume Maudoux):

14653456: [bpf-next,v2] selftests/bpf: Mask socket type flags in mptcpify prog:
    - Submitter: Guillaume Maudoux
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260630095723.564392-1-layus.on@gmail.com/

14701985: [net,1/5] mptcp: decrement subflows counter on failed passive join
14701986: [net,2/5] mptcp: pm: userspace: fix use-after-free in get_local_id
14701987: [net,3/5] mptcp: fix stale skb->sk reference on subflow close
14701988: [net,4/5] selftests: mptcp: userspace_pm: fix undefined variable port
14701989: [net,5/5] mptcp: fix BUILD_BUG_ON on legacy ARM config:
    - State: New
    - Series: mptcp: misc fixes for v7.2-rc5
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1131966&state=*&archive=both


    our repo (by: Chenguang Zhao, Gang Yan, Geliang Tang, luoqing, Matthieu Baerts, Michael Bommarito, Paolo Abeni, Ren Wei):

14614582: [mptcp_net-next,1/1] mptcp: fastopen: only mark MPTFO subflows with SYN data:
    - Series: [mptcp_net-next,1/1] mptcp: fastopen: only mark MPTFO subflows with SYN data
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1106932&state=*&archive=both

14646428: [mptcp-net] selftests: mptcp: userspace_pm: fix undefined variable port:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/24cb3786d7ce0e7bb1397ef14c98c78fd4a9ecb1.1782457344.git.tanggeliang@kylinos.cn/

14652761: [mptcp-net] mptcp: pm: userspace: fix use-after-free in get_local_id:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn/

14655020: [mptcp-net,v2] mptcp: fix extra_subflows leak on failed passive join:
    - Submitter: Chenguang Zhao
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260701032011.358940-1-chenguang.zhao@linux.dev/

14658327: [mptcp-next,v3] Squash-to "mptcp: pm: init and release mptcp_pm_ops":
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260702063002.127027-1-gang.yan@linux.dev/

14670442: [mptcp-net] mptcp: fix BUILD_BUG_ON on legacy ARM config:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org/

14676853: [net,v3] mptcp: only set DATA_FIN when a mapping is present:
    - Submitter: Michael Bommarito
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260709191925.2811195-1-michael.bommarito@gmail.com/

14702029: [mptcp-net,v2] mptcp: avoid combining some incoming suboptions:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260722-mptcp-harden-combine-opt-v2-1-2021e67703f3@kernel.org/

14704997: [mptcp-net,v4] mptcp: pm: fix data race in add_addr timer callback:
    - Submitter: luoqing
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260723032324.189675-1-l1138897701@163.com/

14707750: [mptcp-next,1/2] selftests: mptcp: run fail_test in main shell during join test
14713525: [mptcp-net] mptcp: reclaim forward-allocated memory on RX path errors:
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/patch/54ad24594f194dace522b8f1be3912b242708a6e.1785162224.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts):

14613468: [net] tls: restore sk_prot before calling original destructor:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn/
    - archived → fix needed for stable, but not taken because this part has been removed in next

14708926: [net-next,1/5] mptcp: move the retrans loop to a separate helper
14708927: [net-next,2/5] mptcp: let the retrans scheduler do its job
14708928: [net-next,3/5] mptcp: explicitly drop over memory limits
14708929: [net-next,4/5] mptcp: enforce hard limit on backlog flushing
14708930: [net-next,5/5] mptcp: implemented OoO queue pruning:
    - Series: mptcp: out-of-order queue pruning
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1134020&state=*&archive=both
    - TODO: Matth: send a v2 with fixes → done

14716134: [net,1/5] mptcp: avoid combining some incoming suboptions
14716135: [net,2/5] mptcp: pm: fix data race in add_addr timer callback
14716136: [net,3/5] selftests: mptcp: join: mark tests with data corruption as failed
14716137: [net,4/5] mptcp: fastopen: only mark MPTFO subflows with SYN data
14716138: [net,5/5] mptcp: reclaim forward-allocated memory on RX path errors:
    - Series: mptcp: misc fixes for v7.2-rc6
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1136101&state=*&archive=both

14718129: [net,1/2] tcp: diag: fix unbounded bucket lock hold in tcp_diag_dump()
14718130: [net,2/2] mptcp: diag: fix unbounded listener bucket lock hold:
    - State: New
    - Series: tcp: diag: fix unbounded bucket lock hold in diag dump paths
    - Submitter: Zihan Xi
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1136597&state=*&archive=both
    - Looks too big for a fix, but similar to what is done for TCP → wait for the review of the TCP part?


    our repo (by: Chenguang Zhao, Christoph Paasch, David CARLIER, David equinox Lamparter, Fernando Fernandez Mancera, Gang Yan, Geliang Tang, Gregory Detal, Jiangshan Yi, Kalpan Jani, Li Xiasong, luoqing, luoxuanqiang, Markus Elfring, Matthieu Baerts, Ren Wei, Shardul Bankar, Tao Cui, Zihan Xi):

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
    - TODO: check with Christoph → TODO → Done

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
    - TODO: Matth: still needed? → yes, done

14572928: [mptcp-next,v3,1/2] mptcp: pm: fix extra_subflows underflow on userspace PM connect failure
14572929: [mptcp-next,v3,2/2] mptcp: pm: fix extra_subflows leak on userspace PM subflow close race:
    - State: Changes requested
    - Series: mptcp: pm: fix extra_subflows underflow for userspace PM
    - Submitter: Tao Cui
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1094801&state=*&archive=both
    - Still needed? TODO Matth → done

14593230: mptcp: pm: don't WARN on re-announced addr in kernel PM:
    - State: Needs ack
    - Series: mptcp: pm: don't WARN on re-announced addr in kernel PM
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1100453&state=*&archive=both
    - New version with a different name

14593680: [mptcp-net,v3] mptcp: fix divide-by-zero in __mptcp_push_pending close path:
    - State: Needs ack
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260525194828.1137119-1-shardul.b@mpiricsoftware.com/
    - Paolo looked at it: change requested

14594661: [mptcp-net,1/2] net: add sk_shutdown_timer_sync() helper
14594662: [mptcp-net,2/2] mptcp: use sk_shutdown_timer_sync() for add_addr timer teardown:
    - State: Changes requested
    - Series: mptcp: prevent add_addr timer rearm during teardown
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1100863&state=*&archive=both
    - TODO: Matth: check → replaced by a new patch from Kalpan from what I understood

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
    - State: Needs ack
    - Series: NVMe over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1101939&state=*&archive=both
    - to review

14602587: [mptcp-next,1/5] tls: add clone callback to prevent NULL crash case
14602588: [mptcp-next,2/5] tls: init mixed SW/TOE proto to prevent NULL call
14602589: [mptcp-next,3/5] tls: fix concurrency in TOE device list iterations
14602590: [mptcp-next,4/5] tcp: add socket lock to TCP_ULP getsockopt safely
14602591: [mptcp-next,5/5] tcp: fix ULP diag race by RCU read locks properly:
    - State: Changes requested
    - Series: Fixes for TLS and ULP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103235&state=*&archive=both
    - still needed? Archived?

14603782: [mptcp-next,v11,1/4] mptcp: sockopt: factor inet_flags propagation into a mask
14603783: [mptcp-next,v11,2/4] mptcp: propagate RECVERR sockopts to subflows
14603784: [mptcp-next,v11,3/4] mptcp: support MSG_ERRQUEUE on the parent socket
14603785: [mptcp-next,v11,4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation:
    - State: Needs ack
    - Series: mptcp: MSG_ERRQUEUE support on the parent socket
    - Submitter: David CARLIER
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103609&state=*&archive=both
    - TODO: Matth: apply → done

14604416: [mptcp-next,4/4] mptcp: use READ_ONCE() over sysctls:
    - State: Queued
    - Series: Fixes for "mptcp: pm: drop TCP TS with ADD_ADDRv6 + port"
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1103837&state=*&archive=both
    - TODO: Matth: new task to fix that → remaining: strings for pm and sched → done

14618202: [mptcp-next,v4,1/2] mptcp: implement .splice_eof
14618203: [mptcp-next,v4,2/2] selftests: mptcp: connect: trigger splice_eof:
    - State: Needs ack
    - Series: implement .splice_eof
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1108212&state=*&archive=both
    - TODO: review → TODO!!!

14624989: [v4,1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
14624990: [v4,2/2] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters:
    - State: Needs ack
    - Series: mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1110277&state=*&archive=both
    - TODO: Matth: review → done

14625441: [mptcp-next] mptcp: bpf: fix NULL derefs in bpf_mptcp_sock_from_subflow():
    - State: Changes requested
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com/
    - superseded

14633593: [mptcp-next,v3] mptcp: honour configured min/max RTO in retransmit paths:
    - State: Needs ack
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260617114508.253716-1-kalpan.jani@mpiricsoftware.com/
    - TODO: review → done

14633827: [mptcp-next,v2,1/9] DO-NOT-MERGE: mptcp: test IPV6=m in docker-virtme
14633828: [mptcp-next,v2,2/9] selftests: mptcp: mptcp_lib add runtime IPv6 availability detection helper
14633829: [mptcp-next,v2,3/9] selftests: mptcp: mptcp_connect.sh degrades to v4-only when MPTCP IPv6 is missing
14633830: [mptcp-next,v2,4/9] selftests: mptcp: mptcp_connect.sh don't fail because of nft rules in IPV6-less kernel
14633831: [mptcp-next,v2,5/9] selftests: mptcp: mptcp_sockopt.sh skips v6 paths when MPTCP IPv6 is missing
14633832: [mptcp-next,v2,6/9] selftests: mptcp: simult_flows.sh skips v6 setup when MPTCP IPv6 is missing
14633833: [mptcp-next,v2,7/9] selftests: mptcp: mptcp_join.sh: pick v4 bind default when MPTCP IPv6 is missing
14633834: [mptcp-next,v2,8/9] selftests: mptcp: mptcp_join.sh skips v6 subtests when MPTCP IPv6 is missing
14633835: [mptcp-next,v2,9/9] selftests: mptcp: userspace_pm.sh skips v6 paths when MPTCP IPv6 is missing:
    - State: Changes requested
    - Series: selftests: mptcp: skip the v6 subtests when CONFIG_MPTCP_IPV6=n
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1112987&state=*&archive=both
    - can be included in some distro selftests while CONFIG_IPV6=m is still being used → hard to maintain and to justify in mainline → reject
    - TODO: Matth: send email to explain that → already done before, I hope that was OK

14637687: [mptcp-next,1/2] Squash to "mptcp: pm: init and release mptcp_pm_ops"
14637688: [mptcp-next,2/2] mptcp: pm: fix memory leak from alloc-during-teardown race:
    - State: Needs ack
    - Series: mptcp: pm: net-next port of the alloc-during-teardown leak fix
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1114146&state=*&archive=both
    - TODO: Matth: Apply → done

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
    - State: Needs ack
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
    - To be rebased on top of Matt's series (when ready)

14647932: [mptcp-net] mptcp: pm: userspace: fix memory quota with RCU delayed free:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn/
    - Superseded?

14650263: [mptcp-net,v3] mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow():
    - State: Needs ack
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com/
    - TODO: review → TODO

14653023: [mptcp-net] mptcp: pm: fix potential NULL deref in mptcp_pm_ops_init:
    - State: Changes requested
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260630074237.166076-1-gang.yan@linux.dev/
    - TODO: still needed? v2 required? squash to patch sent instead? → superseded I think

14654288: [net,v5,1/2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
14654289: [net,v5,2/2] selftests: mptcp: add id 0 stale ADD_ADDR regression test:
    - State: Needs ack
    - Series: mptcp: pm: fix stale ADD_ADDR anno_list entry on id 0 removal
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1119114&state=*&archive=both
    - selftests is slow and not reliable, we need something with packetdrill → WIP (validated this time..)
    - but we also need the kernel patch at some patch → TODO: Matth: track packetdrill test evolution → done

14655183: [mptcp-net,v3] mptcp: pm: userspace: unify entry free path via RCU callback:
    - State: Needs ack
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn/
    - is it really needed? looks complex
    - TODO: review → check again

14658326: [mptcp-next,v3] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info():
    - State: Queued
    - Submitter: Jiangshan Yi
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260702062909.4147641-1-yijiangshan@kylinos.cn/
    - TODO: Matth: apply → done

14662629: [mptcp-next,v2,1/5] Squash to "bpf: Export mptcp packet scheduler helpers"
14662630: [mptcp-next,v2,2/5] Squash to "bpf: Export mptcp packet scheduler helpers"
14662631: [mptcp-next,v2,3/5] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
14662632: [mptcp-next,v2,4/5] DO-NOT-MERGE: selftests/bpf: mptcp: verify scheduler rejects non-msk socket to set_timeout
14662633: [mptcp-next,v2,5/5] DO-NOT-MERGE: selftests/bpf: mptcp: extend bad scheduler test to the kfunc type contract:
    - State: Under review
    - Series: mptcp: bpf: fix scheduler kfunc socket type confusion
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1121285&state=*&archive=both
    - Geliang is reviewing it: still in review? TODO check → new version needed

14680441: [mptcp-next,1/3] Squash to "mptcp: pm: init and release mptcp_pm_ops"
14680442: [mptcp-next,2/3] Squash to "mptcp: pm: add get_local_id() interface"
14680443: [mptcp-next,3/3] Squash to "mptcp: pm: add get_priority() interface":
    - State: New
    - Series: mptcp: pm: guard the lockless MP_JOIN path against a NULL pm.ops
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1125769&state=*&archive=both
    - TODO: review → TODO!!

14681230: [01/13,RFC,net-next] net: ipv4: introduce CONFIG_IPV4 to decouple the IPv4 stack:
    - TODO: mark as RFC + archive → Done

14682659: [net,v1] mptcp: pm: fix use-after-free in userspace_pm_get_local_id():
    - State: New
    - Submitter: luoxuanqiang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260713074722.47921-1-xuanqiang.luo@linux.dev/

14683738: [net-next,v2] mptcp: sockopt: implement IPV6_TCLASS:
    - State: Rejected
    - Submitter: David 'equinox' Lamparter
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260713135551.569365-1-equinox@diac24.net/

14685430: mptcp: pm: Fix address ID overflow when all IDs are exhausted:
    - State: Changes requested
    - Submitter: luoqing
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260714080356.805839-1-l1138897701@163.com/
    - Applied → same patch as Geliang

14688091: [mptcp-net,v2,1/3] mptcp: fallback to TCP on MP_FAIL with a single subflow
14688092: [mptcp-net,v2,2/3] mptcp: use READ/WRITE_ONCE for allow_subflows
14688093: [mptcp-net,v2,3/3] mptcp: add MPFailFallback MIB for MP_FAIL TCP fallback:
    - State: New
    - Series: mptcp: fix TCP fallback on single-subflow MP_FAIL
    - Submitter: Chenguang Zhao
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1127903&state=*&archive=both
    - TODO: review: look too complex?

14688538: [mptcp-next,1/2] mptcp: sched: add subflow avoid flag and kfunc
14688539: [mptcp-next,2/2] selftests: mptcp: bpf: exercise the subflow avoid flag:
    - State: New
    - Series: mptcp: sched: let schedulers mark a subflow to avoid
    - Submitter: Kalpan Jani
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1128052&state=*&archive=both
    - TODO: review → TODO

14692583: [mptcp-next,v7,1/9] ipv4: fix uninitialized memory in zerocopy cmsg
14692584: [mptcp-next,v7,2/9] mptcp: use local variable tp in sendmsg_frag
14692585: [mptcp-next,v7,3/9] mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
14692586: [mptcp-next,v7,4/9] mptcp: remove redundant orig_offset in carve_data_frag
14692587: [mptcp-next,v7,5/9] mptcp: add MSG_ZEROCOPY support
14692588: [mptcp-next,v7,6/9] mptcp: handle SO_ZEROCOPY in setsockopt
14692589: [mptcp-next,v7,7/9] selftests: mptcp: connect: add zerocopy io mode
14692590: [mptcp-next,v7,8/9] selftests: mptcp: connect: cover zerocopy mode
14692591: [mptcp-next,v7,9/9] selftests: mptcp: connect: close listensock deterministically:
    - State: New
    - Series: mptcp: add MSG_ZEROCOPY support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1129243&state=*&archive=both
    - TODO: review → TODO

14706006: [mptcp-next,1/2] mptcp: pm: userspace: decrement local_addr_used when remove
14706007: [mptcp-next,2/2] selftests: mptcp: check local_addr_used in userspace PM:
    - State: New
    - Series: mptcp: fix local_addr_used issue in userspace PM
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1133148&state=*&archive=both
    - TODO: likely not needed with Geliang and Matt's series on that topic  → rejected

14706008: tools: Use fputc() calls in some functions:
    - State: Rejected
    - Series: tools: Use fputc() calls in some functions
    - Submitter: Markus Elfring
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1133149&state=*&archive=both

14707751: [mptcp-next,2/2] selftests: mptcp: simult_flows: set EXIT trap earlier:
    - State: New
    - Series: selftests: mptcp: some improvement for selftests
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1133691&state=*&archive=both
    - unlikely, could be OK but there is a risk to be rejected by netdev maintainers, so no.

14710799: [mptcp-next,1/3] mptcp: sched: penalise a slow subflow by halving its cwnd
14710800: [mptcp-next,2/3] mptcp: sched: do not penalise when receive-window-limited
14710801: [mptcp-next,3/3] DO-NOT-MERGE: mptcp: sched: penalise counters:
    - State: New
    - Series: mptcp: sched: penalise a slow subflow ("345, first cut for your lab)
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1134545&state=*&archive=both
    - RFC, Reviewed by Matt

14710937: [mptcp-next,v13,01/12] selftests: mptcp: sockopt: reseed RNG after fork
14710938: [mptcp-next,v13,02/12] selftests: mptcp: sockopt: use exact length in connect_one_server
14710939: [mptcp-next,v13,03/12] selftests: mptcp: sockopt: add check_stat_equal helper
14710940: [mptcp-next,v13,04/12] selftests: mptcp: sockopt: use size_t for byte counters
14710941: [mptcp-next,v13,05/12] selftests: mptcp: sockopt: add is_mptcp_socket helper
14710942: [mptcp-next,v13,06/12] selftests: mptcp: sockopt: add tx/rx protocol options
14710943: [mptcp-next,v13,07/12] selftests: mptcp: sockopt: add TCP_INQ test option
14710944: [mptcp-next,v13,08/12] selftests: mptcp: sockopt: use unix socket instead of pipe
14710945: [mptcp-next,v13,09/12] selftests: mptcp: sockopt: use recvmsg instead of read
14710946: [mptcp-next,v13,10/12] selftests: mptcp: sockopt: get and verify TCP_INQ
14710947: [mptcp-next,v13,11/12] selftests: mptcp: sockopt: add huge data transfer tests
14710948: [mptcp-next,v13,12/12] selftests: mptcp: sockopt: replace mptcp_inq with sockopt:
    - State: New
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1134601&state=*&archive=both
    - TODO: review → TODO!!

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
    - New version needed → split needed, hard to follow

14712496: [mptcp-next,1/6] mptcp: drop the mptcp_ooo_try_coalesce() helper
14712497: [mptcp-next,2/6] mptcp: drop the cant_coalesce CB field
14712498: [mptcp-next,3/6] mptcp: remove CB offset field
14712499: [mptcp-next,4/6] mptcp: sync mptcp skb cb layout with tcp one
14712500: [mptcp-next,5/6] mptcp: trim the duplicated skb head at receive enqueue
14712501: [mptcp-next,6/6] mptcp: defer sk_data_ready to the worker:
    - State: New
    - Series: Reduce the differences between TCP and MPTCP for TLS usage
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1135094&state=*&archive=both
    - With patches from Paolo
    - Reviewed by Paolo, last two patches looks too big for sensitive code (move data)

14713463: [mptcp-net,1/6] mptcp: pm: userspace: properly handle the ID0 case
14713464: [mptcp-net,2/6] mptcp: pm: userspace: allow announcing ID0 addr
14713465: [mptcp-net,3/6] mptcp: pm: userspace: no ID0 exception for RM_ADDR
14713466: [mptcp-net,4/6] mptcp: pm: userspace: don't dump initial ID0
14713468: [mptcp-net,5/6] selftests: mptcp: join: new ID0 subflow from the right IP
14713467: [mptcp-net,6/6] mptcp: pm: restrict in-kernel worker actions to this PM:
    - State: New
    - Series: mptcp: pm: userspace: properly deal with the ID0 case
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1135314&state=*&archive=both
    - OK to slightly increase memory usage in favour of reducing complexity and avoid adding a bunch of new exceptions? → yes

14715298: [mptcp-next,v3,1/9] mptcp: inherit sk_reuse/sk_reuseport on subflow creation
14715299: [mptcp-next,v3,2/9] mptcp: handle TCP_MAXSEG getsockopt in common case
14715300: [mptcp-next,v3,3/9] mptcp: add TCP_SYNCNT setsockopt/getsockopt
14715301: [mptcp-next,v3,4/9] ipv6: extract and export ip6_sock_set_tclass helper
14715302: [mptcp-next,v3,5/9] nvme-fabrics: add IPv6 traffic class option
14715303: [mptcp-next,v3,6/9] nvme-tcp: support IPv6 traffic class
14715304: [mptcp-next,v3,7/9] nvmet-tcp: support IPv6 traffic class
14715305: [mptcp-next,v3,8/9] mptcp: sockopt: implement IPV6_TCLASS
14715306: [mptcp-next,v3,9/9] mptcp: copy the subflow's tos/tclass to the msk on accept:
    - State: New
    - Series: Fix socket options used by NVMe over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1135876&state=*&archive=both
    - TODO: review → TODO!!


→ TODO: Matth: update script to flag uncomplete series that are mixed with other patches here above: Done

Extra, just in case



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 623):

/

    Recently discussed:

  623  [sashiko] possible use-after-free in `mptcp_pm_del_add_timer` [bug]:
      - Kalpan had a patch, but it shouldn't be needed. Can be closed?

  483  [6.1] selftests: `mptcp_connect.sh` failures with `copyfd_io_poll: poll timed out` errors [bug] [selftests]:
      - Reproduced on amazon side, but slightly different. But not on Matt's side. Waiting for them to find out when the regression got introduced.

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched] @geliangtang:
      - Kalpan is looking at this.


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
  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
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


    Recently closed (since 20260617)

  621  [syzkaller] WARNING in `inet_sock_destruct`: `atomic_read(&sk->sk_rmem_alloc)` [bug] [syzkaller]
  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]


    Packetdrill PRs

  201  6 hours ago   k-jani-git          mptcp: add regression test for stale ADD_ADDR on id 0 removal (issue #620):
      - a valid patch is required

  200  16 days ago   chrisocean716-star  mptcp: add sync_join_fail packetdrill test:
      - check kernel patches

  162  5 months ago  geliangtang         mptcp: add splice test:
      - WIP

  52   1 year ago    dcaratti            Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcp-upstream-virtme-docker PRs: /


    mptcpd PRs

  335  22 days ago  Dwyane-Yan  UserPM: Implement per-token get_addr/dump_addrs for userspace path manager:
      - TODO: review → TODO!! → done




FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (7.3): https://github.com/orgs/multipath-tcp/projects/21
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [83c1c5f55802] mptcp: fastopen: only mark MPTFO subflows with SYN data (Wyatt Feng)
        - [93f9f6a5f0c9] mptcp: pm: fix data race in add_addr timer callback (Qing Luo)
        - [30c0951de5cc] selftests: mptcp: join: mark tests with data corruption as failed (Gang Yan)
        - [bab3db141834] mptcp: reclaim forward-allocated memory on RX path errors (Paolo Abeni)
        - [64f53f920f3d] mptcp: avoid combining some incoming suboptions (Matthieu Baerts (NGI0)):
            - TODO: new tasks to have a counter for invalid suboptions for ↑ → done
            - all of them sent to netdev

    - Fixes for net-next: /

    - Features for net-next:

        - [44f17bbaf5c2] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [e195ffe4a245] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [7b8cdee0e7c7] mptcp: pm: add get_priority() interface (Geliang Tang)
        - [3ad35a361bc2] selftests: mptcp: connect: test name in pcap file (Matthieu Baerts (NGI0))
        - [f362e8b52797] selftests: mptcp: simult_flow: test name in pcap file (Matthieu Baerts (NGI0))
        - [38c2c0f1220b] selftests: mptcp: pcap: drop most of the payload (Matthieu Baerts (NGI0))
        - [e4b47358de34] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow (Tao Cui)
        - [16ad7944deb6] mptcp: remove unused data_ack from struct mptcp_ext (Geliang Tang)

        - [729c2cd18d75] mptcp: move the retrans loop to a separate helper (Paolo Abeni)
        - [205bffd09876] mptcp: let the retrans scheduler do its job (Paolo Abeni)
        - [cf742bd24069] mptcp: explicitly drop over memory limits (Paolo Abeni)
        - [b6883a8cae94] mptcp: enforce hard limit on backlog flushing (Paolo Abeni)
        - [2d6fc8b3b0ba] mptcp: implemented OoO queue pruning (Paolo Abeni):
            - v2 required: TODO: Matth → done

        - [e095c0ff8895] selftests: mptcp: fix const qualifier warnings in strchr usage (Geliang Tang)

    - Features for net-next (next): /

    - Features for other trees:

        - [e014c6d57573] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [88919cf669f1] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [33e45286483e] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [f3146a504b1e] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [1dca3b1981c1] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [06a804b423a5] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [034d50ad0f5e] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [903da22206a7] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [f5e95f62bfaa] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [2fe9e3da05bb] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [11b2c96c809a] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang)




Extra tests:
    - news about Syzkaller? (Matth):
        - 

    - Packetdrill (Davide):
        - 

    - Patchew (Davide):
        - 

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - 



Other topics:
    - enable Sashiko's emails? Replying to the list or only the author? Even when everything is OK?:
        - yes
        - TODO: Matth: PR → done
    - ask Jakub about Claude's review that is now often failing → maybe something in Netdev sashiko?:
        - TODO: Matth → done, but not available now
    - From net maintainers: companies should have a Sashiko instance, and employees should check it before submission::
        - TODO: Send reminder when too many versions are sent


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

