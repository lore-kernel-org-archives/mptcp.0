Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD351BBD
	for <mptcp@lists.linux.dev>; Fri, 29 Sep 2023 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696002637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U41AKmaDzcscVgBZ7BbY91lK21ycnfYJ9YlyttI+oEU=;
	b=XrrCstheUZZTZdGobQPPbFURwmy03tj8rdpHuzamGXIr280SD1jaO6BxExSusXCUOuyUHZ
	JtNnl4PJ9OsOdzYwqQc4xRj3OFtSpMqZjMQNRK5kwJZJqsvYG8/ZGIE0gWckYUqNVv44vt
	MEk5btZYZGqp92qqTgVpr7m4f/V4B9c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-MQcy0JB7OhuLGFcSeTJPHQ-1; Fri, 29 Sep 2023 11:50:36 -0400
X-MC-Unique: MQcy0JB7OhuLGFcSeTJPHQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7756d0fb11dso190463985a.0
        for <mptcp@lists.linux.dev>; Fri, 29 Sep 2023 08:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696002635; x=1696607435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16CYwMhm4iaLqfZNig70t7NLTDZpBbnBuhLenudEmvE=;
        b=H1qpiDV+9ayRYhOfUZeDiLQm4lRz/Tsubio9B1Px5HteYLKPA36kVxFaHcy/czOQXG
         fX3QLjl35OGqVYVWQOqyMtJYZNmsuEFbDSn3tWMuFH3tyZ5x2HfA9svB/eoUXQCMcrjt
         CkP7lnBylsSgsFoVD3xA5XJkYNnvsuqxE/y00Hl9NPSi2YwJePy42a5DfQZRx3v7P0ea
         xHqkqAT5IC/Eb0dqnc9jQVrWXmACN6riYk3TBN7UystcNrvpsdioDWXPBy4h41aN6UR7
         bEbWrHFBLedRh3k+pnGEFhdCX/5qa3SKqKAyxlTrR3J3Y/9/vIS3XMykTd0PVbSjRNEQ
         FEpQ==
X-Gm-Message-State: AOJu0YxBWG/WR4cHt7XR19diIPnhbnWJF6oDoO2zN1y+Z+F1giGcZdEw
	9DBbR0UwAkY5/7ue6Jdonzk7y+YA6/+ghn93RUdP1O9Wm6K1dCXzf9pKt7BWffVAuWpDXJftxCj
	/sTBtI7oBdszpkHY=
X-Received: by 2002:a05:620a:1a94:b0:76e:f686:cad5 with SMTP id bl20-20020a05620a1a9400b0076ef686cad5mr4993603qkb.5.1696002635650;
        Fri, 29 Sep 2023 08:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDjIgsKQ9v/l66OSv8+DvDxQLJFtNuGzKJ8utS+ZBFs4NmaF3NMf4AUxJDDZX4pGlNCpasyQ==
X-Received: by 2002:a05:620a:1a94:b0:76e:f686:cad5 with SMTP id bl20-20020a05620a1a9400b0076ef686cad5mr4993589qkb.5.1696002635316;
        Fri, 29 Sep 2023 08:50:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id pe3-20020a05620a850300b007726002d69esm7048077qkn.10.2023.09.29.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:50:35 -0700 (PDT)
Message-ID: <752bb2b1819795ac95868fc7791c2612efdb7386.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: give rcvlowat some love"
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Fri, 29 Sep 2023 17:50:32 +0200
In-Reply-To: <215e55a9-74df-4df1-867c-c942cea85283@tessares.net>
References: <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
	 <215e55a9-74df-4df1-867c-c942cea85283@tessares.net>
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

On Thu, 2023-09-28 at 19:11 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 28/09/2023 17:52, Paolo Abeni wrote:
> > Christoph reported a couple of serious splat caused by
> > the mentioned patch.
> >=20
> > mptcp_set_rcvlowat() can use msk->scaling_ratio, before
> > such field is initialized, causing a divide by zero: we
> > need to init it in the sock constructor.
> >=20
> > Additionally the same function bogusly cast an msk to a
> > tcp_sock, causing memory corruption. The reproducer likely
> > clears the sk refcount for the next msk allocated into the
> > same slab.
> >=20
> > The intent was to properly propagate the rcvbuf changes to
> > the subflows. Let's do that explicitly.
>=20
> Thank you for fixing all that!
>=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > --
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/442
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/443
> >=20
> > since the above issues are introduced by the squash-to patch, I think
> > we can't have the tag in the final patch.
> > ---
> >  net/mptcp/protocol.c |  2 ++
> >  net/mptcp/sockopt.c  | 17 ++++++++++++++---
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6f9e116598ed..3ef6368e26f6 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2758,6 +2758,8 @@ static void __mptcp_init_sock(struct sock *sk)
> >  =09msk->rmem_fwd_alloc =3D 0;
> >  =09WRITE_ONCE(msk->rmem_released, 0);
> >  =09msk->timer_ival =3D TCP_RTO_MIN;
> > +=09msk->scaling_ratio =3D (1200 << TCP_RMEM_TO_WIN_SCALE) /
> > +=09=09=09     SKB_TRUESIZE(4096);
>=20
> I see that the code in TCP is quite recent: dfa2f0483360 ("tcp: get rid
> of sysctl_tcp_adv_win_scale").
>=20
> Do we want to add a new function in include/net/tcp.h which returns:
>=20
>   (1200 << TCP_RMEM_TO_WIN_SCALE) / SKB_TRUESIZE(4096);
>=20
> and use it here and in tcp_scaling_ratio_init()?

Perhaps just a define?=20

#define TCP_INITIAL_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / SKB_TR=
UESIZE(4096))

Note: we want to avoid any argument, to avoid 'different sock' struct
issues.

/P

