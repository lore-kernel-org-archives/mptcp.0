Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615F54779
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214336; cv=none; b=i5ZRbv0DUPuOZKDV8iZmg3agm4S8lbJLIUAawbS05hGxqKU0wVRIyvVlLXB6OH4N8RK2w/iKS+QQrq2VoXobpk820USztBEpf33jiywL1iGZOJ22DzMXZYBhw4p1S01wG3CzC5lPmFTlEpQWpWGylltgJ3gNfZw1v1Ru0PfX12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214336; c=relaxed/simple;
	bh=/FvEpgjoYZ/OLxgjOZu62unYQncqwiLYIls5wMxfuCs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atS8koNknzISnU/mJPeOqM1i2CONrbH8HDF3UH8RwIf46j2ch9tGW1g1wlTui2oPkuzP4gEYPKVXzMTAZ7X0nmN7kfFDez4JKA3Exd3oEn5ju3rEnya+1XwA0E71e7ST+9nw0zvUkZzgq4Sid8tXw1nhwRwki3XXp1Pb8EtQIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XbT/Opt0; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XbT/Opt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792214324; x=1792473524;
	bh=TMi0K5oVG4jqnLDSlYW9g45Q00EROFIEQqCHgOffySk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XbT/Opt0Qpq7FLpFkdto/tx2sGStQmbgLtYIPbpjotpbMhA59g7zuPNzhw9kHgOir
	 1bJPburbjNjpA0YJfUp8c7YQPtC7h00Et45jdvFBB6Tj2W6D65cvKnzkEeegsJ3nI6
	 TzATA+O4ZI+oaHAib+AHnfoLjFGCr6W1hIZhg6Wk5tcrsgkmlw+W+U9pp88S5MT1Dk
	 BINHln51nENIal5adfj88MHySHbpy51+Hqi8w+3NrgO4KG6vfw1zpLHd0gi+BsiiLo
	 oxWcvkoQqoNpZLXsoGjs+K2ZGQH0Lke5QgCgofITX2ki3tzzb+aL5wyh5Akdu2DTnb
	 kOMIATKHBNcqg==
Date: Sat, 17 Oct 2026 05:18:42 +0000
To: netdev-bot+sashiko@kernel.org
From: quanyeyang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, kuba@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: annotate lockless access to msk->scaling_ratio
Message-ID: <oH0C4EkMiU9WgofMExmWaBBrOlKnZeNwWeeApZvOKuFgspfaoCwCLzC_Sy0B1S9iQ0P2rguE-5BB57_s8a6PdGBhzdOhdbsuQLRnlH0kPxs=@proton.me>
In-Reply-To: <179219870023.3135.6428859397034144575@kernel.org>
References: <20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e@proton.me> <179219870023.3135.6428859397034144575@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 1c479fabd5c2352f42511407ed3cb583e847c2be
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 16th, 2026 at PM 5:58, netdev-bot+sashiko@kernel.org <ne=
tdev-bot+sashiko@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The patch is incomplete: one lockless reader of
>   msk->scaling_ratio is still a plain load.
>=20
> --
>=20
> mptcp: annotate lockless access to msk->scaling_ratio
>=20
> This commit annotates the BH write of msk->scaling_ratio in
> mptcp_rcv_rtt_update() with WRITE_ONCE(). It also annotates the reads in
> mptcp_win_from_space() and mptcp_space_from_win() with READ_ONCE(). The
> goal is to fix a KCSAN data-race between mptcp_cleanup_rbuf() and
> mptcp_data_ready().
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/634
>=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 05c38564e8fdf..ffd22849b719b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
>=20
> [ ... ]
>=20
> > @@ -1004,9 +1005,13 @@ static void mptcp_rcv_rtt_update(struct mptcp_so=
ck *msk,
> >  =09if (++msk->rcv_rtt_est.next_sample =3D=3D MPTCP_RTT_SAMPLES)
> >  =09=09msk->rcv_rtt_est.next_sample =3D 0;
> >
> > -=09/* EWMA among the incoming subflows */
> > -=09msk->scaling_ratio =3D ((msk->scaling_ratio << 3) - msk->scaling_ra=
tio +
> > -=09=09=09     tp->scaling_ratio) >> 3;
> > +=09/* EWMA among the incoming subflows.
> > +=09 * Pairs with READ_ONCE() in mptcp_win_from_space().
> > +=09 */
> > +=09scaling_ratio =3D READ_ONCE(msk->scaling_ratio);
> > +=09WRITE_ONCE(msk->scaling_ratio,
> > +=09=09   ((scaling_ratio << 3) - scaling_ratio +
> > +=09=09    tp->scaling_ratio) >> 3);
>=20
> [Severity: Medium]
> Is there one more lockless reader of msk->scaling_ratio that still needs
> annotating? The mptcp_rcvbuf_grow tracepoint in
> include/trace/events/mptcp.h still uses a plain load:
>=20
> include/trace/events/mptcp.h:TRACE_EVENT(mptcp_rcvbuf_grow) {
>     TP_fast_assign(
>         ...
>         __entry->rtt_us =3D mptcp_rtt_us_est(msk) >> 3;
>         ...
>         __entry->scaling_ratio =3D msk->scaling_ratio;
>         ...
> }
>=20
> The tracepoint fires from mptcp_rcv_space_adjust() on the recvmsg and
> read_sock paths:
>=20
> __mptcp_recvmsg_mskq()
>   mptcp_rcv_space_adjust()
>     trace_mptcp_rcvbuf_grow(sk, time)
>=20
> That path holds only the msk owner lock (msk_owned_by_me()), not the msk
> data spinlock. mptcp_data_ready() takes mptcp_data_lock() and calls
> mptcp_rcv_rtt_update() before it checks sock_owned_by_user(). So the
> WRITE_ONCE() above can run on another CPU at the same time as the
> tracepoint read.
>=20
> With the mptcp:mptcp_rcvbuf_grow tracepoint enabled, wouldn't KCSAN still
> report a race on msk->scaling_ratio here? The same TP_fast_assign already
> reads rcv_rtt_est.samples[] locklessly through mptcp_rtt_us_est() with
> READ_ONCE().
>=20
> Should this become the following?
>=20
>     __entry->scaling_ratio =3D READ_ONCE(msk->scaling_ratio);
>=20
> >  }
> >
> >  void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e%40proton.me
>=20

Thanks, the mptcp_rcvbuf_grow tracepoint still does a plain load of
msk->scaling_ratio from mptcp_rcv_space_adjust(), which only holds the
owner lock. I'll include READ_ONCE() there in v2.

pw-bot: cr
