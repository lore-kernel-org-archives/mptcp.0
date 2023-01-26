Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEF4C78
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674755361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2lYj2e0GiAS5XNS2wIxMNctS1C9Mpe+8V0K+/uXNjs=;
	b=bvd6JXwXt/j0p4hUKHjuI0QyyxKiyfhITd1lqs3rwqHO9ZQKDXSHV+uEDOSM3cSs/sJQRT
	M/0Gl99E64qC4lSrr25sJkz97SWE7wkcer/XRDDSWdyzFqDntOEc9Lk19UCp34OsSKC2Fq
	0R0uZgJYd/nsaZlrz7YaeSytWSnBb3s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-bLQZDqmXPTmGONrlzFLvHw-1; Thu, 26 Jan 2023 12:49:20 -0500
X-MC-Unique: bLQZDqmXPTmGONrlzFLvHw-1
Received: by mail-qt1-f200.google.com with SMTP id r24-20020ac85e98000000b003b68b691996so1087801qtx.13
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 09:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9+s/pubNapd4ZfVoNxmN+rvuG8mNwz7t8kLzLpZjxU=;
        b=JnPre5SzS7WOKQzpVe0+o53iJSjJ/lo+nNB3A2MgWYYS6RIjJGnzrUbHfrhkNSSdKN
         EnsZn+5SNe7EOfvjWFoSzhXbd6kRmAjf4Zpf2UFHKTwfdMNf6wfP8R6yMeqRD6ELNBUr
         HkrE/UQwy39hPsl1Do5cP1we6ZlyRiPC7epwYi0DA2dz1umFKdGTDPP1lqXCTg56UidU
         0LpvxaXmG4O3YKqm6g2v/16rivbDFel/28ZujXa7TNb46NyreYQ0hy6IaPMBlPZdqH3t
         pch/rqvqMTd2c7P293YmEreULaPA6OzFR9Bsg3Wh8nB1On5gTEOLwPYT4rumiK6zeIAR
         jIdw==
X-Gm-Message-State: AFqh2kqziwuJrAjAwp8psaN88raYDBcBpuEChIUsNL4zGMrB/BFeAPYF
	aqpQfVbAckfLtb/KOozZsjIwXVXXaVL84cdzBBlg1vr/9Dd+G5C3N0+7lFvIiUZotWvwLK7g2eD
	tcX3gMAY5qFa0Thw=
X-Received: by 2002:a05:6214:19cd:b0:536:ba5e:6aa8 with SMTP id j13-20020a05621419cd00b00536ba5e6aa8mr47081700qvc.49.1674755359832;
        Thu, 26 Jan 2023 09:49:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvYN4gFqfyIT65bc9HPZtzrqbzkm/6HgNORJiZ69XPTZa0BkCOC1RbIu4FZEN8FQEZF4xa7qA==
X-Received: by 2002:a05:6214:19cd:b0:536:ba5e:6aa8 with SMTP id j13-20020a05621419cd00b00536ba5e6aa8mr47081659qvc.49.1674755359485;
        Thu, 26 Jan 2023 09:49:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a01ef00b006f9f714cb6asm1253053qkn.50.2023.01.26.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:49:18 -0800 (PST)
Message-ID: <fd340c53e129664b4041e2370dbcf07e4bfa8ce7.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 08/13] mptcp: move first subflow
 allocation at mpc access time
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 26 Jan 2023 18:49:16 +0100
In-Reply-To: <09a5cdbf-de41-ea88-6f93-f09709c09631@tessares.net>
References: <cover.1673940640.git.pabeni@redhat.com>
	 <badc4b131ab094bb806971a019807538abd6ccd5.1673940640.git.pabeni@redhat.com>
	 <09a5cdbf-de41-ea88-6f93-f09709c09631@tessares.net>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
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

On Tue, 2023-01-24 at 17:31 +0100, Matthieu Baerts wrote:
> On 17/01/2023 08:36, Paolo Abeni wrote:
>=20
> > @@ -116,6 +104,31 @@ static int __mptcp_socket_create(struct mptcp_sock=
 *msk)
> >  =09return 0;
> >  }
> > =20
> > +/* Returns the first subflow socket if available and the MPC
> > + * handshake is not started yet.
> > + */
> > +struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
> > +{
> > +=09struct sock *sk =3D (struct sock *)msk;
> > +=09int ret;
> > +
> > +=09if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
> > +=09=09return ERR_PTR(-EINVAL);
> > +
> > +=09if (!msk->subflow) {
> > +=09=09if (msk->first)
> > +=09=09=09return ERR_PTR(-EINVAL);
> > +
> > +=09=09ret =3D __mptcp_socket_create(msk);
> > +=09=09if (ret)
> > +=09=09=09return ERR_PTR(ret);
> > +
> > +=09=09mptcp_sockopt_sync(msk, msk->first);
>=20
> Do you think the function should be renamed? Maybe not but it looks
> strange to me to create the socket and do the sync here with this name.
> Maybe it is just me but with this name, I would expect it just to
> returns the first subflow or NULL, but not create a socket if not, no?
>=20
> Mainly to make it clear a "[gs]etsockopt()" before the MPC will create a
> new socket.

I don't have a good alternative name handy. You have good suggestions,
they are more then welcome!

IMHO the function name is not bad: it does not imply allocation, nor
lack of such thing.

> > @@ -1708,8 +1722,11 @@ static int mptcp_sendmsg_fastopen(struct sock *s=
k, struct msghdr *msg,
> >  =09 * Since the defer_connect flag is cleared after the first succsful
> >  =09 * fastopen attempt, no need to check for additional subflow status=
.
> >  =09 */
> > -=09if (msg->msg_flags & MSG_FASTOPEN && !__mptcp_nmpc_socket(msk))
> > -=09=09return -EINVAL;
> > +=09if (msg->msg_flags & MSG_FASTOPEN) {
> > +=09=09ssock =3D __mptcp_nmpc_socket(msk);
> > +=09=09if (IS_ERR(ssock))
> > +=09=09=09return PTR_ERR(ssock);> +=09}
>=20
> Here 'ssock' could be declared in this 'if' section: I guess it doesn't
> really matter but out of curiosity, what's the code style to apply here?
> Fine where it is or moved only where needed?

AFAIK there is no strict codying style rule (even if the preference
should go for the smaller scope). I opted for this way just to reduce
the number of added line - otherwise an additional empty line would
have been mandatory.

> > @@ -762,13 +762,15 @@ static int mptcp_setsockopt_first_sf_only(struct =
mptcp_sock *msk, int level, int
> >  {
> >  =09struct sock *sk =3D (struct sock *)msk;
> >  =09struct socket *sock;
> > -=09int ret =3D -EINVAL;
> > +=09int ret;
> > =20
> >  =09/* Limit to first subflow, before the connection establishment */
> >  =09lock_sock(sk);
> >  =09sock =3D __mptcp_nmpc_socket(msk);
> > -=09if (!sock)
> > +=09if (IS_ERR(sock)) {
> > +=09=09ret =3D PTR_ERR(sock);
> >  =09=09goto unlock;
> > +=09}
>=20
> Just to be sure: here and above the error with __mptcp_nmpc_socket()
> should not happen most of the time: only when we reach some limits, e.g.
> mem, etc., right?
>=20
> So it is fine to potentially return a different error than before (and
> potentially different than what TCP what doing), is it correct?

Well the situation is a bit fuzzy. __mptcp_nmpc_socket() can now return
an additional error code (ENOMEM) compared to the code prior to this
patch. But plain tcp could already return such error for
TCP_FASTOPEN_KEY. For the other sockopt addressed with
mptcp_setsockopt_first_sf_only(), that will introduce a new possible
error code. I think that is fine, the user-space application must not
restrict the set of accepted error code for a given syscall.
=20
> >  =09ret =3D tcp_setsockopt(sock->sk, level, optname, optval, optlen);
> > =20
> > @@ -872,7 +874,7 @@ static int mptcp_getsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
> >  =09}
> > =20
> >  =09ssock =3D __mptcp_nmpc_socket(msk);
> > -=09if (!ssock)
> > +=09if (IS_ERR(ssock))
> >  =09=09goto out;
> > =20
> >  =09ret =3D tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
>=20
> Why here you don't assign the error that is returned? (Maybe a comment
> should be added?)

I guess it felt strange returning ENOMEM for a get operation. I can
switch to full error reporting if you prefer.

Thanks!

Paolo

