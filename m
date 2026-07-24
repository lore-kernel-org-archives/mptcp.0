Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AA34D4D6
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887278; cv=none; b=XghTSz3mIBkd9UE3E48dwQwyWsof94PN6B3Yi71P7ICl84UW2lfXr5GC/KjVBosO8SMIG68w6Bh0ipBTaVxPG1VlqJZVoXKH4sWqePFT4oqPJwoEtqs59tw46rokUpcNtDMRLG3LAY0TuaLMUGognF4ZPcO4jnP2cazsfHcQ8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887278; c=relaxed/simple;
	bh=nJ/6Piv8v7WlRp0LVyIyAmqGlGuhyMg2cOjskkYZJsw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dxFKA066JQFYHYwbcvp677R5bI+E6BkJ2hLMs90hm2IR+FjwKZuTqL/UiKrALLRaN2HJOqKiHivBzbtuJYISChznNw1Eu/yTxwnIzfYmcGn5EgpIvCl9j9f2i6jTXEwzCFVu563Nv6HM1oeSSS2ZUVjXAqyhJ7hInvs5FNkYdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mfrRtMmV; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mfrRtMmV"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784887275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kb+nSDnppHBCVLE/D1pwa8dvvegXdX8HDRzdka3SWVM=;
	b=mfrRtMmVl0Lk1eO0ky09PuvlP0XHpkDmNbquzpnxutpwzoQx92hEEUfY0sGV2akPM1taYJ
	Ct1KWNxQPBPDcZ3UjOVhKdKLdy1b1vG7VJxY7NAjhe6rfdoHh1ViI7hfhGFkKZ5h3WG6XW
	/V6PjGI9UjQKL6E1afSzjn0FBylj+vk=
Date: Fri, 24 Jul 2026 10:01:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <702d8cbc3ca44321c1020d059cc0007bb297841d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: run fail_test in main
 shell during join test
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <eb6d7e10-8631-41ff-9c66-80362193897f@kernel.org>
References: <20260724065229.36736-1-gang.yan@linux.dev>
 <20260724065229.36736-2-gang.yan@linux.dev>
 <560844d2-60e5-4d43-b039-071125fc9f08@kernel.org>
 <a3076ab0e3303b7d893c1988d20bc83572043dc0@linux.dev>
 <eb6d7e10-8631-41ff-9c66-80362193897f@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 24, 2026 at 5:48 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:ma=
tttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3=
E > wrote:


>=20
>=20On 24/07/2026 11:39, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> July 24, 2026 at 5:28 PM, "Matthieu Baerts" <matttbe@kernel.org mai=
lto:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel=
.org%3E > wrote:
> >=20=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > Hi Gang,
> > >=20
>=20> >  On 24/07/2026 08:52, Gang Yan wrote:
> > >=20
>=20>  From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  check_transfer() compares the input and output files byte-by-byte =
using
> >  `cmp -l "$in" "$out" | while read ...`. Because the while-loop body =
runs
> >  in a subshell (the script sets neither lastpipe nor pipefail), the
> >  fail_test call inside it -- which sets the global ret/last_test_fail=
ed --
> >  and the `return 1` both act on the subshell, not on check_transfer()=
.
> >  check_transfer() thus always falls through to `return 0`, and any da=
ta
> >  corruption affecting only the payload (leaving the subflow/PM counte=
rs
> >  untouched) is silently reported as PASS.
> >=20
>=20> >=20
>=20> > Good catch!
> > >=20
>=20> >  This looks like a fix that should be backported. Do you have a F=
ixes tag
> > >  to add here?
> > >=20
>=20>=20=20
>=20>  Hi Matt,
> >=20=20
>=20>  Sorry for that, I originally thought only commits touching ./net/m=
ptcp needed
> >  a Fixes tag. This fix should be:
> >=20
>=20"Important" selftests fixes don't need to wait by going to the next
> version. If they fix something that can help users and/or CI, they are
> as essential as fixes in net/mptcp.
>=20
>=20We should just avoid fixes that don't affect results, e.g. the second
> patch of this series. But that's also valid for fixes in net/mptcp, e.g=
.
> a fix for a condition that can never happen with the current code, but
> will be the case with pending new features.
>=20

Thank=20you for your kind reminder. :)=20

Cherrs
Gang

>=20>=20
>=20> Fixes: 8117dac3e7c3 ("selftests: mptcp: add invert check in check_t=
ransfer")
> >=20
>=20Thanks!
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
