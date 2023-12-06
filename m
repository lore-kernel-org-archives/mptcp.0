Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8A482C3
	for <mptcp@lists.linux.dev>; Wed,  6 Dec 2023 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NViArxLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701880252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CF9xDq2UtZcORBXhGqhwL4rzFeB+eZn04EHFmQgnCck=;
	b=NViArxLtvbyrYsa1NMFarqNG9STT9htpJi9UlNqB3Jb9Pvw9Vrv6MO3E04qfHwOussju4I
	eAARLEtNj2h97mjKA0J6FHZXNEqAWzULlv/b/OM7efaDmzk/Fn+8sbPm63zEWa6Y87hCa5
	JSw87lSMQc78djOYWYCciwanzMx7shA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-0n3ltW8bNI6XbVe9TeUGtQ-1; Wed, 06 Dec 2023 11:30:51 -0500
X-MC-Unique: 0n3ltW8bNI6XbVe9TeUGtQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ca0187da0bso29021401fa.2
        for <mptcp@lists.linux.dev>; Wed, 06 Dec 2023 08:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880248; x=1702485048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF9xDq2UtZcORBXhGqhwL4rzFeB+eZn04EHFmQgnCck=;
        b=HMFXK7RwgkDvUdZZQ7YphrUZIOSqMSycbAhyvHxM1uY2OHaNs1PVVHW/MQVL550Su9
         LYIKNzbXqytcbVMhAObHAbE3By5YG9Uuq3UsJyTpqqyKwKXlLTGTZCVYa+QjlFrG4eFL
         wffjs4Ej4hqQlYi0LjtDXJqaV6UgUWYH3Rnjg59iNO+MAZPGNi/Nqy5DUq7M7Pg/AvBF
         MFfLdMcnh+9r1A6Ihuedh8AnhR3+hDivvArlR7SqBqV36/l7AJewsrLs6/nmW670rDC9
         POF7bXyXH3NHIsarDUcD5BxernwQ19mMOO1UzldFUiqkYsOF04UeuDfS3QX/4LPMSQFM
         QMpQ==
X-Gm-Message-State: AOJu0YxL3npYE8SzL80+vf8GUGaYJYYSqAZU185Ngp1WrblE1WNtrycp
	DpAR4Tcsx2s8qhol/AwvR97hceT5Ex/dFfLwOFPZ3MqWu01mU++99Dxg47z1o2Ui3rvz2/dgpg6
	IF89s9q8Nq6NCZu+A65RYDLxp6YP669Q=
X-Received: by 2002:a2e:97d1:0:b0:2c9:f68f:685e with SMTP id m17-20020a2e97d1000000b002c9f68f685emr465763ljj.79.1701880248157;
        Wed, 06 Dec 2023 08:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGzGh1SBFPDaFzk3VJCFmgroi2i52WYTiIucfz9HiyRbzVrRGAMWVVpi9KIJTjs8XNn1NiOrtYEo2+M0sPJh0=
X-Received: by 2002:a2e:97d1:0:b0:2c9:f68f:685e with SMTP id
 m17-20020a2e97d1000000b002c9f68f685emr465751ljj.79.1701880246893; Wed, 06 Dec
 2023 08:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231205091221.2657807-1-dcaratti@redhat.com> <6992069ecb5fbe9468435bd6376bd94a75f877d0.camel@redhat.com>
In-Reply-To: <6992069ecb5fbe9468435bd6376bd94a75f877d0.camel@redhat.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 6 Dec 2023 17:30:35 +0100
Message-ID: <CAKa-r6tcbNeQTRee52JO4bPZ54tO-zLUio7qz5vVkOrhrEKHNg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Paolo, thanks for reviewing!

On Tue, Dec 5, 2023 at 6:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On Tue, 2023-12-05 at 10:12 +0100, Davide Caratti wrote:
> > Eric Dumazet suggests:

[...]

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6956fde61c68d..31822a4fb16e8 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -55,28 +55,16 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
> >       return READ_ONCE(msk->wnd_end);
> >  }
> >
> > -static bool mptcp_is_tcpsk(struct sock *sk)
> > +static const struct proto_ops *mptcp_fallback_tcp_ops(const struct soc=
k *sk)
> >  {
> > -     struct socket *sock =3D sk->sk_socket;
> > -
> > -     if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
> > -             /* we are being invoked after mptcp_accept() has
> > -              * accepted a non-mp-capable flow: sk is a tcp_sk,
> > -              * not an mptcp one.
> > -              *
> > -              * Hand the socket over to tcp so all further socket ops
> > -              * bypass mptcp.
> > -              */
> > -             WRITE_ONCE(sock->ops, &inet_stream_ops);
> > -             return true;
> > +     if (sk->sk_prot =3D=3D &tcp_prot)
> > +             return &inet_stream_ops;
> >  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > -     } else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
> > -             WRITE_ONCE(sock->ops, &inet6_stream_ops);
> > -             return true;
> > +     else if (sk->sk_prot =3D=3D &tcpv6_prot)
> > +             return &inet6_stream_ops;
> >  #endif
> > -     }
> > -
> > -     return false;
> > +     WARN_ON_ONCE(1);
> > +     return sk->sk_socket->ops;
>
> minor nit: you can avoid an additional conditional changing the order
> of the above tests:

it's not avoided, it's just evaluated inside the WARN_ON_ONCE() :-)

>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>         if (sk->sk_prot =3D=3D &tcpv6_prot)
>                 return &inet6_stream_ops;
>  #endif
>
>         WARN_ON_ONCE(sk->sk_prot !=3D &tcp_prot);
>         return &inet_stream_ops;
>
> Returning &inet_stream_ops for non tcpv4 sockets would likely lead to
> later problems, but that warn is there only to protect from unknown/not
> foreseen serious bugs. Anything that happens after such warn is really
> doomed and even the 'return sk->sk_socket->ops;' present in the current
> form of this patch will cause trouble later.

I cowardly decided to let the helper return the current value of ->ops
with the WARN_ON(1) line, with the goal of analyzing the splat on a
live system, with the hope of not doing it on a crashed kernel. But
then it didn't happen on a 5 iterations of kselftests + packetdrill,
so... probably we can shorten the function like you suggested, i.e.:

WARN_ON_ONCE(sk->sk_prot !=3D &tcp_prot);
return &inet_stream_ops;

[...]

> > @@ -3849,18 +3798,36 @@ static int mptcp_stream_accept(struct socket *s=
ock, struct socket *newsock,
> >       if (!ssk)
> >               return -EINVAL;
> >
> > -     newsk =3D mptcp_accept(ssk, flags, &err, kern);
> > +     pr_debug("ssk=3D%p, listener=3D%p", ssk, mptcp_subflow_ctx(ssk));
> > +     newsk =3D inet_csk_accept(ssk, flags, &err, kern);
> >       if (!newsk)
> >               return err;
> >
> > -     lock_sock(newsk);
> > -
> > -     __inet_accept(sock, newsock, newsk);
> > -     if (!mptcp_is_tcpsk(newsock->sk)) {
> > -             struct mptcp_sock *msk =3D mptcp_sk(newsk);
> > +     pr_debug("newsk=3D%p, subflow is mptcp=3D%d", newsk, sk_is_mptcp(=
newsk));
> > +     if (sk_is_mptcp(newsk)) {
> >               struct mptcp_subflow_context *subflow;
> > +             struct sock *new_mptcp_sock;
> > +
> > +             subflow =3D mptcp_subflow_ctx(newsk);
> > +             new_mptcp_sock =3D subflow->conn;
> > +
> > +             /* is_mptcp should be false if subflow->conn is missing, =
see
> > +              * subflow_syn_recv_sock()
> > +              */
> > +             if (WARN_ON_ONCE(!new_mptcp_sock)) {
> > +                     tcp_sk(newsk)->is_mptcp =3D 0;
> > +                     goto out;
>
> very minor nit: the label 'out' above could possibly be renamed to
> something more descriptive, e.g. 'fallback'.

right, I'll send a v3 in the next hours.

> In any case:
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

thanks a lot!
--=20
davide

