Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9F10E5
	for <mptcp@lists.linux.dev>; Thu, 28 Dec 2023 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XnLD8VAi"
Message-ID: <ca9fb0ef220d57b2da0b33ce825d452409e1598b.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703730713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wo+7m90RYio/sXnDFNcvJiOjgCZaLxC3Cwk6m8cQ00w=;
	b=XnLD8VAiz1ttxuRm+5d94SqXFCnWcO6S94o/+q4bfEs86e6hvGrJRF1puPgQa2Knq0ZhNn
	o+KhQkg/SRhb76cszdPsU4wIpjOQ2LNqnk6o1HrLOrQQLSnS1w1TC5FF00YKRhH/BU7zMy
	8DHRZY9UBfJW19Hc8xhZhyZ3tpMk/7M=
Subject: Re: [PATCH mptcp-next v14 00/25] userspace pm enhancements
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Geliang Tang <geliang.tang@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Thu, 28 Dec 2023 10:31:37 +0800
In-Reply-To: <2f9f4b7b-d8ea-40ad-97e3-61d1e767ceb4@kernel.org>
References: <cover.1702029538.git.geliang.tang@linux.dev>
	 <2f9f4b7b-d8ea-40ad-97e3-61d1e767ceb4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Hi Matt,

On Wed, 2023-12-27 at 12:38 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 08/12/2023 11:07, Geliang Tang wrote:
> > v14:
> > =C2=A0- implement flush operation in user space as Mat suggested.
> > =C2=A0- update selftests.
> > =C2=A0- Now this series includes five parts:
> >=20
> > Part 1: dump for userspace pm (patches 1-9)
> > Part 2: fixes for creating id 0 subflow (patches 10-13)
> > Part 3: v4-mapped addr support (patches 14-15)
> > Part 4: flush for userspace pm (patches 16-18)
> > Part 5: address entry refcount for userspace pm (patches 19-25)
>=20
> For tracking purposes, which patches can we drop on Patchwork?
>=20
> https://patchwork.kernel.org/project/mptcp/list/?series=3D808195&state=3D=
7
>=20
> - Part 1: If I understood correctly, patches 1-9 are supposed to be
> replaced by a new series "dump for userspace pm", right? Then can we
> drop patches 1, 2 and 5 from Patchwork? (Patch 3 has been marked as
> "Rejected", I guess that's OK.)

Patches 1, 2 and 3 can been marked as "Rejected".
Patches 4-9 can been marked as "Changes Requested", they will
been included in the next version.

>=20
> - Part 2: does it depend on part 1, or can it be applied separatelly
> in
> -net because they are fixes? Or at least the modifications in the
> code,
> the selftests tests could go only in -next if it is difficult to get
> them in -net.
>=20
> - Part 3: Is it also a fix? I mean: did we forget to support v4-
> mapped
> addr in one command, but others have this support? Can it be sent
> separately to -net?

Yes, patches 10, 11, 12, 14 are fixes. They don't depend on part 1 but
will conflict with part 1. I'll make them a new series for -net.

>=20
> - Part 4: it is not clear to me if they were needed? They have been
> marked as "Rejected", but please tell me if they are still needed and
> just the title here was wrong.

Patch 18 can be marked as "Changes Requested". We can test flushing
addresses in userspace in it.

Thanks,
-Geliang

>=20
> - Part 5: I need to re-check the code before invalidating them (and
> issue #403).
>=20
> Cheers,
> Matt

