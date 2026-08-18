Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27FF472547
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058429; cv=none; b=VgGxIQ1aZkXfkWIZdb5WJZR2mcj7IbB7oHMMLK0F1aWsSxyavwtc1hTGrEwGGLVQYvKAloKurLZ7wG99TR/1grwVEvs96R7eVanuG0DjNnq5cleOIbt7FcF1jlZNBccQ4ocz9slJsqdNAX3x7WeEy17KIJy8kVHGJFhJK6BIHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058429; c=relaxed/simple;
	bh=J6CX9Or13sILzDI7EXo0kbOPuVq3rgsZXPRBMX0U7FA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MQjBx2Aud3n0KAKXTWafm89XEoa6nENETN0V66QidDNIocxPaANduVtgNZPs7YyDFWAE5tdhj3OloD+/uWF/e3aOkUfhmyh091Y/eq3ESKnPX2UNItZnpaRXKccnF6KLXSr5vyXgkrYo2dTEbk24mlePrf0S3RDyQQwsN1rxI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWuL+IUM; arc=none smtp.client-ip=95.215.58.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWuL+IUM"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=J6CX9Or13sILzDI7EXo0kbOPuVq3rgsZXPRBMX0U7FA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787058425; v=1; x=1787663225;
 b=FWuL+IUM+fcSVHIYRNLOGQWtUshH0qMqn+BhWs0kiDJM5hAW9cqLhjDlK6Jl4ekubVgLUbTf
 RV3dxbWP3Wt0IHpi+ULdG/i0mxM23KGwosihM2yNJ7iT3Vu4zzttSXXDjd2Vgu3rVuGhQX5bDsa
 0Wprq2xNuCmU2FXyVIBrw2Mo=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id ace1adf4b90b2e3e;
	Tue, 18 Aug 2026 13:06:54 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 13:06:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <bfb2cbff326ea2bd88562c62cf036ac3b37edc5e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2 4/5] Squash to "mptcp: pm: init and release
 mptcp_pm_ops"
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818100345.8DA631F000E9@smtp.kernel.org>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-5-gang.yan@linux.dev>
 <20260818100345.8DA631F000E9@smtp.kernel.org>

August 18, 2026 at 6:03 PM, sashiko-bot@kernel.org mailto:sashiko-bot@ker=
nel.org  wrote:


>=20
>=20Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [Medium] Resource Leak on Error Path in `mptcp_net_init`
> --
>=20
>=20--- Patch [4]: [PATCH mptcp-next v2 4/5] Squash to "mptcp: pm: init a=
nd release mptcp_pm_ops" ---
> commit b8f493287a2fef63b437fe19fc22666b77c1c08b
> Author: Gang Yan <yangang@kylinos.cn>
>=20
>=20Squash to "mptcp: pm: init and release mptcp_pm_ops"
>=20
>=20This commit introduces lifetime handling for mptcp_pm_ops at the pern=
et
> level. It pins the default mptcp_pm_kernel by taking a module reference
> during pernet defaults initialization and releases it during network
> namespace exit.
>=20
>=20>=20
>=20> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> >  index 733706f06f1b1..32268aa260976 100644
> >  --- a/net/mptcp/ctrl.c
> >  +++ b/net/mptcp/ctrl.c
> >  @@ -124,7 +124,9 @@ static void mptcp_pernet_set_defaults(struct mpt=
cp_pernet *pernet)
> >  pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
> >=20=20
>=20>  RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
> >  - RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
> >  +
> >  + if (bpf_try_module_get(&mptcp_pm_kernel, mptcp_pm_kernel.owner))
> >  + RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
> >=20
>=20[Severity: Medium]
> Does this introduce a module reference leak regression on the error pat=
h
> during network namespace initialization?
>=20
>=20When mptcp_pernet_set_defaults() takes this module reference, it is c=
alled
> from mptcp_net_init() right before mptcp_pernet_new_table():
>=20
>=20mptcp_net_init() {
>  mptcp_pernet_set_defaults(pernet);
>  return mptcp_pernet_new_table(net, pernet);
> }
>=20
>=20If mptcp_pernet_new_table() fails and returns an error, the error is
> propagated without releasing the module reference acquired here. Becaus=
e the
> initialization failed, the core network namespace code will not call th=
e
> corresponding exit function mptcp_net_exit() to release it.
>=20
>=20Should mptcp_net_init() clean up the reference if mptcp_pernet_new_ta=
ble()
> fails?
>=20

Good=20catch.

Maybe check the return val of mptcp_pernet_new_table could handle this. I=
t can
be done in v3.

Thanks
Gang


> [ ... ]
>=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026081809482=
5.48446-1-gang.yan@linux.dev?part=3D4
>
