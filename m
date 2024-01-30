Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675A79921
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640825; cv=none; b=jPyiSkkJQUis1euswNZXU8pAdouEQC3bz4OyfhQcFlPZpKeqHh3CBhUvnCRoCotp4hL+Z0K3HFwIJig7DcmeJquonlcrB/yxbhx8CEpBZjGkXnTXw8AtXwQBTW+X3mGqCYDwBw6hl5a8ADni7RXq3WnaNJDqYh0u/6IfZoyJEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640825; c=relaxed/simple;
	bh=VPfjsjru1h/9V1Ph32sFwwlR8ZM0K7lA4A/uy0qDqXQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkZmx82Eebmiv14xwWImEgvU0K9Uvsd2EOKixSQm551RWEk1doj3l9n/WgV0EP2sJTVDzzyyAjwoPHmcVPMwFPQCpjWZLNwP8OCB2oZFVyIk5hw+qS5CmnLOK1DhFoqrgLM4S1Gp3RyiPEc8n82We9fUGOt2LR74YJFX4sEBJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTzOC7cK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTzOC7cK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706640822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VPfjsjru1h/9V1Ph32sFwwlR8ZM0K7lA4A/uy0qDqXQ=;
	b=cTzOC7cK4xXhgN6ezLoYZ0kHrrYwaIL3/d1dXR1LC3wVdQ3nGdFVN+SyMzY36GaKAlETAm
	G6ZGq9aeX0BZJrEA60U73X99seDLhslx9S6f3GAf+8AHsC9ZqEMnvO7L3LvzJNHFnKuzjP
	if92GP/bLVb2L5gsVGHN5qXh5TzlJnA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-cgbyM7RTMT2tHGtgUqmqAw-1; Tue, 30 Jan 2024 13:53:41 -0500
X-MC-Unique: cgbyM7RTMT2tHGtgUqmqAw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40f02c4aa13so1762675e9.1
        for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 10:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640819; x=1707245619;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPfjsjru1h/9V1Ph32sFwwlR8ZM0K7lA4A/uy0qDqXQ=;
        b=VcC6URH1oN/B9BN0vvrAeX+ZBvujmJHQjyr4NtQNXhKMeY4e/5dogGLU870dews0Ad
         VavaRhX+st0h0inM9mNiIucXWnq1kBHnirJAvBk0mlbU/Phxp6qn22vZ8lnOf9CqdIXK
         lIO1u+KzRtAh5nnrzmpNgy2TFFUBonZXEtvS3Ho3h7A41H8Q1wOtvvP78DiYlxNaHEma
         pRGKhHWEmtHSNBCN6Q9Ufly4fhtlRMzpFD0OI4lBDqmLMI8dQ1apbX7L88ApSAirzaEw
         8W6/4QVytTritL7ZtfB52rmWZnXxb/duhZWVUyPNhyxKDJAXgGwEfWMgwxyTUTdCbfkG
         Xdcw==
X-Forwarded-Encrypted: i=0; AJvYcCXw4MmerG9BsJuPsO1bzYWPfcje4bj73RmRO1ikn76Vi5FUSCOmBYq61a9QhYlNG8thO9HdtCXSwRUHV3Aoz/zYyq3i7PI=
X-Gm-Message-State: AOJu0Ywh8BU0N4VkG9BcK22EQ29Cod6uzP+KUsFDpL89kJ5ul6AfGNhm
	fs+G/hYOMRkranTfwJAFLNBcGoU5RMJJQZVV8qgp9Sd0qh/zrIqX8ZIWPZH2olbyweHZ4Wv+Ae/
	QdwyPfqTUAuk09DYwAskD6BBEjtkoddFt3AVl0w6+7YQjh/l33FQIQIJ5c3Pp
X-Received: by 2002:a05:600c:5187:b0:40e:eab6:f33f with SMTP id fa7-20020a05600c518700b0040eeab6f33fmr361368wmb.3.1706640819506;
        Tue, 30 Jan 2024 10:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+mls8/78DqlPHPXUP4+uTy6uy2SzE9vyWvOCEI0ygI4ytZENZo7HtbwzIa5QKaFGYhGUULw==
X-Received: by 2002:a05:600c:5187:b0:40e:eab6:f33f with SMTP id fa7-20020a05600c518700b0040eeab6f33fmr361357wmb.3.1706640819069;
        Tue, 30 Jan 2024 10:53:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0040ebf603a89sm17545183wmq.11.2024.01.30.10.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:53:38 -0800 (PST)
Message-ID: <aaeedb759fc5fe5ebd9704df58b0c89169dc1428.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix data re-injection from stale
 subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 30 Jan 2024 19:53:37 +0100
In-Reply-To: <762d499c-1f90-470e-8e3f-b26eafd519dc@kernel.org>
References: <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
	 <39a0fa5f-03e2-4ef3-90b7-decd8971905b@kernel.org>
	 <195dfb64e0e8ecfac60c8f29df9e61c1c7cfea17.camel@redhat.com>
	 <762d499c-1f90-470e-8e3f-b26eafd519dc@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-01-30 at 18:52 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> Thank you for your reply!
>=20
> On 30/01/2024 16:12, Paolo Abeni wrote:
> > On Tue, 2024-01-30 at 12:59 +0100, Matthieu Baerts wrote:
> > > Hi Paolo, Mat,
> > >=20
> > > On 23/01/2024 22:03, Paolo Abeni wrote:
> > > > When the MPTCP PM detects that a subflow is stale, all the packet
> > > > scheduler must re-inject all the mptcp-level unacked data. To avoid
> > > > acquiring unneeded locks, it first try to check if any unacked data
> > > > is present at all in the RTX queue, but such check is currently
> > > > broken, as it uses TCP-specific helper on an MPTCP socket.
> > > >=20
> > > > Funnily enough fuzzers and static checkers are happy, as the access=
ed
> > > > memory still belongs to the mptcp_sock struct, and even from a
> > > > functional perspective the recovery completed successfully, as
> > > > the short-cut test always failed.
> > > >=20
> > > > A recent unrelated TCP change - commit d5fed5addb2b ("tcp: reorgani=
ze
> > > > tcp_sock fast path variables") - exposed the issue, as the tcp fiel=
d
> > > > reorganization makes the mptcp code always skip the re-inection.
> > > >=20
> > > > Fix the issue dropping the bogus call: we are on a slow path, the e=
arly
> > > > optimization proved once again to be evil.
> > > >=20
> > > > Fixes: 1e1d9d6f119c ("mptcp: handle pending data on closed subflow"=
)
> > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/468
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > >=20
> > > Thank you for the patch and the review!
> > >=20
> > > Any ideas how to prevent such issues? Changing the signature of the
> > > TCP-specific functions? Adding a custom check for our CI on our side?
> >=20
> > I guess we could add debug-only code in mptcp_sk() and in tcp_sk()
> > checking that the argument pointer belongs to the relevant slab, see
> > kfree():
> >=20
> > https://elixir.bootlin.com/linux/v6.8-rc2/source/mm/slub.c#L4407
> >=20
> > we could fetch slab->slab_cache and check it vs
> > mptcp_v6_prot.slab/mptcp_prot.slab/tcp_prot.slab/tcpv6_prot.slab.
> >=20
> > The main downside is that such code is heavily mm-dependent and may
> > change/break when upstream progresses.
>=20
> Good idea!
>=20
> If you think it is too fragile, maybe we could add a new entry in
> "struct inet_connection_sock" (or "struct sock"?) -- e.g. is_msk --, set
> it in mptcp_init_sock(), and check it in mptcp_sk() and in tcp_sk().

Nice! that would be much more robust! Thinking again about it, we could
simply check:

sk->sk_prot =3D=3D mptcp_prot || sk->sk_prot =3D=3D mptcp_v6_prot

> We can do that only if KASAN kconfig is set (or another one?).

A possible option could be DEBUG_NET, but such option currently enables
almost no-overhead things. I think we can use it, if we opt for
checking sk_prot.

Cheers,

Paolo

