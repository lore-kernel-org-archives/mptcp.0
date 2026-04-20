Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E04388E7C
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678109; cv=none; b=XH8AxrPbbVD1ovYynU6M4eQivmhvh06UzHrmdCXrSjq98RAJQGIoKRkpZRR9S2Z1V1PC9hYWlItCrPOtIiek3iS+WYYiR4e7EFmyMusKJ75QsXXw13BmI5QDNKTeaokeQm8i1SL6aK/fKQfiGEGJfNKhWJjgbNRI8jXsU5rEVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678109; c=relaxed/simple;
	bh=bDkDmJEgV7KuIrfAWQa7e89uQuV8EHkP16cTRtujr8Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=QtG9HdcdBYazMKexpiCKt3TzJ2a66cvs405jBCQqJ6m84Z4G0O2qDupAUMTUi7urgTkrK5kedCNAoiBEgew8UOQBctsi8Yv9/REK4ajUVEYla5s4ga5iK831/0ivCf8O9Z/fw7b+s5Hezx0tK/qAD37IOUWs544rnYKaQeTzrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uuaFvESp; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uuaFvESp"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776678106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx5+NlZe3r+Yl32yM/e8Oxp+NT8NguO4JZZKr5Z/X7Q=;
	b=uuaFvESpUgLoAMlGTHCidt0PIvZZlwkdO+LSJ3aS0Yomot5Cl4fnJuIjwqKDwwBPXH+UDl
	RiGTVyUsumER/RYSdsNxwI/WUcPnRBhu0FSfWm0GVx2ruawNReQDTQYIJLggzNNaoCREfx
	ashSbhY9hHuDj3H4IhN/pAlzg4x3rN8=
Date: Mon, 20 Apr 2026 09:41:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <7dc554be0c3343fee71e09a4fda5179cfe0571f0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
In-Reply-To: <e04bd2eb-0107-4011-97d5-a672d770767c@redhat.com>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
 <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
 <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
 <ef0ce8465f0b852d5e4dc5e54031a156f606b636@linux.dev>
 <e04bd2eb-0107-4011-97d5-a672d770767c@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 20, 2026 at 5:34 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 4/15/26 10:21 AM, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> April 15, 2026 at 3:17 PM, "Paolo Abeni" <pabeni@redhat.com mailto:=
pabeni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > =
wrote:
> >=20
>=20> >=20
>=20> > AFAICS the stall in the self-tests in patch 5/5 is caused by the =
sysctl
> > >  setting taking effect on the server side _after_ that the 3whs
> > >  negotiated the initial window; the rcvbuf suddenly shrinks from ~1=
28K to
> > >  4K and almost every incoming packet is dropped.
> > >=20
>=20> >  The test itself is really an extreme condition; we should accept=
 any
> > >  implementation able to complete the transfer - even at very low sp=
eed.
> > >=20
>=20> >  The initial test-case, the one using sendfile(), operates in a
> > >  significantly different way: it generates 1-bytes len DSS preventi=
ng
> > >  coalescing (I've not understood yet why coalescing does not happen=
),
> > >  which cause an extremely bad skb->truesize/skb->len ratio, which i=
n turn
> > >  causes the initial window being way too "optimistic", extreme rcvb=
uf
> > >  squeeze at runtime and a behavior similar to the previous one.
> > >=20
>=20> >  In both cases simply dropping incoming packets early/in
> > >  mptcp_incoming_options() when the rcvbuf is full does not solve th=
e
> > >  issue: if the rcvbuf is used (mostly) by the OoO queue, retransmis=
sions
> > >  always hit the same rcvbuf condition and are also dropped.
> > >=20
>=20> >  The root cause of both scenario is that some very unlikely condi=
tion
> > >  calls to retract the announced rcv wnd, but mptcp can't do that.
> > >=20
>=20> >  Currently I start to think that we need a strategy similar to pl=
ain TCP
> > >  to deal with such scenario: when rcvbuf is full we need to condens=
e and
> > >  eventually prune the OoO queue (see tcp_prune_queue(),
> > >  tcp_collapse_ofo_queue(), tcp_collapse()).
> > >=20
>=20> >  The above has some serious downsides, i.e. it could lead to larg=
e slice
> > >  of almost duplicate complex code, as is diff to abstract the MPTCP=
 vs
> > >  TCP differences (CB, seq numbers, drop reasons). Still under inves=
tigation.
> > >=20
>=20> >  /P
> > >=20
>=20>  Hi, Paolo
> >  Thanks a lot for your detailed and insightful analysis of this probl=
em!
> >=20=20
>=20>  I fully agree with your points: MPTCP should allow the transfer to=
 complete
> >  even under extremely slow or harsh conditions, just as you mentioned=
.
> >=20
>=20I was likely not clear in my previous message. IMHO the key point is
> that in the mentioned scenario we should consider suitable any fix that
> would allow completing the transfer, even at a extremely low average
> bitrate - because the memory conditions are indeed extreme.
>=20
>=20I.e. we can/should consider this case an extreme slow path.
>=20
>=20>=20
>=20> Regarding the TCP-style mechanisms like 'tcp_prune_queue' for handl=
ing full
> >  rcvbuf conditions =E2=80=94 I have actually attempted similar implem=
entations before.
> >  As you pointed out, this approach is indeed highly complex for MPTCP=
. There
> >  are far too many aspects that require careful modification and consi=
deration,
> >  making it extremely challenging to implement correctly.
> >=20
>=20I agree duplicating the TCP pruning code inside MPTCP does not look a
> viable solution.
>=20
>=20I think we can instead share it (at least the most cumbersome helper)=
,
> with some caveat. I have a few very rough patches doing that. Let me ad=
d
> some comments to at least somehow make the code readable and I'll share
> them here.
>=20

Thank=20you so much for your help and for working on this!

Looking forward to your updates.

Thanks
Gang

> /P
>
