Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A647489864
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733070; cv=none; b=EK/ZS215leHnRCZyLPTiCFJE+3C3ihvYu+zM+MEUyuDRpDWISx9itJcrWYyunXhSjNAJPTxVHPDeuUr5puTJAKGf45dnFtT2nqIwdlDwqq4ryTC104DAmIcFu88bQg1/9UqF6GosRiDuYbFbbH5Cb1l05dY6BVV/Wn/tBZFPPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733070; c=relaxed/simple;
	bh=u+xDzu4/gk99+O+7GP1AXVhg2tHID0nZu09gYpOp/pU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pgRKaPx+vi02qBgh1AL9NWoma9zlmK5gkeZISn86TS3gOtLwQCMboXv9A2TWb4QDMDh77JIt5DvUftEfUfJIzh3mhnXJW7hSSolPQfRXocYp0SGYUYQVyHop8O3HOjNGQvBl2vp+L6vunAcgoJfdZQdsmfIHckR93VRmeNw3dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9eRh3vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9eRh3vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E300E1F00A3A;
	Fri, 14 Aug 2026 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786733069;
	bh=1wbwSPXzkm2rlzR81k7gXxfpoAIFU8Ta+DTQ1sRKO/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9eRh3vf5Y9sE8Vh6mslVw98IyH32UYyCGVz1biFDgXCitih139tfbVS2TgSf9YEm
	 69LD0g6us5xENZTVpY/8SQFt19+G0KVD0M3wcYxMdlJAWG+l2l+JoI10xDbLJx2CVP
	 7UjyHjG7R4C78dS+tjJaBaz0+hNMJKvDL//fR+UHf3MVQhE3PpERUZxaYuBZoP/67U
	 qP/adXAIgEzqn3t8tjsR9/vgsYTMnIhbTyFpFiv7MXxaiYBzqgfWkcSvdpF5SEldXv
	 zdecuYkqNzqFQ1oLf4e38JXxw/6aukUQs/w2qbfA5MM6Wgo4ZELDMROVbY40aB3Rjj
	 4xt4V/Mmul7Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating on
 closing connections
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:44:28 +0000
Message-Id: <20260814184428.E300E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PM endpoint operations silently ignore half-closed connections, le=
aving stale PM state and breaking MPTCP resilience.
- [High] Lockless connection state check introduces a Time-of-Check to Time=
-of-Use race that causes transitioning sockets to permanently miss endpoint=
 removals.
--

--- Patch [3]: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating=
 on closing connections ---
commit d802951fdbb5f62840e58ea428dab6858edf0731
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: pm: kernel: skip operating on closing connections

When iterating over each MPTCP connection after having manipulated MPTCP
endpoints, there is no need to operate on closing (or not ready)
connections. We can then safely skip those.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..c185e53fe42b1 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

[ ... ]

> @@ -1095,7 +1095,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(=
struct net *net,
>  		struct sock *sk =3D (struct sock *)msk;
>  		bool remove_subflow;
> =20
> -		if (mptcp_pm_is_userspace(msk))
> +		if (!mptcp_is_fully_established(sk) ||
> +		    mptcp_pm_is_userspace(msk))
>  			goto next;
> =20
>  		lock_sock(sk);

[Severity: High]
Are half-closed connections skipped by this check?

mptcp_is_fully_established() requires the socket to be in the TCP_ESTABLISH=
ED
state. If a connection is transferring data while in a half-closed state
like TCP_CLOSE_WAIT or TCP_FIN_WAIT1, the PM endpoint operations will silen=
tly
skip it.

If an interface goes down, could this cause dead subflows to remain alive,
breaking failover because data continues to stall over removed interfaces
instead of seamlessly switching to active paths?

[Severity: High]
Can this lockless state check cause transitioning connections to miss
endpoint removals?

Because the check happens before lock_sock(sk) is called, a connection
transitioning from TCP_SYN_RECV to TCP_ESTABLISHED could be skipped.

If the socket transitions to TCP_ESTABLISHED immediately after being skipped
here, the state machine triggers mptcp_pm_nl_fully_established(). However,
that function only synchronizes additions from the PM database, not removal=
s.

Will this result in the endpoint removal event being lost permanently,
leaving stale subflows active indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-mptcp-rese=
t-mpj-early-v1-0-3ca3260f9474@kernel.org?part=3D3
