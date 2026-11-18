Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979340;
	b=mo31EEIy+AP4AkWBCQaQvmREq6VzYZqJLK9x7CX7VG3JsXdS1/horfjjCIwOcXMJZoT8
	 ztqyyopTcPse6anrQrDPFHpmNQ0bXn9k1iTGevlrEyupu/tRV71PJl6diti7PzY7fiQdQ
	 1mNQ0VXxd9iigZY0toOGaB4rGMsclyW0uDrDrHrP31D3/zrz9ltD7AcqnKvgFslsCx2UG
	 +jLsEYfWZtCuFHHCRXG/zeYC9jcrnzpzWYVN8qb1Olj0peyji8WPEJTRQ4ZUh2kXoAq4a
	 R0+3mHdtwniZmZ5aeTTj3r0tW5F8xAZPjNVRAgYBFRgQ1YRmWfv3Picwa/qSjO6WGNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=haQg/B4V2EP/4GzpF0dupjRqUlXc84/hvrYZPMtkeGk=;
	b=IqGQlZjdOyDXZIkBmrPP9+zVYBYxpqvzpvX8lDiuog1N27L1LqAtcDV3BoPWj78xsmNi
	 CGTykcNwQPZLa3NjWOxiGn2xDU62Wdqq0yILBS8eMpm+8Yrh2V6VOzcYfBDR2Y4OR+uQq
	 HY73gQYVqYi2fryuw7h7Ndm8OOIaKLJFX+xXpwEkBpdFNb51ij3m9SgLC/+h+WhrYfF45
	 7JiR2tg6mveGMiyLlhv0JIb0DpjWfC9XtCU9NaMRymdBz/WIpMHmNdvvbQiCds580dSUq
	 tyU73B/jAMDPamuedEgcqc3+SLcGZilqBPKodIAclukyDfIRS4+yGO3eltA/eKKGFjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9O6miAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD02606A32A
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9O6miAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAFE1F000C5;
	Wed, 18 Nov 2026 05:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794979340;
	bh=haQg/B4V2EP/4GzpF0dupjRqUlXc84/hvrYZPMtkeGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9O6miAAfWj8tirgSVFs2yDihxdYtRw37Iy5ZKQncMwxfxZFRWohse+kQ9zsBUiJK
	 BuB7P6HMyG/HhycUY1aCXAS2xz0A7hvIIm/OR7kxvLz496XiBs3/S+Rf8p7z3nbmm1
	 ZeUirwI2g6u9D4eG98zXmwri6MwiuCu3cjXNmTi4qGJ53pmS4aa25+0kPPzgydZkQA
	 DpUKYtp4T2o10z3xPXEW9Ph9wT3epkG3IUMlXBx0HcxooOKTQJ9EUGZlMHs38u3ECf
	 K3svHlDEPvBVyRP3xQEBMB+DjKc1IOipnS+xy402VpcP6Ol9nkSVRnm5RPfGXov5HO
	 LFsf8vWnf/snQ==
Message-ID: <sashiko-outbox-220155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/3] net: bound receive window predictions before
 narrowing
Reply-To: sashiko-reviews@lists.linux.dev
To: "lei lei" <llleigoing@outlook.com>
Cc: =?utf-8?b?bXB0Y3BAbGlzdHMubGludXguZGV2?= <mptcp@lists.linux.dev>
In-Reply-To: <20261117052200.1507847-3-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
 <20261117052200.1507847-3-llleigoing@outlook.com>
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
- [High] net: invalid handle and author mismatch in Signed-off-by
  trailer
--

commit 0e17123a2c1e28d81f7aa6b0170c8d97f7b356e5
Author: lei lei <llleigoing@outlook.com>

> net: bound receive window predictions before narrowing
>
> tcp_rcvbuf_grow() and mptcp_rcvbuf_grow() compute growth terms in u64 but
> accumulate the predicted receive window in u32. The prediction can wrap
> before conversion to a memory budget and application of tcp_rmem[2].
>
> For example, oldval=3D16 KiB and newval=3D4104 KiB produce a slow-start
> window prediction of 4 GiB + 8 MiB. Storing it in u32 leaves only 8 MiB,
> so the memory limit is applied to an already truncated prediction.
>
> Keep rcvwin in u64 and promote newval before the initial shift. Clamp
> the completed prediction at INT_MAX before passing it to the existing
> int-input window-to-memory helpers. Since scaling_ratio is a nonzero
> u8, the required memory is at least as large as the window. Predictions
> above INT_MAX therefore already require a saturated receive budget.
> The helpers' return saturation and the existing tcp_rmem[2] limit then
> provide the appropriate memory bound.
>
> TCP and MPTCP loopback tests using small warm-up reads followed by a
> queued burst of about 4 MiB previously left the budget below the
> configured 64 MiB limit. With this change, both reach that limit.
>
> Fixes: aa251c84636c ("tcp: fix too slow tcp_rcvbuf_grow() action")
> Signed-off-by: lllei <llleigoing@outlook.com>

[Severity: High]
The Signed-off-by trailer uses the single-word handle "lllei" instead of a
real human name and does not match the commit Author header ("lei lei").
Documentation/process/submitting-patches.rst requires a full real name in
Signed-off-by that matches the commit author.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117052200.1507=
847-1-llleigoing@outlook.com?part=3D2
