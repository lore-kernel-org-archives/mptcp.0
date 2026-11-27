Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742239;
	b=Rxv59x2h2eT1C46plKK0bRhAdn1fKoxGtuZwuUCwOTe+l67RTB7jt5ZQqB5QkekGLy0f
	 YKBpSfvizt/68pK6gtZhaqSoP9bHe30eBSrAJrcvzze6ZmqtqgminuXKf65tli3/gziDC
	 cdlFVFCQpiVfPtEzMqM73oxWxba5tWasAKxc7KgZLBwwvRGA3sc7CHLroBEo+A7qrRMFq
	 LfOF34TuSn7daE4Z36mzK7zjCuZnqBkvc0M2Rqg3NUv1D4lB2uATt12KATDG5pYBd6kRt
	 wznblZHSL3AU7wiHgclJ5HAilxEKwPR7AqR6BfyK4B4kOaBTBLMJLToEFv31QqjNvJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742239;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Gvu+yrkeXGohUB07/+hs1cKtWrmuGESC+qjRU5ss48=;
	b=wluB0rilitVXE1agsU/CuRkfnK7m7C/j9GG15tCGQHVDS5hcUMl2KskQnMuLCejMAcp3
	 cZ9RlQnNLTt8IhBUMBg3D+XMxN2PVUivuhNvGdsnp4G8/g/id/p5/po2GoZ+suEiVObAh
	 gxfZz+QtXPZf2lxya3MgtntMTwpRAuI2Voz2Y3J6VBCHlVivS3boSck19TJWMb7HwExrR
	 efv8Gwc4wC7Nh0Q4MFpCOJdPpnolSs5H4JqLOmJJ6VxE4+5xA+QOt9TFx5n15t4Paf4ns
	 0mN8dTzi525wpA7EnQLvPo/WUctImee1/L7Emr9ZxYyYCxBHGz3W3kNLUS4Q/duMKBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGbWfAvZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B607606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGbWfAvZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A3A1F0089A;
	Fri, 27 Nov 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795742238;
	bh=1Gvu+yrkeXGohUB07/+hs1cKtWrmuGESC+qjRU5ss48=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WGbWfAvZKXjS9iiUQTNhyDaWKu9hViUqW2v22OD7Yz/0JReEWjoCntf99+/X98ogh
	 SL3RmzQSTVchEcpZv/g/dlq1/bHBVcgG2w/P/pxOvdH7OtFUFrI958i9oZg6Ml25vd
	 ySETcCC60wnIWKpob/aCWGnLggshtHArMv679qrSDiDPwK8u9kYaTJ4KSe/fHoHleK
	 CRd8XNVqSJvnKzhAq9Paei7A5EiSXAW6m+XPJaerqR/d/jz+pfKEJcmJX9A1am1Cg6
	 hLDzA3VM9ohPEeD68V5D9Zp8suaXDS+r8VwAm3Ie3rZ4CS2fjPgPS3WFQ8xJanzfB8
	 o3HWublidnJyQ==
Message-ID: <d0bc374160ef47466604564e2ab179a84d7fba79.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 21/50] mptcp: drop non-MP_JOIN cookie ACKs
 on PM listeners
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>
Date: Fri, 27 Nov 2026 09:17:14 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-21-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-21-416c0920c73f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> With SYN cookies enabled, a port-based MPTCP signal endpoint can stop
> accepting new subflows until it is deleted.
> 
> Nobody calls accept() on the listener that the in-kernel path manager
> opens for such an endpoint, so it must create only MP_JOIN subflows,
> which never enter the accept queue. The listener is marked pm_listener,
> and since commit 3d041393ea8c ("mptcp: prevent MPC handshake on
> port-based signal endpoints") subflow_check_req() refuses a SYN with no
> MP_JOIN option on it. But a SYN cookie does not record the MPTCP option
> of the SYN, so mptcp_subflow_init_cookie_req() picks the kind of child
> from the options of the ACK, without looking at pm_listener:
> 
>     ACK with a valid cookie and no MP_JOIN option
>       creates a plain TCP child, or an MPTCP one if it has MP_CAPABLE
>         which stays on the accept queue until the endpoint is deleted
>           once the queue is full, the listener drops MP_JOIN SYNs too
> 
> These children also hold a reference on the netns: since commit "mptcp:
> pm: don't let listeners pin their netns", they are what keeps it alive
> for ever once its last process is gone, unless somebody deletes the
> endpoint, as noted by Clashiko on that commit.
> 
> The fix used here is to refuse an ACK with no MP_JOIN option on such a
> listener in mptcp_subflow_init_cookie_req(), so that the request sock is
> freed and the ACK is dropped.
> 
> This issue has been found with the help of an LLM, and reproduced in a
> VM, with the reproducer shared with the original version of this patch:
> a client sent 1025 ACKs with valid SYN cookies and no MP_JOIN to the
> listener of such an endpoint. Without this patch, its accept queue
> stayed full, and another client could not create its additional subflow,
> even 130 seconds later:
> 
>   TCP: request_sock_subflow_v4: Possible SYN flooding on port 10.9.0.2:6666. Sending cookies.
>   [...]
>   C2         4.007  [130 s after C1 has gone] RESULT: subflows established 1, in SYN_SENT 1, the service works
>   --- V, after that try of C2
>       listener 10.9.0.2:6666 Recv-Q 1025 Send-Q 1024
> 
> With the same reproducer, adapted to delete the namespace of the
> listener after a few of these ACKs, this namespace was not freed:
> 
>   srv: listener of the endpoint: Recv-Q 4
>   srv: deleted, then NOT taken down after 60 s
> 
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ Shorter comment, the details are in the commit message. Commit
>   message: how the issue was found, its symptoms, and the netns pinned
>   by the queued children. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v3: commit msg: the netns pinned by the queued children (Clashiko)
> ---
>  net/mptcp/subflow.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 67a749643ad7..91698d154c40 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -315,6 +315,11 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  
>  	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
>  	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
> +
> +	/* PM listeners only take MP_JOIN, like in subflow_check_req() */
> +	if (unlikely(listener->pm_listener) && !opt_mp_join)
> +		return subflow_reset_req_endp(req, skb);
> +
>  	if (opt_mp_capable && listener->request_mptcp) {
>  		if (mp_opt.sndr_key == 0)
>  			return -EINVAL;
