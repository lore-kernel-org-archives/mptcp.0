Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC1277C88
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981206; cv=none; b=SgABAzUa3yRw1iaX/CcvmcXmEFVNPzacBc0CboX4YCI+maq8oHOs4n+/2U+Cy4PNecixo/QrMmPwSx8jYfwoRL2HPzTBMoJEiToeFeynmkQHhGTovgzgNGDwHmnjknls9hVDCDLW6QNl01sgW0920YvPGYyg7AsX97o1PNXGGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981206; c=relaxed/simple;
	bh=sjPx93vcI5fJffm81MfLi1HKYsukkhehasDwG5+ldKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GsAMx13efweLVnB1VFZj9/LxR73QsXBE85am/aSYevqT9t1g3L0FL9X4qnoFkI8jUI0ASN89jMrUfUaE9RaDMLAEiJ5AiGja+lbix66f/DtkWqZObN/hP3w+Nc4Cq5TKObQ4SsYGEUL+SPqmg9b07+ws/R3KLZZUixiO+/Q2+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmusk3Zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmusk3Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1591F000E9;
	Mon, 17 Aug 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981205;
	bh=+dIwt/AHOuyi2u41v7y0kSZkQ/kESmzA3+YqEULW7TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jmusk3ZqDjWXslGzrwi0xFiqt4a314qPPLc4rFyFbNnSugz8Aaw3daY5yO1S1sPea
	 m+J4BYTuEIg+6q0ZUUXU/jJImbuDVYhnTB133Ciftf1tFyWgOVJ7wr7n/lmOp7xEVm
	 ooFVEqLPR8YCNanA6h4A1gnKwalMesJjaEJOQQEV+oPFXwCaEB74Ru+PT8t9l6vIge
	 N43crgCiAaJgscxXuAAFdoay2I4cwTSQVdcJqBVCXtT3+i2fE/fUY+SDi7xHogc2Kl
	 CKzm05duuGbH4Jqlp9rxgV4EcP28Jk2LHjyzDzru3OykA63sqLqz3EAoBldIRIOOOw
	 +ybsK7do3UxEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 1/4] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shardul Bankar" <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-1-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
 <20260817-mptcp_penalise_send_v2-v3-1-e6a2ad2f1b82@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 15:40:04 +0000
Message-Id: <20260817154005.1E1591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The weighted average pacing rate computation silently overflows `u=
64` on high-speed networks with large send buffers, artificially clamping t=
he calculated rate.
--

--- Patch [1]: [PATCH mptcp-next v3 1/4] mptcp: sched: avoid truncating the=
 pacing rate in the scheduler ---
commit b2e45abf072b6d7db21560b1c0ae59fd43742be5
Author: Shardul Bankar <shardul.b@mpiricsoftware.com>

mptcp: sched: avoid truncating the pacing rate in the scheduler

This commit addresses truncation and overflow issues in the MPTCP
scheduler's pacing rate computations. It widens the pace variable to
unsigned long and casts the pacing-rate average product to u64 to
prevent 32-bit integer overflow. It also uses div64_u64 for the linger
time calculation.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c2762d74f29d7..46a49ec75e784 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1691,7 +1692,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_so=
ck *msk)
> =20
>  	subflow =3D mptcp_subflow_ctx(ssk);
>  	subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rate * wm=
em +
> -					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> +					   (u64)READ_ONCE(ssk->sk_pacing_rate) * burst,
>  					   burst + wmem);

[Severity: High]
This is a pre-existing issue, but is it possible for the weighted average
pacing rate computation to still silently overflow a u64 on high-speed
networks with large send buffers?

If mptcp_subflow_get_send() computes the moving average of the pacing rate
for a connection with a large send buffer (e.g., 2 GB) combined with a high
or unlimited pacing rate, the numerator ((u64)subflow->avg_pacing_rate *
wmem + (u64)READ_ONCE(ssk->sk_pacing_rate) * burst) can exceed 64 bits
before division.

This could artificially clamp the calculated rate, drastically reducing it.
For example, an unlimited pacing rate (~0UL) with a 2 GB send buffer might
be incorrectly throttled to ~73 Gbps, and a 100 Gbps paced connection with
a 2 GB send buffer could be throttled to ~26 Gbps.

>  	msk->snd_burst =3D burst;
>  	return ssk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-mptcp_pena=
lise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com?part=3D1
