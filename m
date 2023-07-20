Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F614A9C
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689850417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdGTZNsrI0EzL4VB6Sy8O6GCQOirA6TSTkpRzmDHLpg=;
	b=CilFN/audqaEi+u+iqUthBLSH6wUZurUmKqKjrizlNrfxSPm7hzJ6UTR4bhwHqB3ACkd07
	E07ubqBwMrrkFBHBL8xqU0lvCCzGqyjJFs7UEsMT5oeJmRtpuLbb1CM3+vOnov8LzS2GIs
	0jO4nEoV0jH7jbilZJqLlQBnti6DyRM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-IKnGlhqbNV-yPWT_juna8A-1; Thu, 20 Jul 2023 06:53:36 -0400
X-MC-Unique: IKnGlhqbNV-yPWT_juna8A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767edbf73cbso17737385a.1
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 03:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689850416; x=1690455216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87cBKJEHcbXaQFqJ15mDlM0awnHSrXBzfq89MRos6Y8=;
        b=dcmWkRDgk1qaN9OXazN0h//w4r7BZlXrlXHgsXnbT7+6VOdLhJUd71AhDAbAh1BUb5
         3WawvPucLtSvb16SlHb1ZDyIm+6TGSiokd5f6LjCUjnrhIquvrS5ycoMs/CEXEziPHE5
         umEDIvpV1pF2wZysMFEGuV/0DQFa4yJ6uDIRvf94fXbTAB/kj87zwBh95ds5AyKc6LKB
         +0sLt6vjFcuYvlj9/Fh7EakG704XoG6Q78jC8RG0yn48iRw1g8VIDzBamEYb7ZXwWtcD
         y1YLml6yhorY5AMkGsTFVAF0XHTHRQVdYN300U02piw9MlAVkIe4+TG+oDDp8Sxoo+xX
         76Vw==
X-Gm-Message-State: ABy/qLYYIHjIRxnNrNLalH3XYrvsEzzxZLyHa7X/CvNdcexbg/dbK/Ki
	EJWvWuWQNJwbw18UCAzQh7/Tn+zdNGRKwBLu9oBMuvLpm684JaK5kz0pJYRHpq3rH5Sto11IckQ
	xSXMsNzSeNjSH7z5lyD6MgCY=
X-Received: by 2002:a05:620a:f02:b0:765:3b58:99ab with SMTP id v2-20020a05620a0f0200b007653b5899abmr19482718qkl.4.1689850415967;
        Thu, 20 Jul 2023 03:53:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzfDOTQouELpcEdbcA8H17ZdeppQjhqjCVi6FzZYggs6q2jC4fqAvDnZILLQlRqqgPOIbuAQ==
X-Received: by 2002:a05:620a:f02:b0:765:3b58:99ab with SMTP id v2-20020a05620a0f0200b007653b5899abmr19482703qkl.4.1689850415594;
        Thu, 20 Jul 2023 03:53:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a134a00b00767db1ba172sm156928qkl.31.2023.07.20.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:53:35 -0700 (PDT)
Message-ID: <deb5be81de3d430fd10c8af1687310f9705a45c6.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix rcv buffer auto-tuning.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 20 Jul 2023 12:53:33 +0200
In-Reply-To: <333c6239-bb59-abf1-b2a3-ba3d89520b9f@tessares.net>
References: <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
	 <333c6239-bb59-abf1-b2a3-ba3d89520b9f@tessares.net>
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

On Thu, 2023-07-20 at 10:52 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 20/07/2023 09:03, Paolo Abeni wrote:
> > The MPTCP code uses the assumption that the tcp_win_from_space() helper
> > does not use any TCP-specific field, and thus works correctly operating
> > on an MPTCP socket.
> > The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") br=
oke
> > such assumption, and as a consequence most MPTCP connections stall on
> > zero-window event due to auto-tuning changing the rcv buffer size quite
> > randomly.
> > Address the issue synching again the MPTCP auto-tuning code with the TC=
P
> > one. To achieve that, factor out the windows size logic in socket
> > independent helpers, and reuse them in mptcp_rcv_space_adjust(). The MP=
TCP
> > level scaling_ratio is selected as the minimum one from the all the sub=
flows,
> > as a worst-case estimate.
>=20
> Thank you for having shared this patch!
>=20
> > Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > I still see quite frequent failures on mptcp_join tests 19 && 20:
> > 020 multi flows, signal, bidi, link fail
> >       Info: Test file (size 12288 KB) for server
> >       syn                                 [ ok ]
> >       synack                              [ ok ]
> >       ack                                 [ ok ]
> >       add                                 [ ok ]
> >       echo                                [ ok ]
> >       stale                               [fail] got 0 stale[s] 0 recov=
er[s],   expected stale in range [1..-1],  stale-recover delta 1
> >=20
> > I *think* such failures are still caused by dfa2f0483360 ("tcp: get
> > rid of sysctl_tcp_adv_win_scale") because it should change (increase?) =
the
> > rcv buffer/adv win size, and such tests depends on the transferred file=
s
> > being significantly larger then the adv win. Since the current breakage=
 is
> > pretty bad and the above needs more investigation, sharing it now.
>=20
> I agree, fine to delay the fix of this test.
>=20
> > @Matttbe: fill free to adjust the tag whatever it fit you better!!!
>=20
> Thank you for having mixed the two versions :)
> Tags look good to me (with the Fixes one)
>=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 9f00a0288a0a..3ab67e0dfda9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -90,6 +90,7 @@ static int __mptcp_socket_create(struct mptcp_sock *m=
sk)
> >  =09if (err)
> >  =09=09return err;
> > =20
> > +=09msk->scaling_ratio =3D tcp_sk(ssock->sk)->scaling_ratio;
> >  =09WRITE_ONCE(msk->first, ssock->sk);
> >  =09subflow =3D mptcp_subflow_ctx(ssock->sk);
> >  =09list_add(&subflow->node, &msk->conn_list);
> > @@ -1906,6 +1907,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_s=
ock *msk, int copied)
> >  {
> >  =09struct mptcp_subflow_context *subflow;
> >  =09struct sock *sk =3D (struct sock *)msk;
> > +=09u8 scaling_ratio =3D 255;
>=20
> Small detail: can I set it to U8_MAX when applying the patch?

Sure, thanks for the cleanup!

> (...)
>=20
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 1b4457c44fe8..86cd4d9e8432 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -293,6 +293,7 @@ struct mptcp_sock {
> >  =09bool=09=09csum_enabled;
> >  =09bool=09=09allow_infinite_fallback;
> >  =09u8=09=09mpc_endpoint_id;
> > +=09u8=09=09scaling_ratio;
>=20
> Small detail: should we declare that in "rcvq_space"?
>=20
>   msk->rcvq_space.scaling_ratio
>=20
> It's up to you, I'm suggesting that because it is linked to the rcv
> space stuff and I see we put variables linked to that there.
>=20
> (I can also do the modification when applying the patch)
>=20
> Once applied on our side, do you prefer to send it directly to netdev?

To me it's the same. Whatever you prefer.

Cheers,

Paolo

