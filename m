Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CE4457BA
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515407; cv=none; b=mtVNMUa48C+J9gzsLbs3fgbtpnzbOtGbpvg3fT33/iaBiJBQ5W5QZrLd4k1FnIhC93OCj7tFRJI8DBzBDg0v+YZAdgOBMcYXZ1ac4uuoPDeklqB+GBZuyg6mg94R5Qi6GPMxQwOnwxXlz3r+PjnBsREZWYi7OxlVJGHSIUGrrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515407; c=relaxed/simple;
	bh=1q/J331dp2gmHQtCgCJZjHm5xXKTLaxp5P6Dp9/jlCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8c+Ek6MvsdWofEK9/PXPd/wslHRtAWT7niCS8mGjEpJDCdfsCnkiDyaY2B8JY3aetQ0iZtA+E/Ut3g/KXKF+RSx558tFK3rbHJYB1BMYhiB72fsdHx0qKMy8b3qJQ+N+cF+NrWRAg0dSWDVBeLxX9mtsl2riAubGXojezlvIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRbt4xmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRbt4xmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CA31F00A3D;
	Fri,  4 Sep 2026 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515405;
	bh=si/GGrOQZqX8PnV1Y1WF9QPFFOUlCf0jOEs4tmf5Ouk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRbt4xmLtHwRdJIyG7SSNc+CaQZt8nLJgec3zmxz98RN73gk63hHuuWjjqlKE7A9j
	 J8cvABbF7tvCnjfSPtbApi3/Sv1hxqGJKpaSI2LNHwBvKKoDINxJWWy4r9znqsJYAg
	 cc2s9df9ohyrxYVaJbEAzu6nWVAKUiDZPtPF57FJpFaVFaUsmYkn0K1z7Lsj65hlwb
	 O8f3mi+vlKOo6D/gQI9ceIsSqPXNAt8hfzoURb+M1kNE6K9F+B9zndyawBtj7QNh2h
	 4lZNYon6uYjGTT7mpj4Ds+33ftjLKVjsdm9q36nFR2RM59EYlDbHm4rkmm4FpMMHLQ
	 0wnesq/Q0xYvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 5/6] Squash-to "mptcp: pm: init and
 release mptcp_pm_ops"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904093531.20023-6-gang.yan@linux.dev>
References: <20260904093531.20023-1-gang.yan@linux.dev>
 <20260904093531.20023-6-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:50:04 +0000
Message-Id: <20260904095005.34CA31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Contradictory claim in the commit message regarding module unloa=
ding.
--

commit 954ec9b5378fa18a4b6badb35d44bfbe2edbd12a
Author: Gang Yan <yangang@kylinos.cn>

Squash-to "mptcp: pm: init and release mptcp_pm_ops"

This commit introduces mptcp_pm_ops lifetime handling on sockets and per-net
path managers. It modifies path manager initialization and cleanup routines
to use operations structs directly and take module references.

> This commit introduces the mptcp_pm_ops lifetime handling on sockets
> (mptcp_pm_ops_init/release taking a module reference), and would then
> be the first one whose per-net path managers can be unloaded while a
> pernet still stores them.

[ ... ]

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 87491b961bf27..6379a9f481ac6 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
[ ... ]
> @@ -224,15 +222,22 @@ static int proc_blackhole_detect_timeout(const stru=
ct ctl_table *table,
> =20
>  static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const cha=
r *name)
>  {
> -	struct mptcp_pm_ops *pm_ops;
> +	struct mptcp_pm_ops *pm_ops, *prev;
>  	int ret =3D 0;
> =20
>  	rcu_read_lock();
>  	pm_ops =3D mptcp_pm_find(name);
> -	if (pm_ops)
> -		xchg(&pernet->path_manager, pm_ops);
> -	else
> +	if (pm_ops) {
> +		if (bpf_try_module_get(pm_ops, pm_ops->owner)) {
> +			prev =3D xchg(&pernet->path_manager, pm_ops);

[Severity: Medium]
Does this code contradict the commit message regarding module unloading?

The commit message claims that per-net path managers "can be unloaded while=
 a
pernet still stores them." However, here in mptcp_set_path_manager() (as we=
ll
as in mptcp_pernet_set_defaults()), bpf_try_module_get() is explicitly call=
ed
before storing the pm_ops pointer in the per-net structure.

This increments the module's reference count, which fundamentally prevents =
the
module from being unloaded (e.g., via rmmod) as long as the netns uses it.

Could the commit message or the implementation be clarified to resolve this
mismatch?

> +			if (prev)
> +				bpf_module_put(prev, prev->owner);
> +		} else {
> +			ret =3D -EBUSY;
> +		}
> +	} else {
>  		ret =3D -ENOENT;
> +	}
>  	rcu_read_unlock();
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093531.2002=
3-1-gang.yan@linux.dev?part=3D5
