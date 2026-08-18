Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BF3BED01
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047429; cv=none; b=dzOcUleTwFCYAT/Qa4zjrgzUNlSXmaVtclP6KKb48vsjLkx/s07EgjcfklAYQDc+ixjMcl/DnvreAjHBcYuEQQb5u+yhuMGdG4+ShirOP+Ed2fuxaV90pk5grSFUxtTihaNcc0f6/NiL7I754oeeljsgTt5yavLBDD0tC1cY32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047429; c=relaxed/simple;
	bh=dX8emH89BZ8p/qJ5OnE5chktEIH4Tsgf2OESUCVVL8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6YKc6V0sSY7jVpBy0wHk0jrK0eV81Mmi4Gj3eXuaXEOGllg6mRhj60LtQ/GhK2DJX6jDvGCBYmRz2+OKDW8QZU01rbSYLHuF9te0G3wT4XOsOhA5xficqYLbWrOYLLc/Wyr7/UpOY8e/wsTPDDCCwrUIuSBqcUb1HUyzsvAmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJboFA6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJboFA6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA631F000E9;
	Tue, 18 Aug 2026 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047425;
	bh=sLytcBEbcPmJ1lEO58RMvDBQWGInfLyu7FrmC0CS9ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJboFA6cqNzPX/mlYSDpIS5vwKos6P8hY38Fa4lrZNYVrSmRTZeJzpJhQme60zXnO
	 nBYTuP80c+4/7ExVydOuMngI1caqdq9SEER428eVST9GYM+a+dyhVh/wiDgVZrLHvn
	 IWaRhPFGiqHljsAIqbMrDpLGul7nGYDX9utui9vKgZb6rj5SiXEcc15RAVAI7bsRpn
	 3f/cHvD9DSUiwXRUiiNgjzlHd/HXrjGcj9/FpG32QLkHR4Nr7iLW9KCMQL3l196GeZ
	 2pXdA4ezLc4DpoThxxX6g8BLslIgSnsYs7Jzg7As1uP6kSyvKldbgDOZPVquNht/zG
	 yodydI7YIgPBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 4/5] Squash to "mptcp: pm: init and
 release mptcp_pm_ops"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818094825.48446-5-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-5-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:03:45 +0000
Message-Id: <20260818100345.8DA631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Resource Leak on Error Path in `mptcp_net_init`
--

--- Patch [4]: [PATCH mptcp-next v2 4/5] Squash to "mptcp: pm: init and rel=
ease mptcp_pm_ops" ---
commit b8f493287a2fef63b437fe19fc22666b77c1c08b
Author: Gang Yan <yangang@kylinos.cn>

Squash to "mptcp: pm: init and release mptcp_pm_ops"

This commit introduces lifetime handling for mptcp_pm_ops at the pernet
level. It pins the default mptcp_pm_kernel by taking a module reference
during pernet defaults initialization and releases it during network
namespace exit.

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 733706f06f1b1..32268aa260976 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -124,7 +124,9 @@ static void mptcp_pernet_set_defaults(struct mptcp_pe=
rnet *pernet)
>  	pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
> =20
>  	RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
> -	RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
> +
> +	if (bpf_try_module_get(&mptcp_pm_kernel, mptcp_pm_kernel.owner))
> +		RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);

[Severity: Medium]
Does this introduce a module reference leak regression on the error path
during network namespace initialization?

When mptcp_pernet_set_defaults() takes this module reference, it is called
from mptcp_net_init() right before mptcp_pernet_new_table():

mptcp_net_init() {
    mptcp_pernet_set_defaults(pernet);
    return mptcp_pernet_new_table(net, pernet);
}

If mptcp_pernet_new_table() fails and returns an error, the error is
propagated without releasing the module reference acquired here. Because the
initialization failed, the core network namespace code will not call the
corresponding exit function mptcp_net_exit() to release it.

Should mptcp_net_init() clean up the reference if mptcp_pernet_new_table()
fails?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818094825.4844=
6-1-gang.yan@linux.dev?part=3D4
