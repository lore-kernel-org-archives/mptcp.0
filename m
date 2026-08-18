Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA236F429
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045056; cv=none; b=GQCfoPjEp3j50Xb7pGU1msy6Fj92ipmcsf2DmU+IbSHZRt13Bnk00hr2jQJlmBxuMEeSlE0HbQ/1Qr9QBxhYaukRjjDT1WRN8RE7K0lCdB3mUoXcpmUKMqnBGKsODLcZiPA4mGonfFRZnm2HrrG9mBuIYG+V0BTN3RCePcraeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045056; c=relaxed/simple;
	bh=HIEJnKHJ/6VHLp43d2R+JbqDceU32OqW8vSdFdBPFIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n1HKI1Ugca7U6As/jrp8UqCQKytM7A3MY4T6ZTp3abZZ40h+rtzrJzYD7zzkkxjf7K2auR/Fs3C7rPBiuGg8L8UtkKyRboq+gUhofKoC498+vIV0ZoOSc73zdbpcnbb1wKmZqys8gcSLGdDaOvmURJNv7BAL1c5u/frGLBVLvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdxwbEsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdxwbEsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9F81F000E9;
	Tue, 18 Aug 2026 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045054;
	bh=Qrulf9P++V2Fd+OzhXoQazlEjdDZfV0d958yaoA2jPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdxwbEsQaYck0r/Kz5oUWMLRoBuRIopgVi0PDQMMQxPX6IVe1z2iz0W2iwfQF7UxU
	 tBDkSo0EivIQktgcUu4diD6wF1dB0vx9ctSLArOxIc51O2cWNNUFb2PzY4aaf3t7I8
	 Qvc0qwJ7ZFDxQaybVCM+2+PPYeEaJ1UKkSFKG3Bz57rx8cG8kX0nLKaOOPMniEnCYw
	 YEvvM04pRPo9SVexc0YXAQnKkQzU9/nnf6jFVas0lLLqiC13EmAPZ1aTA5nn0b4bct
	 C57Vot0mqc2XwhwERAJj/A04u/+YAF+/9chlrp7ZRLODd49ScAxBgTR3hrZ8r1m/zh
	 mC2t1K0zdfEbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next RFC v4 1/2] mptcp: add MPFailFallback MIB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <chenguang.zhao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818091417.2200986-2-chenguang.zhao@linux.dev>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
 <20260818091417.2200986-2-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:24:14 +0000
Message-Id: <20260818092414.BB9F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added MIB counter `MPTCP_MIB_MPFAILFALLBACK` is define=
d and exposed to userspace but never incremented anywhere in the codebase.
--

--- Patch [1]: [PATCH mptcp-next RFC v4 1/2] mptcp: add MPFailFallback MIB =
---
commit da81a414aec944549813cb91e3dbd055d9e87a03
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

mptcp: add MPFailFallback MIB

This commit adds a new MIB counter for tracking TCP fallback after accepting
MP_FAIL.

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 608cb568897cf..648d4dbca7646 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
[ ... ]
> @@ -88,6 +88,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>  	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
>  	SNMP_MIB_ITEM("MD5SigReset", MPTCP_MIB_MD5SIGRESET),
>  	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
> +	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),

[Severity: Medium]
Is this counter actually incremented anywhere in the codebase?

It appears that MPTCP_MIB_MPFAILFALLBACK is defined and exposed here, but it
is never passed to MPTCP_INC_STATS() or used in tracking functions like
mptcp_try_fallback() within this patch.

Without being incremented when a fallback actually occurs, won't this count=
er
just permanently read zero when queried by userspace?

>  	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
>  	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818091417.2200=
986-1-chenguang.zhao@linux.dev?part=3D1
