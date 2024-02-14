Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851660DED
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937429; cv=none; b=bWTXvSrfJphfgKkl7wt1uqGrqTgk1mvYH47rD1xT0khgWOkxT9EWMAWaJS6+4VxS2eG07IO3d/QYwC3nWNP6TSkvZ2B9nJUOoC8/3TFimGfi0vST1UWEHYpZFwT3RKG8JYrLsRldfBoOhI51bEJv/kJ4ik3bXHGfpqzbt4FvZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937429; c=relaxed/simple;
	bh=NWQqpVjC6swq/PqOEGFINz+sQRtJ4PJmDwym58VAPw4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CKEV6RUE7kFmM127YZ0V3MjI9T7YLHVo5im9S3WKLpsnq2heEiJewxg1VpP3FQ5rM09/gsZ06C0WkExKFAyb5LHchBBsgOVO6K80BpgZADWBUjl2lcph6T/gsKxxd4BuVYP+wVNIrZWT0DahSXDGPTvF79lZjmp6v5DHj9F0DP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivzWR34q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivzWR34q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0359EC433C7;
	Wed, 14 Feb 2024 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707937429;
	bh=NWQqpVjC6swq/PqOEGFINz+sQRtJ4PJmDwym58VAPw4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ivzWR34q5gqBd/pXKaMjWqzIO+10bPv+HZICXVJNbywdoJuk1WJZxdcRM3Gsj7b7+
	 oRi9iBJ0MSQc8/5webbCS0BMZMJRHhbczOrpkr6tLnrPfC6UkmhmNg//FdNJLkZJmc
	 BTYPDp7hzdmI6kHWXXLrW7igs57YyCzzafW9oBycOrjYkJ2HOrQ9A71vqH9yC9PYen
	 /+i51+7t2vNZvm6k0Ph2iDi2zlZEZCw9TYhp+n31LiBP8+ILvDkAjRbxpIlpNreSDR
	 tAG3IzCV3asdiBe3ez8fDmuOijwJXDZ85KISzz7Wvlox98QSd5yvoSb30gcn8bvGUU
	 +mNMo5Nb/835g==
Date: Wed, 14 Feb 2024 11:03:48 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: check the protocol in tcp_sk()
 with DEBUG_NET
In-Reply-To: <20240207-mptcp-check-protocol-v3-2-77c69c596f55@kernel.org>
Message-ID: <b8171406-f8f8-4bd9-b762-25aaccfb3647@kernel.org>
References: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org> <20240207-mptcp-check-protocol-v3-2-77c69c596f55@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 7 Feb 2024, Matthieu Baerts (NGI0) wrote:

> Fuzzers and static checkers might not detect when tcp_sk() is used with
> a non tcp_sock structure.
>
> This kind of mistake already happened a few times with MPTCP: when
> wrongly using TCP-specific helpers with mptcp_sock pointers. On the
> other hand, there are many 'tcp_xxx()' helpers that are taking a 'struct
> sock' pointer as arguments, and some of them are only looking at fields
> from 'struct sock', and nothing from 'struct tcp_sock'. It is then
> tempting to use them with a 'struct mptcp_sock'.
>
> So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
> kernel devs when a non-TCP socket is being used as a TCP one. 'tcp_sk()'
> macro is then re-defined to add a WARN when an unexpected socket is
> being used.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - v2:
>    - Move from include/linux/tcp.h to net/mptcp/protocol.h: specific
>      to TCP (Paolo)
>    - Use a macro instead of an inlined function (Paolo)
>    - Adapt the commit message after the recent changes.
>  - v3:
>    - add parenthesis around 'ptr' (checkpatch)
>    - there is still this check from checkpatch but I guess that's fine:
>      Macro argument reuse 'ptr' - possible side-effects?
> ---
> net/mptcp/protocol.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index eefd1397106d..6b62a7f35dd9 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -348,6 +348,15 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
> 	sock_owned_by_me((const struct sock *)msk);
> }
>
> +#ifdef CONFIG_DEBUG_NET
> +/* MPTCP-specific: we might (indirectly) call this helper with the wrong sk */
> +#undef tcp_sk
> +#define tcp_sk(ptr) ({								\
> +	WARN_ON((ptr)->sk_protocol != IPPROTO_TCP);				\
> +	container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
> +})

Hi Matthieu -

Could make checkpatch happy with:

#define tcp_sk(ptr) ({								\
 	typeof(ptr) _ptr = (ptr);						\
 	WARN_ON((_ptr)->sk_protocol != IPPROTO_TCP);				\
 	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
})

(same idea for patch 3)

- Mat

> +#endif
> +
> #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
>
> /* the msk socket don't use the backlog, also account for the bulk
>
> -- 
> 2.43.0
>
>
>
