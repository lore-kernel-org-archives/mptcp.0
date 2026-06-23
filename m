Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC442772D
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214800; cv=pass; b=CwhCcGwqNajx1GQzUB0BoIThjFzN4kY1jC5IqHp8eXrbVuMB/tTYc1J6kxDVnheXnUr7KuiqXZI5Qmrbsa1dlJ0qJaicsDRk4Cnn8OG9Y8XQo3yPfDB3sjroaZArMClc5NcZzBRKtefv2FP/i7HjidXGp0tMOBLep1gPunvyFZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214800; c=relaxed/simple;
	bh=4MH7sLrogvS6NkXCAmVqBAh1/+684UniyCn3ZhWkXP8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SLpCQuyWUm1+/5jm1SVpY0rw41aqno7aFuuyAOWwPW/UgNcjmd6+lcQgeUz8Lc5ORJsMrjmGYcwD4hh1lx57oyU8vn2pBS8erRMUQdSUNcvf1wPOkBPrbYsYI1vCc8jrcyvFlL/OOswakIfq0p3VoaEEXH7atQpykWo7ql9gdLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=KTnfStKZ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="KTnfStKZ"
ARC-Seal: i=1; a=rsa-sha256; t=1782214795; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C4m28srliElorNcDqsnbQQSzGNIQEC+kM7vH9MrTF7uOWGPqd5JiQv56RLiv7quP4v11yjNUdJfSS6vB69R0f0N4H2/T9Dk6R833M1zrAe5TuggfmEbDVYLzwf7Md1d3Aas0OAh9l7gJ2OyuaiPYXUhnZtWoqmrdtwWwtfzeYaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782214795; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eDIvpW8X81ecJhuDD8DpmrGhFvMxoQ+cVMlizpzLgtE=; 
	b=TTD/ERudpes4iOY2oYzUPpFWtkYmUcKPNGmb0nnft6BogefnA+5cTPDqGcQWQSpdGaW/j4GBAmld3hH2RwO8ubEWP9tRFoe8YCMai2abU80HxCOm2tO6qZmb46sDjaNob1e5KxUhlnd776Qfx1AxYtBseNyYg1EUb141QgGuv28=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782214795;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eDIvpW8X81ecJhuDD8DpmrGhFvMxoQ+cVMlizpzLgtE=;
	b=KTnfStKZ+Yt0WZDAmZKdcn5IAnniEV533aRIIBLUMTa09XMPkmWVWa01oy/XoZxy
	SFKSM2xCu5amxYUQzuavuVlRbMEEuI+4XWf9Phk955yIGioGvlj+BEwbttc4dZgCG8e
	yHCIYbAJA0Unx9KRp5UlgfcdpAJVHZWfmBGx4ncg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 178221479291751.69283249608361; Tue, 23 Jun 2026 04:39:52 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:09:52 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "Li Xiasong" <lixiasong1@huawei.com>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"akshit" <akshit@mpiricsoftware.com>, "syzbot+fb2c3fa2ba28aec94627"
 <syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"zhangchangzhong" <zhangchangzhong@huawei.com>,
	"yuehaibing" <yuehaibing@huawei.com>,
	"weiyongjun" <weiyongjun1@huawei.com>
Message-ID: <19ef44796c3.794cb169432307.366490776961059119@mpiricsoftware.com>
In-Reply-To: <05d0dbe6-b2d8-415d-9ded-cb5c4f073812@kernel.org>
References: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
 <c45810a3-5a87-4080-a8c4-4846d0fc74ed@huawei.com> <05d0dbe6-b2d8-415d-9ded-cb5c4f073812@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: fix lockdep splat in
 mptcp_subflow_create_socket
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

Hi Matt, Li,

Thank you both for the review.

To be transparent: I did not attempt to reproduce the issue locally =E2=80=
=94
the patch was based purely on analysis of the lockdep report and the
allocation path through sk_net_refcnt_upgrade().

Li's point is well taken on two counts:
1. d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
   dependency") may already address the root cause by fixing the NBD
   lock class confusion.
2. Even with my change, tcp_set_ulp() and the MPTCP ULP init path
   still perform GFP_KERNEL allocations under lock_sock_nested(), so
   the fix would be incomplete at best.

I will test against a tree containing d532cddb6c60 this week and check
whether the lockdep warning can still be triggered. If Eric's fix is
sufficient, I will close issue #599 and drop this patch.

I will report back with results.

Cheers,
Kalpan Jani




From: Matthieu Baerts <matttbe@kernel.org>
To: "Li Xiasong"<lixiasong1@huawei.com>, "Kalpan Jani"<kalpan.jani@mpiricso=
ftware.com>
Cc: <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.=
com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <akshit@mpiricsoftware.=
com>, <syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com>, "mptcp@lists=
.linux.dev"<mptcp@lists.linux.dev>, "zhangchangzhong"<zhangchangzhong@huawe=
i.com>, "yuehaibing"<yuehaibing@huawei.com>, "weiyongjun (A)"<weiyongjun1@h=
uawei.com>
Date: Tue, 23 Jun 2026 14:24:31 +0530
Subject: Re: [PATCH mptcp-next] mptcp: fix lockdep splat in mptcp_subflow_c=
reate_socket

 > Hi Li, Kalpan,
 >=20
 > On 23/06/2026 06:50, Li Xiasong wrote:
 > > Hi, Kalpan
 > >=20
 > > On 6/17/2026 2:48 PM, Kalpan Jani wrote:
 > >> Move sk_net_refcnt_upgrade() outside the socket lock to avoid GFP_KER=
NEL
 > >> allocation under lock_sock_nested(), which can trigger page reclaim a=
nd
 > >> create a circular locking dependency detected by lockdep.
 > >>
 > >=20
 > > Thanks for the patch.
 > >=20
 > > I might be missing something, but I wonder if this is still needed aft=
er:
 > >=20
 > >   d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dep=
endency")
 > >=20
 > > The reported chain seems to involve NBD sockets sharing the generic TC=
P lock
 > > classes, and that patch should address it more directly.
 >=20
 > @Li: Thank you for pointing to this commit. Indeed, that seems to be the
 > required fix for this issue.
 >=20
 > @Kalpan: were you able to reproduce the issue pointed out by syzbot? If
 > yes, can you check if Eric's fix is enough? Or did you try to fix it by
 > analysing the code?
 >=20
 > >> The circular dependency chain detected:
 > >>   fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1
 > >>
 > >> This operation is safe after lock release since the socket is fully
 > >> initialized and no other references to it exist yet.
 > >>
 > >=20
 > > Even with this change, the locked section still contains GFP_KERNEL
 > > allocations: tcp_set_ulp() is called under lock_sock_nested(), and the=
 MPTCP
 > > ULP init path allocates the subflow context with GFP_KERNEL.
 > >=20
 > > So if the NBD dependency is still present, I am not sure this fixes th=
e
 > > reported lockdep dependency rather than moving it to another allocatio=
n site.
 >=20
 > Indeed, the fix might not be enough to fix the issue.
 >=20
 > > It might be worth retesting this report with the NBD reclassification =
patch in
 > > the tree before changing the MPTCP locking here.
 > If it is not possible to reproduce the bug, I suggest closing the
 > corresponding bug, and drop this patch. WDYT?
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20

