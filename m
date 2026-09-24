Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F03264FC
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214832; cv=none; b=s0IbFVrKVQAajaocoZcj4/65WI9ZcYW0w2cqe8dzsB/mJu9j3UeSeYstn3c2jQ7DSN5MoLOf7fVbL1PvzG7nmvU3+V8W6J/tlKNJDsBkL8Wx+D4nCV8l8/vrym37ePYHKPUXl0YJAB47rP+S3FyC6B4vojRYtKbcJfNLEn4zy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214832; c=relaxed/simple;
	bh=931ue2KcThGCUETeys1OfFNQ43tpNJM0OR+htR2Lvxo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=F8E8BpZxGWiVG0ngLf7q+cfG9zvVygARrJDDz+D7PBKhnqoe3SPEkmynCZVLiSFVVWt7Ciou8rb6PIqE9yjirc+gGiHl/7xcU46WwQhxF87M4OSseLG5tPFuqXqdQfZ5dhk7t0CZkfq/CDxHfpMtP9jSobVPbJ92ikYvMH3lcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgDgEAHS; arc=none smtp.client-ip=95.215.58.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgDgEAHS"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=931ue2KcThGCUETeys1OfFNQ43tpNJM0OR+htR2Lvxo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790214828; v=1; x=1790819628;
 b=xgDgEAHShA+frraf4sUheDIFajgLvPfRmlHTbM1auvHsgIw9UTKF2bb0tJdD2D5CN2oahuIf
 85uir8XdDMddVhFbVF4VfY57eLVTPT+CeOc/c6hotUUyJITiUV5/hxLT2yKdmn2gTWUR+/bNZlI
 lOz8TVGqjotdtvVHII8EfBTs=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 81a41aec7d3a9737;
	Thu, 24 Sep 2026 01:53:47 +0000
X-Mizu-Trace-ID: 81a41aec7d3a9737
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 01:53:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <da961f27c729d9232a59e509e8e3c2f50bc1db00@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v7 6/6] Squash to previous one
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260923101140.E62E41F000FF@smtp.kernel.org>
References: <cover.1790147728.git.yangang@kylinos.cn>
 <6a1cbdd1a0f4866ff6cda3b8679450172c203f5b.1790147728.git.yangang@kylinos.cn>
 <20260923101140.E62E41F000FF@smtp.kernel.org>

September 23, 2026 at 6:11 PM, sashiko-bot@kernel.org mailto:sashiko-bot@=
kernel.org  wrote:


>=20
>=20Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [High] mptcp: uaf and uninitialized access in pm_ops during disconnec=
t
> --
>=20
>=20commit 89b80a47ef923bdc04a9069fdcf06de447841c5b
> Author: Gang Yan <yangang@kylinos.cn>
>=20
>=20Squash to previous one
>=20
>=20This patch applies RCU discipline to msk->pm.ops, moving its initiali=
zation,
> publication, and release to better align with RCU patterns. It updates =
readers
> to use rcu_dereference() and writers to use rcu_assign_pointer() under =
the
> PM lock.
>=20
>=20Link: https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@=
linux.dev?part=3D5
>=20
>=20>=20
>=20> mptcp_destroy(), the final close path: mptcp_token_destroy() has
> >  already removed the socket from the token hash by then, so no new
> >  reader can find the msk anymore.
> >=20=20
>=20>  Note that rcu_assign_pointer() before pm_ops->init(msk) does not
> >  publish a partially initialised object: the ops are registered
> >  immutable, init() only prepares the per-socket state, and the msk is
> >  not reachable by readers until its token is registered.
> >=20
>=20[Severity: High]
> Is this assumption accurate? A concurrent SoftIRQ can receive an MP_JOI=
N
> request, look up the socket via mptcp_token_get_sock(), increment its r=
efcnt,
> and drop the RCU read lock. Concurrently, the socket could be disconnec=
ted,
> calling mptcp_disconnect() -> mptcp_pm_data_reset() -> mptcp_pm_ops_ini=
t().
>=20
>=20The SoftIRQ thread could then re-acquire the RCU read lock and call
> mptcp_pm_get_local_id(), accessing the actively tearing down or uniniti=
alized
> per-socket state.

The concurrent softirq reader you describe does exist -- that is
exactly the race this patch fixes. But note what that reader
consumes: mptcp_pm_get_local_id() consults the per-net endpoint
table (inside its own RCU section) and the msk addresses; it does
not read any of the per-socket state managed by init()/release()
(pm->work_pending, accept_addr, ...), which is only consumed by
the PM worker under the socket lock. So the reader cannot observe
the teardown/reset of the fields those callbacks manage. It's safe
for now.

>=20
>=20[ ... ]
>=20
>=20>=20
>=20> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >  index 64244a1a01bca..66fb7c3d9c827 100644
> >  --- a/net/mptcp/pm.c
> >  +++ b/net/mptcp/pm.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -1158,23 +1166,39 @@ void mptcp_pm_worker(struct mptcp_sock *msk=
)
> >  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
> >  struct mptcp_pm_ops *pm_ops)
> >  {
> >  - if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> >  - pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
> >  - pm_ops =3D &mptcp_pm_kernel;
> >  + struct mptcp_pm_ops *old;
> >  +
> >  + spin_lock_bh(&msk->pm.lock);
> >  + old =3D rcu_dereference_protected(msk->pm.ops,
> >  + lockdep_is_held(&msk->pm.lock));
> >  + if (old !=3D pm_ops)
> >  + rcu_assign_pointer(msk->pm.ops, pm_ops);
> >=20
>=20[Severity: High]
> Does this publish the new ops to readers before its state is initialize=
d via
> init(msk) below? If a reader finds the socket, it could access the new =
ops
> before its per-socket state is ready.
>=20

On=20the publish-before-init concern: pm_ops->init(msk) prepares
the per-socket state, not the ops -- the ops are registered
immutable, their callbacks are valid from registration. A reader
entering between the assign and init() would call valid ops code
and read fields it does not consume (see comments above); this
ordering also matches the previous, non-RCU code.

> >=20
>=20> + spin_unlock_bh(&msk->pm.lock);
> >  +
> >  + if (old) {
> >  + synchronize_rcu();
> >  + if (old->release)
> >  + old->release(msk);
> >=20
>=20[Severity: High]
> If old =3D=3D pm_ops, we skip the rcu_assign_pointer() above, meaning t=
he ops
> are still actively published in msk->pm.ops. Does calling old->release(=
msk)
> here violate RCU removal rules by releasing the ops state while it is s=
till
> reachable by readers?
>=20

On=20releasing the still-installed ops when old =3D=3D pm_ops: no
in-tree PM defines release() today, so this is currently dead
code. For a future PM that does define it, the synchronize_rcu()
in front guarantees no in-flight reader is executing the ops when
release() runs, so no RCU removal rule is violated. It's also an old
issue raised by sashiko before, this code can address it correctly I
think (call .release before remove it).

> >=20
>=20> + bpf_module_put(old, old->owner);
> >  }
> >=20=20
>=20>  - msk->pm.ops =3D pm_ops;
> >  - if (msk->pm.ops->init)
> >  - msk->pm.ops->init(msk);
> >  + if (pm_ops->init)
> >  + pm_ops->init(msk);
> >=20=20
>=20>  pr_debug("pm %s initialized\n", pm_ops->name);
> >  }
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> >  index 14aa82647c3d1..4953cfa329e81 100644
> >  --- a/net/mptcp/subflow.c
> >  +++ b/net/mptcp/subflow.c
> >  @@ -94,14 +94,17 @@ static struct mptcp_sock *subflow_token_join_req=
uest(struct request_sock *req)
> >  return NULL;
> >  }
> >=20=20
>=20>  + rcu_read_lock();
> >  local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req);
> >=20
>=20[Severity: High]
> This is where a concurrent reader accesses the PM ops using a cached ms=
k
> reference. Does this disprove the assumption in the commit message that
> the socket is unreachable, since the reader already holds a reference t=
o msk?
>=20

It's=20the misleading of the commit message, as the first comment of this=
 letter
said.

@Matt, @Geliang
So for now, I think all the patches in this series are ready for review. =
It=E2=80=99s
not urgent, so please take a look when you have time.

Thanks
Gang

> >=20
>=20> if (local_id < 0) {
> >  SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
> >  + rcu_read_unlock();
> >  sock_put((struct sock *)msk);
> >  return NULL;
> >  }
> >=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790147=
728.git.yangang@kylinos.cn?part=3D6
>
