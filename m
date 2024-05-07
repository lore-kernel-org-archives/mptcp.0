Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF31862
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044151; cv=none; b=NcI2gTiBJzVzUfuRsybFiVDr1tKWyKAXtSCdXZebN7rwS+BVhKnc4DN8YeYHVmIRXIRIkCd/UdVN7tmJtfkoPzziLZ2OUEELno9aDQoN9p2mUpOn0mkMVajxeOjO5Ur66JMaXNcQz0NZEkYECafN0vjnNlerehj+Jgds8mOJyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044151; c=relaxed/simple;
	bh=KEJEkhOTlz+d80rnG79ROshxAeG5btO/uIqP54kDQE8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ul7x7XAkn6/a1jmElkLtX1UEArizuogpHuVqaF0miSqWjYY/+SWFQ1B6VYyDqTxFo1a4uqJQqhi1qD0z8cgJCV6kVJnNF3T3XKh9UK+wcet7IZdPSfdm9SxJo1lkDJP3TXdW1ocQLbJfuEDyflR/jlqodKXReWhoL2ibr+VAYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWx6MLa0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWx6MLa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECBDC116B1;
	Tue,  7 May 2024 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715044150;
	bh=KEJEkhOTlz+d80rnG79ROshxAeG5btO/uIqP54kDQE8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KWx6MLa0fyKSlA1vRLzAU9utdgRqqCXBDz7qb+++vkSNcPzBWmvZHGC9+q+B8KGdU
	 7d64Y2A6yHdGS9r/po61Jxn+z0QqcnMKsh6478ltbO/jcGc1mjoTEkdPPP6e1YxDi3
	 jTIl2YKlv0XoD6iXAJpd7LHP00BwKNXvHYcYui2k+aIN8REtRUs1nvEPCP+8FAvlh6
	 qsi/wvLvK2pF35wDShOn6+9kbXZmD0NIq+65SY6gKl/p3mrlnYJyyDvMnbB//wfpRY
	 g9QjVAAUpLNZNJzF6UYxm8YyC+Dmjsb9lblkkbUNEdI7qJd+r86a8uvTZZVcI1o/sm
	 TMvwXv7WGfbyw==
Date: Mon, 6 May 2024 18:09:10 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next RFC] mptcp: socket option to check for
 fallback
In-Reply-To: <20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org>
Message-ID: <764b2d9f-8600-a3fd-9312-64b43e78162f@kernel.org>
References: <20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 May 2024, Matthieu Baerts (NGI0) wrote:

> A way for an application to know if the connection fell back to TCP is
> to use getsockopt(MPTCP_INFO) and look for errors. The issue with this
> technique is that the same errors -- EOPNOTSUPP (IPv4) and ENOPROTOOPT
> (IPv6) -- are returned if there was a fallback, or if the kernel doesn't
> support this socket option. The userspace then has to look at the kernel
> version to know what to expect.
>
> It is not clean, and it doesn't take into account older kernels where
> the socket option has been backported. A cleaner way would be to expose
> this info to the TCP socket level. In case of MPTCP socket where no
> fallback happened, the socket options for the TCP level will be handled
> in MPTCP code, in mptcp_getsockopt_sol_tcp(). If not, that will be in
> TCP code, in do_tcp_getsockopt(). So one simply has to return 1, while
> the other can return 0.
>
> If the socket option is not supported, an error will be reported:
> EOPNOTSUPP (95 - Operation not supported) for MPTCP sockets, ENOPROTOOPT
> (92 - Protocol not available) for TCP sockets.
>

Hi Matthieu -

I like this approach as it's much simpler to check than MPTCP_INFO, and 
gives a clear answer to both "Is this kernel new enough to tell me the 
fallback status?" and "If it is new enough, is it currently a TCP or MPTCP 
socket?".

- Mat

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - This is linked to a discussion we had at the last meeting: having a
>    cleaner way, not having to check the kernel version. But maybe it is
>    fine to look at the kernel version? I mean: 5.16 is quite old now,
>    maybe too late for that kind of patch?
>  - During these discussions, I thought we had to also look at the
>    mptcpi_flags field from the 'struct mptcp_info', and check if
>    MPTCP_INFO_FLAG_FALLBACK was set: that's not needed, and this
>    simplify a bit what needs to be done to check for a fallback:
>    https://github.com/multipath-tcp/mptcp.dev/pull/6
>  - Maybe it is enough to optimise the getsockopt(MPTCP_INFO) like this?
>    https://lore.kernel.org/mptcp/20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org/
>
>    Note: typically, it is not possible to do a getsockopt() with an
>    optlen of size 0 from higher level lib (Python, Go, Rust, etc.).
>    Maybe we would need a similar optimisation for optlen <= 4?
> ---
> include/uapi/linux/tcp.h | 2 ++
> net/ipv4/tcp.c           | 3 +++
> net/mptcp/sockopt.c      | 2 ++
> 3 files changed, 7 insertions(+)
>
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index c07e9f90c084..dbf896f3146c 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -135,6 +135,8 @@ enum {
> #define TCP_AO_GET_KEYS		41	/* List MKT(s) */
> #define TCP_AO_REPAIR		42	/* Get/Set SNEs and ISNs */
>
> +#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
> +
> #define TCP_REPAIR_ON		1
> #define TCP_REPAIR_OFF		0
> #define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 95ca73937a1c..39ee5a107544 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4363,6 +4363,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>
> 		return err;
> 	}
> +	case TCP_IS_MPTCP:
> +		val = 0;
> +		break;
> 	default:
> 		return -ENOPROTOOPT;
> 	}
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 2edaf1a16005..e50262b8942e 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1354,6 +1354,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
> 	case TCP_NOTSENT_LOWAT:
> 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
> +	case TCP_IS_MPTCP:
> +		return mptcp_put_int_option(msk, optval, optlen, 1);
> 	}
> 	return -EOPNOTSUPP;
> }
>
> ---
> base-commit: f16f6f211e692c812d4d5b24e8eff95188ecb62c
> change-id: 20240506-getsockopt-tcp_is_mptcp-735fec263981
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
