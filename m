Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC491A6828
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734816; cv=none; b=gKCYvuWbMw0NqylWXUl8vLXW5A91B87L63VtDaUpzIPjaYZ+AjmSTYYWByDYm8s0i54NS3blt6jLreUqcM5pr9CNnTQS02lHu0KGpNizyNdbdOxKUulCvB9IJOesgBuk5zsDu6LiJP2m0sOCHqX4T5F1DW3v5beXve+yRCIfZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734816; c=relaxed/simple;
	bh=ZNPSI0PqloEHK+pYWRDB8DBIV8Immbi/54Vjgval+XQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=TiT89gGY3qqgYNeR5hNvJD6Nt/frRgoYWH1+dYwg1utlZ9PeNaimEr8PVlB/p5L6ocmOkXR5TFRHSkFAobDQj3ztZ18ML2rGNYXfYSBMtxid54GsHOO2jA2NXpd3BIN76LHwMXwk78tOu7oA6WMac9pnItVL1hcQ/sLLJbsBHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WmXVyUSa; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WmXVyUSa"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776734812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPsvt4w3uPnpuFnXjM2GpsGWqO4d3emTBgSnGnPTlwk=;
	b=WmXVyUSaklGLYgJWbc2drS8pnQ06Sg3C9vxcWGQ35YJvUdC4ULGkc4GZ66+RBW3SvFd6MS
	RiOJkwONEm3cv3Lzl7XpdvcS3lKFpksfIxAtkP2+b5aPovM7axbRmKsBGUvOppPtOzP2Z9
	NfkiCWfqMskwUr37Iz1WedejfYv6etw=
Date: Tue, 21 Apr 2026 01:26:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <b3676878753b1956701d07b6010a21fb77c4db83@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: mptcp@lists.linux.dev
In-Reply-To: <2a14005f-a0ef-4a1a-a13c-f7237f0659ec@redhat.com>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
 <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
 <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
 <ef0ce8465f0b852d5e4dc5e54031a156f606b636@linux.dev>
 <e04bd2eb-0107-4011-97d5-a672d770767c@redhat.com>
 <7dc554be0c3343fee71e09a4fda5179cfe0571f0@linux.dev>
 <2a14005f-a0ef-4a1a-a13c-f7237f0659ec@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 20, 2026 at 6:33 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 4/20/26 11:41 AM, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> April 20, 2026 at 5:34 PM, "Paolo Abeni" <pabeni@redhat.com mailto:=
pabeni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > =
wrote:
> >  Regarding the TCP-style mechanisms like 'tcp_prune_queue' for handli=
ng full
> >  rcvbuf conditions =E2=80=94 I have actually attempted similar implem=
entations before.
> >  As you pointed out, this approach is indeed highly complex for MPTCP=
. There
> >  are far too many aspects that require careful modification and consi=
deration,
> >  making it extremely challenging to implement correctly.
> >=20
>=20> >=20
>=20> > I agree duplicating the TCP pruning code inside MPTCP does not lo=
ok a
> > >  viable solution.
> > >=20
>=20> >  I think we can instead share it (at least the most cumbersome he=
lper),
> > >  with some caveat. I have a few very rough patches doing that. Let =
me add
> > >  some comments to at least somehow make the code readable and I'll =
share
> > >  them here.
> > >=20
>=20>=20=20
>=20>  Thank you so much for your help and for working on this!
> >=20
>=20Thank you indeed for all the effort and the patience to cope with my
> slow feedback.
>=20
>=20Also I hope it's clear that the goal is trying to find the "best
> possible" solution and it's _not_ preventing or steeling your (much
> appreciated) work!
>=20
>=20Cheers,
>=20
>=20Paolo
>
Thank you very much for your understanding and patience throughout
the review process.It=E2=80=99s clear to me that we share the same goal:
to find the best and most robust solution. I really value your
feedback and guidance, and I will test your new patch as soon as
possible and provide feedback promptly.

Thanks again for your time and support.

Best regards,
Gang
