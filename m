Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDC415F2F
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676560; cv=none; b=TjmOfwyji2Npi+VLbhjT5YtatGlAZL+0paCipigvIO4qyd58UTMacYCV/0DD3ZXY/A03tuAVVz3XL/SJUAAQHYnLSJ0yITSpF0tO8Jgs+RoaodZv1LCCV9EjCwlYUSE1Zo3aZUrFxqs+aognGR5eVAUfrp+gU8EnhKJy1trjqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676560; c=relaxed/simple;
	bh=xDnOgkK3SUEQEDlFUQ+xZVXMkGT/BmfVrMwST7oJebg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OlJ6Cjqr/g9McIEl0GgbFs3yhCkPkYuHE2YSVDOWknmblPyvEbsU2ohiZAquHJ2z/dCB3O8h9YnwE2LszVZcCjmWRgUaorMAgX3JkEbpejbz4QZPsIvMaIvA/tCtWY7T//PFTkxDIz+QSRlUdAHsjxWhzqBgMrARPZhMk/tSa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxzSsqMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxzSsqMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE81F00A3A;
	Tue, 25 Aug 2026 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787676558;
	bh=jwPKMTf3fBHB9+JW0N2NMB17+JYPeQo7J9bomKxQUpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxzSsqMh/hto9VNJnpxlOJsr11BHPO5ONlMZzh5lN+dO7ASt5exBONhQScW8BuEAD
	 Q41spNu4YqRttivY/HfDpx2Wzc2eiWOpY1oXnHrT6BkoiHDRLhD7iyUufxXaBOVaYu
	 21lj8KJhvVv4IqM4fKwIbTc3by32WOLqXw7HSOnB6AM/ZMNE6g7rK74GKw78eLVLvw
	 06z8GtFPx9DfXRQ32AkpKB8PZi4AjMOWiRE/lmZbJz55rzbg4PznyFpgmwgvgjH1Kg
	 kt2ujgfNjaw6ZzRpOpGpeMKKOg7axuvJGvzBswv+Zes0JCqTdLrrZh6tV8IH2vgsy5
	 V75zhr9vWE3Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 07/14] mptcp: pm: userspace: fix address ID overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-7-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
 <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-7-a92309d121ca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 16:49:18 +0000
Message-Id: <20260825164918.ABAE81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Spurious failure in mptcp_userspace_pm_append_new_local_addr when =
allocating a new ID if an address with ID 0 exists.
--

--- Patch [7]: [PATCH net 07/14] mptcp: pm: userspace: fix address ID overf=
low ---
commit 88d3db755130c825590998e405b9b270ff919205
Author: Qing Luo <luoqing@kylinos.cn>

mptcp: pm: userspace: fix address ID overflow

This commit fixes an overflow issue in the userspace PM when all MPTCP addr=
ess
IDs (1-255) are exhausted. It adds a check against MPTCP_PM_MAX_ADDR_ID aft=
er
calling find_next_zero_bit(), returning -ENOSPC to prevent storing an
incorrect ID 0.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index b94fbb483bf94..fab16d953dbfe 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -69,6 +69,19 @@ static int mptcp_userspace_pm_append_new_local_addr(st=
ruct mptcp_sock *msk,
>  	}

[Severity: High]
This is a pre-existing issue, but does the loop just above here falsely
trigger a match if both IDs are 0?

In the preceding loop, we have:

	id_match =3D (e->addr.id =3D=3D entry->addr.id);
	if (addr_match || id_match)
		break;

If needs_id is true, entry->addr.id is initially 0 as a placeholder. If an
existing address in userspace_pm_local_addr_list was previously added witho=
ut
an ID attribute, it might have id =3D=3D 0.

Could this cause id_match to evaluate to true (0 =3D=3D 0), breaking the lo=
op
prematurely and leading to a spurious -EINVAL failure? This might completely
break dynamic ID allocation and permanently reject new incoming or outgoing
subflow JOINs that require an ID.

>  	if (!addr_match && !id_match) {
> +		unsigned int id;
> +
> +		if (!entry->addr.id && needs_id) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-net-mptcp-=
misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org?part=3D7
