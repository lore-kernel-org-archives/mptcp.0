Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2093403F9
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972425; cv=none; b=HVq68AOpmBdoelA1d95Z0/HQ/fzZ3MZkV8nECx0e3pTNhrrwy7Q27s/cFyp/XLutHylngm8eIJg0Bmc1O4GUVgBx1dbypPEM74778GPSUM+Uf4wMWVZu4pN+7lF71rkx+j6+cPUGR+6pmq/f+O7vQ4/gI68a4ct7ahFpNa54Dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972425; c=relaxed/simple;
	bh=0zt8b88v+I06ej7QDdNURKE8hfVeJC1tkt6TJwnZ0ZY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Z01tLS8tzVnO2Gq0cbNlEXy1i9OBwm6YFciLsOnAYI2ZHp9RkLcbpZj8+qFSf9bmMpsfVc2SpnrBhDBVv2FjMUcrvdeRHF1WzR9YkITMpog7HxWHrVmla54BZ3S4L4E/bXeuLBHK00Flh7CXWGnTCG6y1BWMlmYybYoOuggv2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WeWcyy5D; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WeWcyy5D"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782972420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFo4TZayrh0bH+8YAfYqgSGMY5Ht3atY2ez2QZQxWv4=;
	b=WeWcyy5DFBVNbqndy34b7/bBCS8RR5q18iv6S38zraXYa050I8bwhJafM6ckVBc1SqLaZh
	de3bFV+yMTnr44aFxMoyC+OXxiPwa9eXjZXn5ZhOsPXwWhgpn8yLT3BoDh+4bGAh+l0C+p
	S77a6ICYAVUxI4PXHqT74xqW8Yq+HGA=
Date: Thu, 02 Jul 2026 06:06:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <61f604096b6834fb48313f35716d993b9a3ac571@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2] Squash-to "mptcp: pm: init and release
 mptcp_pm_ops"
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <e35e67705a9c50e30ad5486e197162501d9cf90a.camel@kernel.org>
References: <20260701073713.197616-1-gang.yan@linux.dev>
 <e35e67705a9c50e30ad5486e197162501d9cf90a.camel@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 2, 2026 at 10:15 AM, "Geliang Tang" <geliang@kernel.org mailto:gelia=
ng@kernel.org?to=3D%22Geliang%20Tang%22%20%3Cgeliang%40kernel.org%3E > wr=
ote:


Hi Geliang,

Thanks for your review.

>=20
>=20Hi Gang,
>=20
>=20Thanks for this v2.
>=20
>=20On Wed, 2026-07-01 at 15:37 +0800, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  This patch removes the need to handle a NULL pm_ops in the fallbac=
k
> >  path, and moves the rcu_read_lock\unlock into mptcp_pm_ops_init.
> >=20=20
>=20>  Following sashiko's comments, it also moves the pr_debug() before
> >  bpf_module_put() in mptcp_pm_ops_release.
> >=20=20
>=20>  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  =C2=A0net/mptcp/pm.c | 19 ++++++++++---------
> >  =C2=A01 file changed, 10 insertions(+), 9 deletions(-)
> >=20=20
>=20>  diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >  index 9dc7b41fb562..5fe4276cf895 100644
> >  --- a/net/mptcp/pm.c
> >  +++ b/net/mptcp/pm.c
> >  @@ -1137,12 +1137,14 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
> >  =C2=A0 spin_unlock_bh(&msk->pm.lock);
> >  =C2=A0}
> >  =C2=A0
> >  -static void mptcp_pm_ops_init(struct mptcp_sock *msk,
> >  - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mptcp_pm_ops *pm_ops)
> >  +static void mptcp_pm_ops_init(struct mptcp_sock *msk, const char
> >  *pm_name)
> >  =C2=A0{
> >  + struct mptcp_pm_ops *pm_ops;
> >  +
> >  + rcu_read_lock();
> >  + pm_ops =3D mptcp_pm_find(pm_name);
> >  =C2=A0 if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> >  - pr_warn_once("pm %s fails, fallback to default pm",
> >  - =C2=A0=C2=A0=C2=A0=C2=A0 pm_ops->name);
> >  + pr_warn_once("pm %s fails, fallback to default pm",
> >  pm_name);
> >  =C2=A0 pm_ops =3D &mptcp_pm_kernel;
> >  =C2=A0 }
> >  =C2=A0
> >  @@ -1151,6 +1153,7 @@ static void mptcp_pm_ops_init(struct mptcp_soc=
k
> >  *msk,
> >  =C2=A0 msk->pm.ops->init(msk);
> >  =C2=A0
> >  =C2=A0 pr_debug("pm %s initialized\n", pm_ops->name);
> >=20
>=20nit: Here we can also print "pm_name" to keep it consistent with
> pr_warn_once().

Here is the print of the name of initialized pm, for example, if we fallb=
ack
to kernel_PM it will print like:

'''
pm bpf_pm fails, fallback to default pm
pm kernel initialized
'''

So I think it should use 'pm_ops->name' here.
WDYT?
>=20
>=20>=20
>=20> + rcu_read_unlock();
> >=20
>=20Then this unlock line can be moved ahead of the previous pr_debug()
> line.

>=20
>=20>=20
>=20> }
> >  =C2=A0
> >  =C2=A0static void mptcp_pm_ops_release(struct mptcp_sock *msk)
> >  @@ -1161,9 +1164,9 @@ static void mptcp_pm_ops_release(struct
> >  mptcp_sock *msk)
> >  =C2=A0 if (pm_ops->release)
> >  =C2=A0 pm_ops->release(msk);
> >  =C2=A0
> >  - bpf_module_put(pm_ops, pm_ops->owner);
> >  -
> >  =C2=A0 pr_debug("pm %s released\n", pm_ops->name);
> >  +
> >  + bpf_module_put(pm_ops, pm_ops->owner);
> >  =C2=A0}
> >  =C2=A0
> >  =C2=A0void mptcp_pm_destroy(struct mptcp_sock *msk)
> >  @@ -1184,9 +1187,7 @@ void mptcp_pm_data_reset(struct mptcp_sock
> >  *msk)
> >  =C2=A0 pm->rm_list_rx.nr =3D 0;
> >  =C2=A0 WRITE_ONCE(pm->pm_type, pm_type);
> >  =C2=A0
> >  - rcu_read_lock();
> >  - mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
> >  - rcu_read_unlock();
> >=20
>=20Or we leave rcu_read_lock() and rcu_read_unlock() where they are,
> without moving them into mptcp_pm_ops_init().
>=20
LGTM,=20I'll apply the reset suggestions when sending v3.
> Thanks,
> -Geliang
>=20
>=20>=20

Thanks
Gang

>=20> + mptcp_pm_ops_init(msk, pm_name);
> >  =C2=A0}
> >  =C2=A0
> >  =C2=A0void mptcp_pm_data_init(struct mptcp_sock *msk)
> >
>
