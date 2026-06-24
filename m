Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1262745E
	for <mptcp@lists.linux.dev>; Wed, 24 Jun 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305192; cv=pass; b=FqXquQzePCQRXIsF0q32jGK+zOw2vM6AGzB9NnkU3XQHpqh1uHiynOYWVkLMA/fg8IIUKNesQCAqytwV8XwRX2UYr7sOlmQqaGtWNllVAup11TM8EKS8ysme4uwf2PPuAOuLgkn6e/NmaqI8/r/QxrLV/8/NlnnVKzUCotetSZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305192; c=relaxed/simple;
	bh=GrK4rW+ff6lB8mItWjBa9oIs2DXat9tSzdkI21WWb1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdz7ekJNHVGtBp+O7zgIxTpzkgnymoOz6n6hth3QUG1YvdfzNjI0LLEdzOM/dtWWm6oao637LhiUdjHriyESKGIdN6knCxxflUUGGm5839oCQzXyoZO3blDXDBnjqVHcfsQGA7xd/JJ6fe5YeK2bhY+9Iu9rqPNAKZ69BTDuRz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=UZkj2Fqi reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="UZkj2Fqi"
ARC-Seal: i=1; a=rsa-sha256; t=1782305184; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RKtjAiOkQUkxOLCiHeu8MMmMPiU+sRefK8ClmeuXlQfAdBm94Ne2T/PSIGsFF3Od4C7HAPbrPtyMAufw43+pD372dh8SDnKzJXqPISeB14J+pyUm2DIB2CpsKyXC0QattjYCKvfsWNRxkECiITb6IEJsOyUaCOid2RWIC+doVHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782305184; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GrK4rW+ff6lB8mItWjBa9oIs2DXat9tSzdkI21WWb1A=; 
	b=PspV/VEGv19OOMomV5AQbvbsbKuio7Avwat18shJp+p/Kc81BI/b98griDTcsUe0tkxrmtCWhlLHJ8inK5fTopQR+EOnQjP/HL+UMm2xmXozP50IYSi+hO4AlMM1SXu4pX8P4tcWk0idpI5zZc8WCL2fCCJh0fXSs/F5jFTXkTE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782305184;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=GrK4rW+ff6lB8mItWjBa9oIs2DXat9tSzdkI21WWb1A=;
	b=UZkj2Fqiew8GZnYcZxBk3QcuIi1Jw8uW/Oxi5GjZWOGOvgjx4X43Xa5JVXJIdkUr
	6KLETnjU4gQrrTOuRG6Fy2QEMxtpG6L3pIcZhKzbqYIDZ13Iuwf7sgcPzg11PtUYSO/
	0itw6BFMIGEWkXRsB9kcaxMEqAj80mDtO44oTmro=
Received: by mx.zohomail.com with SMTPS id 1782305182354454.6551242567332;
	Wed, 24 Jun 2026 05:46:22 -0700 (PDT)
Message-ID: <fe240744590015e557feccbbdf0c5c0a06546eff.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: fix memory leak from
 alloc-during-teardown race
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
  pabeni@redhat.com, kalpan.jani@mpiricsoftware.com, janak@mpiric.us, 
 akshit@mpiricsoftware.com
Date: Wed, 24 Jun 2026 18:16:14 +0530
In-Reply-To: <b0dccb83-b9de-4207-9132-f3944bc3d5e6@kernel.org>
References: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
	 <20260620084424.3072634-3-shardul.b@mpiricsoftware.com>
	 <b0dccb83-b9de-4207-9132-f3944bc3d5e6@kernel.org>
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

Hi Matt,

Thanks for the review, and for flagging Sashiko's note.

On Mon, 2026-06-22 at 19:37 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> Thank you for the v4!
>=20
> (Note: please make sure to keep the version in the prefix -- b4 does
> that for you automatically ;) -- to help with the patch tracking)
>=20

Yes I'll be more careful, thanks for pointing it out.

> On 20/06/2026 10:44, Shardul Bankar wrote:
> > mptcp_pm_destroy() empties msk->pm.anno_list and
> > msk->pm.userspace_pm_local_addr_list under msk->pm.lock during
> > socket
> > teardown, dropping the lock between the two.
> >=20
> > A concurrent userspace PM genl ANNOUNCE on the same msk holds a
> > sock
> > reference via mptcp_token_get_sock() and, in
> > mptcp_pm_nl_announce_doit(), calls
> > mptcp_userspace_pm_append_new_local_addr() and
> > mptcp_pm_announced_alloc(). Both take msk->pm.lock briefly to add
> > to
> > their respective lists. Because the genl handler holds a sock
> > reference,
> > mptcp_pm_destroy() may run on the same msk via mptcp_disconnect(),
> > which
> > invokes mptcp_destroy_common() without dropping the sock refcount,
> > before the handler completes.
>=20
> Sashiko seems to say [1] that the mptcp_disconnect() path is not
> covered
> (when 'shutdown()' then 'connect()' is called from the userspace),
> but
> it looks like that's what you are covering it. Just to be sure: is it
> a
> false positive? (I didn't check the different code path to see if
> that's
> possible)
>=20
> [1]
> https://sashiko.dev/#/patchset/20260620084424.3072634-1-shardul.b%40mpiri=
csoftware.com?part=3D2
>=20
> Cheers,
> Matt


It's a false positive for the leak, and your reading is right.

The factual part of the note is true: mptcp_pm_destroy() sets
MPTCP_PM_DESTROYING, but mptcp_disconnect() then calls
mptcp_pm_data_reset(), whose memset(&pm->reset, ...) clears the bit
(status lives in the reset struct_group). So the bit deliberately does
not survive a disconnect(). It just doesn't cause a leak, because the
two teardown paths are covered by two different mechanisms:

- Final teardown: __mptcp_destroy_sock() sets pm.status =3D 0 and then
calls sk_prot->destroy() -> mptcp_destroy_common() ->
mptcp_pm_destroy(), which sets DESTROYING under pm.lock right around
the list free. There is no pm_data_reset() afterwards, so the bit
persists. A concurrent ANNOUNCE
(mptcp_userspace_pm_append_new_local_addr() runs under pm.lock only,
before announce_doit() takes lock_sock()) either runs before the free
and gets reclaimed, or sees DESTROYING and aborts. This is the race the
fence exists for.

- disconnect()/reuse: the userspace list free in mptcp_pm_destroy() is
unconditional (patch 1/2) and runs on every teardown. An entry appended
after the disconnect-time reset lands on the reused, still-live socket
and is reclaimed by the unconditional free at that socket's next
teardown. So it is never orphaned. The fence bit being reset here is
harmless by design.

Thanks,
Shardul
