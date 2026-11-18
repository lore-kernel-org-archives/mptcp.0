Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979341;
	b=mtexxm/1/dplE7dA4tcAGCMSpe1pvBBDSdZRICt0sOynyjMgSxFErb8Tstl64t4FFZx5
	 GfVBMR93ReiK0OCZa3ptmkCdY+EYpoOqU0Yxmjnqm4tg96nBUyfL30LfqRbtTOyoKvM94
	 HaKH9InQd+u3XJQv9rVwZ9sXABK3uGYRPicMkWa0/aIjfRHPfk5dxJlk87FCaQuTbCdQ8
	 qwxEgNq7H11JChBJ+JXL73Yy9ZFtCmsopajuG56I/uVeXljDR9b9q6y/ciX3exdO4Ht9w
	 UlK5y7eb6IrkkXpzgNaAThhHzlJPyz8bjEAoGnLB0m0t+8wAvdnqCV1nqL1EphfvTrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979341;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JK/wSIqENk3uGHJxtgKTesz1KtVMquWy35xeqYmTLwU=;
	b=ePYfpd7wOuYN5Vn3RmbTScHJO/vJPWi/P8Z50rFfvbDEFFMIDyeFykj2+2S3lGSSDFNo
	 D8Ju8a56I56nyFoicg5SzFqn9RgGGBaUDTVHrr8RqczLni19yqH7pwqUYcR0HSgqWSD9k
	 gsiI/7lFrZXq28eLEI5hpWvhRWhDgdJVSWxh+NTjPFfyp+oM7MjCMrTFBWVCZJx2E1+Vg
	 RrKoX+uZSEq829Hu67WiJZTjk+ZJpukP/4vQKm8N1M/wnIhUU6D4zTG37IYhqIt2Wo60p
	 pmUxbPZuptCj2KJcrnKjC7uSjJtvk5h609CGgaOn2+Ry742ylD+cO9QUCqtVDUo9gAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/15B4IO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4F606A32A
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/15B4IO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7A71F000C7;
	Wed, 18 Nov 2026 05:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794979341;
	bh=JK/wSIqENk3uGHJxtgKTesz1KtVMquWy35xeqYmTLwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/15B4IOA7/gpOAEm40aeufAwKT4v/D2zPaNZOR58qP9xPJUkG7Dbnl4pyNZV8tFU
	 fnbXyJNexRFMSouKCXoDmEEy/qRiKGFRIGVwWw3HjjwcbA27+7ggva1Id2BMNBWfnT
	 7ZsX48axoMCE2hi+a9f5npsBQ/JTMlLOZ+K9uqQjjyqIjGxTBKuCxuMkKPcG19Fl0+
	 pferVlkCNN/IUa9QTNy/o+S9eFSnjHhM5p22aCLg421VNZMkgpg72mdYI7ZGwpkzkK
	 QfEZV+J+88ZTCLaAr6Lm6i58GZoe4bBF6ZP7DypqrHlwgAcLbbjDtXD38caKn+8U0I
	 peZrAwM/dG/5A==
Message-ID: <sashiko-outbox-220156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/3] mptcp: exclude MSG_PEEK from receive buffer
 autotuning
Reply-To: sashiko-reviews@lists.linux.dev
To: "lei lei" <llleigoing@outlook.com>
Cc: =?utf-8?b?bXB0Y3BAbGlzdHMubGludXguZGV2?= <mptcp@lists.linux.dev>
In-Reply-To: <20261117052200.1507847-4-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
 <20261117052200.1507847-4-llleigoing@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:22:20 +0000
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
- [High] mptcp: invalid Signed-off-by trailer using handle instead of
  real name
--

commit bf35feefb3ca938f4410fd363b5311a7fad1ae8f
Author: lei lei <llleigoing@outlook.com>

> mptcp: exclude MSG_PEEK from receive buffer autotuning
>
> __mptcp_recvmsg_mskq() passes bytes copied by MSG_PEEK to
> mptcp_rcv_space_adjust(), although those bytes remain in the receive
> queue. Repeated peeks count the same data as new application
> consumption and can inflate the receive-memory budget. Subtracting the
> unread queue at a measurement boundary cannot undo that repeated count.
>
> The receive path originally skipped this adjustment for MSG_PEEK.
> Commit 581302298524 ("mptcp: error out earlier on disconnect") moved
> the adjustment calls without preserving that check.
>
> Only adjust receive space for non-peeking reads. Keep the returned
> byte count unchanged.
>
> A loopback test leaves a fixed 32 KiB queue unread and peeks 4096 times.
> Before this change, sk_rcvbuf grows to the configured 8 MiB limit.
> Afterwards, both the budget and the queue remain unchanged, and a
> subsequent consuming read returns the original data intact.
>
> Fixes: 581302298524 ("mptcp: error out earlier on disconnect")
> Signed-off-by: lllei <llleigoing@outlook.com>

[Severity: High]
The Signed-off-by trailer uses the single-word handle "lllei" instead of
a real full human name and does not match the commit Author header ("lei
lei"), which violates the Developer's Certificate of Origin requirements
in Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117052200.1507=
847-1-llleigoing@outlook.com?part=3D3
