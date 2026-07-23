Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212343CE79
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803714; cv=none; b=clka5rjcFcJUTPeI0+MycHnqXKmAjGBz/6cXCUJQ+y6rB+BkOQx5Ny29fxI26CTPoUBzBvW58vrC1nRxpujKoGqp67NerUdlLhwMRmdxTmacUhoI3bD3BuQZAZg5u72fRdrfXtDfwUWawNsgxlahdSjlH+8tpgONStnhbNW5fGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803714; c=relaxed/simple;
	bh=NXGd6Lism5/nH7BxRNve+gF8hyKb2LHeDAOtfhNSPhc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=J92aBtQGUzrGs7NlfxV8qhuSACruIznHsd3SekCL5O6uNW8LyiUl2re8qbYPI/RQp3FZgJ+KiE1MGybIkxRYajAouEHknOua3WZmgLAn9YpYi7a4ghpdm+juXNhIqTYF2wDH+3JUlNdGMaQnB1wtUjnbU0oOLy7GgBMsFj/gbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJ6B7t/Y; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJ6B7t/Y"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784803711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CusY4yasjA0rpwjEX0TeiX4LdGf5wVS2epko2/fLlcE=;
	b=RJ6B7t/Yy7McKs+Shpr0oqSHeO9GQphr2yT2lNm8tgMtN4hP1BJthR3UK4DMVV5NYqKeCx
	xSDm+oInT8B6uw7eJxkn68cGb8xGXtf7XRMhZyVHak5DsUS8pbU2fPXBhqwPHAyVYxB0lo
	J5qH4AinxLUj5LABAJ04XQkI13bpVkw=
Date: Thu, 23 Jul 2026 10:48:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <b05aee1e4487409adb2fae8b665454c64b760a24@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 1/2] mptcp: pm: userspace: decrement
 local_addr_used when remove
To: "MPTCP Linux" <mptcp@lists.linux.dev>
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <20260723-localaddr-v1-1-ce84b865594a@kylinos.cn>
References: <20260723-localaddr-v1-0-ce84b865594a@kylinos.cn>
 <20260723-localaddr-v1-1-ce84b865594a@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

July 23, 2026 at 5:55 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan@=
linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:


Hi Matt, Hi Ge Liang,
=20
Sorry=20for the confusion. I didn=E2=80=99t notice you(Geliang) had squas=
hed this patch in your prior submission, and I didn=E2=80=99t mean to dup=
licate work on purpose. My
apologies for the oversight.
=20
Separately,=20I recently spotted a TODO item in the userspace PM code tha=
t requires
adding refcount support for entry. I=E2=80=99ve been going through the re=
levant source
code to get familiar with the logic these days.
=20
I=E2=80=99m writing to ask if you have a timeline to merge Ge Liang=E2=80=
=99s patch series
anytime soon. This is not a reminder by any means. If the merge is still =
pending,
I can build my development work directly on top of his patches to avoid e=
xtra
conflicts.
=20
Thanks,
Gang

>=20
> From: Gang Yan <yangang@kylinos.cn>
>=20
>=20mptcp_userspace_pm_append_new_local_addr() increments msk->pm.local_a=
ddr_used
> when a new local address is appended, and mptcp_userspace_pm_delete_loc=
al_addr()
> decrements it when an entry is removed via the subflow destroy path. Th=
e
> mptcp_pm_nl_remove_doit() netlink REMOVE_ADDR handler, however, only un=
links
> the matching entry from msk->pm.userspace_pm_local_addr_list via
> list_del_rcu() without touching the counter, so the counter is not chan=
ged every
> time userspace removes an address by id.
>=20
>=20Decrement msk->pm.local_addr_used under the pm lock right after list_=
del_rcu(),
> mirroring the increment site, so the counter stays in sync with the act=
ual
> number of entries left in the list.
>=20
>=20Assisted-by: Codex:GLM-5.2
> Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
>=20diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 73094bdbdbf2..6402226a9f0e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -334,6 +334,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, st=
ruct genl_info *info)
>  }
>=20=20
>=20 list_del_rcu(&match->list);
> + msk->pm.local_addr_used--;
>  spin_unlock_bh(&msk->pm.lock);
>=20=20
>=20 mptcp_pm_remove_addr_entry(msk, match);
>=20
>=20--=20
>=202.43.0
>
