Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5446EF84
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057877; cv=none; b=a5cy4o/sw34HK5ldmVr8y10dPJlKdYry2oZ9IsxiYIutRILsKN+J9ia6lvIXs4Pj+v/n1xZuBA+aG01YhyR0YCtFDGDmLQALW7aAJCJmTv0RCCCki1bUaHDQNwKpp0pVQfn7bDCdpCOyvlQyJK5C0t6h7IoCzaDd5kdGZAECD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057877; c=relaxed/simple;
	bh=00s5P5+IQBgrycNh3dYbl7w4DrXpvdGxOFhlz4qIwqU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=UK4NW4251v13C2opmj/4G6gMoGZTgmRgj+RVwI+Nt7pfVt1391uWXg3rtlQkyKbW7wwjHwlPEnwdKrIc9wfLYMnfSAyBa1SBF3uZk1xKHCanNRB6rprdWVBHa7dYx60XdYus6P+tmU7ZJnYGjMe+/2WJ+rQIZc95vzzSCUVXHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRdoaLed; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRdoaLed"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=00s5P5+IQBgrycNh3dYbl7w4DrXpvdGxOFhlz4qIwqU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787057873; v=1; x=1787662673;
 b=JRdoaLedfpRqhUTGYf6IkAoRN8UvNJmALqo59KrlInXgkhbsyB+iVcyTZQSKLOHieeVk/E1k
 xS3MYQMUf4StuhckTLHzfgfa0Ez2f3jdE35+WrWzj8zIBvkF/n3QK5xlWWXowk2VQs3aiJ/mdln
 OlshIkUwb+/1KxoMNuHwSELc=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id ea401fb4529652e4;
	Tue, 18 Aug 2026 12:57:52 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 12:57:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <6699d1f7ea653cd3658d77a63c7f92da9134ae8f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: pm: change path_manager sysctl
 atomically
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818100051.2A1BE1F000E9@smtp.kernel.org>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-3-gang.yan@linux.dev>
 <20260818100051.2A1BE1F000E9@smtp.kernel.org>

August 18, 2026 at 6:00 PM, sashiko-bot@kernel.org mailto:sashiko-bot@ker=
nel.org  wrote:


>=20
>=20Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Missing module reference counting when setting the path manage=
r sysctl leads to a Use-After-Free.
> - [High] Missing module reference counting when setting the scheduler s=
ysctl leads to a Use-After-Free.
> --

Hi, Matt

As described in [1], it is safe for now.

Do you have some suggestions here? Or we can ignore these.

Thanks
Gang

>=20
>=20--- Patch [2]: [PATCH mptcp-next v2 2/5] mptcp: pm: change path_manag=
er sysctl atomically ---
> commit c42ca00640178ef2df1ab9f51d1f65a9b722ec86
> Author: Gang Yan <yangang@kylinos.cn>
>=20
>=20mptcp: pm: change path_manager sysctl atomically
>=20
>=20The per-netns path manager name is stored as an inline char[] buffer =
and
> updated via strscpy() from the sysctl handler; a concurrent reader can
> observe a half-written name. This patch replaces the string with a
> pointer to the immutable struct mptcp_pm_ops.
>=20
>=20Link: https://github.com/multipath-tcp/mptcp_net-next/issues/626
>=20
>=20>=20
>=20> Following the tcp_congestion_control() model (and the scheduler cha=
nge in
> >  the previous patch), store a pointer to the immutable struct mptcp_p=
m_ops
> >  instead of the name string:
> >=20
>=20[Severity: High]
> Since this patch follows the scheduler change in the previous patch, do=
es
> mptcp_set_scheduler() have the same module reference counting issue?
>=20
>=20If mptcp_set_scheduler() assigns pernet->scheduler without acquiring =
a
> module reference, and the BPF map is unloaded, could a new MPTCP socket
> creation trigger mptcp_init_sock() which calls mptcp_get_scheduler(),
> causing a Use-After-Free when it dereferences the freed sched pointer?
>=20
>=20>=20
>=20> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> >  index 479b31eb30079..c0481b09c1a17 100644
> >  --- a/net/mptcp/ctrl.c
> >  +++ b/net/mptcp/ctrl.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -85,9 +85,14 @@ int mptcp_get_pm_type(const struct net *net)
> >  return mptcp_get_pernet(net)->pm_type;
> >  }
> >=20=20
>=20>  -const char *mptcp_get_path_manager(const struct net *net)
> >  +void mptcp_get_path_manager(const struct net *net, char *name)
> >  {
> >  - return mptcp_get_pernet(net)->path_manager;
> >  + struct mptcp_pm_ops *pm_ops;
> >  +
> >  + rcu_read_lock();
> >  + pm_ops =3D rcu_dereference(mptcp_get_pernet(net)->path_manager);
> >  + strscpy(name, pm_ops ? pm_ops->name : "kernel", MPTCP_PM_NAME_MAX)=
;
> >=20
>=20[Severity: High]
> If the module was unloaded and the pointer was not pinned, would this
> dereference of pm_ops->name result in a Use-After-Free?
>=20
>=20>=20
>=20> + rcu_read_unlock();
> >  }
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -201,7 +206,7 @@ static int proc_blackhole_detect_timeout(const =
struct ctl_table *table,
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> rcu_read_lock();
> >  pm_ops =3D mptcp_pm_find(name);
> >  if (pm_ops)
> >  - strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
> >  + xchg(&pernet->path_manager, pm_ops);
> >=20
>=20[Severity: High]
> Does this assignment need to pin the module (e.g., via bpf_try_module_g=
et())
> before saving the pointer?
>=20
>=20If a user with CAP_NET_ADMIN sets a BPF struct_ops map as the default=
 path
> manager, and then unloads the BPF program, the map is deleted and the
> struct mptcp_pm_ops memory is freed.
>=20
>=20Could this leave a dangling pointer in pernet->path_manager that caus=
es the
> Use-After-Free mentioned above when mptcp_get_path_manager() is subsequ=
ently
> called?
>=20
>=20>=20
>=20> else
> >  ret =3D -ENOENT;
> >  rcu_read_unlock();
> >=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026081809482=
5.48446-1-gang.yan@linux.dev?part=3D2
>
