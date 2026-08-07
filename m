Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C302DC765
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115934; cv=pass; b=J2kWldC1ZOodbEzoQbp3sCfakEozRP2qergLMAyljgNyd35Vv8+QrnmjvG2Ilc9t6xTmZq/QaTRTniPt2Doo8tk55AVoNbSjfFutYoa/uN9Ku67iOsZzEKwsJEVwZHnoKioG5X+ePxMZZk3GWs75TvrOVyeeHSvVWBoMFxyUJ8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115934; c=relaxed/simple;
	bh=QS6xgPc9tLO7NZTggk4o93lRorTiwGazcZ/VP74FiaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URtbrX/KFSlEUa3P+6brovhextTSIPxGT4TEJBdG4Hk1yOsJySlKtQkaQOiCrqRGTbODo7OIJxE1H5wCdGViJqB/ER5+OptktbpyALNAABBzkeUbUxt8b2URZ/AYi2IdCSnVH6XpunIvPJBIggPo/KeO1CUVytRWl0TFO148bic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Qjd+4ECi reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Qjd+4ECi"
ARC-Seal: i=1; a=rsa-sha256; t=1786115932; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bEk6HzRkzDnQSh2aaL9DsJYOiE63EBxCXdfo05njlquTlLI2H0L2AJ5DJSeQLFKo5QcMYcl6HQrpAhKkkgCVGEjL/F+iFMbwXZMvL09fl3hODJPBDtBUUGqKzI+comC8ccP35mftwVw3vq7szBZosTA4+IdstZ7Scjgk/zKRKuY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786115932; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QS6xgPc9tLO7NZTggk4o93lRorTiwGazcZ/VP74FiaQ=; 
	b=b0yngdqbkY5zGgXpBkr+ywG3YbTWZnaoqhtiM1aF3IYU6xTTfwg7nS8mHMCfGnibol/vMMBL3G012jpvtLumnbHtg0jQvwEyWv2+smhcaH2ax5eMil0JjXe6Ds5ZsPdXZVXMEsm/DAa3EuDVZLMKZKkB16lZXYmd+tGzjzpTfZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786115932;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=QS6xgPc9tLO7NZTggk4o93lRorTiwGazcZ/VP74FiaQ=;
	b=Qjd+4ECiVl4OMVrSzEjz7QfmPM4mxvLFBrhxx4F2alKB7V309/mLSQSVw04E+bK/
	zHK9nTrK0Xw8OXE4zaIjO/ODLbd0wfrmrQm/6WaXxNirlzK9UKXb2BxJapl8bT7c0td
	V91qP2aRf+zo5+zM7p0L2n8AOdf9AFTHUUqFBSQk=
Received: by mx.zohomail.com with SMTPS id 1786115930146203.57458914654433;
	Fri, 7 Aug 2026 08:18:50 -0700 (PDT)
Message-ID: <cb311fd7d3c1a086127b40108d55a0750c91efc1.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: sched: do not penalise when
 receive-window-limited
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, janak@mpiric.us
Date: Fri, 07 Aug 2026 20:48:44 +0530
In-Reply-To: <39a6ac82-7044-4f57-8a89-84b729491d78@kernel.org>
References: 
	<20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
	 <20260726-mptcp_penalise_send-v1-2-84485e0e995b@mpiricsoftware.com>
	 <39a6ac82-7044-4f57-8a89-84b729491d78@kernel.org>
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
> > +/* Only penalise when the connection is not receive-window-
> > limited: all the
> > + * data the application has queued fits within the current send
> > window
> > + * (write_seq <=3D wnd_end). If it has queued past the window edge,
> > the peer's
> > + * receive window (not our congestion window) is the bottleneck:
> > the fast
> > + * path is capped by that shared window too and cannot use
> > capacity freed from
> > + * the slow path, so penalising would only shed the slow path's
> > throughput.
> > + *
> > + * write_seq (application demand) and wnd_end (peer-advertised
> > window) are both
> > + * standing values and neither is derived from cwnd, so unlike the
> > instantaneous
> > + * window headroom this is not biased by the scheduler sampling
> > just after an
> > + * ACK opened the window, nor circular when the window is what
> > suppresses cwnd.
>=20
> (a bit too long, some text can probably be moved to the commit
> message
> if not there already =E2=86=92 but also, I guess this commit will be squa=
shed
> in
> the previous one at the end)
>=20

Yes. I kept it separate for now so the guard can be tested on its own,
and I will squash it into 1/4 for the merge-ready version.

> > + */
> > +static bool mptcp_penalise_send_window_ok(const struct mptcp_sock
> > *msk)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return msk->write_seq <=3D m=
ptcp_wnd_end(msk);
>=20
> It looks like you are doing something similar to tcp_snd_wnd_test(),
> no?
>=20
> I guess you should at least use after64/before64. Here we don't have
> the
> skb, that might change later if the MPTCP scheduler API is modified,
> but
> that can be an optimisation for later.
>=20
> You could name the helper mptcp_snd_wnd_test(), and mention it is
> inspired by the TCP version, but without checking the packet len (for
> the moment).
>=20

Yes, renamed to mptcp_snd_wnd_test(), and it uses after64() now.

> Other than that, this Sashiko's comment is interesting:
>=20
> > Does this heuristic correctly identify receive-window bottlenecks
> > without
> > unintentionally disabling the penalty for congestion-limited bulk
> > transfers?
> > Because write_seq is limited by the socket send buffer (sk_sndbuf)
> > rather
> > than the congestion window, an application performing a bulk
> > transfer with a
> > large send buffer can easily queue data past the peer's advertised
> > receive
> > window.
> > If the connection is heavily congestion-limited, the fast path is
> > saturated
> > and the slow path should still be penalized to reduce head-of-line
> > blocking.
> > However, since write_seq > mptcp_wnd_end(msk) in this scenario, it
> > seems
> > this check will incorrectly assume the connection is receive-window
> > limited
> > and skip the penalty.
>=20
> By chance, did you already validate this case?
>=20

Yes, with a send buffer larger than the receive window. The guard
suppresses the penalty there, correctly: the receiver is genuinely at a
zero window, so it is receive-window-limited rather than congestion-
limited, and it is no slower than baseline.

Thanks,
Shardul
