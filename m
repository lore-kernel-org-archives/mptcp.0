Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D9160
	for <mptcp@lists.linux.dev>; Wed,  8 Feb 2023 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675897663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O01XHApIuc8s9IZ+Ic8AtqyJXHNi8mxT9SJ7SUCwtZI=;
	b=TOg1DqtIak9eE7xs/IqK4xkuldqdW6Qh4xtiolFJ59HQ2t47+oMmCBKOakR6gq1KM7ZZoV
	8k+TKbKRmcScT2ITyBfmRfCOmrOL2hPpiH147fLCmPFi+2LcM1joTI0Wjx2pqb8JbOXbSv
	z90oKNXZPwQiRW0+QXk11wvKpxZ/l+8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-jk1FoB6eOCOd_oZ4zuvXgA-1; Wed, 08 Feb 2023 18:07:42 -0500
X-MC-Unique: jk1FoB6eOCOd_oZ4zuvXgA-1
Received: by mail-qv1-f69.google.com with SMTP id j19-20020a056214033300b0056c11dfb0ddso201659qvu.19
        for <mptcp@lists.linux.dev>; Wed, 08 Feb 2023 15:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKz9ob6sIUEd11AwwxlopQQ8pE6ejPL39pjwY7v2Z20=;
        b=tRo79H6rSRq3KmRJp7AXq0LrG9n19aWcMPbj3boO/4Z0HOzKbR3jZiLL/qjubfUYNy
         C32j6+Hm0ZasVD7Zc6Bh95dCkhJgv3VqzcH6IoQZs8dBU3oJfVKLoeYw/aLBxdAN8OaG
         wrnAGIpnH/en5u2jaGLjsydztwj2CAhKuOscvmSMSffoAXjw1vuw3BhpoRhz8FA0H7VE
         uFuSFaGUW2bi9G8zv5Kf/c1lKlGiDnZSPpVJXTKfBkrUoZtKzERQzrkPslFWyr9jQdq1
         OmpnLm35IUg3H9DUfvFZiZT0f+6wf3rfipWPwZzbUZbHJ8b3wJExAVltSGCm8SGQikXJ
         SSZw==
X-Gm-Message-State: AO0yUKWvcufu7k7so5ByUBW5RjckYCPQT+/HNIMqlHj2lk2EB3sndwCs
	yK/y9hQnUFukiE+4zZYSt9pMPow5nSnF1J3IOHpmTUdSofhFqM5OgAUq9mhVEGbVtJf6AJ5RRvq
	69hYW2HDvRYlHoWkiOBLGDRIB6FjAiHLM9qrKQoPHsbqMCpqlKPLGvc5DcfJjd75omA/klA==
X-Received: by 2002:a0c:e543:0:b0:56c:196f:76e3 with SMTP id n3-20020a0ce543000000b0056c196f76e3mr5609496qvm.0.1675897661620;
        Wed, 08 Feb 2023 15:07:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/NAkzPTCqVF6onyh97HdOMzyRXAiolJGRxzGMBEWvB14w+/x7vWqaEg/y7VTOE4qb0gXNvPg==
X-Received: by 2002:a0c:e543:0:b0:56c:196f:76e3 with SMTP id n3-20020a0ce543000000b0056c196f76e3mr5609456qvm.0.1675897661166;
        Wed, 08 Feb 2023 15:07:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id r129-20020a37a887000000b006cec8001bf4sm131268qke.26.2023.02.08.15.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:07:40 -0800 (PST)
Message-ID: <fbdfec987c845931dda12e6b7aa1f1b581a36a5b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: use the workqueue to destroy
 unaccepted sockets.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Thu, 09 Feb 2023 00:07:38 +0100
In-Reply-To: <b569cbd73ff8fabb04911142f39cd8edb0585bf8.1675892307.git.pabeni@redhat.com>
References: <cover.1675892307.git.pabeni@redhat.com>
	 <b569cbd73ff8fabb04911142f39cd8edb0585bf8.1675892307.git.pabeni@redhat.com>
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

On Wed, 2023-02-08 at 22:44 +0100, Paolo Abeni wrote:
> Christoph reported a UaF while disposing unaccepted MPC
> subflow.
>=20
> We need to properly clean-up all the paired MPTCP-level
> resources and be sure to release the msk last, even when
> the unaccepted subflow is destroyed by the TCP internals
> via inet_child_forget().
>=20
> We can re-use the existing MPTCP_WORK_CLOSE_SUBFLOW infra,
> explicitly checking that for the critical scenario: the
> closed subflow is the MPC one, the msk is not accepted and
> eventually going through full cleanup.
>=20
> With such change, __mptcp_destroy_sock() is always called
> on msk sockets, even on accepted ones. We don't need anymore
> to transiently drop one sk reference at msk clone time.
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 26 +++++++++++++++++---------
>  net/mptcp/protocol.h |  3 ++-
>  net/mptcp/subflow.c  | 11 +++++++++--
>  3 files changed, 28 insertions(+), 12 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 546df81c162f..d7588535bf6d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2444,9 +2444,10 @@ static unsigned int mptcp_sync_mss(struct sock *sk=
, u32 pmtu)
>  =09return 0;
>  }
> =20
> -static void __mptcp_close_subflow(struct mptcp_sock *msk)
> +static void __mptcp_close_subflow(struct sock *sk)
>  {
>  =09struct mptcp_subflow_context *subflow, *tmp;
> +=09struct mptcp_sock *msk =3D mptcp_sk(sk);
> =20
>  =09might_sleep();
> =20
> @@ -2460,7 +2461,15 @@ static void __mptcp_close_subflow(struct mptcp_soc=
k *msk)
>  =09=09if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>  =09=09=09continue;
> =20
> -=09=09mptcp_close_ssk((struct sock *)msk, ssk, subflow);
> +=09=09mptcp_close_ssk(sk, ssk, subflow);
> +=09}
> +
> +=09/* if the MPC subflow has been closed before the msk is accepted,
> +=09 * msk will never be accept-ed, close it now
> +=09 */
> +=09if (!msk->first && msk->in_accept_queue) {
> +=09=09sock_set_flag(sk, SOCK_DEAD);
> +=09=09sk->sk_state =3D TCP_CLOSE;
>  =09}
>  }
> =20
> @@ -2684,6 +2693,9 @@ static void mptcp_worker(struct work_struct *work)
>  =09__mptcp_check_send_data_fin(sk);
>  =09mptcp_check_data_fin(sk);
> =20
> +=09if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> +=09=09__mptcp_close_subflow(sk);
> +
>  =09/* There is no point in keeping around an orphaned sk timedout or
>  =09 * closed, but we need the msk around to reply to incoming DATA_FIN,
>  =09 * even if it is orphaned and in FIN_WAIT2 state
> @@ -2699,9 +2711,6 @@ static void mptcp_worker(struct work_struct *work)
>  =09=09}
>  =09}
> =20
> -=09if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> -=09=09__mptcp_close_subflow(msk);
> -
>  =09if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>  =09=09__mptcp_retrans(sk);
> =20
> @@ -3149,6 +3158,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  =09msk->local_key =3D subflow_req->local_key;
>  =09msk->token =3D subflow_req->token;
>  =09msk->subflow =3D NULL;
> +=09msk->in_accept_queue =3D 1;
>  =09WRITE_ONCE(msk->fully_established, false);
>  =09if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
>  =09=09WRITE_ONCE(msk->csum_enabled, true);
> @@ -3169,8 +3179,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  =09security_inet_csk_clone(nsk, req);
>  =09bh_unlock_sock(nsk);
> =20
> -=09/* keep a single reference */
> -=09__sock_put(nsk);
> +=09/* note: the newly allocated socket refcount is 2 now */
>  =09return nsk;
>  }
> =20
> @@ -3226,8 +3235,6 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
>  =09=09=09goto out;
>  =09=09}
> =20
> -=09=09/* acquire the 2nd reference for the owning socket */
> -=09=09sock_hold(new_mptcp_sock);
>  =09=09newsk =3D new_mptcp_sock;
>  =09=09MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
>  =09} else {
> @@ -3781,6 +3788,7 @@ static int mptcp_stream_accept(struct socket *sock,=
 struct socket *newsock,
>  =09=09struct mptcp_subflow_context *subflow;
> =20
>  =09=09set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
> +=09=09msk->in_accept_queue =3D 0;
> =20
>  =09=09/* set ssk->sk_socket of accept()ed flows to mptcp socket.
>  =09=09 * This is needed so NOSPACE flag can be set from tcp stack.
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3a055438c65e..252f050c96c6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -294,7 +294,8 @@ struct mptcp_sock {
>  =09u8=09=09recvmsg_inq:1,
>  =09=09=09cork:1,
>  =09=09=09nodelay:1,
> -=09=09=09fastopening:1;
> +=09=09=09fastopening:1,
> +=09=09=09in_accept_queue:1;
>  =09int=09=09connect_flags;
>  =09struct work_struct work;
>  =09struct sk_buff  *ooo_last_skb;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f075607adad4..1dff2ea6d6d3 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -693,9 +693,10 @@ static bool subflow_hmac_valid(const struct request_=
sock *req,
> =20
>  static void mptcp_force_close(struct sock *sk)
>  {
> -=09/* the msk is not yet exposed to user-space */
> +=09/* the msk is not yet exposed to user-space, and refcount is 2 */
>  =09inet_sk_state_store(sk, TCP_CLOSE);
>  =09sk_common_release(sk);
> +=09sock_put(sk);
>  }
> =20
>  static void subflow_ulp_fallback(struct sock *sk,
> @@ -1854,7 +1855,6 @@ void mptcp_subflow_queue_clean(struct sock *listene=
r_sk, struct sock *listener_s
>  =09=09struct sock *sk =3D (struct sock *)msk;
>  =09=09bool do_cancel_work;
> =20
> -=09=09sock_hold(sk);
>  =09=09lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  =09=09next =3D msk->dl_next;
>  =09=09msk->dl_next =3D NULL;
> @@ -1949,6 +1949,13 @@ static void subflow_ulp_release(struct sock *ssk)
>  =09=09 * the ctx alive, will be freed by __mptcp_close_ssk()
>  =09=09 */
>  =09=09release =3D ctx->disposable;
> +
> +=09=09/* inet_child_forget() does not call sk_state_change(),
> +=09=09 * explicitly trigger the socket close machinery
> +=09=09 */
> +=09=09if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
> +=09=09=09=09=09=09  &mptcp_sk(sk)->flags))
> +=09=09=09schedule_work(&mptcp_sk(sk)->work);

The above is buggy. Instead of=C2=A0
=09=09=09schedule_work(&mptcp_sk(sk)->work);
should be
=09=09=09mptcp_schedule_work(sk);

@Christoph: could you add the above editing while testing, or do you
prefer I'll send a the full series edited?

Thanks!

Paolo

