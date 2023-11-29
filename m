Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BDEDD
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZxhLrtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B03FC433C7;
	Wed, 29 Nov 2023 01:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701220545;
	bh=Oer/sHPXbNQmhA9nNzO8QCgogdsTpXFewpvEvhcN7EQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iZxhLrtmdHiFzobmmAxIkQS8a9D8+XfUVLKjKAtVyhQRxBLa7jgpGIR3qpyeGdD/u
	 zdil3QMJvQF7ACjgWTe5JDKz6tsxn8bI8pejRt6mSSd1+QC9jlJbthhIWJU6/YRVDX
	 fimSO8Xheox2OeZD0l3q9L0CnglCAkumuIgzyw2waAP6MVbpHT3ZOzNOLG2Vr0se49
	 wnA52sX4e6qcHuan5ZYw2cGFRP/aEK6WmPIMcQDj+IfhTkNdDDNQhLXFOAjYjdsFYm
	 FoAMeuzJbJ++dgcJ8H/m2iduHSM9pF+m2l3u8ejxoMl6/TmxMqtNd/Y4+gwm6wl11m
	 YqvkmaIaBwAYg==
Date: Tue, 28 Nov 2023 17:15:44 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Maxim Galaganov <max@internet.ru>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] mptcp: sockopt: support IP_LOCAL_PORT_RANGE
 and IP_BIND_ADDRESS_NO_PORT
In-Reply-To: <20231122155919.11393-2-max@internet.ru>
Message-ID: <727f8306-eb3b-2f00-a915-ef51641bdce6@kernel.org>
References: <20231122155919.11393-1-max@internet.ru> <20231122155919.11393-2-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 22 Nov 2023, Maxim Galaganov wrote:

> Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in

Hi Maxim -

Thanks for the patches!

> 90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcome bind(0)
> limitations"). Recently ca571e2eb7eb ("inet: move
> inet->bind_address_no_port to inet->inet_flags") allowed its value to be
> accessed without locking the socket.

checkpatch.pl is failing in the CI since it expects the word "commit" 
before each abbreviated hash. Please add that in each of the cases where 
there's a <sha> ("title") pattern.

>
> Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in
> 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option"). In the
> same series a selftest was added in ae5439658cce ("selftests/net: Cover
> the IP_LOCAL_PORT_RANGE socket option"). This selftest also covers the
> IP_BIND_ADDRESS_NO_PORT sockopt.
>
> This patch enables getsockopt()/setsockopt() on MPTCP sockets for these
> socket options, syncing set values to subflows in sync_socket_options().
> Ephemeral port range is synced to subflows, enabling NAT usecase
> described in 91d0b78c5177.
>
> Signed-off-by: Maxim Galaganov <max@internet.ru>
> ---
> net/mptcp/sockopt.c | 29 ++++++++++++++++++++++++++++-
> 1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index cabe856b2a45..53f27354412f 100644
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
> @@ -688,6 +689,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o

This function is no longer specific to IP_TRANSPARENT (and never really 
was), can you add a 3rd patch renaming it to 
mptcp_setsockopt_sol_ip_set()?

> {
> 	struct sock *sk = (struct sock *)msk;
> 	struct sock *ssk;
> +	bool slow;
> 	int err;
>
> 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);

The code otherwise looks good to me. The port range could already be 
configured by sysctl, so there don't appear to be any concerns with the 
path managers handling a non-default range. And the options are validated 
here in the call to ip_setsockopt().

Thanks,

Mat

> @@ -710,6 +712,16 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
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
> 		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
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
> 2.42.0
>
>
>
