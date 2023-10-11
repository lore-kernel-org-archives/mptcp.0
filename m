Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73D39A
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm7LjkJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F522C433C7;
	Wed, 11 Oct 2023 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696986003;
	bh=T+b/IOMoU64cR6hgB+noM0h9K3w4K7Y8hXvtzmdbkc0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tm7LjkJiETBMcSUYGNHc17H9bLMyJwehyUWbHszn2jP29o4Cn9awsM1nZjhf4evjz
	 qgfpdWC9NcU/YS0RWyr/ftMmZDMmjDA+rTRr/NdnHlEXXzc2HUdatxEoAM9EzgZBnX
	 YxWscI1Z9ZZ6Sf6uslXhjKBpMbLTJzBaRB/5iCtAzAASH0aPQ7KX/zH6eFs1zaWHFs
	 ed741qlzxNqM9yhFk1H+Bmxy3e0h55WTXXQHgTJJT/gX62JN+j8qKtMW1SX1UOpwWN
	 2yqsHD81o9GljOtVpQrxRvawnz8ESDIR92VR8sEx6A5fc3rtR/KpRCivZRF3CXN+3u
	 /BBKudF34wreg==
Date: Tue, 10 Oct 2023 18:00:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] tcp: check mptcp-level constraints for backlog
 calescing
In-Reply-To: <b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com>
Message-ID: <e830af72-4c3a-fa52-4eb0-b35e48bf9d1c@kernel.org>
References: <b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 4 Oct 2023, Paolo Abeni wrote:

> The MPTCP protocol can acquire the subflow-level socket lock, and
> cause the tcp backlog usage. When inserting new skb into the
> backlog, the stack will try to coalesce them.
>
> Currently we have no check in place to ensure that such coalescing
> will respect the MPTCP-level DSS, and that may cause data stream
> corruption as reported by Christoph.
>
> Address the issue adding the relevant admission check for coalescing
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
> net/ipv4/tcp_ipv4.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f13eb7e23d03..52b6a0b22086 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1869,6 +1869,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
> #ifdef CONFIG_TLS_DEVICE
> 	    tail->decrypted != skb->decrypted ||
> #endif
> +	    mptcp_skb_can_collapse(tail, skb) ||

Hi Paolo -

Shouldn't this be !mptcp_skb_can_collapse()?

Also, the subject line needs the 'o' in "coalescing".

- Mat

> 	    thtail->doff != th->doff ||
> 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
> 		goto no_coalesce;
> -- 
> 2.41.0
>
>
>
