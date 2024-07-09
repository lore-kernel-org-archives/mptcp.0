Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1F180041
	for <mptcp@lists.linux.dev>; Tue,  9 Jul 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543664; cv=none; b=rnUJKuKFdapTnJAVIsNIln+JiNvt1tN5IIROtruBsYbcxME9dENeBUTiemxBDZOmAy06XT0az23Wm3EULjqV0qiE7h7SIdzn/1yRUMlCBnBKkszOmIXR/PNPQP5HeBL8t8GI1OBD5xrCs46DvaPQ5gw4f2uCv7L0fTyBYjC7NUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543664; c=relaxed/simple;
	bh=PZTnsz3k7CawxbYaHNOfIuo12+SEiU60zS7awFDTuRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3yx9x1KVSoI9MpEXaKxs4YIoCzdeoNeijNO0u/B3bJpzg1ATKR0LYLfzMhc2a9ZCH7rp1wTyessUse9CtrVjOjiS65XK3XMJGNlL2qxd+BNljthEC5ZAUL0CTmoqhJgJWK7rIGtxzn5rTa5rDK/bOPTcNn+XSMV+tzXz34NqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij7lzHnA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij7lzHnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720543661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GAYYJJLJZTTJ7vIliPThcLcQwV0NzOhJYjl5YKSScBQ=;
	b=Ij7lzHnAFwwlxkfs5UM6AOkN0CEX15xg+skl7UvdCE8zP7pkWCQL4nkCOqMuIT0z8A7Z5g
	lNYbuMLjz5qynjxdrZZA7C3zmO06sO7gANvtchobNXbDVnjmDyaJJE4xhAhf/USXjTuaT2
	Z6DTwzNWF/x7V+hDbMm7djjUa89J4pY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-rrSqNrUsMjOArY30LAUu9w-1; Tue, 09 Jul 2024 12:47:40 -0400
X-MC-Unique: rrSqNrUsMjOArY30LAUu9w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52e9b906ce9so863977e87.3
        for <mptcp@lists.linux.dev>; Tue, 09 Jul 2024 09:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543658; x=1721148458;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5t5/YdYCAhCozjsBi8DHHKY52+4IvF+mjHKroeU5Qw=;
        b=Fkq+WE2mlOTLPlKdmKmcYm2CAfhdlSg+RF9Uqfk0et7TgWkY/PGMkNETL9KBIPbbxF
         2oAKO95qhtpNxtukiGfose4EAX3SDwQlZ9QfNVB6wwpahOtC8cR7UtmOzUvOByCPumol
         QfnTWW4HjZwuoEf3a70kH//lW5LBKie/ZDE9sI8uW6ptpo73J4536pEqNxeT35OW3Pc+
         /n5UAC6RuKGdOhuUPH0rXpHDNYwWyKtveTWypb2PWoF/AftjWM7YRQsYCFRpC63wwVKI
         sKZbHSV1SXOopQL30xh9BgPDJszt+qMVZH9dcF/UFoBkVYiuXthZ+afo8YnjPpqB6Ji0
         tqtw==
X-Gm-Message-State: AOJu0Yz5PAS0jpdbImK0MF0Kc9I/9yzxZYQ3mVxqWlmyYf+uQzY//CQa
	shElCudncIPZ8bmx218AMikt/2yEDYtk7/LT/r12zzedSQHKDEcPdfPDC2zETCQIKzMxR5gwkwD
	MkAlqe0EWCIwfxTSoA8kc6xqNFU64DvjkrQKTLvuAyBB0GtQ+c0dyWNW3UzLp1to=
X-Received: by 2002:a05:651c:198b:b0:2ee:8ccc:f113 with SMTP id 38308e7fff4ca-2eeb30b86a9mr21023011fa.1.1720543658273;
        Tue, 09 Jul 2024 09:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnOAunEMqVXzwgYW3V66XXLF5khXtURuMeyQW1l00wVHlB6ZGcDXwOeku75e32mB0s6xMCVg==
X-Received: by 2002:a05:651c:198b:b0:2ee:8ccc:f113 with SMTP id 38308e7fff4ca-2eeb30b86a9mr21022871fa.1.1720543657771;
        Tue, 09 Jul 2024 09:47:37 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427265d6ebasm21693885e9.41.2024.07.09.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:47:37 -0700 (PDT)
Message-ID: <17523f5898468a0b63e57ffa3aef5ec97caf643f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Tue, 09 Jul 2024 18:47:36 +0200
In-Reply-To: <57efbe56-3ef8-4e3b-b425-8405aa3374bd@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
	 <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
	 <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
	 <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
	 <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>
	 <257091ee7be591bcb9aafa0ab4caa4dbca11e4e1.camel@redhat.com>
	 <57efbe56-3ef8-4e3b-b425-8405aa3374bd@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
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

On Fri, 2024-07-05 at 17:29 +0200, Matthieu Baerts wrote:
> On 05/07/2024 10:20, Paolo Abeni wrote:
> > @@ -568,14 +568,27 @@ static void mptcp_pm_create_subflow_or_signal_add=
r(struct mptcp_sock *msk)
> >  =09=09if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
> >  =09=09=09return;
> > =20
> > -=09=09if (local) {
> > -=09=09=09if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
> > -=09=09=09=09__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> > -=09=09=09=09msk->pm.add_addr_signaled++;
> > -=09=09=09=09mptcp_pm_announce_addr(msk, &local->addr, false);
> > -=09=09=09=09mptcp_pm_nl_addr_send_ack(msk);
> > -=09=09=09}
> > -=09=09}
> > +=09=09if (!local)
> > +=09=09=09continue;
> > +
> > +=09=09/* If the allocation fails we are on memory pressure, it looks
> > +=09=09 * not worthy try any forther later action, that will likely fai=
l
> > +=09=09 * And if local has both the SIGNAL and SUBFLOW flags, and the
> > +=09=09 * by bad luck the later subflow creation is successfully, the
> > +=09=09 * msk will end-up not signaling this address; not even
> > +=09=09 * re-attempting to do it.
>=20
> If the subflow creation is successful, the new address will be somehow
> advertised to the other peer. Should we not try to create the subflow
> anyway? That would reduce the diff as well.

The announce list requires a very small amount of memory from a single
slab. A subflow creation will require a tcp socket, an mptcp context,
and likely some lsm context, I think is very unlikely all of them will
be successfully.

The diff reduction will be just mostly for the trimmed comment, am I
correct? If so I think we can keep the code this way. Note that
most/all of comment above could be moved into the commit message
itself.

> > +=09=09 * Likely worthy incrementing a new MIB here
>=20
> I think there are many other places where we don't have such MIB
> counters for not being able to allocate memory. Do you think we would
> need one here?

Thinking again about it, we don't need them. The warn in dmsg should be
enough ;)

Thanks!

Paolo

