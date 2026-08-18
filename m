Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB853537C4
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047252; cv=none; b=H7l+7CyQQE8FpyM0IqHUPpd0vlpHMrTc/kCSozb/GvlTghhW1ZmfTsOY3B7ml6xd9lAm4v56SIDipm/PfBubdU/OYEhOxGpws++uAO871UiQJUxS3x/hjcOxk+ToRxJ+MqxsjyZLf/HQiI5tLIN7nlXatRgTkmsyH9lm4s9EDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047252; c=relaxed/simple;
	bh=8Etv4Qo/RP0QJUX+bLWJiXnVJh4I9cwZooALXJSMCpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQJm08hNMmKfMcQC8LXv79kfPx2wuPWrkyOfiRgknFt0up5UvD17aNtLLkWmmv/H+zTSEWEe/z1wZtSv5Ny6iAVEsc5osDYyJKEZ9jYOP1qnO9bU+j26vS/aClSvMRD4Hr2k2NlM976Fv2T9afYlNLHoYdsa8dpQ60KKGy4S4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC5lTQjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC5lTQjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1BE1F000E9;
	Tue, 18 Aug 2026 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047251;
	bh=C/pkq7BGUzxCdExn7fTQvPabiBhLKWs/0ywqfOIU+OM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XC5lTQjpepwCWexo0F9o+nzEwPtzRQC/C98669UjPrgxKT+XDYvW80eELYEamp2KM
	 W7MVY8g15lP8UxtpTbaDUydrXEZJ7G1xKLrTfaWltSGFZ0gEsWeX88j5P/Rojrmif1
	 qZmtItgnntthWVtNm9tKOmxo8l1piZZIeHuLRKXlqQZt1vPBPN3YrnZCT6WLAVHBk8
	 koXe7BwUbEfSclh6aRn7vyDkzfz5eNeNEGGsMYcloulOD56s5UDIcoQOYpXQIHdhw/
	 X5QAjvSGoMoJHUUrRM2O63NGKlz6UUm+f6kY94NtUqEizxpEN1DV4mwrlJaPAXtDoF
	 acDMo+MB4sr5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: pm: change path_manager sysctl
 atomically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818094825.48446-3-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-3-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:00:50 +0000
Message-Id: <20260818100051.2A1BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing module reference counting when setting the path manager sy=
sctl leads to a Use-After-Free.
- [High] Missing module reference counting when setting the scheduler sysct=
l leads to a Use-After-Free.
--

--- Patch [2]: [PATCH mptcp-next v2 2/5] mptcp: pm: change path_manager sys=
ctl atomically ---
commit c42ca00640178ef2df1ab9f51d1f65a9b722ec86
Author: Gang Yan <yangang@kylinos.cn>

mptcp: pm: change path_manager sysctl atomically

The per-netns path manager name is stored as an inline char[] buffer and
updated via strscpy() from the sysctl handler; a concurrent reader can
observe a half-written name. This patch replaces the string with a
pointer to the immutable struct mptcp_pm_ops.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/626

> Following the tcp_congestion_control() model (and the scheduler change in
> the previous patch), store a pointer to the immutable struct mptcp_pm_ops
> instead of the name string:

[Severity: High]
Since this patch follows the scheduler change in the previous patch, does
mptcp_set_scheduler() have the same module reference counting issue?

If mptcp_set_scheduler() assigns pernet->scheduler without acquiring a
module reference, and the BPF map is unloaded, could a new MPTCP socket
creation trigger mptcp_init_sock() which calls mptcp_get_scheduler(),
causing a Use-After-Free when it dereferences the freed sched pointer?

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 479b31eb30079..c0481b09c1a17 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
[ ... ]
> @@ -85,9 +85,14 @@ int mptcp_get_pm_type(const struct net *net)
>  	return mptcp_get_pernet(net)->pm_type;
>  }
> =20
> -const char *mptcp_get_path_manager(const struct net *net)
> +void mptcp_get_path_manager(const struct net *net, char *name)
>  {
> -	return mptcp_get_pernet(net)->path_manager;
> +	struct mptcp_pm_ops *pm_ops;
> +
> +	rcu_read_lock();
> +	pm_ops =3D rcu_dereference(mptcp_get_pernet(net)->path_manager);
> +	strscpy(name, pm_ops ? pm_ops->name : "kernel", MPTCP_PM_NAME_MAX);

[Severity: High]
If the module was unloaded and the pointer was not pinned, would this
dereference of pm_ops->name result in a Use-After-Free?

> +	rcu_read_unlock();
>  }
[ ... ]
> @@ -201,7 +206,7 @@ static int proc_blackhole_detect_timeout(const struct=
 ctl_table *table,
[ ... ]
>  	rcu_read_lock();
>  	pm_ops =3D mptcp_pm_find(name);
>  	if (pm_ops)
> -		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
> +		xchg(&pernet->path_manager, pm_ops);

[Severity: High]
Does this assignment need to pin the module (e.g., via bpf_try_module_get())
before saving the pointer?

If a user with CAP_NET_ADMIN sets a BPF struct_ops map as the default path
manager, and then unloads the BPF program, the map is deleted and the
struct mptcp_pm_ops memory is freed.

Could this leave a dangling pointer in pernet->path_manager that causes the
Use-After-Free mentioned above when mptcp_get_path_manager() is subsequently
called?

>  	else
>  		ret =3D -ENOENT;
>  	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818094825.4844=
6-1-gang.yan@linux.dev?part=3D2
