Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E110F5
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693814685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN2nGaKxT3oSM5I6BHJg1qwLuNE0Gw4wam0V48VzXP0=;
	b=Tj1FRnuEYeYwtLCAUZVVxl0dBVhF3UE7iXVsgoyTUo7Z/t0yWn622+HKh0rRIGS+5t2ul3
	382fUWfTSEAJXZT+ibcmJgK2K0qg70TpapkjUqDafRnbTvtR4FeuI5L6c9FocnAGNy3VKi
	cRtqHuNrW8eHPVEDKpkwYZwzIRZ8Sc4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-hhtrLXFWPbGsVBjifW3tfQ-1; Mon, 04 Sep 2023 04:04:44 -0400
X-MC-Unique: hhtrLXFWPbGsVBjifW3tfQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1be1e2b63so23036266b.0
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 01:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693814683; x=1694419483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZviStE1SoWyCcSJiRMj827J4CDKVEg2O8/BwCZgl7k=;
        b=kD84pBUvY9mTnXZT1mI20IoaR4p3+2O69HuuTSfnuaakhRNsx7paN2yXJ54moFttQW
         5vZK+0E3rWaxlFRDEIDAyTBiwi7g0U+YZSW7XOpMfp9RYPis01IOPugb/VD1c67MmcGp
         fBwEeMiv/Dwzap491rhOyDfp+39TlljKAL2M9moKTXfvMZ4ehkLNYY6RhWdF9C5tyzv/
         Z2KQihdv6BEtJr5O/z7oFvA7h0Nf3p9uhGQVyICaSGUhGESYEMtVsRWzW8M7D24IaEqD
         eqRf6a8GTsJOW60bGBl2ZPBTJhhgKO5JTLK/MiBjV6aA+dvUdBBah9FY1Vg6YhMkQi3K
         WnkA==
X-Gm-Message-State: AOJu0YzCnS42tHYwzuzC86fTClf/BVBZb83XPLvondMApFsYBne7qr7v
	SRLzRbbJtV25ePy/15s9XmcxZIkzwbXPjzDW/TLKMvrusvzdAJQtxu+lIGUWcrWD4SBXJVyAhCe
	MxJtzdSIib9Z7OxE=
X-Received: by 2002:a17:907:a501:b0:9a6:5340:c337 with SMTP id vr1-20020a170907a50100b009a65340c337mr1263486ejc.2.1693814683386;
        Mon, 04 Sep 2023 01:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDJHo1mBYdsO83cv4FF6fKPZYRdaQ926B19jgkY8rqrm8pUk92j5bERNwgc6TgMWII1WphZw==
X-Received: by 2002:a17:907:a501:b0:9a6:5340:c337 with SMTP id vr1-20020a170907a50100b009a65340c337mr1263474ejc.2.1693814682981;
        Mon, 04 Sep 2023 01:04:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090680c300b009a19fa8d2e9sm5708265ejx.206.2023.09.04.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:04:42 -0700 (PDT)
Message-ID: <a6d662415bcbf613da17abed1652a2ade87db692.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: implement connection level
 timeout.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 04 Sep 2023 10:04:41 +0200
In-Reply-To: <2ab5cd0e-4450-1dcc-5b02-5b3d1a4c6a81@kernel.org>
References: <cover.1693565414.git.pabeni@redhat.com>
	 <382adc94e31c46ade28566d5787dd9d531329c51.1693565414.git.pabeni@redhat.com>
	 <2ab5cd0e-4450-1dcc-5b02-5b3d1a4c6a81@kernel.org>
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

On Fri, 2023-09-01 at 17:23 -0700, Mat Martineau wrote:
> On Fri, 1 Sep 2023, Paolo Abeni wrote:
> > @@ -2635,7 +2640,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *ms=
k, unsigned long fail_tout)
> > =09struct sock *sk =3D (struct sock *)msk;
> > =09unsigned long timeout, close_timeout;
> >=20
> > -=09if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
> > +=09if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
> > =09=09return;
> >=20
> > =09close_timeout =3D inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiff=
ies32 + jiffies + TCP_TIMEWAIT_LEN;
>=20
> RFC 8684 brings up "break-before-make" scenarios in a few places, I think=
=20
> one use case is for VM migrations. 60 seconds seems sufficient but maybe=
=20
> not?
>=20
> There may also be scenarios with busy servers where the server-side admin=
=20
> may want to quickly close "zero subflow" MPTCP connections immediately (o=
r=20
> with a shorter timeout) if their workload does not involve=20
> break-before-make and it's more important to free up resources quickly.
>=20
> Given these examples, what do you think about making this timeout=20
> configurable via sysctl and/or sockopt?

Yes, the idea is to add an additional sysctl. I guess we could add even
a sockopt (MPTCP_USER_TIMEOUT) to cap the above.

I did not include that here, because I intended to keep this change
small, and the sysctl would add a bit more diffstat noise.

Cheers,

Paolo

