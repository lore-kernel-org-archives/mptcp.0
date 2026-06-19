Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86E3B8139
	for <mptcp@lists.linux.dev>; Fri, 19 Jun 2026 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885272; cv=pass; b=d+A1mXXGPGfP3GNaa3IBt514Ov7thopHgXunqoydWqTbFUmXRG0bxoI0qv9kWG2EelxqRICC+ne9qHxWB6FJ9SzyNfLvzQM1A66K4G2kelXX3rcWAcn83dhjrhOD/7nvSIrk4tQAdKsdD4n8LvgMr2gv3SV24KcBMwgBbfYMc5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885272; c=relaxed/simple;
	bh=1DeZUoHZS0MPKVrXYbF2L5zTtU/cqAsx2CjPz40OEFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBwWkveXxX7HtBjxhQ+pKSQMyYScymXiB0+15oyL0f7nb0rp02khizcpa9g7EosCipi+nKmPQ0tUuLM5AKpIoNFAdrrjtFveoRXkRaVGjslUvb/Xyq7U0p5L4WyHqtRL8Vx2DwlKMowaQagSP9t/kIJBVkG7YWCxf1V/5p440fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=r7w+wASD reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="r7w+wASD"
ARC-Seal: i=1; a=rsa-sha256; t=1781885264; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BYJjgiIHiEqbkty/gqMBo+rzTE2pao2IwkIgy/4azFkp2JywkfKzDnLDNX+Ims5GEk8tsf7ynKBZq3jG8WpMc3YgpI4z9fmASBAY4FquDaDSia4askZS03cwhZgwai3Rq8xNAPXbFwQrSlYl41X5bxaJj4Im5l9afVWVP0kGGrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781885264; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1DeZUoHZS0MPKVrXYbF2L5zTtU/cqAsx2CjPz40OEFo=; 
	b=VH1qs9wmLunQngkZBy8TDirQGIFm+KDpU6srr5hSHCg67ZaCz31OAf3jyz3Q4fywNCJFYuctREvFo/0i4YTqie1wg69iKbGXnTbEOXQLujLU2ZOc/V5GGVC1jhqUONtEOBvRvpDcZxwQ4UPluvRgHmhzQs0S0dRJpoYJCAIqD88=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781885264;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=1DeZUoHZS0MPKVrXYbF2L5zTtU/cqAsx2CjPz40OEFo=;
	b=r7w+wASDAsrRoUC/BzZoSgcjOsbISS/RJ47CYH/wuzROFbk4Mfh5947miIz7VB/N
	y1xwSGNhMbxsejj4UJE3iIOLew+Q8aQtd3WUBg2XwxqsP4yC5czW+nREfq0JFojudS8
	9mzQklrdaVXQvEunI35AlFhM1jQCLYiiYSpQ0mJc=
Received: by mx.zohomail.com with SMTPS id 1781885261462872.574317420759;
	Fri, 19 Jun 2026 09:07:41 -0700 (PDT)
Message-ID: <4fb51400e35eb791254d8614595ffe8329fc8bd8.camel@mpiricsoftware.com>
Subject: Re: [PATCH net v3] mptcp: pm: fix memory leak from
 alloc-during-teardown race
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us,  kalpan.jani@mpiricsoftware.com
Date: Fri, 19 Jun 2026 21:37:34 +0530
In-Reply-To: <1c5c7f6c-8398-432a-9756-63eab3746016@kernel.org>
References: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
	 <1c5c7f6c-8398-432a-9756-63eab3746016@kernel.org>
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

Thanks for the review.

On Wed, 2026-06-17 at 19:18 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
>=20
> Do you mind rebasing and re-sending this patch, please? There are
> some
> conflicts here, because on the export branch, mptcp_pm_ops_release()
> is
> called, which will call mptcp_userspace_pm_free_local_addr_list()
> only
> with the userspace PM.
>=20
> From the comment here above, I understand that mptcp_pm_data_reset()
> can
> force a socket to switch to a different PM. I don't know if we should
> avoid that instead. On the other hand, I see that the userspace pm
> local_addr list is init in mptcp_pm_data_init, not in userspace_pm.c.
> So
> it looks OK to me to come back to what we have on export-net, and
> keep
> mptcp_userspace_pm_free_local_addr_list() in mptcp_pm_destroy() + now
> call it unconditionally. WDYT?
>=20

Agreed. So v3 stands as-is for net; I won't send a new version there
(it still applies cleanly on the current export-net), keeping the
unconditional free in mptcp_pm_destroy().

> (Note that the code introducing mptcp_pm_ops_release() is only on
> netdev, so the related patch could be modified with a "squash-to"
> patch)
>=20

For the export branch the patch does not apply, because as you noted
the userspace free moved into pm_ops->release in "mptcp: pm: init and
release mptcp_pm_ops". I will send the fix ported to export so the CI
can exercise it, as two [PATCH mptcp-next] patches:

1. Squash to "mptcp: pm: init and release mptcp_pm_ops": free
userspace_pm_local_addr_list unconditionally in mptcp_pm_destroy() and
drop the now-redundant userspace .release.
2. The MPTCP_PM_DESTROYING fence, rebased onto the renamed
mptcp_pm_announced_alloc() / mptcp_pm_destroy().

v3 remains the canonical net fix; please pick whichever you prefer for
export (take the port, or rebase v3 and resolve the small conflicts). I
will report the CI result once it runs.

Thanks,
Shardul
