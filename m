Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0513441625
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515506; cv=none; b=B00B+nbbPgvSf+tnAOw0s+qZ8dKNpt92GG6JjmkDNzQzvoZWfuOsL7VxCfC/Nv7S5qpB9cjznkUVer4+Pi36jRQiAbljaFikbaSObMlc7B3rtPGYJlO05R41+IM65bd51H4P0/QmZme66gWJw9dGgLpDZ2PB5k+TGSTC4Z0KAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515506; c=relaxed/simple;
	bh=pGKeA8A2eAw48iOL9qIfokaKT2yiFpjhx3OFcUojSjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRY5Y3g0NPytwEsqFiLACw6r8yVeqwfrZFD3uCoV+CGzfCXIP5uAG4hv3VALCW/Xa0jFHRCIyZWXyKmH8QirwIZhEm0h3Etn4k4ckeOt9rXYbtcCePjrN0EfYpzaVbYHbpyVya7GyCSy70M1ooT7LGe2vzN/c+ilIADFwLVaXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbvHLCSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbvHLCSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2D41F00A3D;
	Fri,  4 Sep 2026 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515504;
	bh=jb1CpjeQPKgYzm1hNGA7ihKOFRUuTeE8CFT8Obi5/Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbvHLCSboqN+8WO5opwNCDC+xLlRVo4GCVIln0rx05aPU5XD9BEMfSw6CLPLPXkv4
	 0CGVlJboygHV0Qfnfh5YwBX+72IBq0qzEHdJ6gpZWNXPyK5VBiBvqF1EZPtgFeyQfB
	 YYEAKez3hMB5YE3NF6v02f+EKaBTuehYgBriiDuhqOJ/mswKe0HrrJd9yBJ+LZLUkj
	 37Mn23OjuXgvtJFNSVDQOJprIKTG1MTfzVtilaKwpE7yRTe9/5F09m0ADJvRi5Ix+K
	 sb6RdD9jHMq6ksnM2zD+MBhbhTm/7135NrEM3o4CtFmEyWwdk5V0yTkT69y3cpDx9C
	 GiViGqKiyAY2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 6/6] Squash to previous one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904093531.20023-7-gang.yan@linux.dev>
References: <20260904093531.20023-1-gang.yan@linux.dev>
 <20260904093531.20023-7-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:51:43 +0000
Message-Id: <20260904095144.5B2D41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Bypassing RCU grace period in mptcp_pm_ops_init() when the PM rema=
ins unchanged causes Use-After-Free and data races.
- [High] Publishing new PM ops before initializing its per-socket state exp=
oses uninitialized memory to RCU readers.

Pre-existing issues:
- [High] Module reference count underflow when falling back to the default =
path manager.
--

commit 261318f67b36cf52f532df8226134e77ddd65cd0
Author: Gang Yan <yangang@kylinos.cn>

Squash to previous one

This patch updates the MPTCP path manager operations to use RCU for concurr=
ent
reads. It modifies mptcp_pm_ops_init() and mptcp_pm_ops_release() to safely
handle the assignment and release of the ops pointer, and adds RCU read loc=
ks
in the subflow paths.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 64244a1a01bca..d581d11b350f2 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
[ ... ]
> @@ -1158,23 +1166,44 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>  			      struct mptcp_pm_ops *pm_ops)
>  {
> -	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> -		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
> -		pm_ops =3D &mptcp_pm_kernel;
> +	struct mptcp_pm_ops *old;
> +	bool need_sync =3D false;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	old =3D rcu_dereference_protected(msk->pm.ops,
> +					lockdep_is_held(&msk->pm.lock));
> +	if (old =3D=3D pm_ops) {
> +		need_sync =3D false;
> +	} else {
> +		rcu_assign_pointer(msk->pm.ops, pm_ops);

[Severity: High]
Does this code publish the new PM operations pointer to readers before its
per-socket state is initialized?

If msk->pm.ops is updated via rcu_assign_pointer() here, existing RCU reade=
rs
like subflow_token_join_request() could dereference the new pm_ops and exec=
ute
its methods before pm_ops->init(msk) has run below. For example, if a reader
calls mptcp_pm_get_local_id() and then mptcp_pm_is_backup() in the same RCU
section, it might see the new uninitialized pm_ops for the second call.

> +		need_sync =3D !!old;
>  	}
> +	spin_unlock_bh(&msk->pm.lock);
> =20
> -	msk->pm.ops =3D pm_ops;
> -	if (msk->pm.ops->init)
> -		msk->pm.ops->init(msk);
> +	if (need_sync)
> +		synchronize_rcu();
> +	if (old) {
> +		if (old->release)
> +			old->release(msk);

[Severity: High]
Could this bypass the required RCU grace period and cause a use-after-free?

If old =3D=3D pm_ops, need_sync is set to false, skipping synchronize_rcu().
However, the code still calls old->release(msk) immediately here. If
concurrent lockless RCU readers (e.g., in subflow_token_join_request())
are actively executing path manager methods on the socket, old->release(msk)
can free the per-socket state while they are using it.

> +		bpf_module_put(old, old->owner);
> +	}
> +
> +	if (pm_ops->init)
> +		pm_ops->init(msk);
> =20
>  	pr_debug("pm %s initialized\n", pm_ops->name);
>  }
[ ... ]
> @@ -1211,8 +1239,15 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	WRITE_ONCE(pm->pm_type, pm_type);
> =20
>  	rcu_read_lock();
> -	mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
> +	pm_ops =3D mptcp_get_path_manager(net);
> +	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> +		pr_warn_once("pm %s fails, fallback to default pm",
> +			     pm_ops ? pm_ops->name : NULL);
> +		pm_ops =3D &mptcp_pm_kernel;

[Severity: High]
This is a pre-existing issue, but could this fallback cause a module refere=
nce
count underflow?

If bpf_try_module_get() fails or the requested PM is NULL, pm_ops is set to
&mptcp_pm_kernel without incrementing its module reference count.

Later, mptcp_pm_ops_release() unconditionally calls
bpf_module_put(pm_ops, pm_ops->owner). Since the reference was never acquir=
ed,
this causes an underflow of the MPTCP module's reference count. If MPTCP is
built as a module, this could allow the module to be unloaded while sockets
are still alive.

> +	}
>  	rcu_read_unlock();
> +
> +	mptcp_pm_ops_init(msk, pm_ops);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093531.2002=
3-1-gang.yan@linux.dev?part=3D6
