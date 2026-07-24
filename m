Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9D372EEC
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885957; cv=none; b=BAISWnfF5pAs+J8nsbr59WoN7NAa5BHIIuLOBDLw9bPvl9s/q7Wdit3JI/J2poZ0YtsCPKqSfjjOlahzGu+EvTvKTACG4Fe7L8wJzYdhQnBXQhVxG6vohpv09BcMyzuwnTDszaIteHJBjwLfUiczt8IO6uZIVk/iKgrpR1D4HgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885957; c=relaxed/simple;
	bh=Ptx129g0erFCyffifLk5cd/oRQXWf5KsGsA3rUow0sQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LAVjspxEw7fRN3MD5zxpoYAfogFZzd76I4v1cuVV7b1sVL9jdvurf1AgyH4sLpoPRCZOrInFfZ5dPOsSwhwPxcokiHcQI8lxU+sSRNSUmC0iM+8mMKxX3aZmqlKj38Ns1Q0JDIzS0s2zW0phVMRd3D47Llz80myPQHRsrNS2ys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jdQJXFdq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jdQJXFdq"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784885953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr77Bhj1rY+cajkMb07X7rptVHqEnQSM52v3/E2mcJg=;
	b=jdQJXFdqiEkysroOaEJFwBR9TmQQP8wv6sq0DYXbRYZKxnBXIeL+vSvXoUNvjoj6N511fg
	x4zvJI/2gb4BJNPLa8g2v6+i4yoohrjMeu+HSkR2iqV22sNyCMp0IGkWuU9U7/LpJEYTrX
	KQDToBtwD9susbwzSMbv6Sp0Yszjaxs=
Date: Fri, 24 Jul 2026 09:39:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <a3076ab0e3303b7d893c1988d20bc83572043dc0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: run fail_test in main
 shell during join test
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <560844d2-60e5-4d43-b039-071125fc9f08@kernel.org>
References: <20260724065229.36736-1-gang.yan@linux.dev>
 <20260724065229.36736-2-gang.yan@linux.dev>
 <560844d2-60e5-4d43-b039-071125fc9f08@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 24, 2026 at 5:28 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:ma=
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
>=20Good catch!
>=20
>=20This looks like a fix that should be backported. Do you have a Fixes =
tag
> to add here?

Hi Matt,

Sorry for that, I originally thought only commits touching ./net/mptcp ne=
eded
a Fixes tag. This fix should be:

Fixes: 8117dac3e7c3 ("selftests: mptcp: add invert check in check_transfe=
r")

Thanks
Gang


>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
