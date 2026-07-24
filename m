Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495E1D9A5F
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886781; cv=none; b=DYJ4GfUVX/qp2dBzBh+Z6Y2kqAgob3yyB/hsict7agZrr4JLzVyVQYhWg2Dq/QOcAbFaMhcR4R4ssHj6fm+gZ1lyB2lL4lEyByDlybCWIdIf+Gq9LTT/lLN0CxbO1tMgb2Sx7RsZqRbmt3j39WQf1QZ/ZIA+xotXuDNZocMAJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886781; c=relaxed/simple;
	bh=Ni053XfP8rSVkGdNS5g+jLTTW2OEpZJWbBh6g3do9y0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=aYwTbTgAs6Vd/xml2sGQ9KiMgB8z064VUNHYAkiLFJSChdfkCpDsnU6gZxX/W5p/4DrogwRe+WAFZbV5hV9u27mLmxZnFCBeU44b4ucAbzPrspbc/fFw7isAjXegxfO6mHxrbuXLBIsHO2qFF/UBPFlwk38lnncnajT20KIZ3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UbISm4et; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UbISm4et"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784886775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+B23tBGDD3SlSi5spKFVhx2EGueSmcVyaN+DCxk0HPw=;
	b=UbISm4et8UdH/SMS0xOgxfM31EjwRlbd354+F6bGmJDEE5HeSxb/varqjHU9WPnfmh/KPj
	gIgZUMeRw9B/PKRqODaYrYCPS7RfAfsMfZkn9bk/h6O/a07bXx8jGtNKC2UwL4aFSX+7Ak
	HGRy6rRY59u4yEWkDUojMYo5ymfyaxk=
Date: Fri, 24 Jul 2026 09:52:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <7db78ad766d61c6bbc877acdecc7f6654d1e6582@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: simult_flows: set EXIT
 trap earlier
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <c6091b33-77ec-4bda-abcd-e40554f33e71@kernel.org>
References: <20260724065229.36736-1-gang.yan@linux.dev>
 <20260724065229.36736-3-gang.yan@linux.dev>
 <c6091b33-77ec-4bda-abcd-e40554f33e71@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 24, 2026 at 5:27 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:ma=
tttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3=
E > wrote:


>=20
>=20Hi Gang,
>=20
>=20On 24/07/2026 08:52, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  Set the EXIT trap for cleanup immediately after creating the tempo=
rary
> >  file variables, before the dd commands that fill them and the namesp=
ace
> >  init, to ensure cleanup runs on any failure or interruption during t=
he
> >  early setup phase. If either dd fails (e.g. ENOSPC), the temp files
> >  already created are not cleaned up.
> >=20
>=20From what I see, if one of the 'dd' command fails, the errors are sim=
ply
> ignored.
>=20
>=20>=20
>=20> Assisted-by: Codex: GLM-5.2
> >  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  tools/testing/selftests/net/mptcp/simult_flows.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/t=
ools/testing/selftests/net/mptcp/simult_flows.sh
> >  index 3ea3d1efe32e..b40dea5f9b30 100755
> >  --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> >  +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> >  @@ -62,13 +62,12 @@ setup()
> >  sout=3D$(mktemp)
> >  cout=3D$(mktemp)
> >  capout=3D$(mktemp)
> >  + trap cleanup EXIT
> >  size=3D$((2 * 2048 * 4096))
> >=20=20
>=20>  dd if=3D/dev/zero of=3D$small bs=3D4096 count=3D20 >/dev/null 2>&1
> >  dd if=3D/dev/zero of=3D$large bs=3D4096 count=3D$((size / 4096)) >/d=
ev/null 2>&1
> >=20
>=20This 'fix' is only interesting when the script is abort while one of =
the
> dd command is in progress, to create files of 80k and 16M in RAM. I
> guess this is very unlikely, no?

Hi Matt,

This change was suggested by AI, referencing commit c8da80af2838 ("selfte=
sts: mptcp:
sockopt: set EXIT trap earlier").

I agree the problematic case is unlikely to hit in practice. My main moti=
vation is
to keep the selftest scripts consistent.

If left unfixed, someone might spot this later and send another similar p=
atch,
bringing extra review overhead in the future.

But I am still okay dropping this patch.

Cheers,
Gang


>=20
>=20If you already managed to end-up in this situation by accident, OK to
> accept the change, but the commit message needs to be updated.
>=20
>=20If it is a potential fix for an unlikely situation with the selftests=
,
> we probably don't need that.
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
