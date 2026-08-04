Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835A25785C
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846522; cv=pass; b=j9TlitNKVRSPNBT2iKlpLpWHQJ3UTJopAU4Nc/5BiM2Z9cLWCzCvyjrqiGOjBtT9tqxZTcsCtsobiM7KsLjOIofwVP+QEkmEZbyYrzNl/92RR0fL0uJ740/TxaWKRpI9sZ25/GQ7TEN1YsZqeqJI2/RLUEgsGAL+iZhSFQOBb5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846522; c=relaxed/simple;
	bh=4YFcVKIbof9Uh0zUPiG+iRa6NJGCwgyBOlp0FL68Uwk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PpIV/Fz+uQ5E8XC/86SJIbjshRjSEyGSZOhhEJauEifCVajT9fzgn9y1AQy+8YHfxYVyHMD1WErf2821fs9hnHYon7eFfbLtM+80mh2qKT81+2vGY2tENwTPbAaJu+acOmXv8LRPrtE13/Lnr3rpoJJ7v3rkCMA5K5GebrVm4og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=EPXUsKZ/ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="EPXUsKZ/"
ARC-Seal: i=1; a=rsa-sha256; t=1785846516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IyL81w9FlBwYXa1LQ9J8pt/j8NyS00aqRobZ+a5irY/084BRmTFtODIMkNK0WHnQyF1LorobqzKJiDfoHhHe39nMgH3gLEF9zCYscdiqk0IYjtO8vf4GUgL2t4A7JFBqLahUFyX6ZXxAzCccC/r/dH4o2QXmZ2GzONVB96owWs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785846516; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j8oPiumzShej7XmN9svYE9Vb7HwMYkqPn3TP1Y5sBas=; 
	b=HzcuClHJM+uHTHrfO9FrW2IetiHfz2+9QOuRED4z27ncy3PHLbO/MHxPDK15nbygeLP5yxy9pt/VARToL74OiBNKL/Uoc6k8D4ZB4ITWUIDHxkCA1/tKdRmavZNvb5JrCcdyTxn/SquY5Kv8I1N2ie46zx06Yp2AJcW7/qCjDv8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785846516;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j8oPiumzShej7XmN9svYE9Vb7HwMYkqPn3TP1Y5sBas=;
	b=EPXUsKZ/WePznMgvjoSBJYijRF5n1mMFkgydkd1EkwrseXZjnaEhyHhZOR+CAQc2
	Y2T8UwqP8wpq9lp4QjjT6LgiQ5Xx5kvUBtlfQ2ihC61fBbXtauCsXOmfNgQRqFBEHnP
	qH4l4OuKHidWTXwvaSSEOzUKvYqf2Ch8LSwVZms4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785846515516369.2758114810108; Tue, 4 Aug 2026 05:28:35 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785846514516309.476551362396; Tue, 4 Aug 2026 05:28:34 -0700 (PDT)
Date: Tue, 04 Aug 2026 17:58:34 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"Lixiasong1" <lixiasong1@huawei.com>
Message-ID: <19fccbf4342.1a9db47f221406.2661422723033045309@mpiricsoftware.com>
In-Reply-To: <b47803d8-d192-46bd-97de-da4baa74fbc0@kernel.org>
References: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com> <19fc5f77283.636e19ae49491.8985382660057875751@mpiricsoftware.com> <b47803d8-d192-46bd-97de-da4baa74fbc0@kernel.org>
Subject: Re: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in
 retransmit paths
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Thanks for taking a look.

> I guess at least the commit message should be updated, because the MPTCP
> sockets do not perform routing lookups. It could only do it when a
> subflow has been selected, which is not the case in the cases you
> modified. Same for the socket option: it is not available yet.

Ah right, I missed that. So effectively only the two sysctls matter here,
since that's what gets seeded in __mptcp_init_sock(). I'll fix the commit
message to say that, and drop the claims about the route metric and the
socket options.

> Also, maybe better to directly use icsk_rto_{min,max} to avoid
> confusions, no? By doing that, you can remove the exception for "ip
> route ... rto_min 0" that doesn't influence anything here anyway from
> what I understood.

Yes, makes sense. That also gets rid of the __mptcp_init_sock() special
case I added in v2 for the lockdep splat, so everything reads the icsk
fields the same way. And agreed the rto_min 0 check can go, the sysctl
can't go below 1us anyway.

I'd still keep the max_t(..., 1) inside the ilog2() though: nothing
stops someone from setting tcp_rto_min_us higher than tcp_rto_max_ms
(they're validated separately), and then rto_max / rto_min is 0. I'll
add a comment for that.

> It would be good to have a validation for this. Because it is
> time-sensitive, the easier would be to do it with Packetdrill. Here, no
> need to create a new one, simply extend existing ones, e.g.
> mptcp/dss/dss_fin_retrans_* -> we could set the tcp_rto_max_ms sysctl to
> have a shorter time, no? If at least one test is modified to validate
> your modifications in mptcp_set_datafin_timeout(), that would be good.

Good idea. I'll try with tcp_rto_max_ms=3D1000 (the minimum) in
dss_fin_retrans_established.pkt: with the default rto_min that caps the
shift at ilog2(5) =3D 2, so the intervals should stop doubling after
~800ms. The current test only checks 3 retransmissions and the
divergence should be on the 4th one, so I'll extend it a bit and check
it fails on a kernel without the patch. Packetdrill patch to follow
separately.

Will send a v4 with all that if it sounds good to you.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, "mptcp"<mptcp@lists.linu=
x.dev>
Cc: "martineau"<martineau@kernel.org>, "pabeni"<pabeni@redhat.com>, "shardu=
l.b"<shardul.b@mpiricsoftware.com>, "janak"<janak@mpiric.us>, "kalpanjani00=
9"<kalpanjani009@gmail.com>, "Lixiasong1"<lixiasong1@huawei.com>
Date: Mon, 03 Aug 2026 23:04:58 +0530
Subject: Re: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in =
retransmit paths

 > Hi Kalpan,
 >=20
 > On 03/08/2026 06:52, Kalpan Jani wrote:
 > > Hi all,
 > >=20
 > > Gentle ping on this v3, sent on 2026-06-17:-
 > >=20
 > >   https://lore.kernel.org/all/20260617114508.253716-1-kalpan.jani@mpir=
icsoftware.com/
 >=20
 > Sorry, thank you for your patience. The priority is on the fixes, and we
 > are trying to go through all patches when we can. But I admit is way
 > longer than usual.
 >=20
 > > I didn't get any CI results or review comments on it, so I want to
 > > make sure it didn't get lost somewhere. As far as I can tell it was
 > > sent to the right list with the right prefix.
 >=20
 > It looks like the CI didn't manage to send the notification. I restarted=
 it.
 >=20
 > It looks like the AI review was available:
 >=20
 >=20
 > https://sashiko.dev/#/patchset/20260617114508.253716-1-kalpan.jani%40mpi=
ricsoftware.com
 >=20
 > I guess at least the commit message should be updated, because the MPTCP
 > sockets do not perform routing lookups. It could only do it when a
 > subflow has been selected, which is not the case in the cases you
 > modified. Same for the socket option: it is not available yet.
 >=20
 > Also, maybe better to directly use icsk_rto_{min,max} to avoid
 > confusions, no? By doing that, you can remove the exception for "ip
 > route ... rto_min 0" that doesn't influence anything here anyway from
 > what I understood.
 >=20
 > > Happy to rebase and resend as v4 if that is easier, or to rework it
 > > if this isn't the approach you'd like for issue #618.
 >=20
 > It would be good to have a validation for this. Because it is
 > time-sensitive, the easier would be to do it with Packetdrill. Here, no
 > need to create a new one, simply extend existing ones, e.g.
 > mptcp/dss/dss_fin_retrans_* =E2=86=92 we could set the tcp_rto_max_ms sy=
sctl to
 > have a shorter time, no? If at least one test is modified to validate
 > your modifications in mptcp_set_datafin_timeout(), that would be good.
 >=20
 > WDYT?
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20


