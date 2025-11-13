Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF02F7AAC
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020648; cv=none; b=mCrfRlb1n8Zy2fYFPtfsA5VmH3uXMRryFW3yu1SJOSERJvyOv/XTV4zibF+Sia5/oyl0AzsvXoHhhn81l+tgQsvs13sCeN05ptDHZqHXxnYJiaK3fIlcGzHAdrZOi5o9ZlcySNm0RhGgGMNWqJE/NXOtdc9iwG3ArOeDN8Gzgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020648; c=relaxed/simple;
	bh=OBWAjIWn2J7UREk8EetcvsfP1TQhiOGvIr2rkr+itiY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNIp41dXRzBq82f4288JByb5+nez0ENFkcSXlHRrUSePXtxmaqk7NruO3dTn4dI5YbCq11CVxuQH7jzZG2Sow0bMdocQsbZGJ7knuqU0z7deC4jRjR/lnNeYkDa0sQBYHctcKJPl3+suqYtT/Xr2NOvoBtHNqRFfFfSv7uMFcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBoivHJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBoivHJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7960AC4CEF8;
	Thu, 13 Nov 2025 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763020648;
	bh=OBWAjIWn2J7UREk8EetcvsfP1TQhiOGvIr2rkr+itiY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=qBoivHJNkQic00jxEMx5zEEJ0Y2c6wcRYXwSaep1mxtTD8jLZSV/McD1LibyB1gVi
	 BJy6GPJ9pVLM3DYiShh2TdQ6yyGHHkwWiuS6tOpM4/lEp+SfW1hGdIRJajCD79AUsz
	 LDrZNOf0iwc3l6jAx98YnIq+RcrIhA+lSjRHrTMrLhAA7fpafN/u4VcZRKjaFzsvXr
	 mrVW7tH1Dgc0w8yjKaz1uNfp8Gq2uKTdpuTF8OlVbYp22DUWYDzxpw33+DPBIwT+2u
	 UyozfsFfIcXwDQjSQQi1hTtcY7bwU+iOCohjSXjBK9NNkcLSVnxLnpjwyFMjuzajJX
	 udJMvBadYtlWA==
Message-ID: <f270053afcebcaa9978053dde206b0e9c3e4d82a.camel@kernel.org>
Subject: Re: [Weekly meetings] MoM - 5th of November 2025
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Thu, 13 Nov 2025 15:57:24 +0800
In-Reply-To: <5e7430ff-ef27-49ef-a295-875a8c6fdcd1@kernel.org>
References: <5e7430ff-ef27-49ef-a295-875a8c6fdcd1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-11-12 at 18:58 +0100, Matthieu Baerts wrote:
> Hello everyone,
> 
> Last week, we had our new meeting with Mat (Cruise), Paolo (Redhat)
> and
> myself (NGI0 Core).
> 
> 
> Thanks again for this new good meeting!
> 
> 
> Here are the minutes of the meeting:
> 
> 
> 
> Accepted patches:
>     - The list of accepted patches can be seen on PatchWork:
>       https://patchwork.kernel.org/project/mptcp/list/?state=3
> 
> 
>     netdev (if mptcp ML is in cc) (by: Matthieu Baerts):
> 
> 14287659: [net,1/4] mptcp: drop bogus optimization in
> __mptcp_check_push()
> 14287660: [net,2/4] mptcp: fix MSG_PEEK stream corruption
> 14287661: [net,3/4] mptcp: restore window probe
> 14287662: [net,4/4] mptcp: zero window probe mib:
>     - Series: mptcp: various rare sending issues
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1016623&state=*&archive=both
> 
> 14287911: [net,v3,1/4] mptcp: fix subflow rcvbuf adjust
> 14287912: [net,v3,2/4] trace: tcp: add three metrics to
> trace_tcp_rcvbuf_grow()
> 14287913: [net,v3,3/4] tcp: add newval parameter to tcp_rcvbuf_grow()
> 14287914: [net,v3,4/4] tcp: fix too slow tcp_rcvbuf_grow() action:
>     - Series: tcp: fix receive autotune again
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1016697&state=*&archive=both
> 
> 14295026: [net-next,1/4] mptcp: pm: in-kernel: record fullmesh endp
> nb
> 14295027: [net-next,2/4] mptcp: pm: in kernel: only use fullmesh endp
> if any
> 14295028: [net-next,3/4] selftests: mptcp: join: do_transfer: reduce
> code dup
> 14295029: [net-next,4/4] selftests: mptcp: join: validate extra bind
> cases:
>     - Series: mptcp: pm: in-kernel: fullmesh endp nb + bind cases
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1018552&state=*&archive=both
> 
> 
>     our repo (by: GangYan, Matthieu Baerts, Paolo Abeni):
> 
> 14278733: [v2,mptcp-net,1/2] mptcp: restore window probe
> 14278734: [v2,mptcp-net,2/2] mptcp: zero window probe mib:
>     - Series: mptcp: restore zero window probe
>     - Submitter: Paolo Abeni
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1014382&state=*&archive=both
> 
> 14279404: [v6,mptcp-next,01/11] mptcp: drop bogus optimization in
> __mptcp_check_push()
> 14279409: [v6,mptcp-next,03/11] mptcp: cleanup fallback data fin
> reception
> 14279407: [v6,mptcp-next,04/11] mptcp: cleanup fallback dummy mapping
> generation
> 14279406: [v6,mptcp-next,05/11] mptcp: fix MSG_PEEK stream corruption
> 14279408: [v6,mptcp-next,06/11] mptcp: ensure the kernel PM does not
> take action too late
> 14279411: [v6,mptcp-next,07/11] mptcp: do not miss early first
> subflow
> close event notification.
> 14279410: [v6,mptcp-next,08/11] mptcp: make mptcp_destroy_common()
> static
> 14279412: [v6,mptcp-next,09/11] mptcp: drop the __mptcp_data_ready()
> helper
> 14283178: [mptcp-next] Squash to "selftests: mptcp: join: validate
> extra
> bind cases":
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org/
> 
> 14295242: [mptcp-net,v2,1/6] selftests: mptcp: connect: fix fallback
> note due to OoO
> 14295243: [mptcp-net,v2,2/6] selftests: mptcp: join: rm: set backup
> flag
> 14295244: [mptcp-net,v2,3/6] selftests: mptcp: join: endpoints:
> longer
> transfer
> 14295245: [mptcp-net,v2,4/6] selftests: mptcp: join: userspace:
> longer
> transfer
> 14295246: [mptcp-net,v2,5/6] selftests: mptcp: join: fastclose: drop
> plain RST
> 14295247: [mptcp-net,v2,6/6] selftests: mptcp: connect: trunc: read
> all
> recv data:
>     - Series: selftests: mptcp: join: fix flaky tests
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1018612&state=*&archive=both
> 
> 14297102: [mptcp-next,1/5] selftests: mptcp: lib: introduce
> 'nstat_{init,get}'
> 14297103: [mptcp-next,2/5] selftests: mptcp: lib: remove stats files
> args
> 14297104: [mptcp-next,3/5] selftests: mptcp: lib: stats: remove nstat
> rate columns
> 14297105: [mptcp-next,4/5] selftests: mptcp: join: dump stats from
> history
> 14297106: [mptcp-next,5/5] selftests: mptcp: lib: get counters from
> nstat history:
>     - Series: selftests: mptcp: get counters from nstat history
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1019082&state=*&archive=both
> 
> 14298228: [mptcp-net] mptcp: fix address removal logic in
> mptcp_pm_nl_rm_addr:
>     - Submitter: GangYan
>     - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20251104123416.395362-1-gang.yan@linux.dev/
> 
> 14298615: [mptcp-next,v8,1/4] mptcp: handle first subflow closing
> consistently
> 14298614: [mptcp-next,v8,2/4] mptcp: borrow forward memory from
> subflow
> 14298616: [mptcp-next,v8,3/4] mptcp: introduce mptcp-level backlog
> 14298617: [mptcp-next,v8,4/4] mptcp: leverage the backlog for RX
> packet
> processing:
>     - Series: mptcp: introduce backlog processing
>     - Submitter: Paolo Abeni
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1019535&state=*&archive=both
> 
> 
> 
> Pending patches:
>     - The list of pending patches can be seen on PatchWork:
>       https://patchwork.kernel.org/project/mptcp/list/?state=*
> 
> 
>     netdev (if mptcp ML is in cc) (by: Jiayuan Chen):
> 
> 14299873: [net,v4,1/3] mptcp: disallow MPTCP subflows from sockmap
> 14299851: [net,v4,2/3] net,mptcp: fix proto fallback detection with
> BPF
> 14299874: [net,v4,3/3] selftests/bpf: Add mptcp test with sockmap:
>     - Series: mptcp: Fix conflicts between MPTCP and sockmap
>     - Submitter: Jiayuan Chen
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1019848&state=*&archive=both
> 
> 
> 14296835: [6.12.y-5.10.y] selftests: mptcp: connect modes: re-add
> exec mode:
>     - State: New
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20251103165433.6396-2-matttbe@kernel.org/
>     - cannot be applied because they use Quilt
> 
> 14298196: [6.12.y] mptcp: fix MSG_PEEK stream corruption:
>     - State: New
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20251104121515.1093006-2-matttbe@kernel.org/
> 
> 
>     our repo (by: Christoph Paasch, Gang Yan, Geliang Tang, Gregory
> Detal, Matthieu Baerts, Paolo Abeni):
> 
> 12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
> 13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
> 13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
>     - State: Changes requested
>     - Series: BPF redundant scheduler, part 3
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
>     - status: same as last time
> 
> 13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
> dedicated function
> 13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
> 13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
> 13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt()
> options
> 13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
> 13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
> IPV6_UNICAST_HOPS:
>     - State: Changes requested
>     - Series: mptcp: sockopt: uniform code to get/set values
>     - Submitter: Matthieu Baerts
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
>     - status: same as last time
> 
> 13583230: [RFC] mptcp: react scheduler when subflow events pop up:
>     - State: Changes requested
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
>     - status: same as last time
> 
> 13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
> 13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to
> schedule
> chunks
> 13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
> mptcp_sched_chunk
> 13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
> each subflow:
>     - State: RFC
>     - Series: mptcp: update scheduler API
>     - Submitter: Gregory Detal
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
>     - status: same as last time
> 
> 13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
> 13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX
> validation
> 13932546: [3/3] selftests: mptcp: add a testcase for invalid addr
> timeout:
>     - State: Changes requested
>     - Series: [1/3] mptcp: fix invalid addr occupy
> 'add_addr_accepted'
>     - Submitter: Gang Yan
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
>     - status: same as last time
> 
> 14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
> 14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
> 14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm
> subtest
> 14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm
> subtest:
>     - State: Changes requested
>     - Series: BPF path manager, part 7
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
>     - status: same as last time
> 
> 14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop
> delete_local_addr helper
> 14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update
> userspace
> dump_addr outputs
> 14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send
> RM_ADDR
> between server and client:
>     - State: Under review
>     - Series: only remove entry from local_addr_list when sending a
> REMOVE_ADDR
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
>     - status: same as last time
> 
> 14102233: [mptcp-next,v3,1/3] selftests/bpf: Add sndbuf for
> send_recv_data
> 14102235: [mptcp-next,v3,2/3] Squash to "selftests/bpf: Add bpf
> scheduler test"
> 14102234: [mptcp-next,v3,3/3] DO-NOT-MERGE: selftests/bpf: Increase
> total_bytes of bpf sched tests:
>     - State: Changes requested
>     - Series: send() fails with EAGAIN in blocking IO mode "487
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=967210&state=*&archive=both
>     - status: same as last time

#487 has been fixed by Paolo. So these patches can be dropped. I just
changed the states of them as "Rejected".

Thanks,
-Geliang

> 
> 14167004: [mptcp-next] mptcp: remove redundant orig_offset in
> carve_data_frag:
>     - State: Changes requested
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
>     - status: same as last time
> 
> 14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
> 14175679: [mptcp-next,2/2] selftests: Add tests for
> SO_MAX_PACING_RATE:
>     - State: Changes requested
>     - Series: mptcp: Add support for SO_MAX_PACING_RATE
>     - Submitter: Christoph Paasch
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
>     - status: same as last time
> 
> 14185125: [mptcp-next,1/6] mptcp: add helper for setsockopt on first
> subflow only
> 14185126: [mptcp-next,2/6] mptcp: handle SOL_SOCKET options on first
> subflow only
> 14185128: [mptcp-next,3/6] mptcp: refactor IP socket option handling
> for
> first subflow
> 14185127: [mptcp-next,4/6] mptcp: extract IPv6 socket option handling
> for first subflow
> 14185129: [mptcp-next,5/6] mptcp: handle SOL_TCP options on all
> subflows
> 14185130: [mptcp-next,6/6] mptcp: handle IP socket options on all
> subflows:
>     - State: Needs ack
>     - Series: refactor MPTCP socket option handling
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=990414&state=*&archive=both
>     - status: same as last time
> 
> 14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option
> support
> 14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
> 14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket
> option
> support:
>     - State: Needs ack
>     - Series: mptcp: add more sockopts
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
>     - status: same as last time
> 
> 14197780: [mptcp-next,v2,01/10] selftests: mptcp: sockopt: improve
> test
> output clarity
> 14197781: [mptcp-next,v2,02/10] selftests: mptcp: sockopt: add
> SO_REUSEADDR test helper
> 14197782: [mptcp-next,v2,03/10] selftests: mptcp: sockopt: add
> SO_REUSEPORT test
> 14197783: [mptcp-next,v2,04/10] selftests: mptcp: sockopt: add
> SO_BINDTODEVICE test
> 14197784: [mptcp-next,v2,05/10] selftests: mptcp: sockopt: add
> SO_BINDTOIFINDEX test
> 14197785: [mptcp-next,v2,06/10] selftests: mptcp: sockopt: add
> IP_FREEBIND tests
> 14197786: [mptcp-next,v2,07/10] selftests: mptcp: sockopt: add
> IP_TRANSPARENT tests
> 14197787: [mptcp-next,v2,08/10] selftests: mptcp: sockopt: add
> IP_BIND_ADDRESS_NO_PORT test
> 14197788: [mptcp-next,v2,09/10] selftests: mptcp: sockopt: add
> IP_LOCAL_PORT_RANGE test
> 14197789: [mptcp-next,v2,10/10] selftests: mptcp: sockopt: add
> IPV6_V6ONLY test:
>     - State: Changes requested
>     - Series: selftests: cover more MPTCP socket options
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=993905&state=*&archive=both
>     - status: same as last time
> 
> 14215849: [mptcp-net,v2,1/3] selftests: mptcp: close server file
> descriptor
> 14215850: [mptcp-net,v2,2/3] selftests: mptcp: close IPC descriptor
> on
> server side
> 14229120: [mptcp-next,v4,1/9] selftests: mptcp: sockopt: replace
> /dev/urandom with getrandom
> 14229121: [mptcp-next,v4,2/9] selftests: mptcp: sockopt: add protocol
> arguments
> 14229122: [mptcp-next,v4,3/9] selftests: mptcp: sockopt: add inq
> argument
> 14229123: [mptcp-next,v4,4/9] selftests: mptcp: sockopt: rename
> pipefd
> to ipcfd
> 14229124: [mptcp-next,v4,5/9] selftests: mptcp: sockopt: set TCP_INQ
> sockopt
> 14229125: [mptcp-next,v4,6/9] selftests: mptcp: sockopt: handle INQ
> on
> server side
> 14229126: [mptcp-next,v4,7/9] selftests: mptcp: sockopt: handle INQ
> on
> client side
> 14229127: [mptcp-next,v4,8/9] selftests: mptcp: sockopt: replace
> mptcp_inq with sockopt
> 14229128: [mptcp-next,v4,9/9] selftests: mptcp: sockopt: remove
> obsolete
> mptcp_inq:
>     - State: Changes requested
>     - Series: selftests: consolidate TCP_INQ testing into sockopt
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1001827&state=*&archive=both
>     - status: same as last time
> 
> 14280548: [mptcp-next,v13,1/8] mptcp: add eat_recv_skb helper
> 14280549: [mptcp-next,v13,2/8] mptcp: implement .read_sock
> 14280550: [mptcp-next,v13,3/8] tcp: add recv_should_stop helper
> 14280551: [mptcp-next,v13,4/8] mptcp: use recv_should_stop helper
> 14280552: [mptcp-next,v13,5/8] tcp: export tcp_splice_state
> 14280553: [mptcp-next,v13,6/8] mptcp: implement .splice_read
> 14280554: [mptcp-next,v13,7/8] selftests: mptcp: add splice io mode
> 14280555: [mptcp-next,v13,8/8] selftests: mptcp: connect: cover
> splice mode:
>     - State: New
>     - Series: implement mptcp read_sock
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1014823&state=*&archive=both
>     - Mat will have a look at it
> 
> 14299105: [v2,mptcp-next,1/7] trace: mptcp: add mptcp_rcvbuf_grow
> tracepoint
> 14299106: [v2,mptcp-next,2/7] mptcp: avoid unneeded subflow-level
> drops.
> 14299107: [v2,mptcp-next,3/7] mptcp: fix receive space timestamp
> initialization.
> 14299108: [v2,mptcp-next,4/7] mptcp: consolidate rcv space init
> 14299109: [v2,mptcp-next,5/7] mptcp: better rcv space initialization
> 14299110: [v2,mptcp-next,6/7] mptcp: better mptcp-level rtt estimator
> 14299111: [v2,mptcp-next,7/7] mptcp: add receive queue awareness in
> tcp_rcv_space_adjust():
>     - State: New
>     - Series: mptcp: autotune related improvement
>     - Submitter: Paolo Abeni
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1019624&state=*&archive=both
> 
> 14299674: [mptcp-next,v6,1/7] tcp: md5: remove redundant l3flag
> variable
> 14299675: [mptcp-next,v6,2/7] mptcp: handle TCP_MAXSEG getsockopt in
> common case
> 14299676: [mptcp-next,v6,3/7] mptcp: setsockopt support for
> TCP_MD5SIG
> 14299677: [mptcp-next,v6,4/7] selftests: mptcp: sockopt: add md5
> argument
> 14299678: [mptcp-next,v6,5/7] selftests: mptcp: sockopt: implement
> TCP_MD5SIG support
> 14299679: [mptcp-next,v6,6/7] selftests: mptcp: sockopt: skip
> getsockopt
> for MD5 tests
> 14299680: [mptcp-next,v6,7/7] selftests: mptcp: sockopt: add
> TCP_MD5SIG
> test cases:
>     - State: New
>     - Series: mptcp: TCP_MD5SIG support
>     - Submitter: Geliang Tang
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1019796&state=*&archive=both
>     - Matth: will check that
> 
> 14300058: [mptcp-net,1/2] mptcp: decouple mptcp fastclose from tcp
> close
> 14300059: [mptcp-net,2/2] mptcp: fix duplicate reset on fastclose:
>     - State: New
>     - Series: [mptcp-net,1/2] mptcp: decouple mptcp fastclose from
> tcp close
>     - Submitter: Paolo Abeni
>     - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=1019919&state=*&archive=both
> 
> 
> 
> Issues on GitHub:
>     https://github.com/multipath-tcp/mptcp_net-next/issues/
> 
>     Recently opened (latest from the last meeting: 593):
> 
>   596  selftests: `mptcp_join`: fastclose also generate "plain" RST
> [bug] [selftests] @pabeni:
>       - See patches above
> 
>   595  selftests: `mptcp_connect`: MPTCP -> MPTCP timeout during
> closing
> time [bug] [selftests]:
>       - tried to reproduce the issue but no luck so far.
>       - It is possible multiple data fin can be sent with different
> sequences: in this case, we might ignore the following data_fin
>       - Matth: TODO: check previous packet traces when that might
> have
> happened → done
> 
>   594  selftests: `mptcp_connect`: MPTCP -> TCP timeout during
> closing
> time [bug] [selftests]:
>       - tried to reproduce with a packetdrill test
>       - maybe try with no delay: it will depend on when the worker
> processes the FIN
>       - and also read the last bytes carried in the FIN
>       - and also injecting more data without reading them
>       - TODO Matth: check ↑ → done
> 
> 
>     Recently discussed
> 
>   592  Lower throughput with MPTCP vs TCP [bug]:
>       - HW GRO seems to be the culprit: it would be good to start
> discussing with NICs vendors (NVidia, Intel, etc.). It **might** be
> easy
> to add some exceptions for MPTCP in some NIC firmwares. Who has
> contact
> and/or could help to find the right people to talk to?
> 
>       - Strange TCP is not even higher, maybe because the limitation
> for
> TCP was the IO? (check with 'iperf3 -Z' and/or iotop) If yes, maybe
> we
> can never do better than TCP connections in this case. Or then the
> test
> case is maybe not realistic: it might be different with many
> applications and all sort of data to different hosts? Or maybe only
> the
> resilience is important here, and doing as good as TCP is fine?
> 
>       - It would be interesting to do the same validations on top of
> Paolo's pending series (EDIT: one left as of today, the rest is in
> our
> `export` branch), because there are new optimisations, especially
> when
> the latency is very short like what you would have on the same host
> or
> in a DC.
> 
>   591  in-kernel PM: not established paths when used with IPv6
> link-local addresses [bug]:
>       - Can be closed?
>       - TODO Matth → Done
> 
>   588  in-kernel PM: support NUMA awareness [enhancement] [feedback-
> needed]:
>       - Maybe BPF PM is the solution
> 
>   549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
> [selftests] [pm]:
>       - New comment from Gang: to be checked
> 
> 
>     Bugs (opened, flagged as "bug" and assigned)
> 
>   596  selftests: `mptcp_join`: fastclose also generate "plain" RST
> [bug] [selftests] @pabeni
>   575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for
> transparent integrations [bug] @geliangtang
>   498  in-kernel PM: closed subflows before `RM_ADDR` will not
> decrement
> `add_addr_accepted` [bug] [pm] @geliangtang
>   484  BPF: `setsockopt` on an MPTCP socket: check support [bug]
> [bpf]
> @geliangtang
>   445  MPTCP Info counters: start seq numbers ones from 0 [bug]
> @geliangtang
>   403  userspace pm: only remove entry from `local_addr_list` when
> sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
>   343  scheduler: react when subflow-level events pop up (ACK/RTO)
> [bug]
> [sched] @geliangtang
> 
> 
>     Bugs (opened and flagged as "bug" and not assigned)
> 
>   595  selftests: `mptcp_connect`: MPTCP -> MPTCP timeout during
> closing
> time [bug] [selftests]
>   594  selftests: `mptcp_connect`: MPTCP -> TCP timeout during
> closing
> time [bug] [selftests]
>   592  Lower throughput with MPTCP vs TCP [bug]
>   591  in-kernel PM: not established paths when used with IPv6
> link-local addresses [bug]
>   587  in-kernel PM: Server is only using single IP to establish
> subflows [bug]
>   586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]
>   583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
>   581  Default scheduler under-utilizes newly restored subflows on
> long-lived flows after WAN failback [bug]
>   574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed
> out
> [bug] [selftests]
>   572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
>   567  [syzbot] WARNING in `__mark_subflow_endp_available` [bug]
> [syzkaller] [reproducer]
>   561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug]
> [syzkaller]
>   549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
> [selftests] [pm]
>   508  Divide error on device removal [bug] [feedback-needed]
>   505  Subflows won't be used when the interface for the main flow is
> a
> subinterface [bug] [feedback-needed]
>   495  [syzkaller] KASAN: slab-use-after-free Read in
> `__inet6_lookup_established` [bug] [syzkaller]
>   494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
>   492  userspace pm: subflows counter: not updated when a subflows is
> removed from the other end [bug]
>   491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL
> MP_RST`
> are unstable [bug] [selftests]
>   483  [6.1] selftests: `mptcp_connect.sh` failures with
> `copyfd_io_poll: poll timed out` errors [bug] [selftests]
>   476  packetdrill: coalescing feature doesn't take into account
> MPTCP
> options [bug] [packetdrill]
>   475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
> [selftests]
>   439  mptcp vs net.ipv4.tcp_shrink_window [bug]
>   336  Issues with BPF packet scheduler [bug] [sched] [bpf]
>   325  selftests: `mptcp_join`: test 18 `signal addresses race test`
> is
> sometimes failing [bug] [selftests]
>   324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
> server test` are sometimes failing [bug] [selftests]
>   315  Issues with backup flow [bug]
> 
> 
>     In Progress (opened, new feature and assigned)
> 
>   568  socket option: support `IPV6_TCLASS` [enhancement]
> @geliangtang
>   480  MPTCP and KTLS support [enhancement] @geliangtang
>   434  in-kernel PM: increase subflows limit [enhancement] [pm]
> @matttbe
>   353  sockopt: uniform code to get/set values [enhancement] @matttbe
>   349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
> @geliangtang
>   296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
>   167  packetdrill: add coverage for RM_ADDR [enhancement]
> [packetdrill]
> @dcaratti
>    75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
>    74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang
> 
> 
>     Assigned Questions (opened, questions and assigned)
> 
>   548  disable mptcp for an interface [question] @matttbe
> 
> 
>     Open questions (opened, questions and not assigned)
> 
>   562  [performance] How much is the overhead of MPTCP？ [question]
>   530  about mptcp subflow creation question [question] [feedback-
> needed]
>   520  Question about proper MPTCP configuration over VPN. [question]
> [feedback-needed]
>   412  shadowsocks-libev not working, need guidance for PM
> configuration
> [question] [feedback-needed]
> 
> 
>     For later (opened and not assigned)
> 
>   590  in-kernel PM: use either `subflow` or `signal` depending on
> connector/listener app [enhancement]
>   588  in-kernel PM: support NUMA awareness [enhancement] [feedback-
> needed]
>   584  [syzkaller] improve coverage [syzkaller]
>   578  sockopt: support `SO_MAX_PACING_RATE` to limit the whole MPTCP
> connection [enhancement]
>   566  pm: use `signal` + `subflow` + `fullmesh` [enhancement] [pm]
>   556  Implement all required bits to C/R MPTCP connections from
> user-space (CRIU) [enhancement]
>   552  pm: in-kernel: delay before creating new subflows
> [enhancement]
>   545  Deal with multiple pure TCP ACK without MPTCP options
> [enhancement]
>   543  TCPDump: display `MP_TCPRST` info [enhancement]
>   542  in-kernel PM: limit to one subflow per network interface for
> each
> connection [enhancement] [pm]
>   535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
>   525  tests: cover more MPTCP socket options [enhancement]
> [packetdrill] [selftests]
>   521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
> [enhancement]
>   519  Reset the connection once "MPTCP has been verified" instead of
> a
> fallback [enhancement]
>   511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
>   497  in-kernel PM: check to create new subflows when some are
> destroyed [enhancement] [pm]
>   496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
>   481  remove refcount on TCP sockets for the timers [enhancement]
>   467  Scheduler: add redundant scheduler support in BPF
> [enhancement]
> [sched]
>   462  selftests: print (and set?) random seed [enhancement]
> [selftests]
>   461  Protocol: extend Data-Level Length field [enhancement]
> [protocol]
>   448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
> are enabled [enhancement]
>   441  optimize established options generation [enhancement]
>   440  in-kernel PM: re-establish subflows after "network" errors
> [enhancement] [pm]
>   426  selftests: validate listener sockets with multiple accepts
> [enhancement] [selftests]
>   396  ci: periodically run selftests from the export branch on
> stable
> kernels [enhancement] [selftests]
>   389  packetdrill: increase coverage for "early `close()`" cases
> [enhancement] [packetdrill]
>   350  scheduler: API changes (tasks) [enhancement] [sched]
>   348  scheduler: frequently probe "stale" subflow with reinjected
> data
> [enhancement] [sched]
>   345  scheduler: "penalise" some subflows by sending less than their
> cwnd [enhancement] [sched]
>   344  scheduler: new callback to initiate optimisations
> [enhancement]
> [sched]
>   337  in-kernel PM: listen socket: support "behind a NAT" use case
> [enhancement] [pm]
>   335  Server to Client subflows: option to allow joining the initial
> address and port [enhancement] [pm]
>   334  in-kernel PM: send >1 ADD_ADDR before the establishment of a
> new
> subflow [enhancement] [pm]
>   332  scheduler: implement a "opportunistic retransmission"
> [enhancement] [sched]
>   298  CG Memory accounting for passive MPTCP socket [enhancement]
>   289  mptcp: audit comments for non inclusive language [enhancement]
>   273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement]
> [packetdrill]
>   266  Packetdrill: add MP_FAIL coverage [packetdrill]
>   236  Review supported sockopts list [enhancement]
>   234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
> [packetdrill]
>   222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
>   215  TCP Urgent pointer and MPTCP [enhancement]
>   213  add MPTCP man page [enhancement]
>   208  better handing of ssk memory pressure in the TX path
> [enhancement]
>   202  Add sendmsg support for ancillary data [enhancement]
>   197  more mibs needed [enhancement]
>   180  Get an update when MPTCP fall back to TCP [enhancement]
>   177  improve retransmit subflow selection [enhancement]
>   169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a
> different
> port [enhancement] [packetdrill]
>   150  remove completely workqueue usage [enhancement]
>   141  avoid acquiring mptcp_data_lock() twice in the receive path
> [enhancement]
>    78  notify the application (userspace) when a subflow is
> added/removed [enhancement]
> 
> 
>     Recently closed (since 2025-10-22)
> 
>   593  New MPTCP connections won't be created if there's no
> connectivity
> on primary subflow [question]:
>       - Could be possible to handle that on MPTCP side, but it
> doesn't
> seem easy, and it might break expectations from userspace. Better to
> handle that with routes.
> 
>   589  selftests: `simult_flows`: "unbalanced bwidth with opposed,
> unbalanced delay" is unstable [bug] [selftests] @geliangtang
> 
> 
>     Packetdrill PRs
> 
>   181  22 hours ago  matttbe      mptcp: new DATA_FIN retrans tests:
>       - New test, passing, can be merged if reviews are OK
> 
>   180  12 days ago   matttbe      mptcp: unskip TCP_NOTSENT_LOWAT
> test:
>       - Seems passing now, can be merged if reviews are OK
> 
>   162  4 months ago  geliangtang  mptcp: add splice test:
>       - TODO: Matth: check with Geliang if he plans to update it →
> Done
> 
>   52   9 months ago  dcaratti     Add initial coverage for RM_ADDR
> 
> 
>     mptcp.dev PRs
> 
> /
> 
>     mptcpd PRs
> 
>   327  21 days ago  matttbe  man: plugin-dir: not world writable
>   326  1 hour ago   matttbe  flags: add 'laminar' endpoints support
>   323  27 days ago  matttbe  interface: add `deny_join_id0` parameter
> 
> 
> 
> 
> FYI: Current Roadmap:
>     - Bugs:
> https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
>     - Current/Coming merge window (6.19):
> https://github.com/orgs/multipath-tcp/projects/17
>     - For later: https://github.com/orgs/multipath-tcp/projects/1
> 
> 
> 
> Patches to send to NetDev:
> 
>     - Fixes for other trees:
> 
>         - [f35023f92ed5] selftests: bpf: fix recent compilation
> errors
> (Matthieu Baerts (NGI0))
>         - [a7cb48db2368] gcov: add support for GCC 15 (Peter
> Oberparleiter)
> 
>     - Fixes for -net:
> 
>         - [fa4c16e5903b] selftests: mptcp: connect: fix fallback note
> due to OoO (Matthieu Baerts (NGI0))
>         - [b00cc0dfd3ef] selftests: mptcp: join: rm: set backup flag
> (Matthieu Baerts (NGI0))
>         - [db4e86a2e6c2] selftests: mptcp: join: endpoints: longer
> transfer (Matthieu Baerts (NGI0))
>         - [732cf2c50ddb] selftests: mptcp: join: userspace: longer
> transfer (Matthieu Baerts (NGI0))
>         - [eb98322c2d06] selftests: mptcp: join: fastclose: drop
> plain
> RST (Matthieu Baerts (NGI0)):
>             - Will be dropped soon
> 
>         - [604f4ade5c21] selftests: mptcp: connect: trunc: read all
> recv
> data (Matthieu Baerts (NGI0))
>         - [3c6e894585f2] mptcp: fix address removal logic in
> mptcp_pm_nl_rm_addr (Gang Yan)
> 
>     - Fixes for net-next: /
> 
>     - Features for net-next:
> 
>         - [8aa057db1bba] mptcp: pm: init and release mptcp_pm_ops
> (Geliang Tang)
>         - [fd8a6842c53a] mptcp: pm: add get_local_id() interface
> (Geliang Tang)
>         - [07d670ca1d24] mptcp: pm: add get_priority() interface
> (Geliang Tang):
>             - blocked by pm->lock refactoring that is needed
> 
>         - [ffaa4e7399dc] mptcp: cleanup fallback data fin reception
> (Paolo Abeni)
>         - [8c97e58c6aea] mptcp: cleanup fallback dummy mapping
> generation (Paolo Abeni):
>             - there might be a fix for that
> 
>         - [6628958a45a2] mptcp: ensure the kernel PM does not take
> action too late (Paolo Abeni)
>         - [692254038cb1] mptcp: do not miss early first subflow close
> event notification (Paolo Abeni)
>         - [9f8782509d81] mptcp: make mptcp_destroy_common() static
> (Paolo Abeni)
>         - [440bbc559b86] mptcp: drop the __mptcp_data_ready() helper
> (Paolo Abeni)
>         - [6148a584cce9] mptcp: handle first subflow closing
> consistently (Paolo Abeni)
>         - [6d5d949d5258] mptcp: borrow forward memory from subflow
> (Paolo Abeni)
>         - [7984871487f7] mptcp: introduce mptcp-level backlog (Paolo
> Abeni)
>         - [8afd86c5dc49] mptcp: leverage the backlog for RX packet
> processing (Paolo Abeni):
>             - wait for the fix
> 
>         - [5d9a58722e9c] selftests: mptcp: lib: introduce
> 'nstat_{init,get}' (Matthieu Baerts (NGI0))
>         - [e5aad6ad52b4] selftests: mptcp: lib: remove stats files
> args
> (Matthieu Baerts (NGI0))
>         - [0cdbeae681cb] selftests: mptcp: lib: stats: remove nstat
> rate
> columns (Matthieu Baerts (NGI0))
>         - [e500e971e1bb] selftests: mptcp: join: dump stats from
> history
> (Matthieu Baerts (NGI0))
>         - [22e437406bc4] selftests: mptcp: lib: get counters from
> nstat
> history (Matthieu Baerts (NGI0)):
>             - should be sent after the ones for net + merge with net-
> next
> 
>     - Features for net-next (next): /
> 
>     - Features for other trees:
> 
>         - [be06d52e341d] bpf: Add mptcp_subflow bpf_iter (Geliang
> Tang)
>         - [599fef9658dd] selftests/bpf: More endpoints for
> endpoint_init
> (Geliang Tang)
>         - [4f16da3ca774] selftests/bpf: Drop cgroup_fd of
> run_mptcpify
> (Geliang Tang)
>         - [2eff5ee21d70] bpf: Add mptcp packet scheduler struct_ops
> (Geliang Tang)
>         - [0d54dd03ab0d] bpf: Export mptcp packet scheduler helpers
> (Geliang Tang)
>         - [2aca918a8b6e] selftests/bpf: Add bpf scheduler test
> (Geliang
> Tang)
>         - [c4d2d29ba444] selftests/bpf: Add bpf_first scheduler &
> test
> (Geliang Tang)
>         - [b65f96d93233] selftests/bpf: Add bpf_bkup scheduler & test
> (Geliang Tang)
>         - [84e47205025f] selftests/bpf: Add bpf_rr scheduler & test
> (Geliang Tang)
>         - [df0031f69a5c] selftests/bpf: Add bpf_red scheduler & test
> (Geliang Tang)
>         - [b81ba7f0c095] selftests/bpf: Add bpf_burst scheduler &
> test
> (Geliang Tang):
>             - waiting for a refactoring of the sched API
> 
> 
> 
> 
> Extra tests:
>     - news about Syzkaller? (Matth):
>         - Some issues there, but not reproduceable:
> https://syzkaller.appspot.com/upstream/s/mptcp
>             - maybe: a memory corruption elsewhere?
>             - not reproduced for one month
> 
>     - Packetdrill (Davide):
>         - /
> 
>     - Patchew (Davide):
>         - Was down this WE, but fixed by Davide
> 
>     - CI (Matth):
>         - https://ci-results.mptcp.dev/flakes.html
>         - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
>         - /
> 
> 
> 
> Next meeting:
>     - Next one on Wednesday, the 19th of November.
>     - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
>     - Still open to everyone!
>     - https://annuel2.framapad.org/p/mptcp_upstreaming_20251119
> 
> 
> 
> Feel free to comment on these topics and suggest new ones for the
> next
> meeting!
> 
> Talk to you soon,
> Matt

