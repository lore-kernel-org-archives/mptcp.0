Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF686FD0
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680789407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiFMY7/6AyXcjsnETnchADWsRNrmhJpKorp3C12MeIQ=;
	b=c6jpwrd6lPDmVUH4vyl4DOFx8WebUtedwUUDVDXNC0GIWWT0OaOZr0vPmtlaiAe+i2DN8C
	Z6ESMzbzHWI13QFBbNhlnk1uUJHqjJRiHsxlyjtyaiPxD85P8dd7ZA5JLf4Awe5aTuptMw
	iHFByW4Uv4gicmuDHuaiXL0KWOsyAS4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-jwCWAXqFOw6NRePCaMENXg-1; Thu, 06 Apr 2023 09:56:43 -0400
X-MC-Unique: jwCWAXqFOw6NRePCaMENXg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5bb2d463855so3125926d6.1
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 06:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aT/vWNWvz/vcevpw9RYTaT+HFg7UZf1+yzMhkise8SM=;
        b=U9fswYJYflF+cK1soaOgGy2BMJr57SS8j+0jnJwjfFhM2PFTV2lMYoRN4LkwU0oz9r
         ZNx6iq+UuelPexzYPooHUHiLkiY3q2LtmFXbYH5fS4jD6aIv6BTFb/jdGrT5xUPGlqZs
         4skebspk68RoCN0ymN6b0h1vm0qbbhQt2Q0P1iDk8+VF7k9r5HYIdr9wzOiJA5ceQ3KD
         tZUbujXnwiZAEXwahcyuxlkWegIRT8TK3tZE6GqMvnUaHJJGeEVxhuPsf7aPKfU3Vy8M
         dWsY/rbspiZylM4OgkR2Jd0Wc+6u+8SIMNPcYkVDwn2KgUClAytJKasmrtWOweuIW1zt
         2JtQ==
X-Gm-Message-State: AAQBX9cTgG37IbaVz5z8K7I/0wG4PdK1MOJpKGQophwtLqTpjUktoI+Q
	UNBCaceaxjzpCYUu8d3IdCJpU6VD71J00I4OuP0JknVJjCGaER8ELjwn0Z9Gp1RV9hnFsWxPEvI
	hxn8rR05WCTCwc5o=
X-Received: by 2002:a05:6214:301b:b0:532:141d:3750 with SMTP id ke27-20020a056214301b00b00532141d3750mr9232599qvb.2.1680789402957;
        Thu, 06 Apr 2023 06:56:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350bLqZVridk8WQ6sEWiQV/XPY2PPRWKIzFTarj3wXSdfUjbBQArnJ+lgVT2MXORNi9qSL7rixg==
X-Received: by 2002:a05:6214:301b:b0:532:141d:3750 with SMTP id ke27-20020a056214301b00b00532141d3750mr9232572qvb.2.1680789402614;
        Thu, 06 Apr 2023 06:56:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id oo7-20020a056214450700b005e744765f5csm119311qvb.34.2023.04.06.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:56:42 -0700 (PDT)
Message-ID: <fdb18f114463095b71ba30349a4105e604d12afe.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] Squash-to: "mptcp: fix accept vs worker
 race"
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Thu, 06 Apr 2023 15:56:39 +0200
In-Reply-To: <48cbe7f3-8569-beec-b207-a111e6ff4922@tessares.net>
References: <cover.1680733942.git.pabeni@redhat.com>
	 <a515310923cd2ac4610ce62aa48b21d6d36a19eb.1680733942.git.pabeni@redhat.com>
	 <48cbe7f3-8569-beec-b207-a111e6ff4922@tessares.net>
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

On Thu, 2023-04-06 at 11:19 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> Thank you for the patch!
>=20
> It looks good to me but I just have some questions if you don't mind,
> just to be sure I understood the modifications.
>=20
> On 06/04/2023 00:47, Paolo Abeni wrote:
> > 2 separate fixes needed for the mentioned patch
> >=20
> > On some exceptional scenarios (e.g. listener socket disconnecting while
> > the subflow is created) a newly created MPC is deleted by the TCP stack
> > via inet_child_forget(). When that happen we leak the subflow context
> > and the msk.
> >=20
> > Address the issue explicitly detecting such scenario and forcing a full
> > msk shutdown.
> >=20
> > mptcp_subflow_drop_ctx() does not remove the subflow from the msk list,
> > racing msk lookup done by the NL PM could fetch the msk just before
> > deletion, and try to free again the subflow.
> >=20
> > Just explicitly remove the subflow from said list.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/protocol.c | 13 +++++++++++--
> >  net/mptcp/subflow.c  |  1 +
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 0e4961e87b48..76c1814c0b19 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2378,9 +2378,18 @@ static void __mptcp_close_ssk(struct sock *sk, s=
truct sock *ssk,
> >  =09 * to deliver the msk to user-space.
> >  =09 * Do nothing at the moment and take action at accept and/or listen=
er
> >  =09 * shutdown.
> > +=09 * If instead such subflow has been destroyed, e.g. by inet_child_f=
orget
> > +=09 * do the kill
> >  =09 */
> > -=09if (msk->in_accept_queue && msk->first =3D=3D ssk)
> > -=09=09return;
> > +=09if (msk->in_accept_queue && msk->first =3D=3D ssk) {
> > +=09=09if (!sock_flag(ssk, SOCK_DEAD))
> > +=09=09=09return;
> > +
> > +=09=09/* ensure later check in mptcp_worker will dispose the msk */
> > +=09=09sock_set_flag(sk, SOCK_DEAD);
>=20
> Is it OK to mark the msk as dead and continue below? I guess yes because
> there will not be any data to re-inject anyway?

We don't process any data here (the msk is unaccepted at this point).
Looks safe/sane to me. Overall this is the MPTCP equivalent of
inet_child_forget()

> > +=09=09inet_csk(sk)->icsk_mtup.probe_timestamp =3D tcp_jiffies32 -
> > +=09=09=09=09=09=09=09  TCP_TIMEWAIT_LEN -1;
>=20
> Changing the timestamp looks like an ugly hack :)
>=20
> But I guess it is needed not to wait for nothing and there is no clearer
> way? Or move this logic to the worker?

I can add another flag inside the msk. I did not do that here to keep
the patch small, but no objection on my side to clean this path - the
important thing is let syzkaller crunch this ;)

/P

