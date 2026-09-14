Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EE40B6EF
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375542; cv=none; b=on46UaSjLi9DtendPdYFJmugfnTgDl7fQjVoa1cutnClFdxpRvfxoui9iRXlZvis/rO82AcpnTEZTwLrhSrC382t36t4QZ7HHywDW4N4l+iw8qUbDyf2vtAGOLRsSc3bb6Dl8hYnWB6T4ZHXkLSRDVSocwscO958ZsqoDF29v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375542; c=relaxed/simple;
	bh=fCmcEN2w/YvBwaV3b9hefPqZ881UJA7yaCsX2bSiwBE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=eZ1E9xMSoUfOINiRq+s3tViIQ/XpHRcOFqWhShS48DL2sieUIzAR4IZK4WglwP2zJrPFJ7AJj7aU22aygkM1jtbRR6M86QJZh9OwJEIp0NnCFSf37iw4ogeeNENwfuqf4TywiVDF1ZNmkcd3sGe3+vxwhH6v2yWyMpNBGYu8rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAY1I0KT; arc=none smtp.client-ip=91.218.175.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAY1I0KT"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=fCmcEN2w/YvBwaV3b9hefPqZ881UJA7yaCsX2bSiwBE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789375537; v=1; x=1789980337;
 b=fAY1I0KTO4U5sAo77QqYvSEexclZAugj+Hyhhe9AxcIhnIg2N3MY04qC7mN0BTzH4DNTD+tg
 HoH2n01i/bMmvY4YfptoEkPeG+stDjMUnDQtO+OnGzfDT16rB8TaqP3w8jxp22WRha2DHHREhll
 EW8ellLvqLQYb1u6KfRAA/dI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 454b48ababe58b17;
	Mon, 14 Sep 2026 08:45:08 +0000
X-Mizu-Trace-ID: 454b48ababe58b17
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 08:45:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <0b7ac0ea84f0dea0092aa84d4aff3db0b6dc0f93@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf 1/2] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Geliang Tang"
 <geliang@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Jakub
 Sitnicki" <jakub@cloudflare.com>, "Eric Dumazet" <edumazet@google.com>,
 "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Sabrina Dubroca" <sd@queasysnail.net>,
 "David Howells" <dhowells@redhat.com>, "Matthieu Baerts"
 <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>
Cc: "Geliang Tang" <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev
In-Reply-To: <da26d2f3-7283-4e9f-85b4-6c12b9beda99@linux.dev>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
 <f12f1d886c8ff2b6f6e48f797ccc861037eda685.1789368148.git.tanggeliang@kylinos.cn>
 <da26d2f3-7283-4e9f-85b4-6c12b9beda99@linux.dev>

September 14, 2026 at 4:24 PM, "Jiayuan Chen" <jiayuan.chen@linux.dev mai=
lto:jiayuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40=
linux.dev%3E > wrote:

> Same as the tls one: this looks like a cleanup to me. Is there a real r=
egression that affects kernel or user behavior?
>=20
>=20Do we really need a Fixes tag?
>=20
Hi=20Jiayuan,

It's a part of the thread in [1], just kindly remind that there had some =
comments from Matt:

'''
Also, should this be seen as a fix? From what I understand, some
behaviours have changed, and it is only recently that this call is no
longer needed.
'''

From my view, it seems like that there have some misses in the 'fixed' co=
mmit, so the fix tag
should be kept, right?


[1] https://lore.kernel.org/mptcp/b5f9e8d7-b738-1df6-3b5e-1d54cbbc663c@gm=
ail.com/T/#m1fbcb32408236e2c68554fd26353c98bb59633f9

Thanks
Gang
> >=20
>=20> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  ---
> >  net/ipv4/tcp_bpf.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
>=20>  diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> >  index 2e234d155b5e..d5fcf3ce4861 100644
> >  --- a/net/ipv4/tcp_bpf.c
> >  +++ b/net/ipv4/tcp_bpf.c
> >  @@ -108,7 +108,6 @@ static int tcp_bpf_push(struct sock *sk, struct =
sk_msg *msg, u32 apply_bytes,
> >  off =3D sge->offset;
> >  page =3D sg_page(sge);
> >  > - tcp_rate_check_app_limited(sk);
> >  retry:
> >  msghdr.msg_flags =3D flags | MSG_SPLICE_PAGES;
> >  has_tx_ulp =3D tls_sw_has_ctx_tx(sk);
> >
>
