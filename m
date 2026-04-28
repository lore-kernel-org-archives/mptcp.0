Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29902C3248
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344986; cv=none; b=S5Vq8T6GIdBsi3fGJm2eY8L9JdesD2Xayh1mPodMGmq+aRP3toE6P4eHY8CaCuM1LtheSQ3TvI8WukoqNkZNzUKHywfS49X4VTnAz2mZudx4N0TZRIpjbm9mhm/tzNJEP7OnOYHFeUg6f3u4QI9diTHqxGDvu9GtGkPQEXTrI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344986; c=relaxed/simple;
	bh=bJl+rGb4pbp6oNWWddGycFF3UebUt5fNrWFpZWD1OQ0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=Ng1r/1u8YN2N6zoSOLupmQ9GkA1hmBZjdmBAS/gNT025q9aLqJKWt2Bj+YwJcm/SIDzRHb2n542wd5e0Z6nPzagaJ+z4XhjEmTw+x0EzwTr4bk+4Sve/eV/bB10s3f+b0PCAiv27pDJNVj/7qBmlq4qEvyWlOU5egCxPKC1ElDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whgWO9C4; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whgWO9C4"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777344982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cD4KHmpYNlWnzIbZwvHEE6SQBeKy3mVKGnD6puV9Vw=;
	b=whgWO9C4K2FpiXJUIcwQ8rqxcEATHolHERmYdk13fKUEw5e/hHX00mk7n0s9R87K6lUNqQ
	HQRw2CcUL1vpuEZktZaBOfZ4ZvxRJGZ455/vVd/0xF2c1ab3DE4r8tzNclMqIjiAgirvwG
	MmdKetCzbBERVQlAE6UxSR4mfNounb4=
Date: Tue, 28 Apr 2026 02:56:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <e5a9d2b5e69853ce5a217d52f9e79530de988a2f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net 0/2] mptcp: replace lock_sock_fast with
 sleepable lock
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <71e4db99-a4a3-4ce6-b154-1d65e1b3bdff@kernel.org>
References: <20260422091927.77770-1-gang.yan@linux.dev>
 <71e4db99-a4a3-4ce6-b154-1d65e1b3bdff@kernel.org>
X-Migadu-Flow: FLOW_OUT

April 27, 2026 at 11:04 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org=
%3E > wrote:


>=20
>=20Hi Gang,
>=20
>=20On 22/04/2026 11:19, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  Hi Matt,
> >=20
>=20(I'm not the only one here, anybody is very welcome to review the
> patches: if you put only my name, other people will not tend to review
> your patches ;) )
Got it, thanks for your reminder.

>=20
>=20>=20
>=20> I make some progress about the issue sashiko mentioned in:
> >  https://sashiko.dev/#/patchset/20260420093343.16443-1-gang.yan@linux=
.dev
> >=20=20
>=20>  The problem does exist,though the trigger conditions seem quite st=
rict.
> >=20=20
>=20>  asdasda shjaksdjh askjd hjklajsdhfj klasjd aklshd kljasldkj akjlsd=
 klklk
> >=20
>=20(Not sure what this =E2=86=91 means)

The random garbled content was caused by accidental typing due to my loca=
l
environment issue, which was a careless mistake on my part.

Recently, I=E2=80=99m actively learning and getting familiar with the b4 =
tool.=20
I=20will standardize my patch submission process and ensure that such mes=
sy content
and irrelevant errors will not appear in future patches.

Thanks
Gang

>=20
>=20I only applied patch 1/2:
>=20
>=20New patches for t/upstream-net and t/upstream:
> - 38bf59aed203: mptcp: fix scheduling with atomic in timestamp sockopt
> - Results: 6d491ca82084..1198f2f92b39 (export-net)
> - Results: 2f9eb2a59db0..3c2b57fddf87 (export)
>=20
>=20Tests are now in progress:
>=20
>=20- export-net:
> https://github.com/multipath-tcp/mptcp_net-next/commit/42417392e5ff4cba=
41b6b585233d57bd9102f2da/checks
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/9b2ff7d1da660653=
ed4d10f0888aa499b7988b54/checks
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
