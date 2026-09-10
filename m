Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FED46C835
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038856; cv=none; b=phO1x/bl4xbCITuu18LChASX4RRZ4oKQhnw40VTdCRRKVU/Wv/myzRbwkLjMmTrL9R6T9+jyZRxd3ZnNLVkGTM9hK7y75zGGzfbGA2KYGnZfvzWQG04S6EBow/AwbpGAhyCtG3Zx1upgRY1OFAYIXqmazp4g9VzLbsekT9CTnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038856; c=relaxed/simple;
	bh=3ghV1QzLVKod8PaAxIsdrr7VJd/DfOUFqmFJanO1DjE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=K5fhIDsd3y24jsuMV4lI/zpQ6MvqAvN/xzI7assyrooHE8/zwIW7+uDxdCojlpRDRDCIjS91oqCzkGvwYSLZHUVzdj8m/Y2IZCzRdKGtn7/QrEdNnkBLIKrFH7wcegvgsYufEzZxnXB+6FdhAs79g/EUf562DogH6F4tO3laZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DhWNvFNM; arc=none smtp.client-ip=95.215.58.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DhWNvFNM"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=3ghV1QzLVKod8PaAxIsdrr7VJd/DfOUFqmFJanO1DjE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789038850; v=1; x=1789643650;
 b=DhWNvFNM7wuAxItTdOnMCja+AM8JUSXvV0p7MASEyeKH+oGkxJK+zqpC/IHCusgUzvGZFBMs
 YWQFoYVMSCBjRClk8BETJ7q9Vqk7diSh+2hNWph04p5TwDwRN9/lDmbIFJLhNKKLgggJUrMLEew
 CxWE70T74N/BTsa0z2vmWvtA=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4c76a4a0dd0f5423;
	Thu, 10 Sep 2026 11:14:10 +0000
X-Mizu-Trace-ID: 4c76a4a0dd0f5423
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 11:14:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <e9c7ab0d87da824a59f3fcc3bf44c71278d10c16@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v6 6/6] Squash to previous one
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904095144.5B2D41F00A3D@smtp.kernel.org>
References: <20260904093531.20023-1-gang.yan@linux.dev>
 <20260904093531.20023-7-gang.yan@linux.dev>
 <20260904095144.5B2D41F00A3D@smtp.kernel.org>

September 4, 2026 at 5:51 PM, sashiko-bot@kernel.org mailto:sashiko-bot@k=
ernel.org  wrote:


>=20
>=20Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
>=20
>=20New issues:
> - [High] Bypassing RCU grace period in mptcp_pm_ops_init() when the PM =
remains unchanged causes Use-After-Free and data races.
> - [High] Publishing new PM ops before initializing its per-socket state=
 exposes uninitialized memory to RCU readers.
>=20
>=20Pre-existing issues:
> - [High] Module reference count underflow when falling back to the defa=
ult path manager.
> --
>=20
>=20commit 261318f67b36cf52f532df8226134e77ddd65cd0
> Author: Gang Yan <yangang@kylinos.cn>
>=20
>=20Squash to previous one
>=20
>=20This patch updates the MPTCP path manager operations to use RCU for c=
oncurrent
> reads. It modifies mptcp_pm_ops_init() and mptcp_pm_ops_release() to sa=
fely
> handle the assignment and release of the ops pointer, and adds RCU read=
 locks
> in the subflow paths.
>=20
>=20>=20
>=20> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >  index 64244a1a01bca..d581d11b350f2 100644
> >  --- a/net/mptcp/pm.c
> >  +++ b/net/mptcp/pm.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -1158,23 +1166,44 @@ void mptcp_pm_worker(struct mptcp_sock *msk=
)
> >  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
> >  struct mptcp_pm_ops *pm_ops)
> >  {
> >  - if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> >  - pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
> >  - pm_ops =3D &mptcp_pm_kernel;
> >  + struct mptcp_pm_ops *old;
> >  + bool need_sync =3D false;
> >  +
> >  + spin_lock_bh(&msk->pm.lock);
> >  + old =3D rcu_dereference_protected(msk->pm.ops,
> >  + lockdep_is_held(&msk->pm.lock));
> >  + if (old =3D=3D pm_ops) {
> >  + need_sync =3D false;
> >  + } else {
> >  + rcu_assign_pointer(msk->pm.ops, pm_ops);
> >=20
>=20[Severity: High]
> Does this code publish the new PM operations pointer to readers before =
its
> per-socket state is initialized?
>=20
>=20If msk->pm.ops is updated via rcu_assign_pointer() here, existing RCU=
 readers
> like subflow_token_join_request() could dereference the new pm_ops and =
execute
> its methods before pm_ops->init(msk) has run below. For example, if a r=
eader
> calls mptcp_pm_get_local_id() and then mptcp_pm_is_backup() in the same=
 RCU
> section, it might see the new uninitialized pm_ops for the second call.
>=20
>=20>=20
>=20> + need_sync =3D !!old;
> >  }
> >  + spin_unlock_bh(&msk->pm.lock);
> >=20=20
>=20>  - msk->pm.ops =3D pm_ops;
> >  - if (msk->pm.ops->init)
> >  - msk->pm.ops->init(msk);
> >  + if (need_sync)
> >  + synchronize_rcu();
> >  + if (old) {
> >  + if (old->release)
> >  + old->release(msk);
> >=20
>=20[Severity: High]
> Could this bypass the required RCU grace period and cause a use-after-f=
ree?
>=20
>=20If old =3D=3D pm_ops, need_sync is set to false, skipping synchronize=
_rcu().
> However, the code still calls old->release(msk) immediately here. If
> concurrent lockless RCU readers (e.g., in subflow_token_join_request())
> are actively executing path manager methods on the socket, old->release=
(msk)
> can free the per-socket state while they are using it.
>=20
>=20>=20
>=20> + bpf_module_put(old, old->owner);
> >  + }
> >  +
> >  + if (pm_ops->init)
> >  + pm_ops->init(msk);
> >=20=20
>=20>  pr_debug("pm %s initialized\n", pm_ops->name);
> >  }
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -1211,8 +1239,15 @@ void mptcp_pm_data_reset(struct mptcp_sock *=
msk)
> >  WRITE_ONCE(pm->pm_type, pm_type);
> >=20=20
>=20>  rcu_read_lock();
> >  - mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
> >  + pm_ops =3D mptcp_get_path_manager(net);
> >  + if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> >  + pr_warn_once("pm %s fails, fallback to default pm",
> >  + pm_ops ? pm_ops->name : NULL);
> >  + pm_ops =3D &mptcp_pm_kernel;
> >=20
>=20[Severity: High]
> This is a pre-existing issue, but could this fallback cause a module re=
ference
> count underflow?
>=20
>=20If bpf_try_module_get() fails or the requested PM is NULL, pm_ops is =
set to
> &mptcp_pm_kernel without incrementing its module reference count.
>=20
>=20Later, mptcp_pm_ops_release() unconditionally calls
> bpf_module_put(pm_ops, pm_ops->owner). Since the reference was never ac=
quired,
> this causes an underflow of the MPTCP module's reference count. If MPTC=
P is
> built as a module, this could allow the module to be unloaded while soc=
kets
> are still alive.
>=20
>=20>=20
>=20> + }
> >  rcu_read_unlock();
> >  +
> >  + mptcp_pm_ops_init(msk, pm_ops);
> >  }

Will be handled in the next version.

> >=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026090409353=
1.20023-1-gang.yan@linux.dev?part=3D6
>
