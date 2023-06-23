Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C498BF5
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687527577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS438dyHBGjcjQqM6inIHzB/J8xl5NAgPzkDBubt/FM=;
	b=XpMctpWeAvD6DxUIK7DTbNbN5pVeU1/BQbjCE/2pw/Q3oBB0CFFlaip33609jRm5dG5WBF
	b17Jn3SIplEZGjskyu/q7QReq+MwLsEyEqgN5/+G01HkxyI24Scs1RfEMim/wM0TNBbzQP
	B6FE1/cHCWIwlQBm+fqe2UvFHPt8nnA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-XoOM7EtxPWO5mPE8oe-LSQ-1; Fri, 23 Jun 2023 09:39:34 -0400
X-MC-Unique: XoOM7EtxPWO5mPE8oe-LSQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62ffa1214edso1310786d6.0
        for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 06:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687527573; x=1690119573;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZBLVxef+6t+n22doh9RFvnn/zWriUJ4vRAVN13QP4I=;
        b=L1C8vgOjJHWPaS4F0Rex9a/E8D2lqGtluiuV5/yz1oDYm3TahuK6qzZLEka/CV94b1
         Vp3i3REYkv4FLVZEUu/5wpVSA/hVOLudYcERXg8mcgsRXKoTpFT0n85/aqx8/vIblKgK
         3G/ZU6FHBMhBIlX47ZPgGaf/q2G8+xEXS1nkZV+ueM/FBbqwBUKdrmb9oUKtHp/UsCwh
         RjP21Kcx6iL07Hfba6PkWmBtqZJos1Mcjm6N2PHS1MNcMoRqGdmOBTTg4QDqcc6knID2
         SFVBKtzvTWTTu+66TyiYsiC7gxJuXq8sZiAyH6Rx8m06Q1Va1m9hsHaL/ojeyoWBYd9W
         HUAA==
X-Gm-Message-State: AC+VfDwm1d8WLtbcCwjDUmDHoVAVYyitlV1h9Q58SDM5BnTtGvJJhz8d
	5DfCvyCzDHOHaYnnMXc8WP7rRqFkSduNQfxMIey8ikFCglTZtECMDvKa8BhWD9FiVZUAPOSQJdr
	ZfBt+3IC//rZhqMP932onctg=
X-Received: by 2002:a05:6214:411c:b0:62d:f5b8:7e22 with SMTP id kc28-20020a056214411c00b0062df5b87e22mr25107531qvb.4.1687527573407;
        Fri, 23 Jun 2023 06:39:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46W9zZ/B0M5/aRC7yQioOeocksFmhjlBdxyeAIEYK6ZHlmul7OwPPFNVtg6JFHpcqcnkiTLA==
X-Received: by 2002:a05:6214:411c:b0:62d:f5b8:7e22 with SMTP id kc28-20020a056214411c00b0062df5b87e22mr25107517qvb.4.1687527573147;
        Fri, 23 Jun 2023 06:39:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id v1-20020a0c9c01000000b006301ec0d178sm5089034qve.5.2023.06.23.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:39:32 -0700 (PDT)
Message-ID: <d78212345cf4be185f4ef4bbf61ee92b703936fb.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure listener is unhashed before
 updating the sk status
From: Paolo Abeni <pabeni@redhat.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 23 Jun 2023 15:39:30 +0200
In-Reply-To: <2722281C-B4A6-4CA7-935E-CD6E77112B74@apple.com>
References: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
	 <a99660b20eb4499bb259371f959e307cdda6d2aa.camel@redhat.com>
	 <2722281C-B4A6-4CA7-935E-CD6E77112B74@apple.com>
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

Hi there,

On Thu, 2023-06-22 at 13:27 -0700, Christoph Paasch wrote:
> > On Jun 21, 2023, at 12:23=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com>
> > wrote:
> >=20
> > On Wed, 2023-06-14 at 16:54 +0200, Paolo Abeni wrote:
> > > The MPTCP protocol access the listener subflow in a lockless
> > > manner in a couple of places (poll, diag). That works only if
> > > the msk itself leaves the listener status only after that the
> > > subflow itself has been closed/disconnected. Otherwise we risk
> > > deadlock in diag, as reported by Christoph.
> > >=20
> > > Address the issue ensuring that the first subflow (the listener
> > > one) is always disconnected before updating the msk socket
> > > status.
> > >=20
> > > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > > Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > should close issues/407 for good
> > > ---
> > > net/mptcp/pm_netlink.c =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0| =C2=A01 +
> > > net/mptcp/protocol.c =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 31 ++++++++++++--
> > > -----
> > > .../testing/selftests/net/mptcp/mptcp_join.sh | =C2=A03 ++
> > > 3 files changed, 23 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index ba1406e601e4..333c7e2a7f78 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -1043,6 +1043,7 @@ static int
> > > mptcp_pm_nl_create_listen_socket(struct sock *sk,
> > > =09if (err)
> > > =09=09return err;
> > >=20
> > > +=09inet_sk_state_store(newsk, TCP_LISTEN);
> > > =09err =3D kernel_listen(ssock, backlog);
> > > =09if (err)
> > > =09=09return err;
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index feaedfd2b3eb..015745108d8b 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -2395,13 +2395,6 @@ static void __mptcp_close_ssk(struct sock
> > > *sk, struct sock *ssk,
> > > =09=09kfree_rcu(subflow, rcu);
> > > =09} else {
> > > =09=09/* otherwise tcp will dispose of the ssk and
> > > subflow ctx */
> > > -=09=09if (ssk->sk_state =3D=3D TCP_LISTEN) {
> > > -=09=09=09tcp_set_state(ssk, TCP_CLOSE);
> > > -=09=09=09mptcp_subflow_queue_clean(sk, ssk);
> > > -=09=09=09inet_csk_listen_stop(ssk);
> > > -=09=09=09mptcp_event_pm_listener(ssk,
> > > MPTCP_EVENT_LISTENER_CLOSED);
> > > -=09=09}
> > > -
> > > =09=09__tcp_close(ssk, 0);
> > >=20
> > > =09=09/* close acquired an extra ref */
> > > @@ -2952,10 +2945,24 @@ static __poll_t
> > > mptcp_check_readable(struct mptcp_sock *msk)
> > > =09return EPOLLIN | EPOLLRDNORM;
> > > }
> > >=20
> > > -static void mptcp_listen_inuse_dec(struct sock *sk)
> > > +static void (struct sock *sk)
> > > {
> > > -=09if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> > > -=09=09sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -
> > > 1);
> > > +=09struct sock *ssk;
> > > +
> > > +=09if (inet_sk_state_load(sk) !=3D TCP_LISTEN)
> > > +=09=09return;
> > > +
> > > +=09sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > > +=09ssk =3D mptcp_sk(sk)->first;
> > > +=09if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) !=3D
> > > TCP_LISTEN))
> > > +=09=09return;
> > > +
> > > +=09lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> > > +=09mptcp_subflow_queue_clean(sk, ssk);
> > > +=09
> > > +=09mptcp_event_pm_listener(ssk,
> > > MPTCP_EVENT_LISTENER_CLOSED);
> > > +=09tcp_set_state(ssk, TCP_CLOSE);
> >=20
> > Ooops, too late I saw the above is wrong, should be:
> >=20
> > =09lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> >=20
> > =09tcp_set_state(ssk, TCP_CLOSE);
> > =09mptcp_subflow_queue_clean(sk, ssk);
> > =09inet_csk_listen_stop(ssk);
> > =09mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
> > =09
> > tcp_set_state() also unhash the TCP socket, and that action should
> > be
> > taken first.
> >=20
> > I hope I'll be able to send a follow-up by the end of the week.
>=20
> I just got a WARNING on inet_csk_listen_stop. I assume that=E2=80=99s it =
?

I guess it depends ;)

If the warning was here:

https://elixir.bootlin.com/linux/v6.4-rc7/source/net/ipv4/inet_connection_s=
ock.c#L1388

that could be unrelated.

If it was here:

WARN_ON_ONCE(sk->sk_ack_backlog);

it _should_ be due the above.

> I=E2=80=99m gonna run syzkaller
> with=C2=A0https://github.com/multipath-tcp/mptcp_net-next/commit/2e780fac=
e
> ab0553f7eaa3be86f93f00584c724b2
>=20
> Looks good?

LGTM! thanks!

I'll submit that formally somewhat soon. Regardless of the above warn
it looks a needed one.

Cheers,

Paolo

