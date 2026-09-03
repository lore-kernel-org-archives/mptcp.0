Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7B4AF9EA
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442090; cv=none; b=i7dnHm387sn0zP+ab6fO75vfQ3RlZCjqzm79W/tNkReuhf/z+WaKHu0iraq1dbD7eRgEWWP5nNZEybTdzuSsJbNaMbQenFRhBywLgjGlOaRDdazYI2UagCkk/adzzrL715Fx0vqHjuOuesl4djAA8/sQXQz+WGitm65nAlCrTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442090; c=relaxed/simple;
	bh=dx0kjLF5oPUYVWY/11I9G9mXw67+8osaJOoq+EpE/8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NL+kQaPzujyfs5bD+A4+fBg16VpdLM3IGAETlSjJIZ1RVujVqOZTDo35t7c3bQGfAvLJvLpPz4mkyUsZO7dK2RaygvI8Bq7tq1oCTH+16P6rZH6yDGJTV0EgRvLldEEbIRB6puYtHOD5UFDmmfzSpYd7n8llT4Lmo4GWE2LV9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKMB4h1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKMB4h1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7C11F000E9;
	Thu,  3 Sep 2026 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442077;
	bh=GvjmdXpnZRAnQD8JK3L8swHCqOO6UKbG19xVnd/fpDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKMB4h1N/JoJ6vWSHS607HRTNY0G5KlYUPVGTcRJ6f663StAhJkeNZ6ubbzML5Kh0
	 QhSBJlSIr3Cx+FBITvbwbEwEbmLs51sjUnNTv7hTeHvuw8urWV0/588IpI+jXpF2VB
	 6e6xtIIlkADTh+E6BbMQvOVxoX03BPJO+5QJPXjJTF+Dxrgzjp+2jiQfaIo3bOFTYu
	 Ko3HQ/U9pTQ8JRDcXt3QRKtOMhvne6tUPVwtZWn+dSa6+gUNNV0yxux72hv7B8J4zh
	 KWZjzMIzzm+EhiUj2qWDiE8eW5OWXbnrJ26i1ZnpBgjhmQXiqvjhhCA3A1cJnbyaxp
	 usGAlKhSBASUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: pm: userspace: cap
 extra_subflows on Netlink subflow creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903131416.1112393-4-cui.tao@linux.dev>
References: <20260903131416.1112393-1-cui.tao@linux.dev>
 <20260903131416.1112393-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:27:56 +0000
Message-Id: <20260903132757.5A7C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the error path u=
nconditionally deletes and frees a local address entry, even if the address=
 was pre-existing and shared among multiple subflows.
--

commit 147f86e2aec9bdeead6dcc987672ad229b2286ec
Author: Quanye Yang <quanyeyang@proton.me>

mptcp: pm: userspace: cap extra_subflows on Netlink subflow creation

mptcp_pm_nl_subflow_create_doit() also increments the u8 extra_subflows
counter without any limit: a client with CAP_NET_ADMIN can create more
than 255 extra subflows via Netlink and wrap the counter back to 0,
with the same effects as the MP_JOIN path now bounded separately:
the underflow guards warn on the next subflow close, and
mptcpi_subflows_total reported to userspace is corrupted.

Link: https://lore.kernel.org/all/20260902-mptcp-pm-extra-subflows-v1-1-685=
40a866e5a@proton.me/

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f723a134356f3..bede75a2e2586 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -427,6 +427,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *=
skb, struct genl_info *info)
>  	local.ifindex =3D entry.ifindex;
> =20
>  	spin_lock_bh(&msk->pm.lock);
> +	if (msk->pm.extra_subflows =3D=3D U8_MAX) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		GENL_SET_ERR_MSG(info, "too many extra subflows");
> +		err =3D -ENOSPC;
> +		goto delete_addr;
> +	}
>  	msk->pm.extra_subflows++;
>  	spin_unlock_bh(&msk->pm.lock);
> =20
> @@ -434,9 +440,11 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *=
skb, struct genl_info *info)
>  	err =3D __mptcp_subflow_connect(sk, &local, &addr_r);
>  	release_sock(sk);
> =20
> -	if (err) {
> +	if (err)
>  		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
> =20
> +delete_addr:
> +	if (err) {
>  		spin_lock_bh(&msk->pm.lock);
>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);

[Severity: High]
This is a pre-existing issue, but does this error path incorrectly delete a
shared local address entry if the address was pre-existing?

When mptcp_userspace_pm_append_new_local_addr() is called earlier in
mptcp_pm_nl_subflow_create_doit(), it might match an already existing local
address instead of appending a new one.

If the newly added extra_subflows limit is hit (or if
__mptcp_subflow_connect() fails), the code jumps to this delete_addr error
path.

Because mptcp_userspace_pm_append_new_local_addr() did not allocate a new
entry but simply reused the existing one, unconditionally calling
mptcp_userspace_pm_delete_local_addr() prematurely frees the shared address
and decrements the local_addr_used counter, potentially corrupting the state
for other subflows relying on it.

>  		spin_unlock_bh(&msk->pm.lock);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903131416.1112=
393-1-cui.tao@linux.dev?part=3D3
