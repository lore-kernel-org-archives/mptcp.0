Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90F3B7B79
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092027; cv=none; b=NoIDsFiR0VK748NX5XBM99io2g4Dbpc/w5W6QftzU+sX5Z/NQTyKvJi1nplYLOLLzHdoZkWhbyGFqWe5T8IKWeIbeg2PKWJfA9GCfVptOSTTNlQBxEY2OgEJig9FBK6l9YJctYbkQz+9mRTHlxM4Vk/hwkKU6a7wpFDe/bL5eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092027; c=relaxed/simple;
	bh=Wsz9960Qnk+D5L+yGEtcjK4SzHNX499i+nx158nce2s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fUCMYCxfqE9MJ6crtjJfPfV/isSYyolhdTuZ+b4hPPrKsBzSsulHkZPnqDMY8wI7EDv1HwYFu3S2Nv+Iczc69ltB+BZl9i77ENjSrsnyLHUvVFupZFXZpge4Td9liw/LIDVvHm6jvGAGM0Nmu4C1PyZ16h+AkjuAIXyRweUA0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ps1YD9BD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ps1YD9BD"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779092024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSw4aB8NRQjolw4oaDbiwRqYoOURHUT2FztVQ+Tu46U=;
	b=Ps1YD9BDDvstEHz/H1fsY5AEANprxtdfpwtexRu7g8MPF56ch74PuTKlTFu1dlHKXELI9E
	rcQSQXXUTM6MUxiS507MbqpCQFXuDLTqOd/Sh55TiRVR0wqIKjxWn5Twvzy3n7V6PZTmTG
	LWc4ZgpeK8Xo2se0IGVdaskmM1p7FdU=
Date: Mon, 18 May 2026 08:13:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <a3331544d24acc69090b43bb44fa5087c33a6092@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Geliang Tang" <geliang@kernel.org>
In-Reply-To: <4a38eef7-0143-4980-b856-42591e521b13@redhat.com>
References: <cover.1778835009.git.pabeni@redhat.com>
 <4a38eef7-0143-4980-b856-42591e521b13@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 15, 2026 at 5:29 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 5/15/26 11:07 AM, Paolo Abeni wrote:
>=20
>=20>=20
>=20> This an attempt to fix the data transfer stall reported by Geliang =
and
> >  Gang more carefully enforcing memory constraints at the MPTCP level.
> >=20=20
>=20>  This iteration presents a significant change WRT the previous one,
> >  avoiding entirely the collapse attempt on memory pressure. Note that
> >  this choice represent a trade off: collapsing allow much faster tran=
sfer
> >  (to be more accurate: order of magnitude less slow) under some extre=
me
> >  conditions, but makes transfer slower and much more CPU intensive fo=
r
> >  less unlikely conditions.
> >=20=20
>=20>  As a consequence of the above the `mptcp_data.multi_chunk_sendfile=
`
> >  test-case needs a 240 seconds timeout to complete successfully:
> >=20=20
>=20>  TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
> >=20=20
>=20>  The solution performing data collapsing would need similar long ti=
meout
> >  for the multiproc tests cases: mutliproc_even, mutliproc_readers,
> >  mutliproc_writers, mutliproc_sendpage_even, mutliproc_sendpage_reade=
rs,
> >  mutliproc_sendpage_writers.
> >=20=20
>=20>  Patch 1 is new in v6, and is actually a fix for an old issue (targ=
eting
> >  net), included here just for my convenience.
> >=20=20
>=20>  Patch 2 and 3 makes the admission check much more strict for incom=
ing
> >  packets exceeding the memory limits, with some exception for fallbac=
k
> >  sockets.
> >  Patch 4 makes implement OoO queue pruning for MPTCP and patch 5
> >  addresses an edge scenario that could still lead to transfer stall
> >  under memory pressure.
> >  Finally patch 6 and 7 improve the MPTCP-level retransmission schema =
to
> >  make recovery from memory pressure/after MPTCP-level drop significan=
ly
> >  faster.
> >=20
>=20@Geliang, @Gang: could you please have a spin at this iteration? Note
> that you must increase the timeout for the
> mptcp_data.multi_chunk_sendfile test-case, as mentioned above.
>=20
Hi=20Paolo,

Thanks a lot for the new patch set. We have encountered some issues durin=
g
our testing. It will take us some time to analyze and locate the root cau=
se.
We will post updates on the mailing list as soon as we make progress.

Best regards
Gang

> Side note: with the "collapse" code this revision also omitted a relate=
d
> few refactor patches, that I still plan to upstream later, since the
> effect is a nice cleanup and reducing differences VS plain TCP.
>=20
>=20/P
>
