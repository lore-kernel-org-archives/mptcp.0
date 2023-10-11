Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651933C0
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnG2emeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697037368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsFiTgb9xEObu6I2p/3t0rW2hKIFFXyZLNKG7hDZ3zE=;
	b=AnG2emeMdW9lFRUlrJEarhbGw0dige7bYRotl6BHsD9XuPoM6ngTzO+kLloHAxITn2XuhC
	tOnVn5NGiXJu0n/jMKILv3G9cFg4BvaspIxdI8RMOcfYpRoU2X6gh/wWAOQZlDvk6ZxA61
	EkfkMywacxc/G3OlUbE+vANY029IeE0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-DZxuitjVPu6PF4Aw3prmWw-1; Wed, 11 Oct 2023 11:16:07 -0400
X-MC-Unique: DZxuitjVPu6PF4Aw3prmWw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7756d0fb11dso187434685a.0
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 08:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037366; x=1697642166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ko6MAKOlD1ZOoCBZAVUoWhnJlyntsUea4hYiDdjlVws=;
        b=CIlFhvbavPs3lvJiMJSczyTA/oU22ykCZOUr1YdyTckeA+4ggTmNKE4ylv+IbFK5/x
         BejvxO74PXp4uM3/LZYt3X65rBJYhMvlBkX+CQNrid7Ygg0mswkYFQHZEaDieuVodbq2
         StQoirKNBsHFulD1m62OaYIfBRig6alfJwiP+QAhVnTEyPhQq+3pckC+Rk7cJaBnBvC9
         12Uh/cVfXMrZ7i+WVlN/90BWI+lVQLLq6fvlZ93HXTlhpo6gnT9cHFBgdS0jHMRxAqEn
         RhdCa61Myxg8U7DZLd9rKiRtSaf9cblGN9moEW50jYqb8oVtalnKVcA02lFlresoXyx0
         jLDg==
X-Gm-Message-State: AOJu0YxzcK/fla9xY+WZXHZw/d+R2mMpdY8wa4xBMbU9jfZq0PlxvVau
	IJWgEnQUOYkAb9um0kQWSDQh77MZY8O2YGHiSKpggP10zjdFWaaE4W6fyX0bMvpjn+h6I9dWLK6
	doTaSPibnOhEQlG19s5cHhB8=
X-Received: by 2002:a05:620a:198d:b0:76f:27af:2797 with SMTP id bm13-20020a05620a198d00b0076f27af2797mr24105521qkb.0.1697037366730;
        Wed, 11 Oct 2023 08:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw6Pp1q67SlwXaBKqpzMBhFABkzm3vjwqY4OIc2yT8v2ILnbG/PhKFH33WKRNTLj3jRgK/qw==
X-Received: by 2002:a05:620a:198d:b0:76f:27af:2797 with SMTP id bm13-20020a05620a198d00b0076f27af2797mr24105510qkb.0.1697037366468;
        Wed, 11 Oct 2023 08:16:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-163.dyn.eolo.it. [146.241.235.163])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a10b700b007758ffab58asm5291724qkk.8.2023.10.11.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:16:06 -0700 (PDT)
Message-ID: <f63e04fefb3e6c1ee487e12db65866d4b43bea96.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] tcp: check mptcp-level constraints for
 backlog calescing
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 11 Oct 2023 17:16:03 +0200
In-Reply-To: <e830af72-4c3a-fa52-4eb0-b35e48bf9d1c@kernel.org>
References: <b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com>
	 <e830af72-4c3a-fa52-4eb0-b35e48bf9d1c@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
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

On Tue, 2023-10-10 at 18:00 -0700, Mat Martineau wrote:
> On Wed, 4 Oct 2023, Paolo Abeni wrote:
>=20
> > The MPTCP protocol can acquire the subflow-level socket lock, and
> > cause the tcp backlog usage. When inserting new skb into the
> > backlog, the stack will try to coalesce them.
> >=20
> > Currently we have no check in place to ensure that such coalescing
> > will respect the MPTCP-level DSS, and that may cause data stream
> > corruption as reported by Christoph.
> >=20
> > Address the issue adding the relevant admission check for coalescing
> > in tcp_add_backlog().
> >=20
> > Note the issue is not easy to reproduce, as the MPTCP protocol tries
> > hard to avoid acquiring the subflow-level socket lock.
> >=20
> > Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/ipv4/tcp_ipv4.c | 1 +
> > 1 file changed, 1 insertion(+)
> >=20
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index f13eb7e23d03..52b6a0b22086 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1869,6 +1869,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_b=
uff *skb,
> > #ifdef CONFIG_TLS_DEVICE
> > =09    tail->decrypted !=3D skb->decrypted ||
> > #endif
> > +=09    mptcp_skb_can_collapsen(tail, skb) ||
>=20
> Hi Paolo -
>=20
> Shouldn't this be !mptcp_skb_can_collapse()?
>=20
> Also, the subject line needs the 'o' in "coalescing".

Indeed! thanks for checking!

I'll send a v2!

Cheers,

Paolo

