Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400379F0
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689322595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcdOx7qRxAXCSgTUV9ahzr6Xobo5ivx8Ert8lPYFfcc=;
	b=Zwb3SdNM7JWKMuqKgmE8nv8k5KZf0sortaqprvBMxPJzuiUdWdgLQN67YQ0CxQe9FdtRcG
	xUF6u7wAW+wEeY6l6ZH7dR4T+WpbYpfSOHsV8hrdGz/Af+LW6OVgVKzIO+jneFft7/RTwz
	JJrHfg09fBRgAXogxHv1RL/BWBKxWGw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-SeXAkmNENDGvG1DqMj43-A-1; Fri, 14 Jul 2023 04:16:34 -0400
X-MC-Unique: SeXAkmNENDGvG1DqMj43-A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40234d83032so3032321cf.1
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 01:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322594; x=1689927394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzDiubsX2zrPT2fcAGwHQ2WrNGy8NPv4Fu6fEJJFRSo=;
        b=Vwz00cLnxtD2EWRGJPGuXF0WcF3hMjyKp0lAWLeWD+o73D4NMhYjkSLovq2G+kBCWp
         jH39oCrGNofIXkNy0Jnz6acJLV2XWsGqzAm+HCyKS75lNnkeeCXfq7f35pNLH/G2jd/B
         q2YQ7l1GWcXfAuV4g2k1PoS7LJTZuvz/6aY6W800g2GJ7HPShsYmvZNtem1tyIilCdbg
         XHlWUtCD3u7SSTJKmRGGXPA+Leh16yEqFaqjERHvz573hpLoYejrN3TmH/PRc6Lexk0N
         lhgKqS9T9vjLbK4BE4d/Mqd9fqiZCr3f2tIHeGP3IUmxd8hvRkUyVfvYYA0LEKTkM87H
         Tp1Q==
X-Gm-Message-State: ABy/qLY3+N0q4yymNdAYOExLF/MVNuHU8dFbCL/AuhqjjuPd9D/aFDp/
	1RJ1w+QAuM5OXU3hPtsH0IkEN2iPQ9b1wRQ/98wR/RI00Sfxhp8t2AwUi9Br1yZUh+YHB/KYapF
	LQwgreEa7RWiCHik=
X-Received: by 2002:a05:622a:453:b0:3ff:2a6b:5a76 with SMTP id o19-20020a05622a045300b003ff2a6b5a76mr5117159qtx.5.1689322593490;
        Fri, 14 Jul 2023 01:16:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9rGVIAhC5Wsek6bIHRIM6/pDwQvmD+rYmmkYJ//5Fpovrw0VaGdAxDICoCUIS1yWwvX27Lg==
X-Received: by 2002:a05:622a:453:b0:3ff:2a6b:5a76 with SMTP id o19-20020a05622a045300b003ff2a6b5a76mr5117149qtx.5.1689322593175;
        Fri, 14 Jul 2023 01:16:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id j12-20020ac874cc000000b003f9af049c55sm3747093qtr.18.2023.07.14.01.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:16:32 -0700 (PDT)
Message-ID: <9cfaaef97847e4b206f0d51bde9d4080c722a57a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 07/14] net: factor out __inet_listen_sk()
 helper
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 Jul 2023 10:16:30 +0200
In-Reply-To: <927fb820-a640-48b9-50b4-e395ea0aa604@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com>
	 <c5d9a8a411ec56d847418aad437b63d24872cb71.1688993569.git.pabeni@redhat.com>
	 <927fb820-a640-48b9-50b4-e395ea0aa604@kernel.org>
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

On Wed, 2023-07-12 at 14:50 -0700, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
>=20
> > The mptcp protocol maintains an additional socket just to easily
> > invoke a few stream operations on the first subflow. One of them
> > is inet_listen().
> >=20
> > Factor out an helper operating directly on the (locked) struct sock,
> > to allow get rid of the above dependency in the next patch without
> > duplicating the existing code.
> >=20
> > No functional changes intended.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > include/net/inet_common.h |  1 +
> > net/ipv4/af_inet.c        | 39 +++++++++++++++++++++++----------------
> > 2 files changed, 24 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> > index 8e97de700991..f50a644d87a9 100644
> > --- a/include/net/inet_common.h
> > +++ b/include/net/inet_common.h
> > @@ -40,6 +40,7 @@ int inet_recvmsg(struct socket *sock, struct msghdr *=
msg, size_t size,
> > =09=09 int flags);
> > int inet_shutdown(struct socket *sock, int how);
> > int inet_listen(struct socket *sock, int backlog);
> > +int __inet_listen_sk(struct sock *sk, int backlog);
> > void inet_sock_destruct(struct sock *sk);
> > int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len=
);
> > int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)=
;
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index 2fd23437c1d2..fa482e314162 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -187,24 +187,13 @@ static int inet_autobind(struct sock *sk)
> > =09return 0;
> > }
> >=20
> > -/*
> > - *=09Move a socket into listening state.
> > - */
> > -int inet_listen(struct socket *sock, int backlog)
> > +int __inet_listen_sk(struct sock *sk, int backlog)
> > {
> > -=09struct sock *sk =3D sock->sk;
> > -=09unsigned char old_state;
> > +=09unsigned char old_state =3D sk->sk_state;
> > =09int err, tcp_fastopen;
> >=20
> > -=09lock_sock(sk);
> > -
> > -=09err =3D -EINVAL;
> > -=09if (sock->state !=3D SS_UNCONNECTED || sock->type !=3D SOCK_STREAM)
> > -=09=09goto out;
> > -
> > -=09old_state =3D sk->sk_state;
> > =09if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
> > -=09=09goto out;
> > +=09=09return -EINVAL;
> >=20
> > =09WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
> > =09/* Really, if the socket is already in listen state
> > @@ -227,10 +216,28 @@ int inet_listen(struct socket *sock, int backlog)
> >=20
> > =09=09err =3D inet_csk_listen_start(sk);
> > =09=09if (err)
> > -=09=09=09goto out;
> > +=09=09=09return err;
> > +
> > =09=09tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
> > =09}
> > -=09err =3D 0;
> > +=09return 0;
> > +}
> > +
> > +/*
> > + *=09Move a socket into listening state.
> > + */
> > +int inet_listen(struct socket *sock, int backlog)
> > +{
> > +=09struct sock *sk =3D sock->sk;
> > +=09int err;
> > +
> > +=09lock_sock(sk);
> > +
> > +=09err =3D -EINVAL;
>=20
> Minor tweak: can initialize in the declaration above.

Right you are! Not sure how I missed it. I'll do in v2.

Thanks!

Paolo

