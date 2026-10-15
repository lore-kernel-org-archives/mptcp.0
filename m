Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429B563FD4
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085459; cv=none; b=s7ktxgmGluRD9aIACgPgKeEmXHmW1IqrKfamYUMwkRtmhFoSrkoYIXPbP+4eU+FkEKG057Hfdz72Jlf9y1cOVW4u/WtGYKtDsGjwkRsj2HbxsW6j6+46j8Fn0l5oP3TxPGu3hgh1xC1jlHcL3PX0ZoKMd5qAj+0DinC96j9l/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085459; c=relaxed/simple;
	bh=KFQy8rTMKU4SPPbAgnHv1oPEqjd55Y7agzoGFyD+Dow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwazLaoNvsMPvnnSTjG7ZHvG4vANbbEP1XHtXOEyELeBH/WTIC8NAaBlGB9i54T02HTIgABi4eIOz1rEVav5Vvw7nrT552qDGGkzhHxxbFnYOeoK6Bn+Kc3UD8pzhWwIzH/axuvv+Nm7Nssu5zaCI+8KLrj0HNuIxpnSKC3t7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFD3pJI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFD3pJI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E2B1F000C4;
	Thu, 15 Oct 2026 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085448;
	bh=GJc5O/f7wVVhOtkHFcytrXxhn6xSZzuPFwM+gLzImy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mFD3pJI6O4AChu0UIVo8BIA1Mtegta+lCejsKOKwnWuE085sKovZ1cVOG+RdrPmZO
	 TIz5cEUdxSFz6S8M0CjNQAX9ON6pwTMSv2ncOF2sN3GD8Zii7811Q6JGKUUUFWfBMN
	 unfDvufibWaedXARF2zC0E5GsHa19ojlxMOStXuTXBrJYOue9n62Vkk01btckbGcjf
	 efrh+KK2ff03nv7orDoO6G2tCz4TDW/bXkcQLVOV4IlCIBw+av9hSRo2G1rRPmRqnt
	 knUXLWmPOT3sm7GPpYF9GrZ56yVJ7JKZb0a708C1ph7Ajf6e32GIVAkeXtM4GTPGhQ
	 qY6Y0rDx3Ll6A==
Message-ID: <e30d15a5-10b2-4efe-8fc7-6b77d18ac154@kernel.org>
Date: Thu, 15 Oct 2026 19:30:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: give MPTCP sockets a distinct
 lockdep class
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1792060837.git.tanggeliang@kylinos.cn>
 <23c5f34fa80bff87b4c49981b1ab19d13bf7f136.1792060837.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <23c5f34fa80bff87b4c49981b1ab19d13bf7f136.1792060837.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the patches!

On 15/10/2026 12:42, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> MPTCP sockets and their subflows share the same k-sk_lock-AF_INET
> lockdep class. When both are kernel sockets, lockdep flags every path
> that holds the MPTCP socket lock and then locks a subflow (setsockopt,
> connect, bind, worker send-ack) as "possible recursive locking".
> 
> Reclassify the MPTCP socket lock in mptcp_init_sock() to use a distinct
> lock class (sk_lock-AF_INET-MPTCP for IPv4, sk_lock-AF_INET6-MPTCP for
> IPv6). This approach is similar to nvme-tcp and avoids the need to
> reclassify each subflow socket individually.
> 
> The implementation is based on nvme_tcp_reclassify_socket() from
> drivers/nvme/host/tcp.c.

Note: we also do that in pm_kernel.c for the extra listening socket.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be632..e63896a60595 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -56,6 +56,41 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions) = {
>  };
>  static struct net_device *mptcp_napi_dev;
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC

In pm_kernel.c we don't have that. Do we really need it? If all the
functions are nops, maybe not?

> +/* distinct lockdep class for MPTCP sockets */
> +static struct lock_class_key mptcp_sk_key[2];
> +static struct lock_class_key mptcp_slock_key[2];
> +
> +static void mptcp_reclassify_socket(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +		return;
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		sock_lock_init_class_and_name(sk, "slock-AF_INET-MPTCP",
> +					      &mptcp_slock_key[0],
> +					      "sk_lock-AF_INET-MPTCP",
> +					      &mptcp_sk_key[0]);
> +		break;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	case AF_INET6:
> +		sock_lock_init_class_and_name(sk, "slock-AF_INET6-MPTCP",
> +					      &mptcp_slock_key[1],
> +					      "sk_lock-AF_INET6-MPTCP",
> +					      &mptcp_sk_key[1]);

In pm_kernel.c we only call sock_lock_init_class_and_name() once. Maybe
we should do the same here, then no need to have a special helper?

> +		break;
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +}
> +#else
> +static void mptcp_reclassify_socket(struct socket *sock) { }
> +#endif
> +
>  /* Returns end sequence number of the receiver's advertised window */
>  u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  {
> @@ -3292,6 +3327,8 @@ static int mptcp_init_sock(struct sock *sk)
>  	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
>  	sk->sk_write_space = sk_stream_write_space;
>  
> +	mptcp_reclassify_socket(sk->sk_socket);

Indeed, better in __mptcp_init_sock().

> +
>  	return 0;
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

