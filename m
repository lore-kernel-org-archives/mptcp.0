Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A534BA33
	for <mptcp@lists.linux.dev>; Mon,  6 Jul 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335852; cv=pass; b=seQbWSI5pus0ZNN0C0AZ4LeiymyT1zO6MNbAzdORCKcy98pFm5Gpmg7MpPLK7jKYf160Ek5qkXAp5Ukn1r0lGsHrmM3TZv+puz+qg8KSj8K0xjZz8MsUtfFrwf/cumbgOBI3bh3phgkrQF6KHwx7MIAPl5l84ox/WzoNJMShZhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335852; c=relaxed/simple;
	bh=1imx64ZrpyRSFQZsb0a2InZGG2NtpdSFBVbGK3/rwH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPk8IBEIo81R5/BXWvbLCEjjZg6UqOofcZDMAj/Lj89sQZDv2DbkQn8URnaOETls7tUpdX37RuSthPY25+er9bzeHxBo++7PhZFofpXjUrnAR94KfI+INQ+7n848zL4kPWFP5OagLm5PpERP4hPGJc6fcH7YnZBNgkwHFyaqEoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=oFhv2Vzb reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="oFhv2Vzb"
ARC-Seal: i=1; a=rsa-sha256; t=1783335844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mGGN1SetT9DZJS7p0uWGdkFZwtK+zeaEAm8DEls0X2xUc/aEkpjBMPsHjXG/A8D2CM8y0ltIp1RXUEXngf7S3bOzMxy71tm293u390XOcOAy86cRTmwbHtMj1k5VFTe8GrfcBbivBPgSNvoI6mMAh4hk+7Dq0udo4U9YjCDIiOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783335844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1imx64ZrpyRSFQZsb0a2InZGG2NtpdSFBVbGK3/rwH4=; 
	b=kgfhVNW2ikPG6m9b/hcxjoSRHs0h3kpbZ9Gj1jmv4D7tX4KxBpfcKtVOQZvlG5s1QmROm/wKA0p13worhERkKGg2Bu14s+J6/r2eJQehTB/ye8GiKhl9+xMZdmtESs0mARV4RggbWYbtCFEBTeLJaiq5uIBdW8WhFTZQjiBmoFc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783335844;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=1imx64ZrpyRSFQZsb0a2InZGG2NtpdSFBVbGK3/rwH4=;
	b=oFhv2Vzb6DSYkh212q21YPbh2I+7tv2BhkAJa9e1d4nyL37Z5VclqtEmcGfRw/Fa
	Xfd8bF2CfgtB9bMWR++hRgcbski/rZ8Iju0RKx68aqbPlup0ZNyUpHRrv7EA8rag4Gp
	yUWyI0VoJpXXEf/SCo/6TCE34n0gGRV4+y2cZMUA=
Received: by mx.zohomail.com with SMTPS id 178333584121749.64622623077287;
	Mon, 6 Jul 2026 04:04:01 -0700 (PDT)
Message-ID: <2ec98c9e15ef4f96d01be048c59b160069cb3923.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v2 2/5] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Mon, 06 Jul 2026 16:33:54 +0530
In-Reply-To: <0dc8e723ee2af76224d2fe23eca6c4891207fbe0.camel@kernel.org>
References: 
	<20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
	 <20260703-mptcp_bpf_kfunc_fixes-v2-2-87ae3c64dc7e@mpiricsoftware.com>
	 <0dc8e723ee2af76224d2fe23eca6c4891207fbe0.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Geliang,

Thanks for taking a look.

On Mon, 2026-07-06 at 14:34 +0800, Geliang Tang wrote:
> Hi Shardul,
>=20
> Thanks for this v2. It's much better now.
>=20
> On Fri, 2026-07-03 at 22:27 +0530, Shardul Bankar wrote:
> > ...
> > ...
>=20
> Sashiko complained that the rcu lock is not held here [1]. It seems
> we
> can add the lock, something like:
>=20
> =C2=A0=C2=A0=C2=A0 rcu_read_lock();
> =C2=A0=C2=A0=C2=A0 subflow =3D mptcp_subflow_ctx(ssk);
> =C2=A0=C2=A0=C2=A0 if (subflow && subflow->conn =3D=3D (const struct sock=
 *)msk)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_=
pm_subflow_chk_stale(msk, ssk);
> =C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>=20
>=20
> WDYT?
>=20
> Thanks,
> -Geliang
>=20
> [1]
> https://sashiko.dev/#/patchset/20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c=
64dc7e@mpiricsoftware.com?part=3D2
>=20
>=20

I don't think we need the rcu_read_lock() here, and I think it would
actually be unsafe.

The subflow context is freed with kfree_rcu(), but in this path the msk
socket lock prevents that free, so rcu_read_lock() is not needed.
get_retrans() runs with the msk lock held (msk_owned_by_me() in
mptcp_sched_get_retrans()). A subflow is removed from msk->conn_list by
__mptcp_close_ssk() under that same lock, and only then can it be torn
down and its context freed, so it cannot be freed while get_retrans()
is running. The in-kernel mptcp_subflow_get_retrans() relies on exactly
this: it dereferences the subflow and calls
mptcp_pm_subflow_chk_stale() under the msk lock, without
rcu_read_lock().

rcu_read_lock() would also not be the right call here:
mptcp_pm_subflow_chk_stale() is not a pure reader (it updates subflow-
>stale_count and can trigger a retransmit), so it needs the msk lock
for serialization, which rcu_read_lock() would not provide. It is also
KF_SLEEPABLE and can sleep (its stale path takes lock_sock_fast() and
calls __mptcp_push_pending()), so it cannot run inside an RCU
read-side critical section anyway.

So I'd prefer to keep the code as is. If it helps, I can add a short
comment noting that the msk lock keeps the subflow context alive. Does
this address the concern?

Thanks,
Shardul
