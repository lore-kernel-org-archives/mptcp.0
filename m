Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA13486E74
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333360; cv=none; b=kSO/NW7Ujfv5uuz4xfJxcki3y9SgJ8/vz90ffQXSpF5TwTbeASAfMf12tdvI3RqVy5gSOOs0lGuf0qyAD6AeILVqfix3jv9dY5YFTIR6S59MeF0HlKmjJSEdjNt/QhmDsFxTCPHvNrdLd4SyWS0lU2/1WQMFNaaXXpwcw5jCQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333360; c=relaxed/simple;
	bh=cN5SoUAZB3Fj1wrqmQAkhuCqywfgc4m2ome2gBndw48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+XS1Ln6GpJeLLSXvJg+y64Gpcn7/PtQ3CG1qB4EbO4+DUNXF6NU38TEE+juXWkxYvghV8SQCDGR4SbYiW6WWaOGHmcdIZMJI7xBHxYV14VkfAxByLsmvYRBKkXMY0BxGfvRxU3z1qpZBHTsxkTjhEmcFNBjvtVrAJFeHtUcVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gq8r76Ma; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gq8r76Ma"
Message-ID: <3b55d602-f9ce-464a-896c-8d89af572f6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785333353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zj9LprAygHcCxjzHNSuG+4nSi2mr2UIXdQuc+A27Ppg=;
	b=gq8r76Marm0WyfdS4dWamBsbRREUnRDpfZFEfQxcLy50iWRoex4GlaZ4on+3PTNRleOnkR
	D4v2dMuFjFlUzPJDYKQlcmPRkwLCN/B0dTcPdf08IRxAgjWIK/eUUe8DW/OhDUcRjEjnsw
	Wk4VDABkAU0kcC7PlpXdsJbJLymbNtY=
Date: Wed, 29 Jul 2026 21:55:32 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Zihan Xi <zihanx@nebusec.ai>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, kees@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, fw@strlen.de, vega@nebusec.ai
References: <cover.1785307984.git.zihanx@nebusec.ai>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <cover.1785307984.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/29/26 7:28 PM, Zihan Xi wrote:
> Hi Linux kernel maintainers,
>
> We found and validated a issue in net/ipv4/tcp_diag.c and
> net/mptcp/mptcp_diag.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
>
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
>
> ---- details below ----
>
> Bug details:
>
> inet_diag TCP dumps currently execute attacker-controlled
> INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> heavily populated and the bytecode is a large reject-all filter, the
> dump path can spend an unbounded amount of time under the same bucket
> lock while walking attacker-arranged sockets.
>
> The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> one colliding listener bucket and then issues a NETLINK_SOCK_DIAG dump
> request with 16380 INET_DIAG_BC_NOP instructions followed by a failing
> INET_DIAG_BC_D_EQ test. Because every socket runs the full bytecode and
> none reaches the reply fill path, skb backpressure does not terminate the
> walk early. On the unfixed kernel this triggers a watchdog soft lockup
> and then a panic in inet_diag_bc_sk().
>
> The earlier batching fix direction was still too narrow: it only counted
> sockets that survived the cheap prefilters and reached the expensive dump
> path. An attacker can therefore populate one bucket with many sockets or
> listeners that fail the netns/family/port or MPTCP-specific prefilters,
> causing the same bucket lock to be scanned far past the 16-entry batch
> threshold before control is returned.
>
> The same root cause also exists in MPTCP listener dumping. The
> MPTCP-specific mptcp_diag_dump_listeners() path reuses sk_diag_dump(),
> which runs inet_diag_bc_sk() before filling the netlink reply, while the
> listener bucket lock is still held.
>
> We additionally profiled the MPTCP-specific path locally with a
> separate debugging artifact. Because struct inet_diag_req_v2 stores
> sdiag_protocol in an __u8 field, that request must keep
> sdiag_protocol = IPPROTO_TCP and pass INET_DIAG_REQ_PROTOCOL =
> u32(IPPROTO_MPTCP), otherwise 262 truncates back to TCP and never reaches
> the MPTCP handler. With that corrected request, a 1-group run with 32768
> listeners and 16380 NOP bytecode steps took 2082.608 ms on the fixed
> kernel versus 8.601 ms on the unfixed kernel, and kprobe profiling showed
> inet_diag_bc_sk() executing 32768 times on the fixed kernel but only 256
> times on the unfixed one. That 256-count is not a missed path: the
> unfixed mptcp_diag_dump_listeners() reuses one counter both as the
> in-bucket index and as the resume cursor, so each dump restart advances
> in a triangular skip pattern and stops after approximately sqrt(2N)
> bytecode executions. The inline reproducer and decoded crash log below
> cover the TCP panic path; the MPTCP results above are included only as
> supporting local validation for the second patch.
>
> This series fixes both sites by keeping bucket-locked sections limited to
> raw socket collection and lifetime pinning, and moving all filtering,
> inet_diag_bc_sk(), and socket filling work out of the locked regions so
> the batch limit applies to raw bucket traversal itself. For TCP listener,
> bind, and ehash buckets, and for the MPTCP listener bucket, restarts now
> keep a referenced dump cursor so the next batch resumes after the
> previous socket instead of rescanning the bucket head under the same
> lock.
>
> For the TCP patch, the underlying root cause predates modern git history.
> The Fixes tag therefore uses commit 1da177e4c3f4
> ("Linux-2.6.12-rc2") as the earliest git-import boundary that still
> anchors the pre-git bug in the current repository, rather than
> incorrectly attributing it to a later helper or refactor commit. The
> MPTCP patch uses the real introduction boundary, commit 4fa39b701ce9
> ("mptcp: listen diag dump support").
>
> Reproducer:
>
>      gcc -O2 -static -o poc poc.c
>      unshare -Urn ./poc
>
> For the reproduced panic log below, we enabled
> softlockup panic sysctls and ran the local helper that executes:
>
>      ./poc --listen --groups 4 --stride 2048 --count 32768 --nops 16380
>
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
>
> ------BEGIN poc.c------
> #define _GNU_SOURCE
>
> #
[...]
> static size_t build_request(void *buf, bool listen_mode, bool with_attack,
> 			    unsigned int nops)
> {
> 	size_t msg_len = NLMSG_SPACE(sizeof(struct inet_diag_req_v2));
> 	struct nlmsghdr *nlh = buf;
> 	struct inet_diag_req_v2 *req;
>
> 	memset(buf, 0, msg_len);
> 	nlh->nlmsg_len = msg_len;
> 	nlh->nlmsg_type = SOCK_DIAG_BY_FAMILY;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
> 	nlh->nlmsg_seq = 1;
>
> 	req = NLMSG_DATA(nlh);
> 	req->sdiag_family = AF_INET;
> 	req->sdiag_protocol = IPPROTO_TCP;
> 	req->idiag_states = listen_mode ? TCPF_LISTEN : (1U << 12);

1U << 12

12 is TCP_NEW_SYN_RECV. Is TCP_BOUND_INACTIVE what you expected ?


> 	req->id.idiag_cookie[0] = INET_DIAG_NOCOOKIE;
> 	req->id.idiag_cookie[1] = INET_DIAG_NOCOOKIE;
