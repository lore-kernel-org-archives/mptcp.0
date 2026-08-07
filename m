Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD532D12ED
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115957; cv=pass; b=nYL8kNEq1yyoIzJ+QMdKe2MNCg3mpJIQGxY5XtuJ7/VSjet7aueUv+BgGCfkBIQe0fxccC7pigZm+EPdnWCcKJSj2covEJNN06kGV4MWI4UyJVEMRYm6RMSNe6cnl3n6BZd09uNZpnbpMzLJaEloAh0dQE2BFhKzwpCaf8bR/us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115957; c=relaxed/simple;
	bh=eQweoaemyV+zUmjA/nq776rDRfqylREoLSU6vl96Yp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CWdBoqDIF5vFNs0LF2c3spOeWSse0AXad65JtoCKRZdN48a1JKXs+RmBcN8U1w1eZgF+EFHc8KuBYNaPky6/i2HlK2ayIidgHGkv5ePZBmesUD/UNFVVAM06LaTjq+n6Aks/q7sLuJ+scMW1M8Uff7HevvY86fM4LGjQO6pKtRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=I9mOwXVT reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="I9mOwXVT"
ARC-Seal: i=1; a=rsa-sha256; t=1786115954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ot9erBCtGTo5RLp6OUipkCQoeGbpjeJRjThL24d8U8zwS/KJsvLMnQqy84T3uBEl3pvdLwBQ8NRU6+xp0loOgYzx6xvBo6x4TWEYhMO5Tg1sxvUVg5Ixve7A1+ypoTl30FHAAXHXz7/3PMMMTSfw/AoLyi80S1kNBQaywVJyLoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786115954; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eQweoaemyV+zUmjA/nq776rDRfqylREoLSU6vl96Yp0=; 
	b=LcVcKR1o8U0rlYl6VpDtUaz29ded5Pl/SbkDN7dzxjRUkXNNz2s4BcbRRHne/zAIYiUcX8F6+d0uRMyZ6UfvI9OpYf9A6ouCke/t+L5/TB/RqWdCvcglMClP7bp6wxHjc0gbcP6kYnY5CX6uUjJd6BW27XGdN6XHga0TmqutXcc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786115954;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=eQweoaemyV+zUmjA/nq776rDRfqylREoLSU6vl96Yp0=;
	b=I9mOwXVTVFKnSgB1k+z/x+07ry3pjogwXalJVPnT7pdNq3wraq6oWqF6JgFVEgN+
	HVXHM1Ju55DqmIJw95yKqYLkT8sQi+fVUExG9g1lw4pMpjAoI1Qk9sPyptq4T5htZaq
	TKT7PGGVp2HUjwX9hHCkchxAVWNMxKOMhJlf1GfA=
Received: by mx.zohomail.com with SMTPS id 1786115951293884.5019374558498;
	Fri, 7 Aug 2026 08:19:11 -0700 (PDT)
Message-ID: <30b7b05258dda636068fd53b3e0b5a5ef509d3c1.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 3/3] DO-NOT-MERGE: mptcp: sched: penalise
 counters
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, janak@mpiric.us
Date: Fri, 07 Aug 2026 20:49:06 +0530
In-Reply-To: <70fa5aff-40c0-4ca5-8a29-4e57489d3637@kernel.org>
References: 
	<20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
	 <20260726-mptcp_penalise_send-v1-3-84485e0e995b@mpiricsoftware.com>
	 <70fa5aff-40c0-4ca5-8a29-4e57489d3637@kernel.org>
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

On Wed, 2026-07-29 at 13:50 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> On 26/07/2026 07:55, Shardul Bankar wrote:
> > Instrumentation for validating the two preceding patches; not for
> > merge.
> >=20
> > Adds two MPTcpExt SNMP counters:
> > - CwndPenalized: times a subflow cwnd was actually halved;
> > - PenalCandidate: times the rate trigger picked a slow subflow.
>=20
> I think at least the first counter is interesting, probably the
> second
> one as well, no?
>=20
> Generally, if you need counters during the development, they might be
> needed to debug issues. But here with the scheduler, maybe the
> tracing
> are better. Did you use "trace_mptcp_subflow_get_send"?
>=20

I did not. Looking at it now, it fires before the penalise decision and
does not see the halving, so it would need a small extension (a new
field, or a tracepoint at the halving point) to show what these
counters show. Which would you prefer for v2: keep the DO-NOT-MERGE
counters, or add that tracepoint? I will go with your call.

> >=20
> > =C2=A0
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 7cbc5aa17e22..80866f09831a 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1607,6 +1607,7 @@ static void mptcp_penalise_cwnd(struct sock
> > *ssk)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow->penalise =3D f=
alse;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow->last_penalise =
=3D tcp_jiffies32;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tcp_snd_cwnd_set(tp, ma=
x_t(u32, cwnd >> 1, 2));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MPTCP_INC_STATS(sock_net(ssk=
), MPTCP_MIB_CWNDPENALIZED);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cwnd >=3D tp->snd_s=
sthresh)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->snd_ssthresh =3D max_t(u32, tp->snd_ssthresh=
 >>
> > 1, 2);
> > =C2=A0}
> > @@ -1694,6 +1695,13 @@ struct sock *mptcp_subflow_get_send(struct
> > mptcp_sock *msk)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * once per RTT.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subflow =3D mptcp_subfl=
ow_ctx(ssk);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* DEBUG: count how often th=
e trigger picks a slow path, so
> > a gated-off
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * run (PenalCandidate high,=
 CwndPenalized 0) is
> > distinguishable from one
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * where the trigger never f=
ired.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fastest && ssk !=3D fast=
est &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u64)subf=
low->avg_pacing_rate *
> > MPTCP_PENALISE_RATE_RATIO < max_pace)
>=20
> If this counter is interesting, you could have a variable for
> penal_cand
> and use it below.
>=20

Got it, a single penal_cand local will now feed both the counter and
the penalise decision.

Thanks,
Shardul
