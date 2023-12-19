Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A919472
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAU69jLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702972634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+51hlHrS6PlugOsw6MizI3HpgLu3MOETMtDMDjNWqg=;
	b=dAU69jLo1TqTeLxk+9NpvHI0s+iCJA9emi0IO25868MgaaIIlDyMq3YMn0/vBPehGO//1m
	OZBZWOeS/LL6HaPQbdVdfTsHLMuyhlkwpFfAfc3VUiCkxdxDA5TNeHrlxHit92+VoQC/ab
	shuvMK2caOJyvN142PAGttL/0VnhbIU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-Mw_JkBQYNuaSjFCX0brRAQ-1; Tue, 19 Dec 2023 02:57:11 -0500
X-MC-Unique: Mw_JkBQYNuaSjFCX0brRAQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a24901893abso4036266b.1
        for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 23:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972630; x=1703577430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfVtnj2ytN1NKNU+fhFBlxtrFpFRnukaRytsiUmXQI0=;
        b=Ikhf9IlSeV0pgL0MdXkGArnTFFdkUsf5WS/AnpF8yQzT7B0PrLoJ3x1zaLEAqph+8/
         imMK+wCgOUFNtkokZqmnD7jxwEMcD/ageClWbTNLeH32vdCWP3GJDG1Jj2TGpY8QDXsZ
         +HyktLCiv4Suz653pRlRomidurQNmZOHu2uI52DfIiNYvRvlUgdNwy49jQeZ3gdMt5Xu
         FxoYua7/h444mGwM+PygXTYEfvGnaFGmUC9E+XT2fVxZpaK6vh/Y27de608CxoFIowih
         cppWhxWxJb9PFS5hlWp6qDvKq/h3cbH2VrWmKnYh2ZXvIPPnf6ReK/crDcZXi6WrIfhd
         J+uQ==
X-Gm-Message-State: AOJu0YzvSokQhlM+BgquSneNFJL4fokPQRV2vYYrYZHi+SgmXps3GElI
	wJqxhr5jIj//QyjDGJOPzXRN7hiK5ay+5CpDIRa8IBbb1JIhsIegax9i785ButxwyqpvYndypZd
	kohT9q0MIXjSwg20=
X-Received: by 2002:a17:907:96a5:b0:a23:4939:17df with SMTP id hd37-20020a17090796a500b00a23493917dfmr4350114ejc.1.1702972630169;
        Mon, 18 Dec 2023 23:57:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHypNa7ol+BX4bo4SoD/Owu7JUeU2TAnIJBF7JYAqc907TCyKqIkhebRckjRjvhejPtZNWbKQ==
X-Received: by 2002:a17:907:96a5:b0:a23:4939:17df with SMTP id hd37-20020a17090796a500b00a23493917dfmr4350103ejc.1.1702972629639;
        Mon, 18 Dec 2023 23:57:09 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id vv8-20020a170907a68800b00a1d2b0d4500sm15001209ejc.168.2023.12.18.23.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 23:57:09 -0800 (PST)
Message-ID: <ce5132c6a8e90c44835e0ed05ffe4e093dcd703a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/5] mptcp: move inet_sk_state_store under
 lock
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Date: Tue, 19 Dec 2023 08:57:08 +0100
In-Reply-To: <2a3ded63-0abe-4f9e-a4d2-8d9342b25467@kernel.org>
References: <cover.1702889134.git.geliang.tang@linux.dev>
	 <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
	 <4c1e2e407e2b6721b4ca0aad73746c8ea13f2753.camel@redhat.com>
	 <2a3ded63-0abe-4f9e-a4d2-8d9342b25467@kernel.org>
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

On Mon, 2023-12-18 at 18:29 +0100, Matthieu Baerts wrote:
> On 18/12/2023 17:54, Paolo Abeni wrote:
> > On Mon, 2023-12-18 at 16:47 +0800, Geliang Tang wrote:
> > > @@ -1045,10 +1046,14 @@ static int mptcp_pm_nl_create_listen_socket(s=
truct sock *sk,
> > >  =09else if (ssk->sk_family =3D=3D AF_INET6)
> > >  =09=09err =3D inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
> > >  #endif
> > > -=09if (err)
> > > +=09if (err) {
> > > +=09=09release_sock(newsk);
> > >  =09=09return err;
> > > +=09}
> > > =20
> > >  =09inet_sk_state_store(newsk, TCP_LISTEN);
> >=20
> > If you move 'inet_sk_state_store(newsk, TCP_LISTEN);' just before the
> > '__mptcp_nmpc_sk()' call, the overall patch should be significantly
> > smaller.
>=20
> Thank you for having looked!
>=20
> That's what I had in mind, but I was not sure if there would be an issue
> in case of error (and I didn't check), etc.
>=20
> But if there is no issue, best to move it there indeed!

If __mptcp_nmpc_sk() errors out - or any other check in
mptcp_pm_nl_create_listen_socket() - the newsk will be released just
after by __mptcp_pm_release_addr_entry() so there should be any issues.

Cheers,

Paolo

