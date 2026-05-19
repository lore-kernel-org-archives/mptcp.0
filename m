Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A283955F0
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180647; cv=none; b=Gz7tZS6C1ilLR+pb5GmhDVkegvGKQIWWtz4v4lBLUi/OfH83nAOpO/9PnnbX3oRUFBsqBZtRXtd0ffDf9f9m9s21appG3b8Kdp5Z9177xHwoMSrrcaLkZlrCHuDhcR6UlzFl7ih/Rbohb/3XBZSSg/OP97HLnDG2d7Aevs9k/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180647; c=relaxed/simple;
	bh=qPxkEi+hweBpO9enSJcd/JaXWV06xErMIiCUhup9r3Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Hlxe7RY0SPx8kJ7wGwFyGzYvr92XGfXCWaeQYgC49ZRY5fGVd8WdA86kfnNVcX4oetC3EbQEx6JFwNM/2IUBWi4TIGtv4caZ3ELIL9p5/ShKDeaEVaIg3/ehfBZjIscJKwbKMWT4QhdJ7R2PKT9/XaPdX6aCIJhHFyW7CV63DD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNoE4J1V; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNoE4J1V"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779180644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvOC8JiWjNbWZwpfp9GGS/y/VkV5aUN0bxO7327Q1Fo=;
	b=uNoE4J1VH6UNO14fU+iTQKDkT49/Na/ZKtvfR06SZjU1qhKGIVIh0UCkeu3PHuLNu8kkbC
	KGbAxz8mMKxitxOEVJq4Bpkt0MCEDFzlLiiYoia4FoeAs7XVuydbpklOFyUueCI87ktkEj
	+gMIbsB9V5EvIOgJ/7N96l9NwsxcuwU=
Date: Tue, 19 May 2026 08:50:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <83a3de2bffbecbad544544e77019cbae1ebd913f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Geliang Tang" <geliang@kernel.org>
In-Reply-To: <7f816ee8-6119-47ff-a10d-bbfa61a24e6a@redhat.com>
References: <cover.1778835009.git.pabeni@redhat.com>
 <4a38eef7-0143-4980-b856-42591e521b13@redhat.com>
 <a3331544d24acc69090b43bb44fa5087c33a6092@linux.dev>
 <7f816ee8-6119-47ff-a10d-bbfa61a24e6a@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 19, 2026 at 12:30 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@=
redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 5/18/26 10:13 AM, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> May 15, 2026 at 5:29 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pa=
beni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wr=
ote:
> >=20
>=20> >=20
>=20> > On 5/15/26 11:07 AM, Paolo Abeni wrote:
> > >=20
>=20>  This an attempt to fix the data transfer stall reported by Geliang=
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
>=20> >=20
>=20> > @Geliang, @Gang: could you please have a spin at this iteration? =
Note
> > >  that you must increase the timeout for the
> > >  mptcp_data.multi_chunk_sendfile test-case, as mentioned above.
> > >=20
>=20>  Hi Paolo,
> >=20=20
>=20>  Thanks a lot for the new patch set. We have encountered some issue=
s during
> >  our testing. It will take us some time to analyze and locate the roo=
t cause.
> >  We will post updates on the mailing list as soon as we make progress=
.
> >=20
>=20I run a few hundred iterations of the mptcp_data test without observi=
ng
> any issue (still running). Can you please share which issue are you
> observing, the relevant tests case and the build type (debug/non debug)=
?
>=20
>=20Thanks,
>
Hi Paolo,

Sorry for not providing the specific details earlier in my first message.
The issue we are seeing occurs specifically when KTLS is enabled.

Today I ran several sets of comparative tests (many hundreds iterations),=
 and the
current results suggest that the integration framework between KTLS and M=
PTCP
may need some adjustments. We are investigating the root cause.

Thanks for your help.

Cherrs,
Gang

> Paolo
>
