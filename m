Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362181E7C2E
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627769; cv=none; b=tTF4ImvwLjo5MUj/EgQ3hnNUZ7x67xbzJPyH+DySqs4WISOf+CFzISkf201ZcLNF9nbJjLmxjHIUEjc5Q3kg/HPUkOs0BRrqVSoeQ1MFi2f1aphQkzDC1E7iVMDT0q9NZhajlM0/MtidxrcRLqA+GZNBPat34vyIUEqgTYJbDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627769; c=relaxed/simple;
	bh=C8BrQGJUhs2m6mT/ejqS8oYzjrYSsd6YZfQUVNbaFUQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=QrCOlApASZuOOhNtS/rN/D48dSQcZYl6bmTq4BByuvstKRLUBdY9260iJe7pYnzzuLUEUu3EJfTZJ5V+CA0Z20lmkJwvMk2VgRWWGpI43Wo9VEbR/yNGuZuUrOoMbnnxgIwuPuoRBtUoiPVwo59L9A1U8K0lvTNKBUNW5sQ9/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LPKPO2eF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LPKPO2eF"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770627762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfl48CpZMqKi/QCOIgNUmA6XRBlc6PSRIaGtJZ24l18=;
	b=LPKPO2eFxUmyxbWbwuukhaGh6rsY/mkr9NyWW96TNEFfZhvHoANsudA+LApKoZoh+g2n+J
	BkWSWPKdRS7zlNAHzjeLXvoCxzyZN+HAQR+G2Ko6jG0jD46IFuKs5XN4W6qNN4RQd4FFVM
	Fx1seqS4jpgY1jzQSTg6tBKex7BoszU=
Date: Mon, 09 Feb 2026 09:02:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <75d05ee55e5318ee35d9e6a55c25d59a52d6ea1f@linux.dev>
TLS-Required: No
Subject: Re: [Patch mptcp-net 2/3] mptcp: fix receive stalls when 'ack_seq'
 in backlog_list
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
In-Reply-To: <f9a2229cd1d69731db91a003ac1018f446be9572@linux.dev>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <7bee08bb168041f1fa0440b1b605548bdc03f241.1770273341.git.yangang@kylinos.cn>
 <e1ccad35-0ffc-4219-a7af-3b2541d95612@redhat.com>
 <f9a2229cd1d69731db91a003ac1018f446be9572@linux.dev>
X-Migadu-Flow: FLOW_OUT

February 5, 2026 at 9:14 PM, gang.yan@linux.dev mailto:gang.yan@linux.dev=
  wrote:


>=20
>=20>=20
>=20> February 5, 2026 at 5:36 PM, "Paolo Abeni" <pabeni@redhat.com mailt=
o:pabeni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E =
> wrote:
> >=20
>=20Hi, Paolo:
>=20
>=20>=20
>=20> On 2/5/26 7:41 AM, Gang Yan wrote:
> >=20=20
>=20>=20=20
>=20>  From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  This patch fixes the first backlog_list issue, which can be 100%
> >  reproduced by the multi_chunk.sh test case.
> >=20=20
>=20>  The problem occurs when out-of-order (OFO) queue data accumulates,
> >  causing sk_rmem_alloc to exceed sk_rcvbuf. In this condition, skbs
> >  in backlog_list fail to move to sk->receive_queue even when the
> >  receive queue is empty, leading to transmission stalls.
> >=20=20
>=20>  Very good catch! How did you hit the issue?
> >=20
>=20This issue was exactly exposed during the development of NVMe over MP=
TCP
> and MPTCP KTLS support that Geliang and I have been working on recently=
.
> So, we created the 'multi_chunk.sh' to reproduce it.=20
>=20
> >=20
>=20> This patch adds an empty check for sk->receieve_queue, when it is e=
mpty,
> >  the skb should moved too.
> >=20=20
>=20>  Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  net/mptcp/protocol.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index ff06bbee7781..b6bafc37eea4 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >  @@ -2176,7 +2176,8 @@ static bool __mptcp_move_skbs(struct sock *sk,=
 struct list_head *skbs, u32 *delt
> >  *delta =3D 0;
> >  while (1) {
> >  /* If the msk recvbuf is full stop, don't drop */
> >  - if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> >  + if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
> >  + !skb_queue_empty(&sk->sk_receive_queue))
> >=20=20
>=20>  I think we need to be more conservative, otherwise this could be
> >  exploited to allow unbound increase of the rcvbuf.
> >=20=20
>=20>  Unfortunately it does not look easy, but I think it would be doabl=
e:
> >=20=20
>=20>  - convert the backlog to a rbtree, sorted by MPTCP-level sequence
> >  number; that would likely require:
> >  - factoring out a slightly more generic helper out of mptcp_data_que=
ue_ofo
> >  - use it for both mptcp_data_queue_ofo() and enqueue to backlog
> >  - implement an helper to check if we can dequeue from the backlog; i=
t
> >  should check that we are below memory bounds or that the first skb i=
n
> >  the backlog is in-sequence.
> >  - use such helper here and in mptcp_can_spool_backlog()
> >=20=20
>=20>  I see it's not easy, but I think is necessary. Simpler alternative=
s more
> >  than welcome!
> >=20
>=20I fully agree with your concern. And your proposed solution is much m=
ore robust
> and aligns with the long-term stability of the MPTCP stack.
>=20
>=20I will follow your guidance to implement these changes step by step a=
nd submit
> a v2 version of the patch as soon as possible.
>=20
>=20Thanks again for your insightful feedback!
>=20
>=20Best regards,
> Gang
>=20
Hi,

I=E2=80=99ve been working on this gradually, but progress is slower than =
expected.
Switching backlog_list to an rbtree appears to introduce more race condit=
ions,
and I=E2=80=99m also dealing with KASAN errors and warnings around ssk->r=
mem_alloc.

I remain committed to this development and will continue working on it. O=
nce
meaningful progress is made, I will release v2 as soon as possible.

Thanks
Gang
> >=20
>=20> (side note, on top of my head I think that even plain TCP stumbled =
upon
> >  a similar situation, i.e. could overrun some limits for in-sequence =
skbs).
> >=20=20
>=20>  /P
> >
>
