Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696C3A8DD
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdxRgAM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3F8C433C8;
	Wed, 13 Dec 2023 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702487249;
	bh=zvxoEqmqnkmD6ZEcHXKpJAZNd2GFkLijYK0Xcr1qhhs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VdxRgAM/FQw71u2sth2ub2asxip1yQ+Ki8V7dpx01XQMd8MLILDdwf9HfdZ83Gfc/
	 R/SnJ2BdX4jn2T/VgQXcStinucvjvAqJc6SwCYlWgnYm9QDNluKVTL4DFijvrMv1PD
	 ft/8ELPiUUEQ5+Zg4QeJWq1Pvjyp2jHBkZSbrdXSHlK/fT68f5YGd6JbV+gj54chhq
	 IJmhkNPuZWmQKHRqGLf7wRvKv2AFkCtTRRLYT3M3K9Gbyt2pnNCilVPgn9EcE7WOvY
	 jL6Ioh5DApzyzSTsnWFNPGOxFDgSWqASozpmPQc9a8vjTgrTqUiejwgPGEh2q31r0P
	 OKNuvO2IoHaQg==
Date: Wed, 13 Dec 2023 09:07:28 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Maxim Galaganov <max@internet.ru>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/3] mptcp: sockopt: support IP_LOCAL_PORT_RANGE
 and IP_BIND_ADDRESS_NO_PORT
In-Reply-To: <20231211120309.20752-3-max@internet.ru>
Message-ID: <b4346c70-d040-8836-db89-ab1e1246ba45@kernel.org>
References: <20231211120309.20752-1-max@internet.ru> <20231211120309.20752-3-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 11 Dec 2023, Maxim Galaganov wrote:

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

v3 looks good, thanks Maxim!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/sockopt.c | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index a4bf337e6f77..c40f1428e602 100644
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
> @@ -710,6 +711,14 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
> 		inet_assign_bit(TRANSPARENT, ssk,
> 				inet_test_bit(TRANSPARENT, sk));
> 		break;
> +	case IP_BIND_ADDRESS_NO_PORT:
> +		inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
> +				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> +		break;
> +	case IP_LOCAL_PORT_RANGE:
> +		WRITE_ONCE(inet_sk(ssk)->local_port_range,
> +			   READ_ONCE(inet_sk(sk)->local_port_range));
> +		break;
> 	default:
> 		release_sock(sk);
> 		WARN_ON_ONCE(1);
> @@ -755,6 +764,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> 	switch (optname) {
> 	case IP_FREEBIND:
> 	case IP_TRANSPARENT:
> +	case IP_BIND_ADDRESS_NO_PORT:
> +	case IP_LOCAL_PORT_RANGE:
> 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
> 	case IP_TOS:
> 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
> @@ -1350,6 +1361,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
> 	switch (optname) {
> 	case IP_TOS:
> 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
> +	case IP_BIND_ADDRESS_NO_PORT:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> +	case IP_LOCAL_PORT_RANGE:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				READ_ONCE(inet_sk(sk)->local_port_range));
> 	}
>
> 	return -EOPNOTSUPP;
> @@ -1450,6 +1467,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>
> 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
> 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
> +	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> +	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
> }
>
> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
> -- 
> 2.43.0
>
>
