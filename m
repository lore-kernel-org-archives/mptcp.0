Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E677A23B
	for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW/R8wY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702400182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iC/6WucDkCXde4g5KT5Aqa2B6sZByN3wBjZDvbbxuWw=;
	b=TW/R8wY06cW2qXutd7XKRbaJINT/RVGQvy5O2y5dorX/f/nySMrKvZJGwn7Yfqv8lkN9L8
	rTLu91s709qr30IhhaRfRGxjEubh2qBr7cl7v88Z2ON84WtiN+alRimQHEof5QtRxDBG1i
	HoqyvdYEJ2VUYDOkiX74/4YPOPlb/IQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-YsGCKwxiNyekVugsEwU-eQ-1; Tue, 12 Dec 2023 11:56:21 -0500
X-MC-Unique: YsGCKwxiNyekVugsEwU-eQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d27c45705so126632566b.0
        for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 08:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400180; x=1703004980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0QwFl5+gcx6Y6QDHLNANakj6PaVGVuIjJh/xLqpWNM=;
        b=QNXkQk9bkv7UkKCxcTKidcmOOcgcsloO7VvPBsRt7WJGB6R8+vYcb+f/JMa821/hWd
         06L1Xb4zpzuAzRzX3gLBYNalfGIWc0yCbLwSTPt1hrwTYht9CGiKdyguYgyBFzUGTW9I
         8mOOg96f/nCyEUmd7XDmX8nGEQc9KNbkeK+3OB+HjpZRmQeUSi6cQaI4JHo73mFADKqH
         CcOzPSwpE3CYBs0RN2749eogPm3Km3L0L8edHG3eJ8CZ8YO87sjkAq4+/olZwoH5LkQo
         XrPP+8EHN96EhhhiFqcCtKwVqpzLshVr+N+iMgbHOkPofEHQHxMKYJWIwZsMMVG4vf1b
         R3zg==
X-Gm-Message-State: AOJu0Yx0Qh6RgcSOB8f1KPZGCdgeqCDDrwnaSeElgxAyyK/AYBE+QxRL
	STKYWRczWS4/lEPNk/emROQop07WSCzWkRYuuj2HlTkwCxQK9crZ0fsJejy6Os1d86TigBB/QS3
	RfUgnhqo4fdgFSt9Y8jorubA=
X-Received: by 2002:a17:907:a789:b0:9e6:c282:5bd5 with SMTP id vx9-20020a170907a78900b009e6c2825bd5mr6876813ejc.3.1702400179999;
        Tue, 12 Dec 2023 08:56:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDKfuxN6yZGOfeDoAGSHAbOkxTJpBUf2v15FxSfXYMO7iUb8IF6v+VvJ+9ZjlWQUhz6zGVgw==
X-Received: by 2002:a17:907:a789:b0:9e6:c282:5bd5 with SMTP id vx9-20020a170907a78900b009e6c2825bd5mr6876800ejc.3.1702400179619;
        Tue, 12 Dec 2023 08:56:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1b65cd1957sm6543881ejc.107.2023.12.12.08.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:56:19 -0800 (PST)
Message-ID: <dfaab45e985a326de8bd075ced1ab39211521939.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: don't overwrite sock_ops in
 mptcp_is_tcpsk()
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 12 Dec 2023 17:56:18 +0100
In-Reply-To: <784668db3e21351c91f4f312720059c6fa5cc15d.1702290281.git.dcaratti@redhat.com>
References: <784668db3e21351c91f4f312720059c6fa5cc15d.1702290281.git.dcaratti@redhat.com>
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

On Mon, 2023-12-11 at 11:29 +0100, Davide Caratti wrote:
> Eric Dumazet suggests:
>=20
>  > The fact that mptcp_is_tcpsk() was able to write over sock->ops was a
>  > bit strange to me.
>  > mptcp_is_tcpsk() should answer a question, with a read-only argument.
>=20
> re-factor code to avoid overwriting sock_ops inside that function. Also,
> change the helper name to reflect the semantics and to disambiguate from
> its dual, sk_is_mptcp(). While at it, collapse mptcp_stream_accept() and
> mptcp_accept() into a single function, where fallback / non-fallback are
> separated into a single sk_is_mptcp() conditional.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/mptcp/protocol.c | 108 ++++++++++++++++++-------------------------
>  1 file changed, 44 insertions(+), 64 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4fc038d29623..b7cb60e6f0c3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -55,28 +55,14 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  =09return READ_ONCE(msk->wnd_end);
>  }
> =20
> -static bool mptcp_is_tcpsk(struct sock *sk)
> +static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock =
*sk)
>  {
> -=09struct socket *sock =3D sk->sk_socket;
> -
> -=09if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
> -=09=09/* we are being invoked after mptcp_accept() has
> -=09=09 * accepted a non-mp-capable flow: sk is a tcp_sk,
> -=09=09 * not an mptcp one.
> -=09=09 *
> -=09=09 * Hand the socket over to tcp so all further socket ops
> -=09=09 * bypass mptcp.
> -=09=09 */
> -=09=09WRITE_ONCE(sock->ops, &inet_stream_ops);
> -=09=09return true;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -=09} else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
> -=09=09WRITE_ONCE(sock->ops, &inet6_stream_ops);
> -=09=09return true;
> +=09if (sk->sk_prot =3D=3D &tcpv6_prot)
> +=09=09return &inet6_stream_ops;
>  #endif
> -=09}
> -
> -=09return false;
> +=09WARN_ON_ONCE(sk->sk_prot !=3D &tcp_prot);
> +=09return &inet_stream_ops;
>  }
> =20
>  static int __mptcp_socket_create(struct mptcp_sock *msk)
> @@ -3258,44 +3244,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, =
const struct sock *ssk)
>  =09WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
>  }
> =20
> -static struct sock *mptcp_accept(struct sock *ssk, int flags, int *err,
> -=09=09=09=09 bool kern)
> -{
> -=09struct sock *newsk;
> -
> -=09pr_debug("ssk=3D%p, listener=3D%p", ssk, mptcp_subflow_ctx(ssk));
> -=09newsk =3D inet_csk_accept(ssk, flags, err, kern);
> -=09if (!newsk)
> -=09=09return NULL;
> -
> -=09pr_debug("newsk=3D%p, subflow is mptcp=3D%d", newsk, sk_is_mptcp(news=
k));
> -=09if (sk_is_mptcp(newsk)) {
> -=09=09struct mptcp_subflow_context *subflow;
> -=09=09struct sock *new_mptcp_sock;
> -
> -=09=09subflow =3D mptcp_subflow_ctx(newsk);
> -=09=09new_mptcp_sock =3D subflow->conn;
> -
> -=09=09/* is_mptcp should be false if subflow->conn is missing, see
> -=09=09 * subflow_syn_recv_sock()
> -=09=09 */
> -=09=09if (WARN_ON_ONCE(!new_mptcp_sock)) {
> -=09=09=09tcp_sk(newsk)->is_mptcp =3D 0;
> -=09=09=09goto out;
> -=09=09}
> -
> -=09=09newsk =3D new_mptcp_sock;
> -=09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
> -=09} else {
> -=09=09MPTCP_INC_STATS(sock_net(ssk),
> -=09=09=09=09MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> -=09}
> -
> -out:
> -=09newsk->sk_kern_sock =3D kern;
> -=09return newsk;
> -}
> -
>  void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
>  {
>  =09struct mptcp_subflow_context *subflow, *tmp;
> @@ -3738,7 +3686,6 @@ static struct proto mptcp_prot =3D {
>  =09.connect=09=3D mptcp_connect,
>  =09.disconnect=09=3D mptcp_disconnect,
>  =09.close=09=09=3D mptcp_close,
> -=09.accept=09=09=3D mptcp_accept,
>  =09.setsockopt=09=3D mptcp_setsockopt,
>  =09.getsockopt=09=3D mptcp_getsockopt,
>  =09.shutdown=09=3D mptcp_shutdown,
> @@ -3848,18 +3795,36 @@ static int mptcp_stream_accept(struct socket *soc=
k, struct socket *newsock,
>  =09if (!ssk)
>  =09=09return -EINVAL;
> =20
> -=09newsk =3D mptcp_accept(ssk, flags, &err, kern);
> +=09pr_debug("ssk=3D%p, listener=3D%p", ssk, mptcp_subflow_ctx(ssk));
> +=09newsk =3D inet_csk_accept(ssk, flags, &err, kern);
>  =09if (!newsk)
>  =09=09return err;
> =20
> -=09lock_sock(newsk);
> -
> -=09__inet_accept(sock, newsock, newsk);
> -=09if (!mptcp_is_tcpsk(newsock->sk)) {
> -=09=09struct mptcp_sock *msk =3D mptcp_sk(newsk);
> +=09pr_debug("newsk=3D%p, subflow is mptcp=3D%d", newsk, sk_is_mptcp(news=
k));
> +=09if (sk_is_mptcp(newsk)) {
>  =09=09struct mptcp_subflow_context *subflow;
> +=09=09struct sock *new_mptcp_sock;
> +
> +=09=09subflow =3D mptcp_subflow_ctx(newsk);
> +=09=09new_mptcp_sock =3D subflow->conn;
> +
> +=09=09/* is_mptcp should be false if subflow->conn is missing, see
> +=09=09 * subflow_syn_recv_sock()
> +=09=09 */
> +=09=09if (WARN_ON_ONCE(!new_mptcp_sock)) {
> +=09=09=09tcp_sk(newsk)->is_mptcp =3D 0;
> +=09=09=09goto tcpfallback;
> +=09=09}
> +
> +=09=09newsk =3D new_mptcp_sock;
> +=09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
> +
> +=09=09newsk->sk_kern_sock =3D kern;
> +=09=09lock_sock(newsk);
> +=09=09__inet_accept(sock, newsock, newsk);
> =20
>  =09=09set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
> +=09=09msk =3D mptcp_sk(newsk);
>  =09=09msk->in_accept_queue =3D 0;
> =20
>  =09=09/* set ssk->sk_socket of accept()ed flows to mptcp socket.
> @@ -3881,6 +3846,21 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
>  =09=09=09if (unlikely(list_is_singular(&msk->conn_list)))
>  =09=09=09=09inet_sk_state_store(newsk, TCP_CLOSE);
>  =09=09}
> +=09} else {
> +=09=09MPTCP_INC_STATS(sock_net(ssk),
> +=09=09=09=09MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> +tcpfallback:
> +=09=09newsk->sk_kern_sock =3D kern;
> +=09=09lock_sock(newsk);
> +=09=09__inet_accept(sock, newsock, newsk);
> +=09=09/* we are being invoked after accepting a non-mp-capable
> +=09=09 * flow: sk is a tcp_sk, not an mptcp one.
> +=09=09 *
> +=09=09 * Hand the socket over to tcp so all further socket ops
> +=09=09 * bypass mptcp.
> +=09=09 */
> +=09=09WRITE_ONCE(newsock->sk->sk_socket->ops,
> +=09=09=09   mptcp_fallback_tcp_ops(newsock->sk));
>  =09}
>  =09release_sock(newsk);
> =20
LGTM! thanks Davide!

Acked-by: Paolo Abeni <pabeni@redhat.com>

btw the CI failures look real, but unrelated ?!?

