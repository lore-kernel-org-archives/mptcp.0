Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBE39927
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6tSjQTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D73C433C8;
	Wed, 11 Oct 2023 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697045155;
	bh=6eiqO5/CvuR9xvzU3ZZ2Vkj7cVvWsa05bWPP2f+klDM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=U6tSjQTSEEhh2GDTySyzQpB5DD2Khj+X2IT4qx2vv8zPyUtY6JKQ+RGh/FBJDkpnD
	 mRa3UIKx1Hd8fmzzvEEIq4RM+JprgK1wgxFLkMv+60jeU9o3fHCMf19CwR+bMR1kEJ
	 yb5eBWMdcWIVdnYkklJP+KsnUsJ/EbieenAk7rrTdQFsTJYwf86p+GT65kKOGgfpej
	 Mq+hQK3s58pso7w4SzgelpwGM8hQ28CE9wyxBsJFmEW75aFjWsrbM0kmMm9GN3oUUK
	 AY8Hq/3QyA9cxCQ6l1S9EnHXQPM1v4BC4liCoLZj+EAXI1c4gA6cjR77YF3mdTikJz
	 dnNJYqzMkoG7A==
Date: Wed, 11 Oct 2023 10:25:52 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] tcp: check mptcp-level constraints for
 backlog coalescing
In-Reply-To: <f1e771e52c4dce3db4884ac0e629d363d1676b75.1697037788.git.pabeni@redhat.com>
Message-ID: <5bb14ee4-7363-fefd-7db0-6f8633c2114a@kernel.org>
References: <f1e771e52c4dce3db4884ac0e629d363d1676b75.1697037788.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 11 Oct 2023, Paolo Abeni wrote:

> The MPTCP protocol can acquire the subflow-level socket lock and
> cause the tcp backlog usage. When inserting new skbs into the
> backlog, the stack will try to coalesce them.
>
> Currently, we have no check in place to ensure that such coalescing
> will respect the MPTCP-level DSS, and that may cause data stream
> corruption, as reported by Christoph.
>
> Address the issue by adding the relevant admission check for coalescing
> in tcp_add_backlog().
>
> Note the issue is not easy to reproduce, as the MPTCP protocol tries
> hard to avoid acquiring the subflow-level socket lock.
>
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - !coalesce (mat)
>  - typo in commit message (mat)

Thanks Paolo, v2 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/ipv4/tcp_ipv4.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a441740616d7..4d66a8ab3b98 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1870,6 +1870,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
> #ifdef CONFIG_TLS_DEVICE
> 	    tail->decrypted != skb->decrypted ||
> #endif
> +	    !mptcp_skb_can_collapse(tail, skb) ||
> 	    thtail->doff != th->doff ||
> 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
> 		goto no_coalesce;
> -- 
> 2.41.0
>
>
>
