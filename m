Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545603A1A38
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558341; cv=none; b=CHFXY5h3rsJZ/2qjkiAnJoarJmIM4/MEGqWbCRL9wq/QMRSCb9ZifyjhvplmkTNQoueaZSi80LFn6HKwF/iEnU4oTCHzlyaFukbm1wbzyS4/1GdtcZLmQbY8CFbzBrIgQASnH3Q/mq18eMPwsVKeAct7qu1jSc8UYn+H6ARnWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558341; c=relaxed/simple;
	bh=v/kJs+8Qf0eNEVm+oelLFhSaPh0ht9SUwjowW/NM3CI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JR3Ydw8QWvQUkRNgthdlW5InvSC4iOXvrlHxSbFyIo6A+EYjysDmf8deEjH6QJw7oN9P42D5MePoHZ9J4HrNeyHZ1hz8Hy4+I20O707U+hzU5XXHsQmIoofvZeiLSYZVnKtSLeruM3y3rW81aeJwJZeRVzp7hDwYHCvbWYvTcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMiK5iCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMiK5iCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44DA1F000E9;
	Mon, 24 Aug 2026 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787558333;
	bh=uVA8KOaL7k55ICw3xCIjPuTEPKuczs6T4GrTKC2D6fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMiK5iCT6HNshgcKKGoYvQ7HUvKIyk542+TGbc55q7JXEaMsseYsMf9opJznCr6kV
	 XsYHXcOor3LxOc2ry714EoLUUt79OHkO5n3VdfjYTRh3tJPq0EHy+pHmBAcY7IWJJ0
	 fqzAOAI1f2llwaJIPbEsaPwQG++9uyJJZ25sLrvIGT0XsBg7Xz9369gzaZd/exQwXM
	 7ZCv8NxzJx74t7wSsV89OjbwOEwx40TpeTO5ivbhDf09CPNfBh5Ed95OPQSojYs807
	 yDN+Xc7AVjEjAToq87ip5i8XJin/GO8VjLoWWfVcK/uLUi5hnqz9V3xevpmgoD4/1/
	 fgpQYbRQh6jQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 6/6] Squash to previous one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260824073625.57471-7-gang.yan@linux.dev>
References: <20260824073625.57471-1-gang.yan@linux.dev>
 <20260824073625.57471-7-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:58:53 +0000
Message-Id: <20260824075853.B44DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-After-Free of PM ops pointer due to premature RCU unlock.
- [High] Resource Leak and Lifecycle Violation in PM ops replacement.
- [High] Use-Before-Initialization of PM ops via RCU publishing.
--

--- Patch [6]: [PATCH mptcp-next v4 6/6] Squash to previous one ---
commit 300bc1205800c2307a03b20ff740b6c4f84c422e
Author: Gang Yan <yangang@kylinos.cn>

Squash to previous one

This commit applies RCU discipline to the msk->pm.ops pointer, marking
it __rcu and adding appropriate locks and synchronization.

Link: https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.=
dev?part=3D5

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -1158,23 +1166,46 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>  			      struct mptcp_pm_ops *pm_ops)
>  {
> +	struct mptcp_pm_ops *old;
> +	bool need_sync =3D false;
> +
>  	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
>  		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
>  		pm_ops =3D &mptcp_pm_kernel;
>  	}
> =20
> -	msk->pm.ops =3D pm_ops;
> -	if (msk->pm.ops->init)
> -		msk->pm.ops->init(msk);
> +	spin_lock_bh(&msk->pm.lock);
> +	old =3D rcu_dereference_protected(msk->pm.ops,
> +					lockdep_is_held(&msk->pm.lock));
> +	if (old =3D=3D pm_ops) {
> +		need_sync =3D false;
> +	} else {
> +		rcu_assign_pointer(msk->pm.ops, pm_ops);

[Severity: High]
Does this publish the new pm_ops pointer before it is fully initialized?

The rcu_assign_pointer() call exposes pm_ops to concurrent readers before
pm_ops->init(msk) is called. Could concurrent access during the grace period
execute callbacks on a partially initialized state?

> +		need_sync =3D !!old;
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (need_sync)
> +		synchronize_rcu();
> +	if (old)
> +		bpf_module_put(old, old->owner);
> +
> +	if (pm_ops->init)
> +		pm_ops->init(msk);

[Severity: High]
When replacing an existing path manager, does this code leak the old resour=
ces?

The code calls bpf_module_put(old, old->owner) but doesn't seem to call
old->release(msk) to free the actual path manager resources.

Also, if old =3D=3D pm_ops, we still reach pm_ops->init(msk) here. Will
unconditionally calling init() on unchanged ops cause a double-allocation?

>  	pr_debug("pm %s initialized\n", pm_ops->name);
>  }

[ ... ]

> @@ -1204,6 +1233,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	const struct net *net =3D sock_net((struct sock *)msk);
>  	u8 pm_type =3D mptcp_get_pm_type(net);
>  	struct mptcp_pm_data *pm =3D &msk->pm;
> +	struct mptcp_pm_ops *pm_ops;
> =20
>  	memset(&pm->reset, 0, sizeof(pm->reset));
>  	pm->rm_list_tx.nr =3D 0;
> @@ -1211,8 +1241,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	WRITE_ONCE(pm->pm_type, pm_type);
> =20
>  	rcu_read_lock();
> -	mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
> +	pm_ops =3D mptcp_get_path_manager(net);
>  	rcu_read_unlock();
> +
> +	mptcp_pm_ops_init(msk, pm_ops);
>  }

[Severity: High]
Can dropping the RCU read lock here lead to a use-after-free?

The rcu_read_unlock() invalidates the pm_ops pointer before it is passed to
mptcp_pm_ops_init(), which then dereferences it (via pm_ops->owner) in
bpf_try_module_get().=20

Should the lock be held across the initialization, or should the module
reference be taken before dropping the read lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824073625.5747=
1-1-gang.yan@linux.dev?part=3D6
