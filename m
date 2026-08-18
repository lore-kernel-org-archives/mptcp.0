Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B3417BE9
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047197; cv=none; b=SgnI7wiuXX2EZVmvOt8lhtdtB1wbBijzeRkOaSKPzDlWJ1bGydhjpnha9v+jcb/3Ig/Oi88fOnT6/7aESYj89Ha7IL8YHEj07pobx5cvtiQfd0ao9uFcjzxgMgqbSgfOr3olmj4DATxLDOqVAHf9+BUG26Jei6hoRyqPFHFk7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047197; c=relaxed/simple;
	bh=vCdzBAe88KEPVpz/8qyzVsxSem2B9iKVNU29Eb4a1dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rdri4mLXrO3vU/KqAcGHSiSNPnNQvaa0DMqdAMexefwhRg158jpIX6r9N+hKJSvdejGh+Vg5goV+JKRmanfa94/w3SPj7abOzXWlk64gRkIu6Cb780zLwk2Tbswuop/5ZyIebifZnDvqcx7IrhZLLvnWpjWar/IlnkQ0TOwgo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N37u9TOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N37u9TOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892E1F000E9;
	Tue, 18 Aug 2026 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047195;
	bh=bKvNZR8lPQjY4ACBaHY6n4h8+06coclO3IrM1rte0bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N37u9TOr+TDtl8p6hzIRcyM4rcVvUme2NjGuzemgDbZU2egtJCNZo43DWL1EF3fmW
	 SVVWJhhy1eNDrh/x9voYaZy81cFaLoseDsx7G4vXdBEZzluoU9XPBEs6sdfCcc4sWT
	 8XzJoYymDoL7MXpiPJ9hFpMpbWIlvJwLHSraEI2ORvj6cLGW2s81AOL/fvzcxvQi0s
	 04VeMWituaOvcgvsQ7DTe895QX8YVdaxECVmM6mOrrgcgcn/2NF9IxcoArpywU8wEj
	 k8V+O/xqZRm+bPRunUS3+PiD+s9ccDrIiQA5OUTLqiSj8Neojo13N8OnUy6+HhESAm
	 PrnqOlB5sbAWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 1/5] mptcp: sched: change scheduler sysctl
 atomically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818094825.48446-2-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-2-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:59:54 +0000
Message-Id: <20260818095955.6892E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free and module reference leak due to missing reference =
counting when setting the default MPTCP scheduler
- [Medium] Redundant scheduler list traversal during socket initialization =
defeats pointer caching
--

--- Patch [1]: [PATCH mptcp-next v2 1/5] mptcp: sched: change scheduler sys=
ctl atomically ---
commit d5b1780c033b9909a1b30fbd814812af5c25ed2f
Author: Gang Yan <yangang@kylinos.cn>

mptcp: sched: change scheduler sysctl atomically

This commit changes the per-netns scheduler storage from an inline string
to an RCU-protected pointer to an mptcp_sched_ops struct. It updates the
sysctl read/write paths and socket initialization to use this pointer,
aiming to prevent concurrent readers from observing half-written names.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 63c5747f0f63c..479b31eb30079 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
[ ... ]
> @@ -126,7 +133,7 @@ static int mptcp_set_scheduler(char *scheduler, const=
 char *name)
>  	rcu_read_lock();
>  	sched =3D mptcp_sched_find(name);
>  	if (sched)
> -		strscpy(scheduler, name, MPTCP_SCHED_NAME_MAX);
> +		xchg(&pernet->scheduler, sched);

[Severity: High]
When replacing the scheduler pointer here with xchg(), does this leak the
module reference for the previous scheduler returned by xchg()?

Also, do we need to acquire a module reference for the newly assigned sched
via bpf_try_module_get() before storing it? Without a reference, could the
module be unloaded, leaving pernet->scheduler pointing to freed memory that
would trigger a use-after-free when dereferenced by a concurrent reader in
proc_scheduler()?

[ ... ]
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c2762d74f29d7..82df0400d0f94 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -3271,8 +3272,8 @@ static int mptcp_init_sock(struct sock *sk)
>  		return -ENOMEM;
> =20
>  	rcu_read_lock();
> -	ret =3D mptcp_init_sched(mptcp_sk(sk),
> -			       mptcp_sched_find(mptcp_get_scheduler(net)));
> +	mptcp_get_scheduler(net, sched_name);
> +	ret =3D mptcp_init_sched(mptcp_sk(sk), mptcp_sched_find(sched_name));

[Severity: Medium]
Since pernet->scheduler now stores the mptcp_sched_ops pointer directly,
could we retrieve and use that pointer here directly? Extracting the name
via mptcp_get_scheduler() just to perform a redundant list traversal with
mptcp_sched_find() seems to defeat the purpose of caching the operations
pointer.

>  	rcu_read_unlock();
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818094825.4844=
6-1-gang.yan@linux.dev?part=3D1
