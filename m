Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCE3033C6;
	Mon,  8 Jun 2026 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889078; cv=none; b=T9B6GXYboLMZpOeHH2EbmRvLY9qAp1COxtOPO9wbEviCvID2rNUjU3shSE3h8wjc/fMn2TPnlPqo6jHiph8yBGpZ7hSb3YbxUTcyuCZJrty7diF58P4Y1RA18KdOA12Dt5lyjQgXUFbaBmGoFPYCPmnwtMRm+yI3jsiFd+qNrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889078; c=relaxed/simple;
	bh=gI62n54pfpLXfuVQTyYee6WZ2UR44KWCzr9opDEbP38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oA5eXVgPLS8WOU9naW3R0UlhwcOXLvf8p3pHmbYNcY1pyXhOof1513iI+wPxnmlqZUzoLWlweE+bZt27rk6r/OMRYOME5aPKinlXZww9WuTiouFeOaAm31BIq7g8pUHEBX4cMoB94w6yZCsSnq6dL0n4rBlY1uFntc59EkFvhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnqAc6dJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnqAc6dJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD3C1F00893;
	Mon,  8 Jun 2026 03:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780889076;
	bh=fTtibsZWf7w3UHmNdC4pBjPhNepkVbmN4NQuE+w+vuA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TnqAc6dJQyGyi4Sb/XUfq0emLSZPQbnRQ4Z0ZmfpBrKS2ofSTqHcr9nTUB4rSXT4g
	 QUkXJ0ylKAnmZEb/tG9s9GSTakyE6J2a62H54Zh/2m/dmaWNZa6KM6mYJoY43ErWBA
	 oeR6Tn6NpOtSjLZj36VNm/3x+CjmwmeTNxu18jbohCWXuLSCi4c83xLcfy/inhURAR
	 zB2+e0nNgwBMN5LuCChOKLHkZ9T3vja6Z4igcjdvTnUxtCbtyF/2Kxq408Ay61U8ze
	 mF2erkRkDF2fpLs3iyOLyXYB80ejVPIM9bHTWdU/qrqU/kOi5vZKZUk7UXrd1nTpU/
	 F3kjzMEYr7rgg==
Message-ID: <53cbd2999ea0e54a975812265684f1183bc3df70.camel@kernel.org>
Subject: Re: [PATCH net] tls: restore sk_prot before calling original
 destructor
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Atul Gupta
 <atul.gupta@chelsio.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Date: Mon, 08 Jun 2026 11:24:31 +0800
In-Reply-To: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
References: 
	<158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2026-06-05 at 20:57 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When a TLS socket is offloaded to a TOE device, tls_toe_bypass()
> replaces
> sk->sk_prot with a TLS-specific protocol table. On socket
> destruction,
> tls_toe_sk_destruct() calls the original sk_destruct callback
> (ctx->sk_destruct), which may rely on the original sk_prot (e.g., for
> memory accounting or close handling). Without restoring sk->sk_prot
> before calling ctx->sk_destruct, the destructor may access stale or
> incorrect protocol functions, leading to use-after-free or kernel
> panic.
> 
> Add WRITE_ONCE(sk->sk_prot, ctx->sk_proto) before invoking
> ctx->sk_destruct to restore the original protocol pointer. This
> mirrors
> the restoration already done in tls_sk_proto_close() for the software
> and device offload paths.
> 
> Fixes: 76f7164d02d4 ("net/tls: free ctx in sock destruct")

Sorry, this "Fixes" tag is not accurate. sk_proto was only added to
struct tls_context in commit 32857cf57f92, so it would be better to
update the "Fixes" tag as follows:

Fixes: 32857cf57f92 ("net/tls: fix transition through disconnect with
close")

If needed, I can send a v2.

Thanks,
-Geliang

> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> Hi,
> 
> This bug was identified by Sashiko during my development of "MPTCP
> KTLS
> support" [1]. I am sending this fix separately for now.
> 
> Thanks,
> -Geliang
> 
> [1]
> https://patchwork.kernel.org/project/mptcp/cover/cover.1780621326.git.tanggeliang@kylinos.cn/
> ---
>  net/tls/tls_toe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
> index 825669e1ab47..c9c1a0952f4b 100644
> --- a/net/tls/tls_toe.c
> +++ b/net/tls/tls_toe.c
> @@ -48,6 +48,8 @@ static void tls_toe_sk_destruct(struct sock *sk)
>  	struct inet_connection_sock *icsk = inet_csk(sk);
>  	struct tls_context *ctx = tls_get_ctx(sk);
>  
> +	WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
> +
>  	ctx->sk_destruct(sk);
>  	/* Free ctx */
>  	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);

