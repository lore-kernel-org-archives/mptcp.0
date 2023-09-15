Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516BD534
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694769426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elbyOWNc4ybdN3S/qq8icElyr22uEmCQSMSsIyxBi/U=;
	b=fQFWX/hMJeAlSWfQ13L7ZOl5QJ3Ted7E2iZep+9JQ0ETn0NE96YKkA7ko9x3yz7sa1G+4R
	J/aZKagGu6OLJPPlbZP3K6HjvI8EsOgFgJYNKSshavVkhLRUottll8ooJ+2BUvGG5M8EXM
	LX6HqFXj3zkvt204saz24NS7/zsAnJg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-zGHfzRbwPmWaPdfEpRhNUQ-1; Fri, 15 Sep 2023 05:17:04 -0400
X-MC-Unique: zGHfzRbwPmWaPdfEpRhNUQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-502e40acb78so423158e87.0
        for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 02:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769422; x=1695374222;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9QWX+0zzK4X9dogLW8MAPRNhJBpaPbVVllmiReHvc0=;
        b=wbEkLas5GNWge/EbIqPqSkvo6vRuebwZ/0Vo+MBORymfWMc4vIGJc20w9J2r2Vqs9/
         FRcibUnmOPeMR2NgWz2gRZbwlHUierKMkflxifEZKst/WxGqZaDuYretaWyWnuKd4tNv
         wxdoCNdD9o8DdR++eADCKbB+mI707Sx7oeZhA+fE6CrmDH6V9QVJyOCxFfwNjpX5tohh
         9imyQh/slcrIDoePRnQ6S/WtqNte6ZSSIC0L2X0qf3AWquQJ5Xvv619+ybslH8GxTqUj
         cCeWDuUpCTmzMQ2qvAAam3aBehpt+A2nZesoBFH8s0ZkeUxGceb1BgOfHdvg/IV7iEHS
         Y/3Q==
X-Gm-Message-State: AOJu0YxR9vsTqkH7XQZAeWLLtiM5u5Un3PwWs7v9jJj0kZeiXxLa3lcp
	26rjvzRn1MT1qeURtXC50ne0VuYEp3zWhDoADphlCDerKiy4yxac+gJnNstxVPQ/hN0eONebsEq
	VHQ434EvJv0pb333NVTb/Pde31lKiOAvrHURgTXqRyeOY2dWrIZ8ItVwlofG6EA+ORozAVcPD
X-Received: by 2002:a19:7617:0:b0:502:9b9a:195c with SMTP id c23-20020a197617000000b005029b9a195cmr853329lff.2.1694769422407;
        Fri, 15 Sep 2023 02:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLqTqtp8XHIGMeevVHjDY1iQqlWrhjVBjQB73HnBeN5cp8RV3suxt4nNNEFpGx9T9/2HDpQA==
X-Received: by 2002:a19:7617:0:b0:502:9b9a:195c with SMTP id c23-20020a197617000000b005029b9a195cmr853318lff.2.1694769421888;
        Fri, 15 Sep 2023 02:17:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-255-248.dyn.eolo.it. [146.241.255.248])
        by smtp.gmail.com with ESMTPSA id bq14-20020a170906d0ce00b0099ddc81903asm2124893ejb.221.2023.09.15.02.17.01
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:17:01 -0700 (PDT)
Message-ID: <b180377d752584020e9c46c939c4ea200d8d1d4e.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: refactor sndbuf auto-tuning.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 15 Sep 2023 11:17:00 +0200
In-Reply-To: <91b50314a17d427087f718d4b77aa23dd07fcde4.1694710538.git.pabeni@redhat.com>
References: <cover.1694710538.git.pabeni@redhat.com>
	 <91b50314a17d427087f718d4b77aa23dd07fcde4.1694710538.git.pabeni@redhat.com>
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

On Thu, 2023-09-14 at 19:02 +0200, Paolo Abeni wrote:
> The MPTCP protocol account for the data enqueued on all the subflows
> to the main socket send buffer, while the send buffer auto-tuning
> algorithm set the main socket send buffer size as the max size among
> the subflows.
>=20
> That causes bad performances when at least one subflow is sndbuf
> limited, e.g. due to very high latency, as the MPTCP scheduler can't
> even fill such buffer.
>=20
> Change the send-buffer auto-tuning algorithm to compute the main socket
> send buffer size as the sum of all the subflows buffer size.
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 25 ++++++++++++++++++++++++-
>  net/mptcp/protocol.h | 32 +++++++++++++++++++++++++++-----
>  net/mptcp/subflow.c  |  3 +--
>  3 files changed, 52 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3a905c122306..180755c8c4d1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -891,6 +891,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *ms=
k, struct sock *ssk)
>  =09mptcp_sockopt_sync_locked(msk, ssk);
>  =09mptcp_subflow_joined(msk, ssk);
>  =09mptcp_stop_tout_timer(sk);
> +=09__mptcp_propagate_sndbuf(sk, ssk);
>  =09return true;
>  }
> =20
> @@ -2403,6 +2404,7 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  =09=09 * disconnect should never fail
>  =09=09 */
>  =09=09WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> +=09=09__mptcp_propagate_sndbuf(sk, ssk);
>  =09=09mptcp_subflow_ctx_reset(subflow);
>  =09=09release_sock(ssk);
> =20
> @@ -2427,6 +2429,7 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  =09}
> =20
>  out_release:
> +=09__mptcp_update_sndbuf(sk, -subflow->cached_sndbuf);
>  =09__mptcp_subflow_error_report(sk, ssk);
>  =09release_sock(ssk);
> =20
> @@ -3214,7 +3217,7 @@ struct sock *mptcp_sk_clone_init(const struct sock =
*sk,
>  =09 * uses the correct data
>  =09 */
>  =09mptcp_copy_inaddrs(nsk, ssk);
> -=09mptcp_propagate_sndbuf(nsk, ssk);
> +=09__mptcp_propagate_sndbuf(nsk, ssk);
> =20
>  =09mptcp_rcv_space_init(msk, ssk);
>  =09bh_unlock_sock(nsk);
> @@ -3339,6 +3342,14 @@ void __mptcp_check_push(struct sock *sk, struct so=
ck *ssk)
>  =09=09__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
>  }
> =20
> +static void __mptcp_tune_sndbuf(struct sock *sk)
> +{
> +=09struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +=09__mptcp_update_sndbuf(sk, msk->delta_sndbuf);
> +=09msk->delta_sndbuf =3D 0;
> +}
> +
>  #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
>  =09=09=09=09      BIT(MPTCP_RETRANSMIT) | \
>  =09=09=09=09      BIT(MPTCP_FLUSH_JOIN_LIST))
> @@ -3392,6 +3403,8 @@ static void mptcp_release_cb(struct sock *sk)
>  =09=09=09__mptcp_set_connected(sk);
>  =09=09if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
>  =09=09=09__mptcp_error_report(sk);
> +=09=09if (__test_and_clear_bit(MPTCP_TUNE_SNDBUF, &msk->cb_flags))
> +=09=09=09__mptcp_tune_sndbuf(sk);
>  =09}
> =20
>  =09__mptcp_update_rmem(sk);
> @@ -3437,6 +3450,15 @@ void mptcp_subflow_process_delegated(struct sock *=
ssk)
>  =09=09mptcp_data_unlock(sk);
>  =09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
>  =09}
> +=09if (test_bit(MPTCP_DELEGATE_SNDBUF, &subflow->delegated_status)) {
> +=09=09mptcp_data_lock(sk);
> +=09=09if (!sock_owned_by_user(sk))
> +=09=09=09__mptcp_propagate_sndbuf(sk, ssk);
> +=09=09else
> +=09=09=09__set_bit(MPTCP_TUNE_SNDBUF, &mptcp_sk(sk)->cb_flags);
> +=09=09mptcp_data_unlock(sk);
> +=09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SNDBUF);
> +=09}
>  =09if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
>  =09=09schedule_3rdack_retransmission(ssk);
>  =09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
> @@ -3523,6 +3545,7 @@ bool mptcp_finish_join(struct sock *ssk)
>  =09/* active subflow, already present inside the conn_list */
>  =09if (!list_empty(&subflow->node)) {
>  =09=09mptcp_subflow_joined(msk, ssk);
> +=09=09mptcp_propagate_sndbuf(parent, ssk);
>  =09=09return true;
>  =09}
> =20
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index aebc0cc24dad..02fb8b22c4ee 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -123,6 +123,7 @@
>  #define MPTCP_RETRANSMIT=094
>  #define MPTCP_FLUSH_JOIN_LIST=095
>  #define MPTCP_CONNECTED=09=096
> +#define MPTCP_TUNE_SNDBUF=097
> =20
>  struct mptcp_skb_cb {
>  =09u64 map_seq;
> @@ -320,6 +321,7 @@ struct mptcp_sock {
>  =09=09u64=09rtt_us; /* last maximum rtt of subflows */
>  =09} rcvq_space;
>  =09u8=09=09scaling_ratio;
> +=09int=09=09delta_sndbuf;
> =20
>  =09u32=09=09subflow_id;
>  =09u32=09=09setsockopt_seq;
> @@ -446,6 +448,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_=
delegated_actions);
> =20
>  #define MPTCP_DELEGATE_SEND=09=090
>  #define MPTCP_DELEGATE_ACK=09=091
> +#define MPTCP_DELEGATE_SNDBUF=09=092
> =20
>  /* MPTCP subflow context */
>  struct mptcp_subflow_context {
> @@ -518,6 +521,7 @@ struct mptcp_subflow_context {
> =20
>  =09u32=09setsockopt_seq;
>  =09u32=09stale_rcv_tstamp;
> +=09int     cached_sndbuf;
> =20
>  =09struct=09sock *tcp_sock;=09    /* tcp sk backpointer */
>  =09struct=09sock *conn;=09    /* parent mptcp_sock */
> @@ -780,13 +784,31 @@ static inline bool mptcp_data_fin_enabled(const str=
uct mptcp_sock *msk)
>  =09       READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
>  }
> =20
> -static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *=
ssk)
> +static inline void __mptcp_update_sndbuf(struct sock *sk, int delta)
>  {
> -=09if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <=3D READ=
_ONCE(sk->sk_sndbuf))
> -=09=09return false;
> +=09if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) && delta)
> +=09=09WRITE_ONCE(sk->sk_sndbuf, sk->sk_sndbuf + delta);
> +}
> +
> +static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct sock=
 *ssk)
> +{
> +=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +=09int ssk_sndbuf =3D READ_ONCE(ssk->sk_sndbuf);
> +
> +=09__mptcp_update_sndbuf(sk, ssk_sndbuf - subflow->cached_sndbuf);
> +=09subflow->cached_sndbuf =3D ssk_sndbuf;
> +}
> +
> +static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *=
ssk)
> +{
> +=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +
> +=09if (likely(READ_ONCE(ssk->sk_sndbuf) =3D=3D subflow->cached_sndbuf))
> +=09=09return;
> =20
> -=09WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
> -=09return true;
> +=09local_bh_disable();
> +=09mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SNDBUF);
> +=09local_bh_enable();

I guess the above deserve a little more explainations/comments on how
the whole schema actually works. I'll add the in the next revision.

Additionally I need to update cached_sndbuf in
mptcp_enter_memory_pressure().

Cheers,

Paolo

