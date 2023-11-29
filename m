Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21D1D521
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGuHzw6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA001C433C7;
	Wed, 29 Nov 2023 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701281264;
	bh=O9KR9Nyoj4Pi9IbPiTkjOtIchVk98Y5G3hKKsQkfaGY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sGuHzw6YF3+OVLf5VoZdTQpD9/WgDoMF+ujuCn8pzxJimG3n1ct8tOLeZDzJZPeYX
	 eKfCB/GsuaD4+p5vjzSx3mk/o5IWJB6ZT37KVpsMlahjY58KXmzAJv89gOsloxPtKU
	 AhZHBDhMj1Lhp6eubi9OH5sxGu1yQ+CPGbMuuy8mb0uDjqGFcvAiDMO5oaKjXEFGwb
	 T/AWPzdy+jI1qKWZGSS1/0qUpGJQvHzlL/gdtK2cOcjYkYrFxgP+o6whxDXgdEbedG
	 yl5Znn5w2ipg3/GmXGlaauhEofFwxNT5zaxlD+SAIiT6vneXhH24+2TGvdwzhtqkgm
	 105OphBp8tgNQ==
Date: Wed, 29 Nov 2023 10:07:44 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Maxim Galaganov <max@internet.ru>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 2/3] mptcp: sockopt: support IP_LOCAL_PORT_RANGE
 and IP_BIND_ADDRESS_NO_PORT
In-Reply-To: <20231129113403.157953-3-max@internet.ru>
Message-ID: <7d400717-0bfd-5dcc-3ea7-fc12db4c4759@kernel.org>
References: <20231129113403.157953-1-max@internet.ru> <20231129113403.157953-3-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Nov 2023, Maxim Galaganov wrote:

> Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in [1].
> Recently [2] allowed its value to be accessed without locking the
> socket.
>
> Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in [3].
> In the same series a selftest was added in [4]. This selftest also
> covers the IP_BIND_ADDRESS_NO_PORT sockopt.
>
> This patch enables getsockopt()/setsockopt() on MPTCP sockets for these
> socket options, syncing set values to subflows in sync_socket_options().
> Ephemeral port range is synced to subflows, enabling NAT usecase
> described in [3].
>
> [1] commit 90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcome
> bind(0) limitations")
> [2] commit ca571e2eb7eb ("inet: move inet->bind_address_no_port to
> inet->inet_flags")
> [3] commit 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option")
> [4] commit ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE
> socket option")
>
> Signed-off-by: Maxim Galaganov <max@internet.ru>

Thanks for the v2 Maxim, looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/sockopt.c | 29 ++++++++++++++++++++++++++++-
> 1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index a4bf337e6f77..a164a3e21be4 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -440,6 +440,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
> 		/* should work fine */
> 		case IP_FREEBIND:
> 		case IP_TRANSPARENT:
> +		case IP_BIND_ADDRESS_NO_PORT:
> +		case IP_LOCAL_PORT_RANGE:
>
> 		/* the following are control cmsg related */
> 		case IP_PKTINFO:
> @@ -455,7 +457,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
> 		/* common stuff that need some love */
> 		case IP_TOS:
> 		case IP_TTL:
> -		case IP_BIND_ADDRESS_NO_PORT:
> 		case IP_MTU_DISCOVER:
> 		case IP_RECVERR:
>
> @@ -688,6 +689,7 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
> {
> 	struct sock *sk = (struct sock *)msk;
> 	struct sock *ssk;
> +	bool slow;
> 	int err;
>
> 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> @@ -710,6 +712,16 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
> 		inet_assign_bit(TRANSPARENT, ssk,
> 				inet_test_bit(TRANSPARENT, sk));
> 		break;
> +	case IP_BIND_ADDRESS_NO_PORT:
> +		inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
> +				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> +		break;
> +	case IP_LOCAL_PORT_RANGE:
> +		slow = lock_sock_fast(ssk);
> +		inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
> +		inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
> +		unlock_sock_fast(ssk, slow);
> +		break;
> 	default:
> 		release_sock(sk);
> 		WARN_ON_ONCE(1);
> @@ -755,6 +767,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> 	switch (optname) {
> 	case IP_FREEBIND:
> 	case IP_TRANSPARENT:
> +	case IP_BIND_ADDRESS_NO_PORT:
> +	case IP_LOCAL_PORT_RANGE:
> 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
> 	case IP_TOS:
> 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
> @@ -1346,10 +1360,20 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
> 			       char __user *optval, int __user *optlen)
> {
> 	struct sock *sk = (void *)msk;
> +	bool slow;
> +	int val;
>
> 	switch (optname) {
> 	case IP_TOS:
> 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
> +	case IP_BIND_ADDRESS_NO_PORT:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> +	case IP_LOCAL_PORT_RANGE:
> +		slow = lock_sock_fast(sk);
> +		val = inet_sk(sk)->local_port_range.hi << 16 | inet_sk(sk)->local_port_range.lo;
> +		unlock_sock_fast(sk, slow);
> +		return mptcp_put_int_option(msk, optval, optlen, val);
> 	}
>
> 	return -EOPNOTSUPP;
> @@ -1450,6 +1474,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>
> 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
> 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
> +	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> +	inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
> +	inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
> }
>
> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
> -- 
> 2.43.0
>
>
>
