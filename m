Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27811217704
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203665; cv=none; b=ExJbuTLoVgQzO9cxcjm8k/+5UvL04IdimKLKUKwPdUzll5FfqAFEW63KzyvG9CYprd61U/E3pDFWDxEztZw0Iv736nCrPlPembQa9ndj2w7JUSKM6W4ZZ6xgkvhnHbP0rMxXrwtASx+KVJ6Z1l44xZ4G1KIgHsbZWMOAKF6m91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203665; c=relaxed/simple;
	bh=3H9gDiu5b6XcZn4Kls+VYCYrWPhF93T4I1RYRk++4T8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bFS2JO/CTEedMRzKMq+D+D0X79j2KV7eUQBkX6COFbyPElO33feQY8gG90QNVZd6qoeUl4FbYtN6X5a03Zmo9mP33dz2zZmH5ShAva/cQLst7Buk5c0bvb70Z+BCrtuc/SfRDSnPqHAM16Ha1vPJO/BZI8RvI5rR4tf7a03KmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhE9wtwp; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhE9wtwp"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785203660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+02zH+KH0UQpDDmzD8/252rwP2Pf6gWaagh1tgOeiY=;
	b=fhE9wtwpcznFIE14/J3bD2y78ai4FA3L5ZUlaLdcHNE27pK0wjA6EqwsO6mPQ1VAO6CKx8
	7C8DOm0Lg5l1OaJXoLLdLZ8snetE4o6wQfAnUxraoU8poXdxH3cRg+BqRRgBV2iHIIxyHU
	WDmNqvJoQuMymxTgeRQ8SNh6W5rM36M=
Date: Tue, 28 Jul 2026 01:54:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <b1a6b022b19d0f127964501acb1a7f1a3e9071d4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v3 1/7] mptcp: drop unused @max arg of
 __mptcp_setsockopt_set_val
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <13793643d394a86e9f16ca02c1f18cc75adf7a28.camel@kernel.org>
References: <20260727022849.20923-1-gang.yan@linux.dev>
 <20260727022849.20923-2-gang.yan@linux.dev>
 <13793643d394a86e9f16ca02c1f18cc75adf7a28.camel@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 27, 2026 at 2:37 PM, "Geliang Tang" <geliang@kernel.org mailto:gelia=
ng@kernel.org?to=3D%22Geliang%20Tang%22%20%3Cgeliang%40kernel.org%3E > wr=
ote:


>=20
>=20On Mon, 2026-07-27 at 10:28 +0800, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  The @max argument is never read in the function body. Remove it an=
d
> >  the
> >  MAX_TCP_KEEP* values passed by the TCP_KEEPIDLE/INTVL/KEEPCNT
> >  callers.
> >=20
>=20No, we shouldn't drop this "max" argument. Instead, we need to add so=
me
> code to check the "val" argument against the "max" argument in
> __mptcp_setsockopt_set_val(), something like:
>=20
>=20 if (val < 1 || val > max)=20
>=20 return -EINVAL;
>=20

Hi=20Geliang

Thank you for the review and the suggestion to add a range check inside _=
_mptcp_setsockopt_set_val().

But, I noticed that the underlying TCP helper functions already perform t=
heir
own parameter validation internally.=20

Given=20that these helpers already enforce the same bounds, I would like =
to ask
for your opinion: Is it still necessary to add an extra check in the MPTC=
P layer?

Thanks
Gang


> >=20
>=20> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  =C2=A0net/mptcp/sockopt.c | 11 ++++-------
> >  =C2=A01 file changed, 4 insertions(+), 7 deletions(-)
> >=20=20
>=20>  diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> >  index fcf6feb2a9eb..9c4faa0d82ef 100644
> >  --- a/net/mptcp/sockopt.c
> >  +++ b/net/mptcp/sockopt.c
> >  @@ -632,7 +632,7 @@ static int
> >  mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_=
t
> >  =C2=A0 return ret;
> >  =C2=A0}
> >  =C2=A0
> >  -static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int
> >  max,
> >  +static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk,
> >  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*set_val)(struct sock *,
> >  int),
> >  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *msk_val, int val)
> >  =C2=A0{
> >  @@ -876,18 +876,15 @@ static int mptcp_setsockopt_sol_tcp(struct
> >  mptcp_sock *msk, int optname,
> >  =C2=A0 ret =3D __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
> >  =C2=A0 break;
> >  =C2=A0 case TCP_KEEPIDLE:
> >  - ret =3D __mptcp_setsockopt_set_val(msk,
> >  MAX_TCP_KEEPIDLE,
> >  -=20
>=20>  &tcp_sock_set_keepidle_locked,
> >  + ret =3D __mptcp_setsockopt_set_val(msk,
> >  &tcp_sock_set_keepidle_locked,
> >  =C2=A0 &msk-
> > keepalive_idle, val);
> >  =C2=A0 break;
> >  =C2=A0 case TCP_KEEPINTVL:
> >  - ret =3D __mptcp_setsockopt_set_val(msk,
> >  MAX_TCP_KEEPINTVL,
> >  -=20
>=20>  &tcp_sock_set_keepintvl,
> >  + ret =3D __mptcp_setsockopt_set_val(msk,
> >  &tcp_sock_set_keepintvl,
> >  =C2=A0 &msk-
> > keepalive_intvl, val);
> >  =C2=A0 break;
> >  =C2=A0 case TCP_KEEPCNT:
> >  - ret =3D __mptcp_setsockopt_set_val(msk,
> >  MAX_TCP_KEEPCNT,
> >  -=20
>=20>  &tcp_sock_set_keepcnt,
> >  + ret =3D __mptcp_setsockopt_set_val(msk,
> >  &tcp_sock_set_keepcnt,
> >  =C2=A0 &msk-
> > keepalive_cnt,
> >  =C2=A0 val);
> >  =C2=A0 break;
> >
>
