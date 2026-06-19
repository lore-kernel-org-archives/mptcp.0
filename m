Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146D3002D8
	for <mptcp@lists.linux.dev>; Fri, 19 Jun 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854617; cv=pass; b=dywzoAbdzKtoqjRwfvY7iQ8pxjrjuGYNhbVukP3dJUz7WuiPA6fhvrZYNE9ceG/tjplST66o5APow6NhujejdDMbFglQjjl0KmSWbmlttHzrv0NQMquX64E8Dp0iub7mmA3P1D+d4wb94I1Dm7T1E6je4V0e1F4RhdRdtcG60j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854617; c=relaxed/simple;
	bh=awBEl/DQB+m8wrDsQv0YhAvZY12rQ1SN4YK2rV4x+Bk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Bpz723hjy0gM7DQslsTqkimwamrZrJlh9aBgf8HuSAqK2hMtuKqVJ2uBKnSK6jy+aXwTibWVT7Oiu40x3nBnl3d4FdibWiwkL09tXNeWOvrfoz8yF2vrpc3ySQz69FNHDgM6qa9PbWtU1RRf1kIdu9FydrZC8bKsI3qRqnmE+ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=VQTC7Wi4 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="VQTC7Wi4"
ARC-Seal: i=1; a=rsa-sha256; t=1781854608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JHz70MbWuIJ+gkpzT/hqm5cGcfZpecXaJfXZYwK7sTj7rj8ZXk510fPKliLckzX84F69lA0ZfCShAV0cNiTRslI6lTqoabCzNVL7J88wyUy6ymn8TajJ2Hu6glx5atUBhgW80qFyg56pLnCOqVXsWFLHsmrUOscjhyPR8jByjvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781854608; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3e3FaTdCfchwugl9+Bi8wNfNsWikJecmfcZjnN/c69w=; 
	b=UBFUnTgCSwoK27n3612d+bWVnNXM3vb4CMxWa/gJm1qh0pxTBsFx61USX1NyHbSFOPszIiqV/LHutNZD2lfTUMl95T3FAzZ2Owob9OFs9unvgDpOmb0JLWGziwZAjymrQKXOMP9kfvRRnjRyrPKue26/aKEEAZlMfVdzkP/Z/Js=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781854608;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3e3FaTdCfchwugl9+Bi8wNfNsWikJecmfcZjnN/c69w=;
	b=VQTC7Wi47f/0DKe62OiV1TcUTNzKL6hsfir07PxqgsgEl3joUp+Wlmi9sGAbwHAg
	PFJSYGKnb+i3Z3iA3eM8BR2H5+wbMcD5yNttfA3E0UVNl/b39E7TzJxVlFXyjMqpPR/
	LhnLubvOv/1RIM+jlDuBYzUP8j74vzClvruh7p8c=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781854599994777.8483509152263; Fri, 19 Jun 2026 00:36:39 -0700 (PDT)
Date: Fri, 19 Jun 2026 13:06:39 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Tao Cui" <cui.tao@linux.dev>
Cc: "janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"martineau" <martineau@kernel.org>, "matttbe" <matttbe@kernel.org>,
	"mptcp" <mptcp@lists.linux.dev>, "pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"shardulsb08" <shardulsb08@gmail.com>, "cuitao" <cuitao@kylinos.cn>,
	"syzbot+55c2a5c871441261ed14"
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
Message-ID: <19edecf7b26.8016d4fc87564.6167938013625579685@mpiricsoftware.com>
In-Reply-To: <20260618001035.1701878-1-cui.tao@linux.dev>
References: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com> <20260618001035.1701878-1-cui.tao@linux.dev>
Subject: Re: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing
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


Hi Tao,

Thanks a lot for digging into this -- this is a real bug in the patch, not =
noise.

You're right: msk_local carries the connection's local port, and the lookup=
 in
mptcp_pm_announced_remove() compares with use_port =3D true, so passing msk=
_local
directly fails to match the pending entry from a no-port signal endpoint. T=
he
teardown then never runs and the WARN still fires on reselection. So v3 as-=
is is
effectively a no-op in this configuration -- thanks for catching it.

I haven't reproduced it deterministically on my side yet, so I'd gladly tak=
e you
up on the repro you mentioned -- please share it. I'll run it with a printk=
 in
the id 0 path to confirm the stored entry port and the announced result bef=
ore
and after the fix.

One detail I want to nail down with that: your note says the entry is "keye=
d with
port 1", but the suggested fix zeroes the port (anno_addr.port =3D 0). If t=
he entry
port is really 0, clearing the port as you suggested matches and is the min=
imal
fix; if it turns out non-zero, zeroing wouldn't match either and the addres=
s-only
lookup variant would be needed instead. The repro will let me check which i=
t is.

I'll fold the fix into v4 (rebased onto current export, where the helper is
mptcp_pm_announced_remove()), add a regression test based on the repro, and=
 credit
you with a Suggested-by. If the repro ends up forming the test, I'll coordi=
nate the
right tags with you.

Cheers,
Kalpan Jani


From: Tao Cui <cui.tao@linux.dev>
To: <kalpan.jani@mpiricsoftware.com>
Cc: <janak@mpiric.us>, <kalpanjani009@gmail.com>, <martineau@kernel.org>, <=
matttbe@kernel.org>, <mptcp@lists.linux.dev>, <pabeni@redhat.com>, <shardul=
.b@mpiricsoftware.com>, <shardulsb08@gmail.com>, <cui.tao@linux.dev>, <cuit=
ao@kylinos.cn>, <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
Date: Thu, 18 Jun 2026 05:40:34 +0530
Subject: Re: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing =
id 0 endpoint

 > From: Tao Cui <cuitao@kylinos.cn>
 >=20
 > Hi Kalpan,
 >=20
 > First of all, thanks for this patch!
 >=20
 > While playing with it on top of the current tree, I think I may have
 > bumped into a small detail, and I just wanted to mention it in case it
 > is useful =E2=80=94 please do correct me if I got any of this wrong.
 >=20
 > After the "mptcp: pm: uniform announced addresses helpers" refactor
 > (7d4dacc8ccca), the helper became mptcp_pm_announced_remove(), and its
 > lookup uses mptcp_addresses_equal(..., /* use_port =3D */ true). A pendi=
ng
 > ADD_ADDR entry coming from a signal endpoint added without a port
 > (`ip mptcp endpoint add ADDR signal`) is keyed with port 1, while
 > msk_local carries the connection's local port. With a listener on port
 > 5000, a temporary printk in the id 0 path shows:
 >=20
 >     msk_local.port =3D 5000
 >     announced(port0_lookup) =3D 1
 >=20
 > So, at least in this configuration, passing msk_local directly does not
 > match the entry: the stale entry survives, and the WARN still shows up
 > on the next reselection. It only goes away when the port is ignored
 > during the lookup.
 >=20
 > If that matches what you see, the smallest change that keeps the v3
 > shape would be to clear the port before the lookup, something like:
 >=20
 >         struct mptcp_addr_info anno_addr =3D msk_local;
 >=20
 >         anno_addr.port =3D 0;
 >         announced =3D mptcp_pm_announced_remove(msk, &anno_addr);
 >=20
 > (An address-only variant of the lookup might be a touch cleaner, since a
 > signal entry never carries the connection port =E2=80=94 but the one-lin=
er above
 > is enough to fix the case I reproduced.)
 >=20
 > I have a small repro that triggers it deterministically if it would help
 > =E2=80=94 happy to share.
 >=20
 > Thanks again for looking into this, and sorry for the noise if I'm
 > missing something obvious here.
 >=20
 > Cheers,
 > Tao
 >=20

