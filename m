Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353FC8ED
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689322944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJKPNj78NJuENhnJlMW+rXiRGLs649hjsTKBGbWkGaQ=;
	b=JVV326/pJE0+gAc7Dx4Qn5hKuegmiuMxGnJ+NFgxfCUFf/vvOtg+2imLw4eG3YyUg41oZk
	Gti+amJXErV0JE2nYug3ySG1YPI2KzPTRB86WTuDCaWGNDu8OtruAFzPcNfI76qtvfzaUN
	+c6vasaQBVMYx26mVFj+My6Iba1U5XE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Ek35-5tZN9u1PDkHWFjhcQ-1; Fri, 14 Jul 2023 04:22:23 -0400
X-MC-Unique: Ek35-5tZN9u1PDkHWFjhcQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767b80384a3so38672485a.0
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 01:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322943; x=1691914943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ax/+ejtuZ066cP8ndARMvJrs3n/cSY6t+Tye1yRn/qs=;
        b=IlInNFjQRLVwnBG3EnCUZvj4kcQ6d0euTenJI5KSs3hV327bFhf+izTmPZEXB62JwX
         DDZNvKmDw7a/h2JrCSzljLqt9zqb6VodpQS+XP6CgbY7/EYj2q4vlqkxI/Q/m6r3nlQ5
         VVfMcA33HfIeeogeKCirghjb3rm8YwhqFBIvjv3Bf2VEPE9OGl4gO8V+fPXfjZx4rKvo
         Y0qkLJDPGZwFXnj92NBbIKDAbirsVj0MCwzpHfIlArfhyv40QEbKlo3IAQ2ELRQD5iYT
         M4rBCGJH7bXkTF4fCQ+e/dNpWjYaWB/V90wtyG1nOF4GoFiWgYwCjRzEvelfvZnaNPKd
         JwYA==
X-Gm-Message-State: ABy/qLYJ6+/cQ823oNxTv4NQ3xMMTtpw4OUnJHw1HvN9LIvHRoSgORxV
	T5IHbsQ06Y/0oMuUSOIVhNwLSfCJd9MoDYwWOkHLTEy5n+AVZdkixbl6+hpqabWyZNIVGYdTCI+
	Gl+Fo0y3fpkinp6uO0Zw1jyU=
X-Received: by 2002:a05:620a:444f:b0:763:d32b:5095 with SMTP id w15-20020a05620a444f00b00763d32b5095mr5146070qkp.6.1689322943137;
        Fri, 14 Jul 2023 01:22:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJpnmHtqdt2s+3LhxVWiQ+aTqRb91BLBRwuTv0Uwe+RuGKoQyM/QccY6p4BVwq65b2b8xezA==
X-Received: by 2002:a05:620a:444f:b0:763:d32b:5095 with SMTP id w15-20020a05620a444f00b00763d32b5095mr5146063qkp.6.1689322942913;
        Fri, 14 Jul 2023 01:22:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b007659935ce64sm3592664qkj.71.2023.07.14.01.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:22:22 -0700 (PDT)
Message-ID: <ef527d36db430629dfaaa891c0a4941c741ef09c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 08/14] mptcp: avoid additional indirection in
 mptcp_listen()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 Jul 2023 10:22:20 +0200
In-Reply-To: <fcd2efdf-67d9-e90e-ddd7-355f7367ce05@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com>
	 <3e6dc1e7ec147cf1ab8109a7ec65b62319565604.1688993569.git.pabeni@redhat.com>
	 <fcd2efdf-67d9-e90e-ddd7-355f7367ce05@kernel.org>
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

On Wed, 2023-07-12 at 14:52 -0700, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
>=20
> > We are going to remove the first subflow socket soon, so avoid
> > the addictional indirection via at listen() time. Instead call
> > directly the recently introduced helper on the first subflow sock.
> >=20
> > No functional changes intended.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 14 ++++++++++----
> > 1 file changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 00b891f709f7..c5da7a172ee9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3759,6 +3759,7 @@ static int mptcp_listen(struct socket *sock, int =
backlog)
> > =09struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > =09struct sock *sk =3D sock->sk;
> > =09struct socket *ssock;
> > +=09struct sock *ssk;
> > =09int err;
> >=20
> > =09pr_debug("msk=3D%p", msk);
> > @@ -3775,15 +3776,20 @@ static int mptcp_listen(struct socket *sock, in=
t backlog)
> > =09=09goto unlock;
> > =09}
> >=20
> > +=09ssk =3D msk->first;
> > =09inet_sk_state_store(sk, TCP_LISTEN);
> > =09sock_set_flag(sk, SOCK_RCU_FREE);
> >=20
> > -=09err =3D ssock->ops->listen(ssock, backlog);
> > -=09inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> > +=09lock_sock(ssk);
> > +=09err =3D __inet_listen_sk(ssk, backlog);
> > +=09release_sock(ssk);
> > +=09inet_sk_state_store(sk, inet_sk_state_load(ssk));
> > +
> > =09if (!err) {
> > +=09=09WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
>=20
> This seems like new functionality that isn't mentioned in the commit=20
> message. Do the changes here expose an issue with making the msk-level=20
> sk_max_ack_backlog match the subflow, or is this an unrelated fix?

You are right, I should have move this to a different patch.=20

I added this just for added consistency, but the field is never used
and not even exposed to the user-space (diag reads the first subflow
sk_max_ack_backlog). I'll drop the chunk in v2.

Thanks!

Paolo

