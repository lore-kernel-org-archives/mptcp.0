Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F73463B85
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158311; cv=none; b=XCThsU82w4I8ZiAVxfMHAkyBp6PTUCpkK7q0dSXR62v1gKGBvS5gdQXx/xAgGBK6T5RbE/lLfSzBjkmPO2QuzJbR8kw9SCSg4hsONob8PERztnAgamReWXQ4szP/q4b0zDiPYFfNfs6KjUNDvOl5RiWdkdHkPhytHnsQRlVJqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158311; c=relaxed/simple;
	bh=9DJHPFAS6T3XbBbRorwIIEm80KXjWcpNPaagOXO7RGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SPNnTdw2RmcFlPUetSElsr6znEaPxTgv4T5j+Te+/Cj3L8igJU4ivlhvZ7IJC6Rxx/iKXlLsUyqjYGjhmUI7iLmZJCODup1s5Le+DTguFSulPpAACzDzRpmHj6Z4tUv2QHtonmE0k51+xTmrA0gYliujnpE3O6fIeDHvQxm1IuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeObuRYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeObuRYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E41F000FF;
	Wed, 23 Sep 2026 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158301;
	bh=5wp24O5TsOjx+ljE/2kDZ66NCCp8ENEp01V7JiZfiwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QeObuRYUXOV86JVB0YLYO3M66J/yG/pmMVacUzFzeojxhsmfHcPb//+mILYFPV0Pk
	 QinL9a7XEeIGHpHTeiXfzF6Fl8mRvmmFcZlCG9J9+RA/fceuu7efsvOuBv1m4N643h
	 5ZytERqXVpEC/flUhs9kEmyIJayPixlpa0I2Xx86AJQvwEA0vuEc5MbIxjKcOJObw9
	 7LBF0vKEnISggFRVhuPrJSpzeYO61zuiDfzIERwJJ0ffu73ko8wUJtjDuW0C0ztL4s
	 p/lBANlczF3UzOs8FULV78dXQJtC5eHwraVEhhGCCG7Sovwg+sCTG7B0vDAOa+qlnn
	 9pAqlmYlnc0rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v7 6/6] Squash to previous one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <6a1cbdd1a0f4866ff6cda3b8679450172c203f5b.1790147728.git.yangang@kylinos.cn>
References: <cover.1790147728.git.yangang@kylinos.cn>
 <6a1cbdd1a0f4866ff6cda3b8679450172c203f5b.1790147728.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:11:40 +0000
Message-Id: <20260923101140.E62E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: uaf and uninitialized access in pm_ops during disconnect
--

commit 89b80a47ef923bdc04a9069fdcf06de447841c5b
Author: Gang Yan <yangang@kylinos.cn>

Squash to previous one

This patch applies RCU discipline to msk->pm.ops, moving its initialization,
publication, and release to better align with RCU patterns. It updates read=
ers
to use rcu_dereference() and writers to use rcu_assign_pointer() under the
PM lock.

Link: https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.=
dev?part=3D5

>     mptcp_destroy(), the final close path: mptcp_token_destroy() has
>     already removed the socket from the token hash by then, so no new
>     reader can find the msk anymore.
>    =20
>     Note that rcu_assign_pointer() before pm_ops->init(msk) does not
>     publish a partially initialised object: the ops are registered
>     immutable, init() only prepares the per-socket state, and the msk is
>     not reachable by readers until its token is registered.

[Severity: High]
Is this assumption accurate? A concurrent SoftIRQ can receive an MP_JOIN
request, look up the socket via mptcp_token_get_sock(), increment its refcn=
t,
and drop the RCU read lock. Concurrently, the socket could be disconnected,
calling mptcp_disconnect() -> mptcp_pm_data_reset() -> mptcp_pm_ops_init().

The SoftIRQ thread could then re-acquire the RCU read lock and call
mptcp_pm_get_local_id(), accessing the actively tearing down or uninitializ=
ed
per-socket state.

[ ... ]
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 64244a1a01bca..66fb7c3d9c827 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
[ ... ]
> @@ -1158,23 +1166,39 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>  			      struct mptcp_pm_ops *pm_ops)
>  {
> -	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> -		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
> -		pm_ops =3D &mptcp_pm_kernel;
> +	struct mptcp_pm_ops *old;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	old =3D rcu_dereference_protected(msk->pm.ops,
> +					lockdep_is_held(&msk->pm.lock));
> +	if (old !=3D pm_ops)
> +		rcu_assign_pointer(msk->pm.ops, pm_ops);

[Severity: High]
Does this publish the new ops to readers before its state is initialized via
init(msk) below? If a reader finds the socket, it could access the new ops
before its per-socket state is ready.

> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (old) {
> +		synchronize_rcu();
> +		if (old->release)
> +			old->release(msk);

[Severity: High]
If old =3D=3D pm_ops, we skip the rcu_assign_pointer() above, meaning the o=
ps
are still actively published in msk->pm.ops. Does calling old->release(msk)
here violate RCU removal rules by releasing the ops state while it is still
reachable by readers?

> +		bpf_module_put(old, old->owner);
>  	}
> =20
> -	msk->pm.ops =3D pm_ops;
> -	if (msk->pm.ops->init)
> -		msk->pm.ops->init(msk);
> +	if (pm_ops->init)
> +		pm_ops->init(msk);
> =20
>  	pr_debug("pm %s initialized\n", pm_ops->name);
>  }
[ ... ]
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 14aa82647c3d1..4953cfa329e81 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -94,14 +94,17 @@ static struct mptcp_sock *subflow_token_join_request(=
struct request_sock *req)
>  		return NULL;
>  	}
> =20
> +	rcu_read_lock();
>  	local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req);

[Severity: High]
This is where a concurrent reader accesses the PM ops using a cached msk
reference. Does this disprove the assumption in the commit message that
the socket is unreachable, since the reader already holds a reference to ms=
k?

>  	if (local_id < 0) {
>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
> +		rcu_read_unlock();
>  		sock_put((struct sock *)msk);
>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790147728.gi=
t.yangang@kylinos.cn?part=3D6
