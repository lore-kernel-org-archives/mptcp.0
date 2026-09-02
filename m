Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9E4AA1C7
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364163; cv=none; b=Yv1pK5F+mxMC7nTxa5+EyRAL+Ue5EQ0hQU5SSYo2J/AfT3NnesDfhjskWmxmmYKb2PFrsGQN34K8IN3e+4gRMFaSXzh4z8Jgzz5WnMPmXBSWM21XUB44GAlTiNTmjMflyQWnRFgEhqxUlwoKbwiwHjVC4liDIQLcGnPRmdDT+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364163; c=relaxed/simple;
	bh=6eHBNly9SpJasDa4IFuhYpjV+1lAJRgOrgbdsVZAJ3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUnaww4cNt3Pj8x+R3ANAsVkhQ0vTgQZZ/803OfcvZmi4th4dwQ68yeoQK8ft3G28jJ5do8JkDqzRXDpVwPHU5JPq6bmVUDUDek7Mu0R+i46lafTzGWT/iJ7z8JN+ZRiYbCD/kIwGnlQ3yn52Wb4HsfNzuCG4H7U38JMUNEnHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdZotmrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdZotmrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCD1F00A3A;
	Wed,  2 Sep 2026 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364160;
	bh=Opj5OIDu3myykWA1k8DvlFmFbUHW8xQ2lZ2c86TPH6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdZotmrUombmd9Z/HbQOMlzxDqfaCmvDPHBBKigRYr6PP9Votdz8hkUb3cknForkt
	 93kNCOVcawqNv7U4kFXrf4bst4BShe6gt6sXLTxnSKBxFaQGL/SQGd/8quHOkl0WOa
	 mKpu7uv0y7XlQzz14ukMtXui9vRBUyBg5FXrbteMyp57DJbu9cjShH75m2pgV0ep5V
	 dM2FFC0JUmpVOyOKuMLuidshT3k8fClIIphhLtxvGuILHfbwWbzNFfdUEWSqlGEHCN
	 PftudJISs6f7rIln0q/JhXY5qoGqhLc8l3+gEbQCTtNoWklanPtWxh7B+bhMU0K24o
	 tRDLhCJIBIFjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: pm: cap userspace extra_subflows at
 U8_MAX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Quanye Yang" <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
References: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:49:19 +0000
Message-Id: <20260902154920.52DCD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error paths in mptcp_pm_nl_subflow_create_doit unconditionally del=
ete pre-existing local addresses, corrupting state and underflowing local_a=
ddr_used.
--

commit 09af196be93604649e0aad5970acd8810bf5dcca
Author: Quanye Yang <quanyeyang@proton.me>

mptcp: pm: cap userspace extra_subflows at U8_MAX

The userspace PM increments extra_subflows with no upper bound. The
field is a u8, so the 256th extra subflow wraps the counter to 0 and
the next close hits WARN_ON_ONCE().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index fab16d953dbfe..6d798dd967029 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -427,16 +427,22 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff =
*skb, struct genl_info *info)
>  	local.ifindex =3D entry.ifindex;
> =20
>  	spin_lock_bh(&msk->pm.lock);
> -	msk->pm.extra_subflows++;
> -	spin_unlock_bh(&msk->pm.lock);
> +	if (msk->pm.extra_subflows =3D=3D U8_MAX) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		GENL_SET_ERR_MSG(info, "too many extra subflows");
> +		err =3D -ENOSPC;
> +	} else {
> +		msk->pm.extra_subflows++;
> +		spin_unlock_bh(&msk->pm.lock);
> =20
> -	lock_sock(sk);
> -	err =3D __mptcp_subflow_connect(sk, &local, &addr_r);
> -	release_sock(sk);
> +		lock_sock(sk);
> +		err =3D __mptcp_subflow_connect(sk, &local, &addr_r);
> +		release_sock(sk);
> +		if (err)
> +			GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
> +	}
> =20
>  	if (err) {
> -		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
> -
>  		spin_lock_bh(&msk->pm.lock);
>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);
>  		spin_unlock_bh(&msk->pm.lock);

[Severity: High]
This is a pre-existing issue, but does this error path incorrectly delete
pre-existing local addresses?

If a user issues MPTCP_PM_CMD_SUBFLOW_CREATE using a local address that was
already appended, mptcp_userspace_pm_append_new_local_addr() returns success
without allocating a new entry or incrementing local_addr_used.

However, if the new subflow connection fails (or if the newly introduced
extra_subflows =3D=3D U8_MAX limit is hit), the error handling path blindly=
 invokes
mptcp_userspace_pm_delete_local_addr(msk, &entry) inside=20
mptcp_pm_nl_subflow_create_doit().

Will this inadvertently destroy pre-existing PM state for existing subflows
relying on that address, and underflow the 8-bit msk->pm.local_addr_used
counter since it wasn't incremented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-mptcp-pm-e=
xtra-subflows-v1-1-68540a866e5a@proton.me?part=3D1
