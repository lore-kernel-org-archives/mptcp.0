Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429113;
	b=ekmF0ZzntUEFW/xO7JVQpfs+9NZiVIVXpH3dUz0AzZcurOGXNY97UaqBlGKSNcJgcN0Z
	 YOCOvLdXlGjD+TxokBtPrge3dekb+qKEYo+TFk+aqL/8+8ns3iJrzBaGQLBz4QeE/Xk1q
	 EHTIJ1MJ0bdlPRtRN0lKwpWWnkTCkCCQbcE2xaJqPr0A07uSaqsbKQPQ8GCPSnNghBuZX
	 c3jqorFmOtiEa+iHeh4p4MTTrF62xopu01PxUkOiWOgItBxQA66oLXu3btN80jMoNJpJW
	 WFQhMCqLjF2NU4ip8ulZDogkRrQozAh8tle+NV/YrvjyWfVkCwRA7z4G/J8l4AfpPoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429113;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3hwiQYBMtUFszNgRO0EOSdLPgtWj+YxlrObcZCODYx4=;
	b=B6Ej/WJ3rGcVA+zWm5OWvfnMPKT/cbD+QdurxHbI7eCK87sW1irzVVj6cGjQLC2wqnps
	 y/20zcANLVIOBjHYQjnuCEEgig0RRFy0ub7AtmKw3b1AzJEG3PRRYlosyuAzRfu8dKZX7
	 ESowDrUqxPnQR3mrcsGI9V/V/CVA8dY3vNSKJBNCLXP7ecQhg93ZTbbaT4cRq/3FC/6NU
	 cbf1UNT3uUTJ4JYxQmae6Y9NQTHlfD02qkg5tTJtjTVh8idgp7vckFtUAm2jw7XBEJERf
	 my8EOYkrWiETrfGB+pM81x3Q5Q+Y4/JP2jWuaxtrW7IMcfMsPDq23rqhNMKG0TDKWPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XcGwOD/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C42606A31F
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcGwOD/q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0313A1F000F4;
	Mon, 23 Nov 2026 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795429113;
	bh=3hwiQYBMtUFszNgRO0EOSdLPgtWj+YxlrObcZCODYx4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XcGwOD/q3ZLg0kCT0U8OT26z2UFeypGV+uIpYGowL8ip/i+y9GsdpoXyYzNrs4kCi
	 vYWVzcfm2G/pZRITNiFupDCy6yxCOHOrSyVn35G0MFFAQgTlpdZtKcv0gV2J+cwFuR
	 nvDD+Lovt7rTtbrRECT2rCJ4AQefcU1oQuCqf++cVLkihc0dcK3wZ91+S4mNaF3Lc5
	 fBpGBN5JLq9qaND2ui4mGn3P5hlFTrZBxTOcXMAJe04nr3Y56pV1p4qBKBzPiNvHU8
	 6pjFmiFUBetm/o3rD7ElxBNpW7UfQZFgo0Xu6fYewsaWSFGc7ThCi0ND0l10+Y5ZWn
	 hKcZMyvPokJQQ==
Message-ID: <sashiko-outbox-229032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 1/2] mptcp: sched: add subflow avoid flag
 and enforce it in default sched
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261123100821.2228839-2-kalpan.jani@mpiricsoftware.com>
References: <20261123100821.2228839-1-kalpan.jani@mpiricsoftware.com>
 <20261123100821.2228839-2-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:18:31 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: sched: unreachable subflow->avoid checks in default
  scheduler
--

commit 581a16fad32148d403da6646a8629a080cac8614
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: sched: add subflow avoid flag and enforce it in default sched

This commit adds an avoid flag to mptcp_subflow_context, exposes
mptcp_subflow_set_avoid() as a BPF kfunc for custom packet schedulers,
reports the flag via MPTCP diag, and skips avoided subflows in
mptcp_subflow_get_send() and mptcp_subflow_get_retrans().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index be23768b6d051..8a2894293e70c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1650,7 +1650,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_so=
ck *msk)
> =20
>  		trace_mptcp_subflow_get_send(subflow);
>  		ssk =3D  mptcp_subflow_tcp_sock(subflow);
> -		if (!mptcp_subflow_active(subflow))
> +		if (!mptcp_subflow_active(subflow) || READ_ONCE(subflow->avoid))
>  			continue;
> =20
>  		tout =3D max(tout, mptcp_timeout_from_subflow(subflow));
> @@ -2575,7 +2575,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp=
_sock *msk)
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> =20
> -		if (!__mptcp_subflow_active(subflow))
> +		if (!__mptcp_subflow_active(subflow) || READ_ONCE(subflow->avoid))
>  			continue;
> =20
>  		/* still data outstanding at TCP level? skip this */

[Severity: Medium]
Can subflow->avoid ever be true in mptcp_subflow_get_send() or
mptcp_subflow_get_retrans()?

mptcp_subflow_set_avoid() has no in-kernel callers and
bpf_mptcp_common_kfunc_filter() restricts it to bpf_mptcp_sched_ops
programs.  An MPTCP socket binds msk->sched once at creation and only
clears it in mptcp_release_sched().  When a custom BPF scheduler is
attached, mptcp_sched_get_send() and mptcp_sched_get_retrans() dispatch to
msk->sched->get_send() and msk->sched->get_retrans() rather than the
default scheduler, and neither mptcp_subflow_get_send() nor
mptcp_subflow_get_retrans() is exported as a BPF kfunc.  Conversely, when
msk->sched is &mptcp_sched_default, no bpf_mptcp_sched_ops program runs on
the socket to set subflow->avoid, making both checks unreachable dead
code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123100821.2228=
839-1-kalpan.jani@mpiricsoftware.com?part=3D1
