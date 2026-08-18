Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004F47140E
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057805; cv=none; b=u1aLefOC1VGnRMDaeWtS75m47YA9emdC9O4HyBt+2baO1wFwdBAFXJrFHl7bHulY6JW2b29xn6v6dumJyRfnZKFvQXt3LFLDV9tNY9eAlA+ygbdOTlxjXnsY+fXF8c/vMTgmyGds5odZAQVuLQTK7bVUUtWKXHpieCPiOcy3g1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057805; c=relaxed/simple;
	bh=p5JJuqLylq9ImerUrult5K3ksayef5SjuM4l3CtXeqc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gl8mmzjvCpnkRMSHEpGEI2n7H/x45UaWMawuSDYKNtCGis9A79GXgI8DGQGJeG/TQGS56ma9bqPTHp21FxVjXVl89kRL8GBmT8Er966Y/veKjR2cQ643YiEeNZ0vUelPHEkxykaOAVmYfdFeDkcdeeKfzPj0VLIlMVrgQn8U0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VM9M9F/N; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VM9M9F/N"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=p5JJuqLylq9ImerUrult5K3ksayef5SjuM4l3CtXeqc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787057797; v=1; x=1787662597;
 b=VM9M9F/NnDcd1SZOGjmNklbxLJvZ0JRfsjnmcCBrvPx3OzOsP09DbZJc0c6h2PJLJwZLhKWM
 5EjPikin/GuD3KsYmisNB83LwJhBBnP99cXq4uSHE3JPvFD4N9ZbK6ZbzUbLsueSyz/0Ep964L1
 YU+mlasl6VsCkw7doC6CLE9A=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 4baefb6e2b4a5c1a;
	Tue, 18 Aug 2026 12:56:37 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 12:56:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <a9ef03bb12d3087e8f4af51d6d7dcd9967810942@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2 1/5] mptcp: sched: change scheduler sysctl
 atomically
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818095955.6892E1F000E9@smtp.kernel.org>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-2-gang.yan@linux.dev>
 <20260818095955.6892E1F000E9@smtp.kernel.org>

August 18, 2026 at 5:59 PM, sashiko-bot@kernel.org mailto:sashiko-bot@ker=
nel.org  wrote:


>=20
>=20Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Use-After-Free and module reference leak due to missing refere=
nce counting when setting the default MPTCP scheduler
> - [Medium] Redundant scheduler list traversal during socket initializat=
ion defeats pointer caching
> --
>=20
>=20--- Patch [1]: [PATCH mptcp-next v2 1/5] mptcp: sched: change schedul=
er sysctl atomically ---
> commit d5b1780c033b9909a1b30fbd814812af5c25ed2f
> Author: Gang Yan <yangang@kylinos.cn>
>=20
>=20mptcp: sched: change scheduler sysctl atomically
>=20
>=20This commit changes the per-netns scheduler storage from an inline st=
ring
> to an RCU-protected pointer to an mptcp_sched_ops struct. It updates th=
e
> sysctl read/write paths and socket initialization to use this pointer,
> aiming to prevent concurrent readers from observing half-written names.
>=20
>=20Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
>=20
>=20>=20
>=20> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> >  index 63c5747f0f63c..479b31eb30079 100644
> >  --- a/net/mptcp/ctrl.c
> >  +++ b/net/mptcp/ctrl.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -126,7 +133,7 @@ static int mptcp_set_scheduler(char *scheduler,=
 const char *name)
> >  rcu_read_lock();
> >  sched =3D mptcp_sched_find(name);
> >  if (sched)
> >  - strscpy(scheduler, name, MPTCP_SCHED_NAME_MAX);
> >  + xchg(&pernet->scheduler, sched);
> >=20
>=20[Severity: High]
> When replacing the scheduler pointer here with xchg(), does this leak t=
he
> module reference for the previous scheduler returned by xchg()?
>=20
>=20Also, do we need to acquire a module reference for the newly assigned=
 sched
> via bpf_try_module_get() before storing it? Without a reference, could =
the
> module be unloaded, leaving pernet->scheduler pointing to freed memory =
that
> would trigger a use-after-free when dereferenced by a concurrent reader=
 in
> proc_scheduler()?

Hi Matt,

As far as I know, for linux-master branch, the sched ops cannot be torndo=
wn, and
the only static default scheduler is used, so no reference counting is ne=
eded.

It is safe for now, the pm is as the same. Right?

>=20
>=20[ ... ]
>=20
>=20>=20
>=20> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index c2762d74f29d7..82df0400d0f94 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -3271,8 +3272,8 @@ static int mptcp_init_sock(struct sock *sk)
> >  return -ENOMEM;
> >=20=20
>=20>  rcu_read_lock();
> >  - ret =3D mptcp_init_sched(mptcp_sk(sk),
> >  - mptcp_sched_find(mptcp_get_scheduler(net)));
> >  + mptcp_get_scheduler(net, sched_name);
> >  + ret =3D mptcp_init_sched(mptcp_sk(sk), mptcp_sched_find(sched_name=
));
> >=20
>=20[Severity: Medium]
> Since pernet->scheduler now stores the mptcp_sched_ops pointer directly=
,
> could we retrieve and use that pointer here directly? Extracting the na=
me
> via mptcp_get_scheduler() just to perform a redundant list traversal wi=
th
> mptcp_sched_find() seems to defeat the purpose of caching the operation=
s
> pointer.
>

That's a good point, will done in v3.

Thanks
Gang
=20
>=20>=20
>=20> rcu_read_unlock();
> >  if (ret)
> >  return ret;
> >=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026081809482=
5.48446-1-gang.yan@linux.dev?part=3D1
>
