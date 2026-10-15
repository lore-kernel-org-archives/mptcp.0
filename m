Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB52931F1
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073126; cv=none; b=KM2CSaahRBniWwSEmhUyLj/S4nheR8OerNoNR7gHioSs4GQoj7O/INMlScZgjSSOovA6RFSSVfH+1e14siHDGlb4UVs1z79nOI3dulSRpJbP9oItnpjJhZjIwNZC1hA7cICaXoQyOP9RUIrsxxNNjQNIW0/5SetwwVRUq9lQsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073126; c=relaxed/simple;
	bh=EKsQmou59LJWGU/F0+yQu6pjXH7HAh1zw3qrovJu154=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Z70XQNL29pviv6QKdFxlZsQK1CTLYsuVcdouiKv+GFKkD6ZOVcroy+PFgBTGxhJy5vRgK4C8WyyTBFm+P6YLan6v0HmfycXDjZoNpXrh05pvatoTzt48kyBVUuUWd1YpBY33Bnmf98pLmbYc9vNw5DpYQX/cK6zeOZPgxohtuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq8in4xS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq8in4xS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637E61F000C4;
	Thu, 15 Oct 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073125;
	bh=aOh9AsApnWJgcgb+tnasnbdkQIqHn8wiYj8S86HyrDc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mq8in4xSpEGE6jDn/JQPKArI+88Woy6ljKDpxLLaEQ+dcrO7omtx8k6+WzzJrs917
	 Ziw0Y6k5QTEmYQuTkTbA2KIejW7Xg6udGdz6b9XzHEAloxVlWcBRs7nILy0A46nWht
	 kHCOcvAI5Nm9pjeUpjFJR4eLe0+7A7mhaxLzB/utgYby2Odzki9w80h5nx61Fe3XIJ
	 E5a3tYDNwLJC4mtV8+aVLhvAlcFE2tnufBbT++YzncjvyLC+fuWSswcekox4GNyoy4
	 cl3jY5ycsR4qeCkOu1qoH/H0vIOE5JPCLffl9frBI06CLgYpr1c/2TNDz+DbfOMikt
	 WPay8qF//vLkw==
Message-ID: <sashiko-outbox-172945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: disconnect: reset first subflow's
 local_id
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
References: <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:05:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] mptcp: NULL pointer dereference in mptcp_disconnect() on uncon=
nected socket
--

commit 79fba9c250462a2f6852b46cf0562a508bcae604
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: disconnect: reset first subflow's local_id

This commit resets the local_id of the first subflow to 0 when disconnectin=
g.
This ensures the value is correctly initialized if the subflow is reused
after a reconnect.

Link: https://lore.kernel.org/179198834484.434549.4616694240552704738@kerne=
l.org

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3654,6 +3654,7 @@ static int mptcp_disconnect(struct sock *sk, int fl=
ags)
>  	 */
>  	mptcp_do_fastclose(sk);
>  	mptcp_destroy_common(msk);
> +	WRITE_ONCE(mptcp_subflow_ctx(msk->first)->local_id, 0);

[Severity: Critical]
Does this code cause a NULL pointer dereference in mptcp_disconnect() on an
unconnected socket?

If a user creates an MPTCP socket via socket(AF_MPTCP, SOCK_STREAM, 0),
msk->first is initially NULL. If the user then calls connect() with
AF_UNSPEC before any connection is made, the networking core handles
AF_UNSPEC by directly invoking the socket's disconnect handler,
mptcp_disconnect().

At this point, msk->first is still NULL. Passing it to mptcp_subflow_ctx()
yields an invalid pointer, leading to an immediate page fault when local_id
is written.

> =20
>  	/* The first subflow is already in TCP_CLOSE status, the following
>  	 * can't overlap with a fallback anymore

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-mptcp-firs=
t-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org?part=3D1
