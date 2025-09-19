Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846B1CFBA
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275440; cv=none; b=Iyyotrt3N/57jjxBolIV8IndLqypH2FN51ymE8UauRVvtF5FKDblGxXskKcarRehxXS82s4iqF3Hpn7emnanN64e/t0tDYwIs+O21lnPbSBYe8Ae8/0Uk4A/ylIBJ2sTKcgexdhRIvnlNebpsb3RN75LKGADBDwkJcj5a1UQ57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275440; c=relaxed/simple;
	bh=/C4VOsN+9q2Purc80u6ziF43ZP2yWGrSnNIIpm4eJhk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzdxa43xxgBsuffMHaCX17is3O/wYX9BwHlUN4dVRYM35NiJOOIYQzaKHZAFGEUxU44vVQoq/3cNQIM5s+75NDmINGMQD/sbWq2oxJiTTeQ0aHT23E8ZP0iMhOohWyflua3XTPtuxWW25qjsN6+eNyAegB1oHTJt4KoA0Khuceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc3zfugk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc3zfugk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DBAC4CEF0;
	Fri, 19 Sep 2025 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275440;
	bh=/C4VOsN+9q2Purc80u6ziF43ZP2yWGrSnNIIpm4eJhk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Cc3zfugkhbJo89HWXQZfKa18d2VmigR1g14J4doQ0tFH0muxZP1iDtcOSlOuDf3jX
	 SXgENzq1oG2AGybsWJipNOgAhTeeQHN5wnGIVxoFqNEZ/TJoE1sPmEAq4nzUdUlGtt
	 71c8/BmzGYKD9CwPiPDwjUh0FyQUgps6PrGIpXCrBdtZeZJ1KU/jE6rZGOFvIGED5p
	 q9CwhX6wnWZPrGB3ecfgBfc37ylraYIjL6KpHlj0ZymeveVn/1j5Jtim2OLPHBNT35
	 yueqmlLvfUDQ3ULOva4hDxrqEhzhTPycUkRMCfYZDS9cOrvBYmtkgjQbcIzQdP8PYe
	 6CvZMi9tWyF/w==
Message-ID: <3517fd7b54f5425970f9aea39c4762b723bfca63.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 05/12] mptcp: remove unneeded
 mptcp_move_skb()
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 19 Sep 2025 17:50:36 +0800
In-Reply-To: <ef7887b4b1762d95f5fa64659083153d476ba467.1758214564.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <ef7887b4b1762d95f5fa64659083153d476ba467.1758214564.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-09-18 at 19:14 +0200, Paolo Abeni wrote:
> Since commit b7535cfed223 ("mptcp: drop legacy code around RX EOF"),
> sk_shutdown can't change during the main recvmsg loop, we can drop
> the related race breaker.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  net/mptcp/protocol.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 048056b29a92d..19b5b925e2acc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2202,14 +2202,8 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  				break;
>  			}
>  
> -			if (sk->sk_shutdown & RCV_SHUTDOWN) {
> -				/* race breaker: the shutdown could
> be after the
> -				 * previous receive queue check
> -				 */
> -				if (__mptcp_move_skbs(sk))
> -					continue;
> +			if (sk->sk_shutdown & RCV_SHUTDOWN)
>  				break;
> -			}
>  
>  			if (sk->sk_state == TCP_CLOSE) {
>  				copied = -ENOTCONN;
