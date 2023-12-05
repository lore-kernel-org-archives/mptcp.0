Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF969288
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8gEaYGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701796243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWSZH1o/TV4beUukdLUpxhHJPEq/M1llrxPB9y2JgYY=;
	b=H8gEaYGZSopS/91zC92IxVztrzs1GPmp+kOa5H4lWbEFZEyWzl2NMc5tYI0QBoLvmSdRns
	jDU0umfoXReIm7vn9yOqosmKxvCgzbzGK4MKqGKkW+Y0Rn7NNNIdZSjNnVLZxA+iMNMK8H
	SIZoPyNfwStvKhnLNC3arP3dAivgVDc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-sRRIg0N9NpWWYyaYjLxHmw-1; Tue, 05 Dec 2023 12:10:39 -0500
X-MC-Unique: sRRIg0N9NpWWYyaYjLxHmw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9f0e20fafso6613671fa.1
        for <mptcp@lists.linux.dev>; Tue, 05 Dec 2023 09:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796236; x=1702401036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSeiiATz3AAG9c+nLzK/6/nUoeSix2e0Ik8lb+fV7/U=;
        b=K6HBtgybQ1O5L3PzrUI8+FuXCPg4NvJE0GxB45fE6mWWdkqMwW8DvITMBNfO4Nmb/N
         3ibW6j2B3yvI4PA09qjQUrQ/FWwoS5Tt1KBa0SV6zo4Uct008sIkRgDqm8i2PjPXkLas
         lKHt1C3gxhu9zsTk+lju2sOYoseapImSAKiLi6XfT4IGoBDbo9IaWYLDIoOlQv8qWJsJ
         j3KOzpl0InAt7mmtuppam9cUn3emWEw4EnBf2HZDOBwmr4eOsPhCps/8zyURIMEaRSdo
         ryKFmewDYfkzesapuFo1jiRDzPvVBEbs6jmurCr1iEt779LNg78//QfoRzLurOGZJTJf
         Kv5g==
X-Gm-Message-State: AOJu0YxdeKbIW+ic0MMeq8RM/MqKzK2CkJp6/qCMLh2G55UxwdgYFEtc
	9Pn2A0RhJQ3yrasMSTPcE3Ujq4YCkexW0430zzprpg2a9n8qvoCl8HANQJ/YIsoB/Ja0koNcnOf
	kyP7Gk/Ek5+0dJQl4f2szEIs=
X-Received: by 2002:a2e:1458:0:b0:2c9:e3a4:4825 with SMTP id 24-20020a2e1458000000b002c9e3a44825mr7170307lju.0.1701796236510;
        Tue, 05 Dec 2023 09:10:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvIFjNt3nxjN6morRZUQ14vxN6wnpy5l6FMGxBAMdWnwj74cNWf88pijeK7t4xp77TAzxUjQ==
X-Received: by 2002:a2e:1458:0:b0:2c9:e3a4:4825 with SMTP id 24-20020a2e1458000000b002c9e3a44825mr7170141lju.0.1701796234879;
        Tue, 05 Dec 2023 09:10:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d889000000b0054b1360dd03sm1345700edq.58.2023.12.05.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:10:34 -0800 (PST)
Message-ID: <6992069ecb5fbe9468435bd6376bd94a75f877d0.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: don't overwrite sock_ops in
 mptcp_is_tcpsk()
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 05 Dec 2023 18:10:33 +0100
In-Reply-To: <20231205091221.2657807-1-dcaratti@redhat.com>
References: <20231205091221.2657807-1-dcaratti@redhat.com>
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

Hi,

On Tue, 2023-12-05 at 10:12 +0100, Davide Caratti wrote:
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
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Nice! this avoids a few conditionals in fast-path!

> ---
>  net/mptcp/protocol.c | 110 ++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 64 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6956fde61c68d..31822a4fb16e8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -55,28 +55,16 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
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
> +=09if (sk->sk_prot =3D=3D &tcp_prot)
> +=09=09return &inet_stream_ops;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -=09} else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
> -=09=09WRITE_ONCE(sock->ops, &inet6_stream_ops);
> -=09=09return true;
> +=09else if (sk->sk_prot =3D=3D &tcpv6_prot)
> +=09=09return &inet6_stream_ops;
>  #endif
> -=09}
> -
> -=09return false;
> +=09WARN_ON_ONCE(1);
> +=09return sk->sk_socket->ops;

minor nit: you can avoid an additional conditional changing the order
of the above tests:

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
=09if (sk->sk_prot =3D=3D &tcpv6_prot)
=09=09return &inet6_stream_ops;
 #endif

=09WARN_ON_ONCE(sk->sk_prot !=3D &tcp_prot);
=09return &inet_stream_ops;

Returning &inet_stream_ops for non tcpv4 sockets would likely lead to
later problems, but that warn is there only to protect from unknown/not
foreseen serious bugs. Anything that happens after such warn is really
doomed and even the 'return sk->sk_socket->ops;' present in the current
form of this patch will cause trouble later.
=09
>  }
> =20
>  static int __mptcp_socket_create(struct mptcp_sock *msk)
> @@ -3258,44 +3246,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, =
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
> @@ -3739,7 +3689,6 @@ static struct proto mptcp_prot =3D {
>  =09.connect=09=3D mptcp_connect,
>  =09.disconnect=09=3D mptcp_disconnect,
>  =09.close=09=09=3D mptcp_close,
> -=09.accept=09=09=3D mptcp_accept,
>  =09.setsockopt=09=3D mptcp_setsockopt,
>  =09.getsockopt=09=3D mptcp_getsockopt,
>  =09.shutdown=09=3D mptcp_shutdown,
> @@ -3849,18 +3798,36 @@ static int mptcp_stream_accept(struct socket *soc=
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
> +=09=09=09goto out;

very minor nit: the label 'out' above could possibly be renamed to
something more descriptive, e.g. 'fallback'.=20

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
> @@ -3882,6 +3849,21 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
>  =09=09=09if (unlikely(list_is_singular(&msk->conn_list)))
>  =09=09=09=09inet_sk_state_store(newsk, TCP_CLOSE);
>  =09=09}
> +=09} else {
> +=09=09MPTCP_INC_STATS(sock_net(ssk),
> +=09=09=09=09MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> +out:
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

Both notes not intended to block the patch, feel free it ignore.

In any case:

Acked-by: Paolo Abeni <pabeni@redhat.com>

