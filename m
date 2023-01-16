Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BC46B5
	for <mptcp@lists.linux.dev>; Mon, 16 Jan 2023 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673893966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzFZYQkv29TfrkdCuLR3UGp6w7PjQ739gMLOKjLJ5Ss=;
	b=ieYIPRwXySfpmZ51CS3e8dOIm3I/DlPDO+6Wrs2mxcyRFiZTNqlr25eUlVP1N9d6kc0FYh
	rrrctRbslXqN24WaaS8tVsCkcG6NMAx+830udx9sUCoAStErz2BUymTY5S2clTOfOk87wP
	wK6T+QbufPOhvv6sOMSYJfBVJi7LfGo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-GiB09uLsO6-3q-bsEv47aA-1; Mon, 16 Jan 2023 13:32:45 -0500
X-MC-Unique: GiB09uLsO6-3q-bsEv47aA-1
Received: by mail-qv1-f72.google.com with SMTP id lc30-20020a0562142c1e00b0052f5d835229so14747984qvb.5
        for <mptcp@lists.linux.dev>; Mon, 16 Jan 2023 10:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67djzDjsZTTw+nv4jpxdbIzCi54q3JY/deKIVOO8ZFM=;
        b=QF4BlbKOtCMf8EzDygMSyZ7wCp1A5Eq6Qv8ugDlrJ2M1pfmAI/7CKprn2ZHuutUTcD
         Xukx2oTfxqkIMbEFuQFw3mQlVJ+M7yngKM3VIGrZd77ycaBygvmggcyn1L8S8cQFTM71
         yyBYN4Vjxtx/aCe6cLEjqRIYQXVb9zNYUjrNED/LWHJK4mUWfL8H/PzDqUMrqRyEKKuT
         m2GtaaCvs9AVZP3vEphcbR8QEG19iemhzj67OwZDqA81GKEQFVp5NPUXeSSO4reGt2L/
         /NN4LRuAMSECSguJzsT7weuMSYh7wUfUbwF+WnCe4pQIjyJMLoJSXnuAPrB0ImtwsTR7
         aaOg==
X-Gm-Message-State: AFqh2kqGKrs8dWkXgOTVg2msDjmjF99zh7RKD5zK77br6C3ZP80Ot4iC
	KbsYrBZqNA3R/9TyngsZf0CX9DKvA1Ug4IOI8CPsDcA6YtsRk/X4l+hMwWryau3W3gOIzQh4v2t
	PJ4GH3BppEIS9wtVyfLBApO+jFxNEiYk+id9oqeH5kXLT0ugKkB75RPxJXpkG+BjZ
X-Received: by 2002:a05:6214:588b:b0:4c6:e1d0:efdb with SMTP id md11-20020a056214588b00b004c6e1d0efdbmr1062994qvb.32.1673893964525;
        Mon, 16 Jan 2023 10:32:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvktu4901e4gEygde2u8QAdL7CGQ01M4820+52Jsx7IjxMwVCc3DNn/mVR2tHjzfbW1Yw7EvQ==
X-Received: by 2002:a05:6214:588b:b0:4c6:e1d0:efdb with SMTP id md11-20020a056214588b00b004c6e1d0efdbmr1062961qvb.32.1673893964109;
        Mon, 16 Jan 2023 10:32:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-52.dyn.eolo.it. [146.241.112.52])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006fca1691425sm18703691qko.63.2023.01.16.10.32.43
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:32:43 -0800 (PST)
Message-ID: <832d35947a672ea58f572c4f03f1c02e4acee184.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 6/9] mptcp: move first subflow allocation at
 mpc access time
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 16 Jan 2023 19:32:41 +0100
In-Reply-To: <241299ba21925d0dff397d2e84b66a3280e213dc.1673629755.git.pabeni@redhat.com>
References: <cover.1673629755.git.pabeni@redhat.com>
	 <241299ba21925d0dff397d2e84b66a3280e213dc.1673629755.git.pabeni@redhat.com>
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

On Fri, 2023-01-13 at 19:20 +0100, Paolo Abeni wrote:
> In the long run this will simplify the mptcp code and will
> allow for more consistent behavior. Move the first subflow
> allocation out of the sock->init ops into the __mptcp_nmpc_socket()
> helper.
>=20
> Since the first subflow creation can now happen after the first
> setsockopt() we additionally need to invoke mptcp_sockopt_sync()
> on it.
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm_netlink.c |  4 +--
>  net/mptcp/protocol.c   | 57 +++++++++++++++++++++++++++---------------
>  net/mptcp/protocol.h   |  2 +-
>  net/mptcp/sockopt.c    | 18 ++++++-------
>  4 files changed, 49 insertions(+), 32 deletions(-)
>=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e82a112b8779..290f88fffe5f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1014,8 +1014,8 @@ static int mptcp_pm_nl_create_listen_socket(struct =
sock *sk,
>  =09=09return -EINVAL;
> =20
>  =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (!ssock)
> -=09=09return -EINVAL;
> +=09if (IS_ERR(ssock))
> +=09=09return PTR_ERR(ssock);
> =20
>  =09mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9c4c729bf271..1b93624db62d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -49,18 +49,6 @@ static void __mptcp_check_send_data_fin(struct sock *s=
k);
>  DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
>  static struct net_device mptcp_napi_dev;
> =20
> -/* If msk has an initial subflow socket, and the MP_CAPABLE handshake ha=
s not
> - * completed yet or has failed, return the subflow socket.
> - * Otherwise return NULL.
> - */
> -struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
> -{
> -=09if (!msk->subflow || READ_ONCE(msk->can_ack))
> -=09=09return NULL;
> -
> -=09return msk->subflow;
> -}
> -
>  /* Returns end sequence number of the receiver's advertised window */
>  static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  {
> @@ -116,6 +104,31 @@ static int __mptcp_socket_create(struct mptcp_sock *=
msk)
>  =09return 0;
>  }
> =20
> +/* Returns the first subflow socket if available and the MPC
> + * handshake is not started yet.
> + */
> +struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
> +{
> +=09struct sock *sk =3D (struct sock *)msk;
> +=09int ret;
> +
> +=09if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
> +=09=09return ERR_PTR(-EINVAL);
> +
> +=09if (!msk->subflow) {
> +=09=09if (msk->first)
> +=09=09=09return ERR_PTR(-EINVAL);
> +
> +=09=09ret =3D __mptcp_socket_create(msk);
> +=09=09if (ret)
> +=09=09=09return ERR_PTR(ret);
> +
> +=09=09mptcp_sockopt_sync(msk, msk->first);
> +=09}
> +
> +=09return msk->subflow;
> +}
> +
>  static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
>  {
>  =09sk_drops_add(sk, skb);
> @@ -1699,6 +1712,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, =
struct msghdr *msg,
>  {
>  =09unsigned int saved_flags =3D msg->msg_flags;
>  =09struct mptcp_sock *msk =3D mptcp_sk(sk);
> +=09struct socket *ssock;
>  =09struct sock *ssk;
>  =09int ret;
> =20
> @@ -1708,8 +1722,11 @@ static int mptcp_sendmsg_fastopen(struct sock *sk,=
 struct msghdr *msg,
>  =09 * Since the defer_connect flag is cleared after the first succsful
>  =09 * fastopen attempt, no need to check for additional subflow status.
>  =09 */
> -=09if (msg->msg_flags & MSG_FASTOPEN && !__mptcp_nmpc_socket(msk))
> -=09=09return -EINVAL;
> +=09if (msg->msg_flags & MSG_FASTOPEN) {
> +=09=09ssock =3D __mptcp_nmpc_socket(msk);
> +=09=09if (IS_ERR(ssock))
> +=09=09=09return PTR_ERR(ssock);
> +=09}
>  =09if (!msk->first)
>  =09=09return -EINVAL;
> =20
> @@ -3592,8 +3609,8 @@ static int mptcp_connect(struct sock *sk, struct so=
ckaddr *uaddr, int addr_len)
>  =09int err =3D -EINVAL;
> =20
>  =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (!ssock)
> -=09=09return -EINVAL;
> +=09if (IS_ERR(ssock))
> +=09=09return PTR_ERR(ssock);
> =20
>  =09mptcp_token_destroy(msk);
>  =09inet_sk_state_store(sk, TCP_SYN_SENT);
> @@ -3681,8 +3698,8 @@ static int mptcp_bind(struct socket *sock, struct s=
ockaddr *uaddr, int addr_len)
> =20
>  =09lock_sock(sock->sk);
>  =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (!ssock) {
> -=09=09err =3D -EINVAL;
> +=09if (IS_ERR(ssock)) {
> +=09=09err =3D PTR_ERR(ssock);
>  =09=09goto unlock;
>  =09}
> =20
> @@ -3718,8 +3735,8 @@ static int mptcp_listen(struct socket *sock, int ba=
cklog)
> =20
>  =09lock_sock(sk);
>  =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (!ssock) {
> -=09=09err =3D -EINVAL;
> +=09if (IS_ERR(ssock)) {
> +=09=09err =3D PTR_ERR(ssock);
>  =09=09goto unlock;
>  =09}
> =20
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 5f1a30959b5c..3a055438c65e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -632,7 +632,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
>  void mptcp_subflow_reset(struct sock *ssk);
>  void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
>  void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> -struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
> +struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
>  bool __mptcp_close(struct sock *sk, long timeout);
>  void mptcp_cancel_work(struct sock *sk);
>  void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 9986681aaf40..022a6cad00c1 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -301,9 +301,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_s=
ock *msk, int optname,
>  =09case SO_BINDTOIFINDEX:
>  =09=09lock_sock(sk);
>  =09=09ssock =3D __mptcp_nmpc_socket(msk);
> -=09=09if (!ssock) {
> +=09=09if (IS_ERR(ssock)) {
>  =09=09=09release_sock(sk);
> -=09=09=09return -EINVAL;
> +=09=09=09return PTR_ERR(ssock);
>  =09=09}
> =20
>  =09=09ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen=
);
> @@ -396,9 +396,9 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk=
, int optname,
>  =09case IPV6_FREEBIND:
>  =09=09lock_sock(sk);
>  =09=09ssock =3D __mptcp_nmpc_socket(msk);
> -=09=09if (!ssock) {
> +=09=09if (IS_ERR(ssock)) {
>  =09=09=09release_sock(sk);
> -=09=09=09return -EINVAL;
> +=09=09=09return PTR_ERR(ssock);
>  =09=09}
> =20
>  =09=09ret =3D tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optle=
n);
> @@ -693,9 +693,9 @@ static int mptcp_setsockopt_sol_ip_set_transparent(st=
ruct mptcp_sock *msk, int o
>  =09lock_sock(sk);
> =20
>  =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (!ssock) {
> +=09if (IS_ERR(ssock)) {
>  =09=09release_sock(sk);
> -=09=09return -EINVAL;
> +=09=09return PTR_ERR(ssock);
>  =09}
> =20
>  =09issk =3D inet_sk(ssock->sk);
> @@ -764,8 +764,8 @@ static int mptcp_setsockopt_first_sf_only(struct mptc=
p_sock *msk, int level, int
> =20
>  =09/* Limit to first subflow, before the connection establishment */
>  =09sock =3D __mptcp_nmpc_socket(msk);
> -=09if (!sock)
> -=09=09return -EINVAL;
> +=09if (IS_ERR(sock))
> +=09=09return PTR_ERR(sock);
> =20
>  =09return tcp_setsockopt(sock->sk, level, optname, optval, optlen);
>  }
> @@ -865,7 +865,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptc=
p_sock *msk, int level, int
>  =09}
> =20
>  =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (!ssock)
> +=09if (IS_ERR(ssock))
>  =09=09goto out;
> =20
>  =09ret =3D tcp_getsockopt(ssock->sk, level, optname, optval, optlen);

Self-nack. While rebasing the LSM/selinux patches on top of this
series, I noticed I actually forgot (ahem ...) to remove the first
subflow initialization from mptcp_init_sock(). The relative low number
of issues found while testing should have warned me...

I'm updating the series and I'll post after some more testings.

Cheers,

Paolo

