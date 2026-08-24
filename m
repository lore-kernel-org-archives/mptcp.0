Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884C36E47A
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563304; cv=none; b=PHrWUWJmMHM0UShc2hQuZ4Vv5raxwLXg0L8N6kzGnRRKBJSIuEh2LtIYOPX9wAoO/k9VQdaGiL4xFKcpvc3cBxO4ioBOOpzIuSM9gBdIsPacg/VKjzoVKog+S6pDAgXdlBrSYwsbXHC0uvEHt4CRURtpSrD9Sqn2gy7TVC19rUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563304; c=relaxed/simple;
	bh=xELYEE5DKokB6QO0xi/+HN7EOh2mQhDD090KyMKYPfg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=uFdUsysmxhXcESU4bjGPhBdaiv26jvPi2BbnGOvI8OGdSETAn3uEZebRP2dm4sMmPuvUFvyKLRIjJJoOMUeoRj37gESuiIkuGlhZWSGmFqfqVlWfaz3UBLWKb3yATs7UQ0/6n2QH8LnrXCpPD2+mNKoXVfMisp6lo4h0tIKdD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bGDr1mDA; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bGDr1mDA"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=xELYEE5DKokB6QO0xi/+HN7EOh2mQhDD090KyMKYPfg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787563296; v=1; x=1788168096;
 b=bGDr1mDAtOf0NwCflJmCF5rA3oBIc1Iu/DI1yd1Z83n8U22BXivv6ha6F8/7nuh4YeGcoWWR
 iZqxG1rvOLdpOlOxLH7AxUovYVJ4ZbZ2L+mqyJR+vBLjRQCBz9D3OpuujzSHYcS3czzGIR9v9mr
 YXzgQg5Mcqsqrld+jaNIA6+c=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 65145cb9ef89b3bc;
	Mon, 24 Aug 2026 09:21:36 +0000
X-Mizu-Trace-ID: 65145cb9ef89b3bc
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 09:21:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <412ac8f7acf27006301bde880d20d542986bf565@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v4 6/6] Squash to previous one
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260824075853.B44DA1F000E9@smtp.kernel.org>
References: <20260824073625.57471-1-gang.yan@linux.dev>
 <20260824073625.57471-7-gang.yan@linux.dev>
 <20260824075853.B44DA1F000E9@smtp.kernel.org>

August 24, 2026 at 3:58 PM, sashiko-bot@kernel.org mailto:sashiko-bot@ker=
nel.org  wrote:

> >  + struct mptcp_pm_ops *old;
> >  + bool need_sync =3D false;
> >  +
> >  if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> >  pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
> >  pm_ops =3D &mptcp_pm_kernel;
> >  }
> >=20=20
>=20>  - msk->pm.ops =3D pm_ops;
> >  - if (msk->pm.ops->init)
> >  - msk->pm.ops->init(msk);
> >  + spin_lock_bh(&msk->pm.lock);
> >  + old =3D rcu_dereference_protected(msk->pm.ops,
> >  + lockdep_is_held(&msk->pm.lock));
> >  + if (old =3D=3D pm_ops) {
> >  + need_sync =3D false;
> >  + } else {
> >  + rcu_assign_pointer(msk->pm.ops, pm_ops);
> >=20
>=20[Severity: High]
> Does this publish the new pm_ops pointer before it is fully initialized=
?
>=20
>=20The rcu_assign_pointer() call exposes pm_ops to concurrent readers be=
fore
> pm_ops->init(msk) is called. Could concurrent access during the grace p=
eriod
> execute callbacks on a partially initialized state?
>=20

Hi

The=20ordering is safe, because what pm_ops->init() initialises is the pe=
r-socket
PM state (msk->pm.*), not the ops themselves.

The ops are statically registered and unchangeable -- their callbacks are=
 valid
from registration, so the published pointer never refers to a half-initia=
lised
object.


> >=20
>=20> + need_sync =3D !!old;
> >  + }
> >  + spin_unlock_bh(&msk->pm.lock);
> >  +
> >  + if (need_sync)
> >  + synchronize_rcu();
> >  + if (old)
> >  + bpf_module_put(old, old->owner);
> >  +
> >  + if (pm_ops->init)
> >  + pm_ops->init(msk);
> >=20
>=20[Severity: High]
> When replacing an existing path manager, does this code leak the old re=
sources?
>=20
>=20The code calls bpf_module_put(old, old->owner) but doesn't seem to ca=
ll
> old->release(msk) to free the actual path manager resources.

On the missing old->release(): on the disconnect path the per-socket
PM resources are already freed before we get there --
mptcp_pm_destroy() unconditionally calls
mptcp_userspace_pm_free_local_addr_list() (and the announced list)
from mptcp_destroy_common(), so by the time mptcp_pm_data_reset()
swaps the ops there is nothing left for old->release() to free. The
kernel PM has no per-socket resources and no release callback today,
and the userspace PM's release only frees the local address list,
which is covered by the above.


>=20
>=20Also, if old =3D=3D pm_ops, we still reach pm_ops->init(msk) here. Wi=
ll
> unconditionally calling init() on unchanged ops cause a double-allocati=
on?
>=20

that=20is the pre-existing behaviour -- the socket was just torn down by
disconnect() and the PM flags (work_pending, accept_addr, ...) need to be
rebuilt from the current sysctl values. mptcp_pm_kernel_init() only sets
those flags, it does not allocate, so re-running it is an idempotent
reset, not a double allocation.


> >=20
>=20> pr_debug("pm %s initialized\n", pm_ops->name);
> >  }
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -1204,6 +1233,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *m=
sk)
> >  const struct net *net =3D sock_net((struct sock *)msk);
> >  u8 pm_type =3D mptcp_get_pm_type(net);
> >  struct mptcp_pm_data *pm =3D &msk->pm;
> >  + struct mptcp_pm_ops *pm_ops;
> >=20=20
>=20>  memset(&pm->reset, 0, sizeof(pm->reset));
> >  pm->rm_list_tx.nr =3D 0;
> >  @@ -1211,8 +1241,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *m=
sk)
> >  WRITE_ONCE(pm->pm_type, pm_type);
> >=20=20
>=20>  rcu_read_lock();
> >  - mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
> >  + pm_ops =3D mptcp_get_path_manager(net);
> >  rcu_read_unlock();
> >  +
> >  + mptcp_pm_ops_init(msk, pm_ops);
> >  }
> >=20
>=20[Severity: High]
> Can dropping the RCU read lock here lead to a use-after-free?
>=20
>=20The rcu_read_unlock() invalidates the pm_ops pointer before it is pas=
sed to
> mptcp_pm_ops_init(), which then dereferences it (via pm_ops->owner) in
> bpf_try_module_get().=20
>=20
> Should the lock be held across the initialization, or should the module
> reference be taken before dropping the read lock?

Yes, and I think it can be fixed through this:

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ae75e68bc662..769b084ed9cd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1169,11 +1169,6 @@ static void mptcp_pm_ops_init(struct mptcp_sock *m=
sk,
        struct mptcp_pm_ops *old;
        bool need_sync =3D false;
=20
-=20      if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
-               pr_warn_once("pm %s fails, fallback to default pm", pm_op=
s->name);
-               pm_ops =3D &mptcp_pm_kernel;
-       }
-
        spin_lock_bh(&msk->pm.lock);
        old =3D rcu_dereference_protected(msk->pm.ops,
                                        lockdep_is_held(&msk->pm.lock));
@@ -1242,6 +1237,11 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
=20
=20       rcu_read_lock();
        pm_ops =3D mptcp_get_path_manager(net);
+       if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
+               pr_warn_once("pm %s fails, fallback to default pm",
+                            pm_ops ? pm_ops->name : NULL);
+               pm_ops =3D &mptcp_pm_kernel;
+       }
        rcu_read_unlock();
=20
=20       mptcp_pm_ops_init(msk, pm_ops);


WDYT? @Maintainers. If yes, it can be will done in v5.

Thanks
Gang

>=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026082407362=
5.57471-1-gang.yan@linux.dev?part=3D6
>
