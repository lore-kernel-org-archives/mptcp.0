Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89A31F9A2
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345805; cv=none; b=LCMpvVOQWdISW0ONBgiJATU/GPm/MNp2unJbJGX7uiIgAuzcCWRKVEmYALsF0zUZoO7do453q1vOe2Rgg7lDjPepVPsi6+qSxbUHlGfvyJgg+EbA0KdmXaE+RCxWGNwkZ3Q6GQFZYGMntEMi4kkhDGWa6RrnloptQAS5P3V9/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345805; c=relaxed/simple;
	bh=sKxEKtWrvEogLLMqxaivx8nINeAC7QGHR5gWglahvF8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=s1FSV6W7XLqL6je3e5r5BalBLy7pkb8fJOKTOh3cctRsHqXMZViizDf/GvHbFFDd30H91G4iSJ6PMNCnikEgsQ8u3ZSbQlYv2DBLnM1JJqpvJIndQIzkfE9yceSNNIfNgoTbKftAeg2nxiZhqVKuwyUAr/UvTBs2vBonxkMOCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cet2TLDW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cet2TLDW"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777345801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtJ5m+AhXuZI+6fPgOw2cW8jWVJYvnenztVqo56rQ40=;
	b=cet2TLDWNyb7yAkJE5q9TJ0N4CXwOR+1p6mczh5ITxHVrNOl75QDUKqDZYqWuIVQVSO8EQ
	KonAZ/gk/nGX26U6nXv9ESAyHykqui204qQW+SXCVAXCXu5hMwqSBZvq3bYpz1NgHS88fT
	Op/gQed1iCazAh0VF2BEXSkXiZpZCF0=
Date: Tue, 28 Apr 2026 03:09:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <c773d6a165a1abeb963481ef76117a049952ae87@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 2/2] mptcp: use sockopt_lock(release)_sock in
 sockopt
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <318c9ceb-b446-499f-9ee0-ccef871b5b21@kernel.org>
References: <20260422091927.77770-1-gang.yan@linux.dev>
 <20260422091927.77770-3-gang.yan@linux.dev>
 <318c9ceb-b446-499f-9ee0-ccef871b5b21@kernel.org>
X-Migadu-Flow: FLOW_OUT

April 27, 2026 at 10:47 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
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
>=20>  TCP and the core socket layer all use sockopt_lock_sock()
> >  sockopt_release_sock() in their setsockopt and getsockopt handlers. =
It
> >  is a BPF-aware wrapper that skips lock acquisition when invoked from=
 a
> >  BPF program, where the socket lock is already held.
> >=20=20
>=20>  Using lock_sock_fast() on subflows requires extra care: the fast p=
ath
> >  holds the socket spinlock with BH disabled, creating an atomic conte=
xt
> >  where sleeping is not allowed. Switching to sockopt_lock_sock()
> >  avoids the risk of accidentally introducing sleeping operations insi=
de
> >  the lock_sock_fast() critical section.
> >=20
>=20Good catch, I guess we need this too. I think this patch can be seen =
as
> a fix as well, maybe with this tag?
>=20
>=20 24426654ed3a ("bpf: net: Avoid sk_setsockopt() taking sk lock when
> called from bpf")
>=20
>=20WDYT?
>=20
>=20Also, from the same BPF series, we probably need this, no?
>=20
>=20 e42c7beee71d ("bpf: net: Consider has_current_bpf_ctx() when testing
> capable() in sk_setsockopt()")

Great suggestions!

I'm a bit busy with ongoing work recently, but will check those two commi=
ts
carefully this week later. If these changes are necessary, I will send ou=
t a
new complete patch series. If not required separately, I will post releva=
nt
updates in the mailing list thread accordingly.

Thanks
Gang
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
