Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA4883E
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693913173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4hpBIxibOpKJbV3iCu1aGQpybJ09N97HH9dLW+Z858=;
	b=jOqTg6XpdWwAOj1a02ddwCROT52SGJnha+1g6PPfbZJ+vXNHy93dxd/xHfxgbpLiXzhsBs
	NZsl0KR0hskUU8h+D/INtrsGvMX9vkKUJb2KWzEQdpqvugT6Mf/fk8iBVSpR6TsLFb1S6F
	llqY7xrnANUNOpqG8R3Xwt8Rl5Hcf8Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619--o6VYZN6O8uS-5x4nwLzCg-1; Tue, 05 Sep 2023 07:26:12 -0400
X-MC-Unique: -o6VYZN6O8uS-5x4nwLzCg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bbafb70ecbso4090141fa.0
        for <mptcp@lists.linux.dev>; Tue, 05 Sep 2023 04:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693913170; x=1694517970;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4hpBIxibOpKJbV3iCu1aGQpybJ09N97HH9dLW+Z858=;
        b=TYoq+xxQ21mlYDhNOny6s4Fl1B4ki5+NzefRh7l/A8piZ79wsbWkCALlO/DZYRvRX0
         xqEw+GfsLFJb7D42uMciHIuC5M/C2/FagTtiyViF8CgukNu0Di5mZ0aKUUQfkS7hijxi
         T/QMUK5+CcFPOT8510H0S59uWkw/CQ/AwvrGfxINC5cVYQNA5RVeiPQY8Ab1GlRF1XY2
         ceV/XcFuWQLrn9ZCjVhIbhL9VicaWtQ87eelFK81g+aeiAUWVnhNc1GH87wmrryLBVtl
         SZCz0lIgxT+YnZZnnqrZfYmvdYMA1dBO74ywMygW1CkaCc/6RH+fchhndpNWWVnYCQsJ
         OSdQ==
X-Gm-Message-State: AOJu0YwTK2UFjA5Yp6uVs26a6y17/u7D7IdvzGRjT4e9Vt2efaz/3LDi
	R4k/KSaOYU8nSsGHzzzOsmBylH9mFNZNTv+zlIlKuzGMizAkkW4HwCDblK0OrDv42PM37HH8bRv
	L64oWIS2fi8C13UA=
X-Received: by 2002:a2e:b544:0:b0:2bc:ba79:c3ff with SMTP id a4-20020a2eb544000000b002bcba79c3ffmr7091442ljn.2.1693913170494;
        Tue, 05 Sep 2023 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpsTg+L4vQYTYFYze/eYVLuYuAigDmKjEtqbmcqVeC8l1jpqtoz6/ZSY26hUeyr36a4hjqIA==
X-Received: by 2002:a2e:b544:0:b0:2bc:ba79:c3ff with SMTP id a4-20020a2eb544000000b002bcba79c3ffmr7091428ljn.2.1693913170090;
        Tue, 05 Sep 2023 04:26:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b009937dbabbd5sm7438862ejb.220.2023.09.05.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:26:09 -0700 (PDT)
Message-ID: <5079a4afdb1373c4034e2c6fda21dfbe18be3458.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: convert netlink from small_ops
 to ops
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 05 Sep 2023 13:26:08 +0200
In-Reply-To: <ZPX1wsXgq7FkIcz7@dcaratti.users.ipa.redhat.com>
References: <cover.1693591676.git.dcaratti@redhat.com>
	 <9079cf99466869474845cf89b55de5dfa7e01326.1693591676.git.dcaratti@redhat.com>
	 <70d408aed5fe8f7a307aa024f3614d1daae6a6ad.camel@redhat.com>
	 <ZPX1wsXgq7FkIcz7@dcaratti.users.ipa.redhat.com>
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

On Mon, 2023-09-04 at 17:20 +0200, Davide Caratti wrote:
> hello Paolo, thanks for looking at this!
>=20
> On Mon, Sep 04, 2023 at 11:13:15AM +0200, Paolo Abeni wrote:
> > On Fri, 2023-09-01 at 20:10 +0200, Davide Caratti wrote:
> > > in the current MPTCP control plane, all operations use a netlink
> > > attribute of the same type "MPTCP_PM_ATTR". However, add/del/get/flus=
h
> > > operations only parse the first element in the message _ the one that
> > > describes MPTCP endpoints (that was named MPTCP_PM_ATTR_ADDR and
> > > mostly used in ADD_ADDR operations _ probably the similarity of "attr=
",
> > > "addr" and "add" might cause some confusion to human readers).
> > > Convert MPTCP from 'small_ops' to 'ops', thus allowing different attr=
ibutes
> > > for each single operation, hopefully makes all this clearer to human
> > > readers.
> >=20
> > Minor nit: I'm wondering if it would make sense factoring out only the
> > bits replacing MPTCP_PM_ATTR_ADDR with MPTCP_PM_ENDPOINT_ADDR, to make
> > it clearer what is happening here.
>=20
> I think the addition of MPTCP_PM_ENDPOINT_ADDR and its use in add/del/get=
/flush
> operation would have little/no sense with small_ops. It's there to avoid
> selecting an element in 'endpoint' using the same label we use to
> get the local address form 'attr'.
> =20
> > Likely not a big deal either ways.
>=20
> I'd like to keep one single patch that does the 'small_ops' ->
> 'ops' conversion (to avoid adding a hidden dependency to future patches
> that will fix this patch. You know, there are those fancy tools that sele=
ct
> follow-ups commits ;) ).

Fine by me.
=20
> >=20
> > What if we reorder the 'attributes' in 'operations/list' in patch 3/6
> > to respect the corresponding numeric order? would that lead to more
> > natural order here, too?
>=20
> in patch 3/6 they are actually respecting the numeric order: otherwise
> the uAPI would be broken (e.g. a userspace program would see a value
> change in one or more enum elements).
>=20
> I see that we have some spots like:
>=20
>  382       do: &sf_create
>  383         request:
>  384           attributes:
>  385             - addr_remote
>                      ^^^ this is out-of-order, but  the C code is generat=
ed correctly
>  386             - token
>                      ^^^ same here
>  387             - addr
>=20
>=20
> they can be fixed with in patch 3 v3, but that will have with no effect o=
n the
> generated C code.=C2=A0

If it has no effect on the generated code, then it's up to you
(possibly using the same order everywhere would made things clearer,
but it's a matter of personal preference).

> Did I get correctly the change request?

Yes :)

Thanks!

Paolo

