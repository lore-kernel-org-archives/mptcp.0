Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94B4D9F93
	for <mptcp@lists.linux.dev>; Wed, 16 Sep 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591099; cv=none; b=DwR9zveuCS4AeNKtC37dBN4hJOJULZrZelvs1Uocvgr63UYHkcOdmwNILC8NDaIMRYure11wL4UtUh/OX81oYll0m7kUY8hhUmvuE12yXH1CXKTqPRPisirMcrLb2+wCIO5SYbkPHU2yC1Yi6gd+z/HgeZJTTpvsdJ7dj6jC00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591099; c=relaxed/simple;
	bh=elJqWs6lMVc064jEZYo3plamz4OtG/xfQClr0yAUCOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAuwgYffXLkVkxRHImKictuocYyJiVSYnSfYtbFCSYUSo1PBO8psVqXpoHLrdh6gbXM78xVwXW7JP+Rx3bN1qVYVVUsjZuGuim1KoXzpmLgzsEvEyXe4h6kmt3QwzTYl/DWubxDJzQq2l40gHGXMKo4clmCyNasopHarCEOT1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2LdZBWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2LdZBWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B891F000FF;
	Wed, 16 Sep 2026 20:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591083;
	bh=3qLnqPkMjdABCDnz6JFom6yQYnaF5vAnLaUjJQf1XWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2LdZBWsJw8DRjISnFhtyvxcM5ImeSqnRhEzxxADyoE58xPyqvLpm8zUl8ujv+jFR
	 2v4syYhGXZE6bsddect6LFv4SnCS9cmOuFUV01PiFblAR0kcuLPcvSudgU2ThtYk9m
	 /pdJ+PrgUhqivigGD+qHLPJM/oR5vcG72oO/27NRZ3xoIBFsJ8PgLM/V3cXpGvCb1N
	 Sv1fiODFML+tenqNiF0X6CXQzLzFv46D6tM0Zfp4ZzmY+XBjon+gKrxKTpE8rA1CkE
	 ZjfSMTEGlmjUtrvNsoj1tBJHcxbP0VrFPJX5gsax8fP5FBpCFcmMLhoHebORhG54p0
	 wd/XEmLWfMcAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] mptcp: avoid unneeded actions on subflow reset
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-1-a257797dd5d0@kernel.org>
References: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org>
 <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-1-a257797dd5d0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:38:02 +0000
Message-Id: <20260916203803.08B891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp: data race in bitfield resetting and close_event_done
- [High] mptcp: memory leak of receive queue skbs on subflow reset
--

commit c5cb7c23812480bd88951ebb970702ef4bea70fa
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: avoid unneeded actions on subflow reset

This commit introduces a resetting flag to break a recursion loop during
subflow reset. It avoids unnecessary Rx queue processing and error
reporting by exiting early in subflow_state_change() when the exceptional
condition is met.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2b4c274264773..0384d6a023f9d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -585,7 +585,8 @@ struct mptcp_subflow_context {
>  		is_mptfo : 1,	    /* subflow is doing TFO */
>  		close_event_done : 1,       /* has done the post-closed part */
>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
> -		__unused : 9;
> +		resetting : 1,	    /* subflow is resetting */

[Severity: High]
Does this bitfield placement introduce a data race?

The resetting and close_event_done flags share the same 32-bit word in stru=
ct
mptcp_subflow_context. In C, bitfield assignments compile to non-atomic
read-modify-write operations on the entire word.

It appears mptcp_subflow_reset() modifies resetting under the ssk lock, whi=
le
mptcp_close_ssk() modifies close_event_done under the parent sk lock. Since
these locks are distinct and not mutually exclusive, concurrent updates cou=
ld
overwrite and lose the resetting flag, which might reintroduce the recursive
lock deadlock this patch aims to fix.

> +		__unused : 8;
>  	bool	data_avail;
>  	bool	scheduled;
>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 01db7edce18a6..cbe227d218449 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1883,6 +1884,13 @@ static void subflow_state_change(struct sock *sk)
> =20
>  	__subflow_state_change(sk);
> =20
> +	/* Rx queue processing is unneeded, error reporting will take place at
> +	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
> +	 * fallback: subflow_sched_work_if_closed() would be a no-op.
> +	 */
> +	if (subflow->resetting)
> +		return;
> +

[Severity: High]
Can this early return cause a memory leak of unread skbs?

When a subflow is reset, tcp_done() is called and sets the state to TCP_CLO=
SE,
but it does not purge the receive queue. Because this early return bypasses
mptcp_data_ready(), the skbs remaining in the receive queue are never drain=
ed.

Later, __mptcp_close_subflow() explicitly skips closing any subflow with a
non-empty receive queue:

if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
        continue;

Could this cause the subflow to be permanently skipped and kept in the
connection list, leaking both the subflow context and unread skbs until the
parent socket is closed?

>  	/* as recvmsg() does not acquire the subflow socket for ssk selection
>  	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
>  	 * the data available machinery here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-net-mptcp-=
misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org?part=3D1
