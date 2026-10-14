Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32343803D1
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989420; cv=none; b=BDXn2+inRXNasPKj1V/hmDFPQ8eNVEOxq94t7/TLJkfgGcR6DzDeklxjMdieuX//tI50t//qi0LRKuupC1uBrfoeK3M5YHOk5I8H+MKVYhgJ/HFng1tj9kP9MBLhdUPh7TXuEDrKPCU2RnJHc/zLQmgnKVH7ziMtI+jjCZyn800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989420; c=relaxed/simple;
	bh=hLhNaXYIp8OKeJH+N0ijtxidqpXckam9Yq9Pa0rBC8Q=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Fj6P9tPtq9OdtvfSTPEz8+qiXMIeRgTBhKpghRSqM/Tn6xpXdEe9n4djo0IUXxLneREmHGDv0bVCRwbo74ySXWzaZeGYmE0oLIph9ihwDqZ/nJBVeNST86bOcK8gGJLd6xE5CQ5oZ0sPZn+aUVIcMxE6treCw13Zqb01+Uxd7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYNRwaT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYNRwaT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92DA1F000C7;
	Wed, 14 Oct 2026 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989416;
	bh=roKRYRfq/qDMov+6yP1uE9fx6cL0DToH9/Tpci/WgMQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nYNRwaT/COZulbzjDMa6oTYm12mg77iIGWr/uR8hOzLQ8AItdIMXG+p2uOKpLSLsQ
	 XjZsTF2LK31esiavoid3R7OyZG9AckvbaEMi01XQTFzCu191Mia+66ObEnbnJFTA0d
	 mo39yR3ck59MxmHHDfYhjs9MHDOrXWHg7awiK9MXSQ0GmbFlyRebmBJdS7hTDZqnAF
	 vwOG6pDrYgz/wyLMysQHO2ACD9Aa9mcwWMiUFr4G/vvE1id5oV5UTRh+jjL5sAwGNw
	 BZaJemy9x0AEpl/PEkvu4KnOGVPFsuEU5sOZIJP2Ov5tSTkM0TIk9tcXIRRcPadcFL
	 YcqGm16uNNb5g==
Message-ID: <sashiko-outbox-171447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261014143349.768138-3-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:50:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: duplicate MPTCP_EVENT_SUB_CLOSED event emitted on reconne=
ct failure
--

commit 66071f5b3caa5390ad8bce4ae347cb2285123fa3
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: kernel: retry subflows closed after an error

This commit adds an opt-in sysctl to retry creating subflows closed by
TCP after an error. The PM immediately creates a new subflow using the
same addresses, and spaces out attempts via SYN retransmissions. A new
SubflowRetry counter tracks these attempts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..d020e5f69c013 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
[ ... ]
> @@ -1591,6 +1591,151 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_=
sock *msk)
[ ... ]
> +/* Called with the msk socket lock held, instead of closing the subflow =
*/
> +bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct sock=
 *ssk,
> +				     const struct mptcp_pm_retry *retry)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	/* like mptcp_close_ssk() does for the failed attempt */
> +	mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
> +
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> +	if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remote))
> +		return false;

[Severity: Medium]
Will this sequence emit a duplicate MPTCP_EVENT_SUB_CLOSED event if the
reconnect attempt fails?

When mptcp_subflow_reconnect() is called, it clears the subflow context
using mptcp_subflow_ctx_reset(), which zeroes the close_event_done flag:

net/mptcp/subflow.c:mptcp_subflow_reconnect() {
...
	mptcp_subflow_ctx_reset(subflow);
...

If the underlying tcp connect call fails, mptcp_subflow_reconnect() returns
an error, causing mptcp_pm_kernel_retry_reconnect() to return false.

[ ... ]
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..f29cfd2ad69b9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -2827,7 +2829,14 @@ static void __mptcp_close_subflow(struct sock *sk)
>  		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>  			continue;
> =20
> +		do_retry =3D mptcp_pm_kernel_retry_check(msk, subflow, &retry);
> +		if (do_retry && retry.reuse &&
> +		    mptcp_pm_kernel_retry_reconnect(msk, ssk, &retry))
> +			continue;
> +
>  		mptcp_close_ssk(sk, ssk, subflow);

[Severity: Medium]
When mptcp_pm_kernel_retry_reconnect() returns false, the fallback path
here calls mptcp_close_ssk().

Since the close_event_done flag was cleared to false by the failed
reconnect attempt, and the parent MPTCP socket is still in TCP_ESTABLISHED,
mptcp_close_ssk() will unconditionally emit a second MPTCP_EVENT_SUB_CLOSED
event for the exact same subflow socket.

Could this duplicate state notification confuse or desynchronize userspace
path managers?

> +		if (do_retry && !retry.reuse)
> +			mptcp_pm_kernel_retry(msk, &retry);
>  	}
> =20
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014143349.7681=
38-1-anilkaushikwireless@gmail.com?part=3D2
