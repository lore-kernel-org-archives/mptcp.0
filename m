Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6933D7
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/r66hbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702657859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQoVlu2nC3An3NXDh3aukCzIW+oEg+vtzuLTT5pCuio=;
	b=g/r66hbOn54WBLvjzBeTJiMJygwIEbeNzQjFnOc3wzLJWLxRiwnzAR5YqRYedRapXrdv2/
	N0Jg0f7Y+D+CFWzE7UsP8bXnszfDILsoTATvQJ8TN5rV9wO4jaQTeQzVeQUhtIkTYDyYKI
	euJJUzcbBG0UaajJ7IOTtWVMinB/zM8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-xgjx5ebPNnO7BpuU2ckHgw-1; Fri, 15 Dec 2023 11:30:57 -0500
X-MC-Unique: xgjx5ebPNnO7BpuU2ckHgw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1df644f6a8so17421066b.1
        for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 08:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657856; x=1703262656;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l47iqiC+/jd6DzBvapq6KCKEODC/7oCia1TsB160jc0=;
        b=eXGVFE+e65bBQex7/+3DP0yB3IJyVdDCzSxNazvY10GXVE8Adi2Jq08fXAfzhV/ITx
         eRwCJsfrdBlXBAm9HceGxRNajJg7OubVqTfw8FROvR6piqpDdX82/2KZPPLhMXchtQgo
         3wJMyvbnaNzGxF6B0Oi0FFW+QsFdiGdaFLqnhjmMycDmVcExLLjVH9sMIJQi83C8Vl2m
         f3i+g3uM1HHy3mk1kU8gLLzSTtS5edMbHCnyy1gD1Lc894VSb2eWn5OCNASYnKm1R1ux
         JYa94LhwOwejj8Dm9TGuTiSv2kGcTXwTQfBdIg5rUSL+7Diyyh9w3xg2eM7nGodTr+Eu
         2KdA==
X-Gm-Message-State: AOJu0Yx97Wab/h6RsrlAHTdOgHx48LWsU1FSASDGvE4JW+Xz+0yuGCrl
	wbR1WEmskG+Fy2gQYwlKY+YW6SOjYiUVSI7QO7djavK49SAql0Np6vrh4Xwk6ir1no2pSRntLQY
	XeKMvirJu5hXyhX4=
X-Received: by 2002:a17:907:d109:b0:a1e:3c8f:bc9e with SMTP id uy9-20020a170907d10900b00a1e3c8fbc9emr12779648ejc.0.1702657856590;
        Fri, 15 Dec 2023 08:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdT92bIkAk90pZjr7y230oX5Xp/tUHdPgR3pufCBcwomYy2OmtSEWlVNWb8az3vNJ/mpQ4nQ==
X-Received: by 2002:a17:907:d109:b0:a1e:3c8f:bc9e with SMTP id uy9-20020a170907d10900b00a1e3c8fbc9emr12779635ejc.0.1702657856279;
        Fri, 15 Dec 2023 08:30:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-255-162.dyn.eolo.it. [146.241.255.162])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm10807345ejd.80.2023.12.15.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:30:55 -0800 (PST)
Message-ID: <79875f13de371fe527ff695b69a5f8a84aab2a59.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 2/3] mptcp: use mptcp_set_state
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang
 <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Date: Fri, 15 Dec 2023 17:30:54 +0100
In-Reply-To: <b62b361c-60f1-402e-8e93-2fd0ec826dd9@kernel.org>
References: <cover.1702446832.git.geliang.tang@linux.dev>
	 <d6ac6b189ca025dd510455c37daa17fa98db8259.1702446832.git.geliang.tang@linux.dev>
	 <b62b361c-60f1-402e-8e93-2fd0ec826dd9@kernel.org>
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

On Wed, 2023-12-13 at 12:25 +0100, Matthieu Baerts wrote:
> Hi Geliang, Paolo,
>=20
> On 13/12/2023 06:56, Geliang Tang wrote:
> > This patch replaces all the 'inet_sk_state_store()' calls under net/mpt=
cp
> > with the new helper mptcp_set_state().
> >=20
> > Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> > ---
> >  net/mptcp/pm_netlink.c |  3 +++
> >  net/mptcp/protocol.c   | 38 +++++++++++++++++++-------------------
> >  net/mptcp/subflow.c    |  2 +-
> >  3 files changed, 23 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index bf4d96f6f99a..b93683b5e618 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1048,6 +1048,9 @@ static int mptcp_pm_nl_create_listen_socket(struc=
t sock *sk,
> >  =09if (err)
> >  =09=09return err;
> > =20
> > +=09/* avoid replacing inet_sk_state_store with mptcp_set_state here, a=
s the
> > +=09 * old status is known to be TCP_CLOSE, hence will not affect the c=
ount.
> > +=09 */
> >  =09inet_sk_state_store(newsk, TCP_LISTEN);
>=20
> Why not calling mptcp_set_state() here as well? I agree that it will do
> nothing more than calling inet_sk_state_store(), but maybe better for
> the uniformity?

mptcp_set_state() needs to be called under the msk socket lock, while
we can avoid that for inet_sk_state_store() - with some care.

The above code is outside the msk socket lock scope. We can extend it,
but will make the patch more noisy - all other chunks are simple helper
replacements.

If we want this change, we can add a pre-req patch moving
inet_sk_state_store() under the socket lock.

Cheers,

Paolo

> Also, mptcp_set_state() function name is generic: it is not specific to
> change a counter (even if it is what it does *for the moment*). Using it
> here could even be useful for extensions done in BPF (a useful hook), may=
be?

Yes, that was the idea: with time we can consolidate in=20
mptcp_set_state() more actions. e.g. token destruction.


Cheers,

Paolo

