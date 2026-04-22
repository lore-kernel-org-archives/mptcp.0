Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C363CB
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837147; cv=none; b=g13ImGNyeTEivPmoEkIpuNAmkkYkdjDKR/CT2Hr7rRXPLMHA0ZeEAgZ77M2BBkE8UiFiHauzt01roNM6c52dlun3nJcz0rAEjnfl9P/QVmvTYMEjGvUs52qImg9jfJp77JZjR4lbtLJaJUkntXJxaYJ7vQjuCFx/O6ZFlKdau38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837147; c=relaxed/simple;
	bh=5nh08finujlkAXlNqGvjjVqPrxdVZMN2V6XuLq2pY4o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=XsVlkAIz7DrBMzJezOikQFx8t+JhgKnlAcERoWOf24zAnYe3j7oR6bgBhf0s95IwbDG0aPGla5UmHbvyYT2LvM8dgJG1uany2szSnaQX4YQQxND4T0dELvJkEiwlgow2qGeIEMvkEzwwV4owScyaYw/pe1gftEGilNNCMKQSQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nN/7P6cf; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nN/7P6cf"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776837144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXYPVE9ABTScaHP1TbR9X1BDEOnQgsA8tLWU9GYbE0w=;
	b=nN/7P6cfrrzs1AmHDR29T2zkfv2QF0ktjbw0guF8RqNJP68P700rp1PpiVpgKLqwJrbkxo
	EGDk6Wh4tiDgiMSwi0LjndnUGFG9LtwC3lqVdXLOwL+DUqTvOeqxojz/SEOrsFi2/DxOho
	uSBqRFlWcek+0MmRax+zP8m8TezwuMU=
Date: Wed, 22 Apr 2026 05:52:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <091162cb30a989b1a46612cc3f1a2879935edfec@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: set timestamp flags on subflow
 socket, not msk
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <0709c747-463f-4f5f-995b-156764f35da3@kernel.org>
References: <20260420093343.16443-1-gang.yan@linux.dev>
 <0709c747-463f-4f5f-995b-156764f35da3@kernel.org>
X-Migadu-Flow: FLOW_OUT

April 20, 2026 at 5:46 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:


>=20
>=20Hi Gang,
>=20
>=20On 20/04/2026 11:33, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  Both mptcp_setsockopt_sol_socket_tstamp() and
> >  mptcp_setsockopt_sol_socket_timestamping() iterate over subflows,
> >  acquire the subflow socket lock, but then erroneously pass the MPTCP
> >  msk socket to sock_set_timestamp() / sock_set_timestamping() instead
> >  of the subflow ssk. As a result, the timestamp flags are set on the
> >  wrong socket and have no effect on the actual subflows.
> >=20=20
>=20>  Pass ssk instead of sk to both helpers.
> >=20
>=20Good catch! How did you find the issue? It would be good to add a tes=
t
> for that, but not sure how.
>=20

Hi=20Matt,

Sorry for the late feedback.

Thanks! I=E2=80=99ve been using AI assistance to study and understand thi=
s part of
the code recently, and that=E2=80=99s how I found the issue.

And I noticed the issue of sashiko mentioned. I=E2=80=99ll take time to l=
ook into it
recently, and I will post updates on this issue to the mailing list.

Thanks
Gang
> >=20
>=20> Fixes: 3f4f958c3a3c ("mptcp: sockopt: propagate timestamp request t=
o subflows")
> >=20
>=20It looks like this commit doesn't exist in the 'export' or 'export-ne=
t'
> branches. I guess you meant to use 9061f24bf82e instead?
>=20
>=20When you do a git blame, do not use branches from the TopGit tree. Us=
e
> 'net', 'net-next', or the 'export' ones.
>=20
>=20>=20
>=20> Fixes: 6c9a0a0f2333 ("mptcp: setsockopt: convert to mptcp_setsockop=
t_sol_socket_timestamping()")
> >  Assisted-by: GLM-5.1
> >=20
>=20Thank you for using this tag!
>=20
>=20Apart from the above, it looks good to me:
>=20
>=20Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20
>=20I will wait for the CI, but I can also fix the SHA (if correct) when
> applying the patch.
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
