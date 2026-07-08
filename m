Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AF377558
	for <mptcp@lists.linux.dev>; Wed,  8 Jul 2026 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488688; cv=pass; b=PZFjdyn1/xAvEesuJDlcVyv4ROj/28DuSiZBlxeP5ZaAGWVBBpKZY5TUW+NlLfBnWWHGFvMlIOxznP57/YOsefvR5JyZUjm2yV2CPX8glk6fN/FJ/foRrbNfV+UV/XJhVZKyHUeXToHw2eK9IChC3uGGqKhtPdxwyZWk3HHEMDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488688; c=relaxed/simple;
	bh=q0xnivoPD6gGsJAg8mxLZ44gc9NFQeN7FXhSXLwC+VA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jnS63O8OY2EBX5rMvsUhyT4S3UG0arzExm5n6CRkUlUYlJbZpJ9WMv/tgR2dUD5SNXhop0dPfO75C1hX05MIIhqDsDyjog3x6Idv23iarTHjjhBqRU2/PCdcE+UoSXvYCyfGJ/uSN3+vtfdIL8255KB/YQwFxUKp7deHMAoB9dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=bHim12hn reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="bHim12hn"
ARC-Seal: i=1; a=rsa-sha256; t=1783488684; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J1uNvd8YWkdTw/+vrR+ChamPP3QEILZW9ui50klhvQ2m532tLPXLoc5ec9RUmv4bQPzl/FDkUn2NI66r2IV7cLEKggAyS+Nuyp3HEj1SZiI86LoScVqDGH0lEQYffntD4KcYj3rVnoB+rZa+e/AU1KQAx5XcIWzNtJAyvHoIInI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783488684; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q0xnivoPD6gGsJAg8mxLZ44gc9NFQeN7FXhSXLwC+VA=; 
	b=JAtrKNRv+gcAwdqezntgaY3NOPpqy8MHz1LgrRxf6tO3gehSQSJA11k0DEVT6y9venpPeQHAVujX8lFZcafKE7Rj9zDYtj2jo/jHb/G7EqLkZknEDkmm54BqJ7s7EvHq+Ovzg7FVlXZ9qC9LcU82W4bPc645cQB8fUdQBGJetvw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783488684;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q0xnivoPD6gGsJAg8mxLZ44gc9NFQeN7FXhSXLwC+VA=;
	b=bHim12hnL2EWQrQw2T2ODSkbtCQCXvOwRMVTNiKXvk+ubRP8ezpXGqS2Gi1OnO8+
	M541O5TsnM5ERSxeO6VNS8mTt+JhzZNcED2AInPuqwM0rG/B6Yhxsn1rS/DJ3NO1kDV
	I7Xnobt3J8TQn1cXY7xnSX/L5XU03UCo7BLg8IzY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1783488683736380.56333902628023; Tue, 7 Jul 2026 22:31:23 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1783488681527919.3357198695397; Tue, 7 Jul 2026 22:31:21 -0700 (PDT)
Date: Wed, 08 Jul 2026 11:01:21 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>
Message-ID: <19f403595bc.42f51a311935197.9099603416352376121@mpiricsoftware.com>
In-Reply-To: <3fa5bb51-f140-4cbb-b748-d264232c3eae@kernel.org>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
 <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
 <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com>
 <6d0b954c-4028-4c1e-bf02-5bf5f43f58af@kernel.org>
 <19f3b374a41.2132097d1809464.3759794617307044756@mpiricsoftware.com>
 <ad9044cd-ff6d-4a88-ba3f-fbba7d40b092@kernel.org>
 <19f3cca8500.ef8eb681856418.2642565239132356618@mpiricsoftware.com> <3fa5bb51-f140-4cbb-b748-d264232c3eae@kernel.org>
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
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

PR opened: https://github.com/multipath-tcp/packetdrill/pull/201

One note on patch 1: v5 passes &anno_addr (a zeroed copy of msk_local)
instead of addr directly. This works for no-port endpoints but is
fragile for with-port ones. Should I send a corrected v6 for patch 1,
or can you fix it up while applying?

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pab=
eni"<pabeni@redhat.com>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"=
<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>, "shardulsb08"<=
shardulsb08@gmail.com>
Date: Tue, 07 Jul 2026 19:44:57 +0530
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing =
id 0 endpoint

 > On 07/07/2026 15:35, Kalpan Jani wrote:
 > > Hi Matt,
 > > Thank you for pointing me to add_addr_retry_errors.pkt =E2=80=94 that =
makes the idiom clear. Inject a data packet after the del+re-add sequence a=
nd expect a plain DSS ACK back with no add_address option piggybacked. On a=
n unfixed kernel the stale entry causes a spurious ADD_ADDR(id=3D0) retrans=
mit to appear on that ACK, which packetdrill catches as an unexpected optio=
n.
 >=20
 > Great!
 >=20
 > > I will write the packetdrill test using that pattern and send v6 with:
 > >=20
 > > Patch 1: kernel fix (also correcting the addr argument =E2=80=94 the &=
anno_addr copy in v5 is fragile for with-port endpoints)
 >=20
 > If that's the same version as the v5, no need to resend it.
 >=20
 > > Patch 2: packetdrill regression test in gtests/net/mptcp/regressions/
 >=20
 > Can you open a PR instead, please?
 >=20
 > https://github.com/multipath-tcp/packetdrill/
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20


