Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23927466A
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115916; cv=pass; b=D/F0hrMOHIOoHR0qFP//igyKcImOtFDvvBvPcgBSGoFrV4pHuPs9NODZ1ysSsUH2nM8PRIc2WJSgQcXma5Z0SFtns1qNBt4zj3/xZhj4mahh9y2nj3TpCLAhLTkwha+XzLf3IdIOH6AdN9+jvxdA9bsCqB3p9IEipiR0fN2uXAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115916; c=relaxed/simple;
	bh=3xjW7sl1t3xqX7yuV/ji/2KtlbBuLi0T15esoZdvKbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhS57OiUM4kZXHNK8MmbaTWzjE8Fvt/WUhMbqmjikYRTZsW1m0xd/sdBg3/u9ziavapEyBemAovdYSeX9C14GxWPuaQZ/nF7K6WgwOYxCjU8e/yYWD05lhsKvU5V/M2HQVJlnZRD7KiUWH9NkHOuAFgZX3zdW8vooSh/9FzCyzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Hy2Fwc5H reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Hy2Fwc5H"
ARC-Seal: i=1; a=rsa-sha256; t=1786115914; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HopasuzWz3An0oxjxkMFQkGcHHp6zfyPOp3/5pQNLfhkVaSjcQtLUtHoTzbNeWlcgRXM+lBYZacUp+ux/B5lCayovbJWZC2vb3lNPPp22g2cD7zpTR75o5j4liyMgkqkvrBfG9IakjXAWQYbi3qjanhRhy9KQA+FR9QrtSAO/cw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786115914; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3xjW7sl1t3xqX7yuV/ji/2KtlbBuLi0T15esoZdvKbY=; 
	b=FpyWiQezxgwgl864q0Mle55JQ7chlblmWkFjh8d1mIC0Q8UqstNbf1p63XBaVp9tzMs7d4isPEFuzY1zRNcaKoLo7GAwTsuh2tRc4ZOiC2VMtSMqBh/MmAg03TBPf1TTOtoxSnYmobjSfCloYrFE6TtEbiHZS7ZFR1x6zfjggmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786115914;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=3xjW7sl1t3xqX7yuV/ji/2KtlbBuLi0T15esoZdvKbY=;
	b=Hy2Fwc5Hcfy/iNmZnTQuj1wTARdpWkEvh8vr3FY8BuuZJ5zs5UXrbZpj3x+jEsvV
	bomQboQqB+zWHo4O0sSWA6Iqm8wjy/TWjfiwGk3sXv0AtMVqZ6hGm0vg3SITXIysWI1
	CtFeDp93kYloBIh4ACHrhZAEhNux0TT+X94p9os8=
Received: by mx.zohomail.com with SMTPS id 1786115911092591.2045643641362;
	Fri, 7 Aug 2026 08:18:31 -0700 (PDT)
Message-ID: <087874be7587606209365cb9e9791a9f0e11b934.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: sched: penalise a slow subflow by
 halving its cwnd
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, janak@mpiric.us
Date: Fri, 07 Aug 2026 20:48:25 +0530
In-Reply-To: <085c3192-1adc-4016-ab27-a0c053a2f2c1@kernel.org>
References: 
	<20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
	 <20260726-mptcp_penalise_send-v1-1-84485e0e995b@mpiricsoftware.com>
	 <085c3192-1adc-4016-ab27-a0c053a2f2c1@kernel.org>
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

On Wed, 2026-07-29 at 13:49 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> On 26/07/2026 07:55, Shardul Bankar wrote:
> >=20
>=20
> Could you reduce the size of the comments, please? I understood that
> LLM
> tends to leave long comments, but too long is not always good:
> explanations can go in the commit message, or be understood by
> reading
> the conditions (or that's a sign the code should be improved).
> Ideally,
> comments should not be needed when reading the code, or limited to
> one,
> with some exceptions for complex cases.
>=20
> Here for example, I think you could limit the comment to one line:
>=20
> /* Penalise subflows with pacing rate < this fraction of the fastest
> path */
>=20

Yes, shortened them to one line each and moved the rationale into the
commit messages.

> > +
> > +/* Halve the congestion window (and ssthresh, if cwnd is past it)
> > of a subflow
> > + * the scheduler flagged. Runs in the push path under the subflow
> > socket lock,
> > + * which protects snd_cwnd. The congestion control grows the
> > window back,
> > + * ACK-clocked, and that regrowth is the built-in probe, so no
> > explicit probing
> > + * is needed.
> > + */
>=20
> Same here: I think what is important to mention is that it is under
> subflow socket lock, and you can move the comment about the CC
> growing
> the window back below: no explicit probing required then.
>=20

Ack'ed.

> > +static void mptcp_penalise_cwnd(struct sock *ssk)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_subflow_context=
 *subflow =3D
> > mptcp_subflow_ctx(ssk);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tcp_sock *tp =3D tcp_=
sk(ssk);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 cwnd =3D tcp_snd_cwnd(tp=
);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow->penalise =3D false;
>=20
> You probably need to check inet_csk(ssk)->icsk_ca_state =3D=3D
> TCP_CA_Open
> again here, under the subflow socket lock, just in case it has been
> modified in between.

Added: mptcp_penalise_cwnd() now re-reads it under the subflow lock and
bails if it is no longer Open.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow->last_penalise =3D t=
cp_jiffies32;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tcp_snd_cwnd_set(tp, max_t(u=
32, cwnd >> 1, 2));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cwnd >=3D tp->snd_ssthre=
sh)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tp->snd_ssthresh =3D max_t(u32, tp->snd_ssthresh >>
> > 1, 2);
> > +}
> > +
> > =C2=A0/* implement the mptcp packet scheduler;
> > =C2=A0 * returns the subflow that will transmit the next DSS
> > =C2=A0 * additionally updates the rtx timeout
> > @@ -1565,9 +1603,9 @@ struct sock *mptcp_subflow_get_send(struct
> > mptcp_sock *msk)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct subflow_send_inf=
o send_info[SSK_MODE_MAX];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_subflow_co=
ntext *subflow;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sock *sk =3D (st=
ruct sock *)msk;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 pace, burst, wmem;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 pace, burst, wmem, max_p=
ace =3D 0;
>=20
> Sashiko is (rightly I think) mentioning that the size of these
> variables
> are wrong. I guess a separate fix is needed to change "pace" to
> "unsigned long" is required. "max_pace" will get this type too then.
>=20

I am splitting that into its own patch (1/4, Fixes: 3ce0852c86b9).

> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Flag the chosen subflow f=
or cwnd halving (applied in the
> > push path)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when its delivery rate is=
 a small fraction of the
> > fastest path's and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that fast path is saturat=
ed (cwnd-limited), so moving
> > load off the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * slow path is worthwhile. =
Only penalise a path in
> > TCP_CA_Open, one
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * whose cwnd is not already=
 being shrunk by loss recovery,
> > and at most
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * once per RTT.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>=20
> Same here. Maybe a comment is not needed, or limited?
>=20

Ack'ed.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow =3D mptcp_subflow_ct=
x(ssk);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow->penalise =3D fastes=
t && ssk !=3D fastest &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (u64)subflow->avg_pacing_rate *
> > MPTCP_PENALISE_RATE_RATIO < max_pace &&
>=20
> (or divide max_pace once before?)
>=20

Changed to avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 inet_csk(ssk)->icsk_ca_state =3D=3D
> > TCP_CA_Open &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tcp_is_cwnd_limited(fastest) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 mptcp_penalise_throttle_ok(subflow);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0burst =3D min(MPTCP_SEN=
D_BURST_SIZE, mptcp_wnd_end(msk) -
> > msk->snd_nxt);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wmem =3D READ_ONCE(ssk-=
>sk_wmem_queued);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!burst)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return ssk;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow =3D mptcp_subflow_ct=
x(ssk);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow->avg_pacing_rat=
e =3D div_u64((u64)subflow-
> > >avg_pacing_rate * wmem +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 READ_ONCE(ssk-
> > >sk_pacing_rate) * burst,
>=20
> (here as well, it looks like there is an existing bug, and a cast to
> u64
> is probably needed for 32-bit system, as pointed by Sashiko)
>=20

Added in the same fix as the issue reported above.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 burst + wmem);
> > @@ -1685,6 +1744,9 @@ static int __subflow_push_pending(struct sock
> > *sk, struct sock *ssk,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_data_frag =
*dfrag;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int len, copied =3D 0, =
err =3D 0;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mptcp_subflow_ctx(ssk)->=
penalise)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mptcp_penalise_cwnd(ssk);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while ((dfrag =3D mptcp=
_send_head(sk))) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0info->sent =3D dfrag->already_sent;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0info->limit =3D dfrag->data_len;
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index da40c6f3705f..2bf801292563 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -587,6 +587,7 @@ struct mptcp_subflow_context {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__unused : 8;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=C2=A0=C2=A0=
=C2=A0data_avail;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=C2=A0=C2=A0=
=C2=A0scheduled;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=C2=A0=C2=A0=C2=A0=
penalise;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* sc=
heduler flagged this
> > subflow for cwnd halving */
>=20
> (If you don't need to read this locklessly, then you can probably use
> one unused bit.)
>=20

It is written under two locks (set in the scheduler under the msk lock,
cleared in the push path under the subflow lock), so a shared bitfield
word would race on the read-modify-write, and I kept it a bool for that
reason. If you see a single-lock way to do it, I am glad to move it to
a bit.

Thanks,
Shardul
