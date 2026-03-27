Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B763009EE
	for <mptcp@lists.linux.dev>; Fri, 27 Mar 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637924; cv=none; b=UoDWHx2NaHyxuj+F9l7cJudyaJ3OB1mhpmEGo685KUYpkzF0/Vqymr40xyZMLzUNoJ9bvkjsRf0Ez/kgR0MaY9lySdLcVF2AwPVPWilrmYtj56OJALta2s3rd8INZF3UI9CaeWCC+8j+O1gWrKUhxO/lRFgx/Mu0RGMnSpegSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637924; c=relaxed/simple;
	bh=esokfOw+/fxId+ey8otSRTBMqKO/oy6K/0ZrVv4ZZ9o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=qjGISN7ZT1pxxuFh0+SHUpADAASFk9Hr2NaSTHnmlBepP6ypN8KjeNaX1GoPr6eMINDDfVtVOOdj9l3kCBLrSsuxEJJ/GsN//vZ5/b8mmhaJ5WcA4D/9Ffrmw2XHuVl4HeIjDSeC/Mwm62o/pqvnbqGZaDDU9zv6khFCabge1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcnsXJzV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcnsXJzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48118C19423
	for <mptcp@lists.linux.dev>; Fri, 27 Mar 2026 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774637924;
	bh=esokfOw+/fxId+ey8otSRTBMqKO/oy6K/0ZrVv4ZZ9o=;
	h=Date:From:Subject:To:From;
	b=QcnsXJzVvIT3cwIz8fYEGJjKk/Yst8fleRmiuPCe/86Mhjuj/TJdtfonZ7KW3oi0n
	 /dMBY5x3dTiam+2iT0WPmtOkJ5jNM8+QIwCBybB0uU8DxrID42E2fF/TVigvV6Hxfj
	 GRAmkWiIbyhnQM54Qyt0Bl5q+8Gpxq58uDRajaj3LZWWrICZIgm6CNLiKVDgk1BpIM
	 PaPA5ZT9JdemR/WOqqKnfkn3ky0KkzNOXgdXXZ5d15keKElOsnBIyLlTFetQdfSbg8
	 5R0TtKCAOjtAHQfuPZU0Qxugwg+UEtMWpb8yxYTPhtomKOEAtrHMN8FDd417731wlH
	 h0s1B2fgB1EkQ==
Message-ID: <8a9beead-811b-4dbb-8afd-4308fec8a0a6@kernel.org>
Date: Fri, 27 Mar 2026 19:58:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Subject: [Weekly meetings] MoM - 25th of March 2026
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), and myself
(NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Li Xiasong, Matthieu Baerts, Keita Morisaki, Simon Baatz):

14449624: [net,1/5] selftests: mptcp: more stable simult_flows tests
14449625: [net,2/5] mptcp: pm: avoid sending RM_ADDR over same subflow
14449626: [net,3/5] selftests: mptcp: join: check RM_ADDR not sent over same subflow
14449627: [net,4/5] mptcp: pm: in-kernel: always mark signal+subflow endp as used
14449628: [net,5/5] selftests: mptcp: join: check removing signal+subflow endp:
    - Series: mptcp: misc fixes for v7.0-rc2
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1060560&state=*&archive=both

14460614: [net-next,v3,1/6] tcp: implement RFC 7323 window retraction receiver requirements
14460615: [net-next,v3,2/6] mptcp: keep rcv_mwnd_seq in sync with subflow rcv_wnd
14460616: [net-next,v3,3/6] tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
14460617: [net-next,v3,4/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
14460618: [net-next,v3,5/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
14460619: [net-next,v3,6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt:
    - Series: tcp: RFC 7323-compliant window retraction handling
    - Submitter: Simon Baatz
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1063485&state=*&archive=both

14483786: [net] MPTCP: fix lock class name family in pm_nl_create_listen_socket:
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260319112159.3118874-1-lixiasong1@huawei.com/


14451810: [net-next,V2,RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb():
    - Submitter: Keita Morisaki
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260304111517.2088694-1-kmta1236@gmail.com/


    our repo (by: Matthieu Baerts):

14427551: [mptcp-net] mptcp: pm: in-kernel: always mark signal+subflow endp as used:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org/

14428224: [mptcp-net] selftests: mptcp: join: check removing signal+subflow endp:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260219101033.716403-2-matttbe@kernel.org/

14429639: [mptcp-net,v2,1/2] mptcp: pm: avoid sending RM_ADDR over same subflow
14429640: [mptcp-net,v2,2/2] selftests: mptcp: join: check RM_ADDR not sent over same subflow:
    - Series: mptcp: pm: avoid sending RM_ADDR over the same subflow
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1055875&state=*&archive=both

14432575: [mptcp-next] mptcp: pm: in-kernel: remove mptcp_pm_has_addr_attr_id:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260223-mptcp_pm_has_addr_attr_id-v1-1-1efb38ad6488@kernel.org/

14432728: [mptcp-next] selftests: mptcp: join: recreate signal endp with same ID:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260223-mptcp-sft-re-use-id-v1-1-ec648a8bda22@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Li Xiasong, Matthieu Baerts):

14461679: [net-next,1/2] mptcp: better mptcp-level RTT estimator
14461680: [net-next,2/2] mptcp: add receive queue awareness in tcp_rcv_space_adjust():
    - Series: mptcp: autotune related improvement
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1063766&state=*&archive=both

14492176: [net,v2] mptcp: fix soft lockup in mptcp_recvmsg():
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260324085131.4187473-1-lixiasong1@huawei.com/
    - v3 is expected.
    - Funny to see different AI reviews for that one:
        - https://sashiko.dev/#/patchset/20260324085131.4187473-1-lixiasong1%40huawei.com → Google
        - https://netdev-ai.bots.linux.dev/ai-review.html?id=4d7f2ec2-b646-4362-a319-b37727b095d6 → Claude on Netdev
        - https://netdev-ai.bots.linux.dev/ai-review.html?id=fc105106-677e-44c6-8189-ab8feef032aa → Claude on MPTCP


    our repo (by: Christoph Paasch, Gang Yan, Geliang Tang, Gregory Detal, Matthieu Baerts):

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
    - Submitter: Geliang Tanghttps://github.com/sashiko-dev/sashiko/issues/50
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
14443235: [RESEND,mptcp-net,v2] mptcp: fix stall because of data_ready:
    - State: Changes requested
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260228011511.440437-1-gang.yan@linux.dev/
    - status: same as last time

14456317: [RESEND,mptcp-net] mptcp: sync the msk->sndbuf at accept() time:
    - State: New
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260306062316.1333680-1-gang.yan@linux.dev/
    - TODO: Matth: check with Paolo → WIP

14460375: [mptcp-next] mptcp: preserve MSG_EOR semantics in sendmsg path:
    - State: New
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260309025431.125943-1-gang.yan@linux.dev/
    - TODO: Matth: check AI review and reply → done

14472498: [RFC,mptcp-next,v5,1/7] mptcp: add sk_is_msk helper
14472499: [RFC,mptcp-next,v5,2/7] mptcp: add sock_set_nodelay
14472500: [RFC,mptcp-next,v5,3/7] mptcp: add sock_set_reuseaddr
14472501: [RFC,mptcp-next,v5,4/7] nvmet-tcp: add mptcp support
14472502: [RFC,mptcp-next,v5,5/7] mptcp: add sock_set_syncnt
14472503: [RFC,mptcp-next,v5,6/7] nvme-tcp: add mptcp support
14472504: [RFC,mptcp-next,v5,7/7] selftests: mptcp: add NVMe over MPTCP test:
    - State: New
    - Series: VME over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1066056&state=*&archive=both
    - Depends on ↓ "mptcp: fix stall because of data_ready"

14478424: [mptcp-net,v3,1/3] mptcp: replace backlog_list with backlog_queue
14478425: [mptcp-net,v3,2/3] mptcp: fix the stall problems using backlog_queue
14478426: [mptcp-net,v3,3/3] mptcp: fix the stall problems with data_ready:
    - State: Changes requested
    - Series: mptcp: fix stall because of data_ready
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1067816&state=*&archive=both
    - Some issues spot by AI review and during testing by Geliang

14478733: [RESEND,mptcp-next,v2,1/3] tcp: export do_tcp_splice_eof
14478734: [RESEND,mptcp-next,v2,2/3] mptcp: implement .splice_eof
14478735: [RESEND,mptcp-next,v2,3/3] selftests: mptcp: connect: trigger splice_eof:
    - State: New
    - Series: implement .splice_eof
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1067870&state=*&archive=both
    - TODO: Matth: review → done

14478764: [RESEND,mptcp-next,v2,1/2] mptcp: check desc->count in read_sock
14478765: [RESEND,mptcp-next,v2,2/2] tcp: add recv_should_stop helper:
    - State: New
    - Series: add tcp_recv_should_stop helper
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1067876&state=*&archive=both
    - Patch 2/2 looks OK but is not a simple refactoring as stated, but patch 1/2:
        - is it a fix?
        - or just some extra code that is not needed but doesn't hurt → in this case the patch is not needed
        - TODO: Matth: reply on ML → Done

14478884: [mptcp-net,v2] mptcp: fix data-race in __mptcp_retrans / mptcp_incoming_options:
    - State: Queued
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org/
    - patch is OK, but likely other places to fix as well → TODO Matth

14481348: [mptcp-next,v3,1/2] mptcp: implement psock_update_sk_prot
14481349: [mptcp-next,v3,2/2] selftests/bpf: Update sockmap tests for MPTCP:
    - State: New
    - Series: implement psock_update_sk_prot
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1068551&state=*&archive=both
    - AI review found some issues: https://netdev-ai.bots.linux.dev/ai-review.html?id=57d21956-629b-4fcd-ba95-310317b0f175
    - legit?

14483678: [RFC,mptcp-next,v11,01/15] tls: introduce struct tls_prot_ops for protocol ops
14483679: [RFC,mptcp-next,v11,02/15] tls: add tls_prot_ops pointer to tls_context
14483680: [RFC,mptcp-next,v11,03/15] tls: add MPTCP SKB offset check in strp queue walk
14483681: [RFC,mptcp-next,v11,04/15] mptcp: update mptcp_check_readable for TLS use
14483682: [RFC,mptcp-next,v11,05/15] mptcp: avoid sleeping in read_sock path under softirq
14483683: [RFC,mptcp-next,v11,06/15] mptcp: implement tls_mptcp_ops for MPTCP TLS
14483684: [RFC,mptcp-next,v11,07/15] tls: disable device offload for MPTCP sockets
14483685: [RFC,mptcp-next,v11,08/15] mptcp: update ULP getsockopt for TLS support
14483686: [RFC,mptcp-next,v11,09/15] mptcp: enable ULP setsockopt for TLS support
14483687: [RFC,mptcp-next,v11,10/15] selftests: mptcp: connect: use espintcp for ULP test
14483688: [RFC,mptcp-next,v11,11/15] selftests: tls: add mptcp variant for testing
14483689: [RFC,mptcp-next,v11,12/15] selftests: tls: increase nonblocking data size for MPTCP
14483690: [RFC,mptcp-next,v11,13/15] selftests: tls: wait TCP_CLOSE in shutdown_reuse for MPTCP
14483691: [RFC,mptcp-next,v11,14/15] selftests: tls: add MPTCP test cases
14483692: [RFC,mptcp-next,v11,15/15] selftests: mptcp: cover mptcp tls tests:
    - State: New
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1069182&state=*&archive=both
    - Needs to be reviewed

14492302: [6.1.y,1/2] selftests: mptcp: join: implicit: stop transfer after last check
14492303: [6.1.y,2/2] selftests: mptcp: join: check removing signal+subflow endp:
    - State: New
    - Series: selftests: mptcp: specific fixes for v6.1
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1071541&state=*&archive=both


Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 618):

None.


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  616  Subflow on a inactive and disconnected network path disconnects after ~16 minutes [bug]
  602  A query about the update of 'msk->sk_sndbuf' [bug]
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


    Recently closed (since 2026-03-11)

  617  CI: Stalls when starting a VSOCK listening socket: soft lockups, RCU stalls, timeout [bug] [CI] @matttbe:
      - even got mentioned on Phoronix: https://www.phoronix.com/news/Linux-7.0-Sched-Fixes-Perf-Hang


    Packetdrill PRs

  189  16 days ago  Dwyane-Yan   packetdrill: mptcp: add tests for MSG_EOR:
      - Matth: TODO: check that → done

  162  1 month ago  geliangtang  mptcp: add splice test
  52   1 year ago   dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /



    mptcp-upstream-virtme-docker PRs: /



    mptcpd PRs: /



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (7.1): https://github.com/orgs/multipath-tcp/projects/19
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:


    - Fixes for -net:

        - [664615b26a0e] mptcp: fix soft lockup in mptcp_recvmsg() (Li Xiasong):
            - Already sent
            - a new version

    - Fixes for net-next: /


    - Features for net-next:

        - [df303635a41d] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [062587ca01fa] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [a538a6f9bc81] mptcp: pm: add get_priority() interface (Geliang Tang):
            - wait for pm->lock refactoring

        - [c2b696680946] mptcp: better mptcp-level RTT estimator (Paolo Abeni)
        - [d05f4dd1b62e] mptcp: add receive queue awareness in tcp_rcv_space_adjust() (Paolo Abeni):
            - new version needed, see AI review → TODO Paolo (or Matth?)

        - [9f01ac098cb6] mptcp: pm: in-kernel: remove mptcp_pm_has_addr_attr_id (Matthieu Baerts (NGI0))
        - [b56a02218c50] selftests: mptcp: join: recreate signal endp with same ID (Matthieu Baerts (NGI0)):
            - can wait a bit to be sent with other small refactoring

    - Features for net-next (next): /

    - Features for other trees:

        - [ead68f28763e] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [5894d027dfe1] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [355b0bf44f01] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [ffc24a871489] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [cdfb6b9e0e23] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [f79179a227ea] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [6aeb42300043] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [6323b7739fdf] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [00ced3af9699] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [48eb8cf7400b] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [93825ab22e4e] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang):
            - wait for sched API refactoring




Extra tests:
    - news about Syzkaller? (Matth):
        - now with instances running with KCSAN and KMSAN which were not enabled before because mutually exclusive with KASAN

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - packetdrill issues with some retransmissions, to be checked what other better solutions we can have, maybe a sysctl to avoid such spurious retransmissions or do not check results in details with a kernel in debug mode (similar to what is done on NIPA)



AI reviews:
    - MPTCP patches are also checked by Google Gemini:
        https://sashiko.dev/#/?list=dev.linux.lists.mptcp
    - Could be nice to add a link from Patchwork: TODO Matth: modify CI to poll, or check if they can add the status (one post) → Done https://github.com/sashiko-dev/sashiko/issues/50
    - Could be even better to add the status result, if we have it at that time



Next meeting:
    - Next one on Wednesday, the 8th of April.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20260408



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

