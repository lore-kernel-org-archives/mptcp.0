Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232B352C35
	for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885815; cv=none; b=RkwhJCIJEoa0/hAyAPiPxz041K2oLga57j+ZvlA2AnQyhAsVQWH4lychUcZ2v8XPBAW5rdiyBf3kxLSOIoBAFQVRD4GeW0CX5NzhxQcROgeRTKR804oNmo7q1ZU09KgpPSAz80lprpdw26e5KEctzPerM8qY3FXcWbEys1X/HdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885815; c=relaxed/simple;
	bh=TK0uG2CgGtpXiFowCE7GF4murr2zWBycG7N7vkHdwL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXxk0MhluOZ+agqCX1C6rVoMhHHCURVdcSkgB9axLunbpEc4M/v+3KnrNBphWK3d1R3MKuBD6bPEnAm3qM14MRXWr4RkoiYZz4GLVHUD7yQychGolBc250kHrYmSqwwLDzx7jxJazQSu1kthWxf925ZcSrVUck4eueBKq7E4JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIDWgYOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIDWgYOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A8E1F000FF;
	Sun, 20 Sep 2026 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885813;
	bh=Q8xvYdfFwB+tElFpSStrK+sUwEBtI170Ut1CUcPocy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIDWgYOd0ZDPtXlrw68dD6RpzlV6Sh8c1cTqwPKUHSbxWnDJiRA8gz5Nueh6bpaxq
	 O8uDpAVbJYPElSnkbERj+shW4xn6XEU3ECDjcrNjh1LqiJ4R4wLlNVvLXsEeCtFbJE
	 gMsGw4JlRcsrHtAfYybNN56Jz6bR3pHuaKTOrH+rVoYwWhmVsNZzZQgMqRTAMcsN7f
	 rQHhEI8TXDZoz2PUImGMzPU0nrXWdaf1HVHSsqEFpy16uVxryGadwdxRHt0ecokesx
	 itp8liSE+fskRtIWLoIs6+ZpSr9NanM5pxu1jpn86QV8uvoDvt8Z25tgs96czRiWt7
	 baz5Eiswx5t1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260920061755.3575063-1-yilinzhang@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <20260920061755.3575063-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:30:13 +0000
Message-Id: <20260920063013.89A8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net/mptcp: unintentional disabling of TCP timestamps for MP_JOIN
--

commit 2eba4e34ce837e7639b005fa4e73483919c7fa14
Author: Yilin Zhang <yilinzhang@moonshot.ai>

mptcp: do not use Fast Open on MP_JOIN subflows

This commit rejects Fast Open on MP_JOIN subflows since data on a subflow
requires a completed HMAC exchange. It falls back to the regular handshake
for TFO SYN packets and strips the Fast Open cookie from MP_JOIN SYN/ACKs.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..7bf94aea5f681 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -348,6 +348,10 @@ static void subflow_prep_synack(const struct sock *s=
k, struct request_sock *req,
>  	if (foc && foc->len > -1)
>  		ireq->tstamp_ok =3D 0;
> =20
> +	/* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
> +	if (foc && mptcp_subflow_rsk(req)->mp_join)
> +		foc->len =3D -1;
> +

[Severity: Medium]
Does this sequence unintentionally disable TCP timestamps for MP_JOIN reque=
sts
with TFO cookies?

In subflow_prep_synack(), if a remote client sends an MP_JOIN SYN with a TFO
cookie request, foc->len will initially be > -1, causing ireq->tstamp_ok to
be cleared to 0.=20

Immediately following that, this new check sets foc->len to -1 to reject TF=
O.
While the TFO cookie is correctly dropped and not sent, tstamp_ok has alrea=
dy
been cleared and remains 0, leading to an unintended loss of TCP timestamps
on the subflow.

>  	if (synack_type =3D=3D TCP_SYNACK_FASTOPEN)
>  		mptcp_fastopen_subflow_synack_set_params(subflow, req);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920061755.3575=
063-1-yilinzhang@moonshot.ai?part=3D1
