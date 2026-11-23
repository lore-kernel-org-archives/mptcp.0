Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438023;
	b=oKsYAeSloi18YGUDfx6GxB7zGCCPhagZ5PSS5Z6dOgA8IRBTjQ1Dy3lVp+vE9ewxfgpq
	 H0tBrDXP1NV2eZ7/0MPrBt1NHF+Mk2lthjhMOE8jF7iA7whZ+ZpU3ouP3K/qszsw324e3
	 /K955KcLWa5lVSWyCB698Zt8sgXNoyErIQzUX+Y75Nrwn66lMdmdO0s75YEvTIdHXz6Aw
	 oCGim3sl659fg7c+wMvPv8jxAMckCWvpzyuqSNwcIdxrYWXszZv4oXDnbwhNVoelnDzmG
	 Wje8Z3Tg69IJa0wxqtEJ4OTUGOpEfq8KbYGAaw0D0/6GwXwEV3iZFfbmTNynudoRWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=azj7nPjS7dDHmaER7U9r8isuCnEXUkXJznmtZ7YYcHE=;
	b=PvCWBG3SPJVFuMaiukWSYYeeMkA228ZgrVxOaGC8QBVALzSiMwH9pll0KpcxTa0d6YLo
	 mTOqpafs8gyX2z96Dux6w/uBpap1PRWbxtNQASI6tB21kEIAcxccu1RLmeq5JY8n57EZZ
	 1jHpLFXtcSB7dR8fy27albCTMcUpeSCwbY9MNusAKHtAVuZxR9tffT5fAm4T6RcbmCEjV
	 7WY5LNkLitPXGj6dB0/vSC9eHDx3a+hH8ME303m0brwMc6kGQDSpAEnTSCeH7GNbKGzhP
	 XdfGBWj/ar+l4LZu9b3229ITUGVIIZZ+k+QOkSyezxeKZmbXo9Nx+0FjBj9TRReu8VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsxpUb6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8590606A31F
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsxpUb6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347F1F000C6;
	Mon, 23 Nov 2026 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438023;
	bh=azj7nPjS7dDHmaER7U9r8isuCnEXUkXJznmtZ7YYcHE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fsxpUb6IAvZ59R2uPDa6h/9llubFZR24N3YlivRkr9v1NhliG/C6vYwRRLXHWsAAu
	 M2lITllvcgPCcOi3D/xTw1SsscOx83Lw6KUkPT1aeIGofOKdxlHaGGDVx8Fpf7tygU
	 N6PCAcL/9bveS8yecHGXPUCV5JUNTMhmw7aM4d7OInn0c/KnH+Ve1i7dZ/Y/ebmsp6
	 oJFXDNv7B3OBc1D+hydyZmy5A8FNxIG5tE9QzkRKZ1pf360Grr6GtYTtnLju2N4flf
	 lFUZYvUqvpQpX1/jQtbCZXqsfEhJ5og51hmTZWsYIagkhCOBDdO/8u42VfKwCGasxs
	 OMmG62Leg4W3g==
Message-ID: <sashiko-outbox-229247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v7 1/2] mptcp: sched: add subflow avoid flag
 for BPF schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261123123730.3265284-2-kalpan.jani@mpiricsoftware.com>
References: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
 <20261123123730.3265284-2-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:47:02 +0000
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
- [Medium] mptcp: sched: subflow avoid flag is unused by MPTCP core
--

commit 0e785089a6ea448f3459342cf4c1519134065b30
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: sched: add subflow avoid flag for BPF schedulers

This commit adds an avoid boolean to struct mptcp_subflow_context, a
mptcp_subflow_set_avoid() BPF kfunc for struct_ops packet schedulers,
and the MPTCP_SUBFLOW_FLAG_AVOID diagnostic flag.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1e59072d478c9..0ce59eb093df6 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -165,6 +165,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflo=
w_context *subflow,
>  	WRITE_ONCE(subflow->scheduled, scheduled);
>  }
> =20
> +__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *s=
ubflow,
> +					 bool avoid)
> +{
> +	WRITE_ONCE(subflow->avoid, avoid);
> +}
> +
>  int mptcp_sched_get_send(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;

[Severity: Medium]
As reported by Paolo Abeni on v1 [1], what does subflow->avoid provide
when the MPTCP core never reads or acts on it?

Outside of subflow_get_info() exporting MPTCP_SUBFLOW_FLAG_AVOID for
diagnostics, nothing in the MPTCP core checks subflow->avoid during
scheduling, transmission, retransmission, or activity evaluation.  A BPF
scheduler calling mptcp_subflow_set_avoid() only stores a boolean for
that same BPF scheduler to read back before calling
mptcp_subflow_set_scheduled(), without changing any core subflow
handling.

[1] https://lore.kernel.org/r/74e1a388-2d49-4dea-96d1-4a7844a63b08@redhat.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123123730.3265=
284-1-kalpan.jani@mpiricsoftware.com?part=3D1
