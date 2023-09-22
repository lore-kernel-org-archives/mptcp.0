Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D810FF
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 06:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695364503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4QHPnsrCaQAQWlnoucpx11FYOUVEqxhQn8M9qKx+Rc=;
	b=UoibB4mM83DFyHYVVWBo6tyKsF9zXr9eIUBCLNJBLVRdiyybdwA4lD3GJTf2Fa4nZHNCt0
	jQw0/ciKxGii1OYHQxIPS4U+jmjdboBNwZ3kkfATY6iAuBrOgBycZj0jzDjxHLA+s9k5U8
	6u46aNhZSBlCouzNymKQ33New/sLbfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-rpzvP1XYMgeyhqMKDIZSNw-1; Fri, 22 Sep 2023 02:35:01 -0400
X-MC-Unique: rpzvP1XYMgeyhqMKDIZSNw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-405004757dfso6188535e9.0
        for <mptcp@lists.linux.dev>; Thu, 21 Sep 2023 23:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695364500; x=1695969300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njTkZeFYAt9RPjHhdtUAM5en7IUCgz94x71xgBRZUaM=;
        b=e5c5HTi0R9xutDsHCUHQoG2p5tqmnkeyUS9wpGc8jSvCJhOjOgGYZcexk+zyDv66so
         nSoHM4r89RNuaBCIdgMLsQqzHHyeIYxb1OTpcj37OHG0Bserwsk5wrhaQfYNMLA6jY+1
         7ErZNP7OrY/hoVRJVdUscwGoxIAiR+O1a95CGfTteCj5a3USFwnAcM8OOMCI86ZPBMrw
         XaXARjruHJC/IYmnYiVOqHcL3CwUEjjXeckwe0XeVXxQMMqJqhVpQmJrjaW1VZSJ3SPP
         zu+t+DpErwlYO0nlAvtBbPyuO2ikmH/4Q85Fo9R9pulH1pWQv3/C9xc0Rx+ploLrSSfa
         d1rQ==
X-Gm-Message-State: AOJu0YztRrXddFxZqKCjFJQKbPVtEVwBCFfpf5vX/8OihqWSSldJ4QtT
	O/MVSkQZe2xoBPFPYbwO2YnVx23wcQb/bsP0JNVWLTfkmt4d8w7MdlNUePBXIzdgagUXPIP/ZmZ
	5IDZ6x3OtDcypU8agG1iPdw7Emg==
X-Received: by 2002:a05:600c:3d87:b0:3ff:8617:672b with SMTP id bi7-20020a05600c3d8700b003ff8617672bmr7010904wmb.2.1695364500058;
        Thu, 21 Sep 2023 23:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFFZhCpkT+jQ0LYakz1eGLWGOuHCaALJQXnaPDXl8cuFJm+zzE7StdKV+wHs+M5lavN0Bl6g==
X-Received: by 2002:a05:600c:3d87:b0:3ff:8617:672b with SMTP id bi7-20020a05600c3d8700b003ff8617672bmr7010890wmb.2.1695364499586;
        Thu, 21 Sep 2023 23:34:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id l18-20020a1c7912000000b003fef3180e7asm6628845wme.44.2023.09.21.23.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:34:59 -0700 (PDT)
Message-ID: <47c6192e7fa540d5df512a28620b3d06d651f225.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 4/4] mptcp: refactor sndbuf auto-tuning.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Date: Fri, 22 Sep 2023 08:34:58 +0200
In-Reply-To: <df729ef3-9745-c59c-a1b2-c89d52809f99@kernel.org>
References: <cover.1695200723.git.pabeni@redhat.com>
	 <5c1ff76635a9a7453d7a315a739c83d71a44536b.1695200723.git.pabeni@redhat.com>
	 <df729ef3-9745-c59c-a1b2-c89d52809f99@kernel.org>
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

On Thu, 2023-09-21 at 16:55 -0700, Mat Martineau wrote:
> On Wed, 20 Sep 2023, Paolo Abeni wrote:
>=20
> > The MPTCP protocol account for the data enqueued on all the subflows
> > to the main socket send buffer, while the send buffer auto-tuning
> > algorithm set the main socket send buffer size as the max size among
> > the subflows.
> >=20
> > That causes bad performances when at least one subflow is sndbuf
> > limited, e.g. due to very high latency, as the MPTCP scheduler can't
> > even fill such buffer.
> >=20
> > Change the send-buffer auto-tuning algorithm to compute the main socket
> > send buffer size as the sum of all the subflows buffer size.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> > - avoid ingremental updates, always recompute sum(ssk->sndbuf) to avoid
> >   drift on memory pressure/decrease
> > ---
> > net/mptcp/protocol.c | 18 +++++++++++++--
> > net/mptcp/protocol.h | 54 ++++++++++++++++++++++++++++++++++++++++----
> > net/mptcp/subflow.c  |  3 +--
> > 3 files changed, 66 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f727a7ee662d..0a9d00e794d4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -891,6 +891,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *=
msk, struct sock *ssk)
> > =09mptcp_sockopt_sync_locked(msk, ssk);
> > =09mptcp_subflow_joined(msk, ssk);
> > =09mptcp_stop_tout_timer(sk);
> > +=09__mptcp_propagate_sndbuf(sk, ssk);
> > =09return true;
> > }
> >=20
> > @@ -1077,15 +1078,16 @@ static void mptcp_enter_memory_pressure(struct =
sock *sk)
> > =09struct mptcp_sock *msk =3D mptcp_sk(sk);
> > =09bool first =3D true;
> >=20
> > -=09sk_stream_moderate_sndbuf(sk);
> > =09mptcp_for_each_subflow(msk, subflow) {
> > =09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >=20
> > =09=09if (first)
> > =09=09=09tcp_enter_memory_pressure(ssk);
> > =09=09sk_stream_moderate_sndbuf(ssk);
> > +
> > =09=09first =3D false;
> > =09}
> > +=09__mptcp_sync_sndbuf(sk);
> > }
> >=20
> > /* ensure we get enough memory for the frag hdr, beyond some minimal am=
ount of
> > @@ -2436,6 +2438,7 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
> > =09=09WRITE_ONCE(msk->first, NULL);
> >=20
> > out:
> > +=09__mptcp_sync_sndbuf(sk);
> > =09if (need_push)
> > =09=09__mptcp_push_pending(sk, 0);
> >=20
> > @@ -3214,7 +3217,7 @@ struct sock *mptcp_sk_clone_init(const struct soc=
k *sk,
> > =09 * uses the correct data
> > =09 */
> > =09mptcp_copy_inaddrs(nsk, ssk);
> > -=09mptcp_propagate_sndbuf(nsk, ssk);
> > +=09__mptcp_propagate_sndbuf(nsk, ssk);
> >=20
> > =09mptcp_rcv_space_init(msk, ssk);
> > =09bh_unlock_sock(nsk);
> > @@ -3392,6 +3395,8 @@ static void mptcp_release_cb(struct sock *sk)
> > =09=09=09__mptcp_set_connected(sk);
> > =09=09if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> > =09=09=09__mptcp_error_report(sk);
> > +=09=09if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
> > +=09=09=09__mptcp_sync_sndbuf(sk);
> > =09}
> >=20
> > =09__mptcp_update_rmem(sk);
> > @@ -3436,6 +3441,14 @@ void mptcp_subflow_process_delegated(struct sock=
 *ssk, long status)
> > =09=09=09__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> > =09=09mptcp_data_unlock(sk);
> > =09}
> > +=09if (status & BIT(MPTCP_DELEGATE_SNDBUF)) {
> > +=09=09mptcp_data_lock(sk);
> > +=09=09if (!sock_owned_by_user(sk))
> > +=09=09=09__mptcp_sync_sndbuf(sk);
> > +=09=09else
> > +=09=09=09__set_bit(MPTCP_SYNC_SNDBUF, &mptcp_sk(sk)->cb_flags);
> > +=09=09mptcp_data_unlock(sk);
> > +=09}
> > =09if (status & BIT(MPTCP_DELEGATE_ACK))
> > =09=09schedule_3rdack_retransmission(ssk);
> > }
> > @@ -3520,6 +3533,7 @@ bool mptcp_finish_join(struct sock *ssk)
> > =09/* active subflow, already present inside the conn_list */
> > =09if (!list_empty(&subflow->node)) {
> > =09=09mptcp_subflow_joined(msk, ssk);
> > +=09=09mptcp_propagate_sndbuf(parent, ssk);
> > =09=09return true;
> > =09}
> >=20
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 7c7ad087d8ac..ab775e48c11d 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -123,6 +123,7 @@
> > #define MPTCP_RETRANSMIT=094
> > #define MPTCP_FLUSH_JOIN_LIST=095
> > #define MPTCP_CONNECTED=09=096
> > +#define MPTCP_SYNC_SNDBUF=097
> >=20
> > struct mptcp_skb_cb {
> > =09u64 map_seq;
> > @@ -447,6 +448,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptc=
p_delegated_actions);
> > #define MPTCP_DELEGATE_SCHEDULED=090
> > #define MPTCP_DELEGATE_SEND=09=091
> > #define MPTCP_DELEGATE_ACK=09=092
> > +#define MPTCP_DELEGATE_SNDBUF=09=093
> >=20
> > #define MPTCP_DELEGATE_ACTIONS_MASK=09(~BIT(MPTCP_DELEGATE_SCHEDULED))
> > /* MPTCP subflow context */
> > @@ -520,6 +522,9 @@ struct mptcp_subflow_context {
> >=20
> > =09u32=09setsockopt_seq;
> > =09u32=09stale_rcv_tstamp;
> > +=09int     cached_sndbuf;=09    /* sndbuf size when last synced with t=
he msk sndbuf,
> > +=09=09=09=09     * protected by the msk socket lock
> > +=09=09=09=09     */
> >=20
> > =09struct=09sock *tcp_sock;=09    /* tcp sk backpointer */
> > =09struct=09sock *conn;=09    /* parent mptcp_sock */
> > @@ -768,13 +773,52 @@ static inline bool mptcp_data_fin_enabled(const s=
truct mptcp_sock *msk)
> > =09       READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
> > }
> >=20
> > -static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock=
 *ssk)
> > +static inline void __mptcp_sync_sndbuf(struct sock *sk)
> > {
> > -=09if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <=3D RE=
AD_ONCE(sk->sk_sndbuf))
> > -=09=09return false;
> > +=09struct mptcp_subflow_context *subflow;
> > +=09int ssk_sndbuf, new_sndbuf;
> > +
> > +=09if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
> > +=09=09return;
> > +
> > +=09new_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
> > +=09mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> > +=09=09ssk_sndbuf =3D  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sn=
dbuf);
> > +
> > +=09=09subflow->cached_sndbuf =3D ssk_sndbuf;
> > +=09=09new_sndbuf +=3D ssk_sndbuf;
> > +=09}
> > +
> > +=09/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
> > +=09WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
> > +}
> > +
> > +/* The called held both the msk socket and the subflow socket locks,
> > + * possibly under BH
> > + */
> > +static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct so=
ck *ssk)
> > +{
> > +=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +
> > +=09if (READ_ONCE(ssk->sk_sndbuf) - subflow->cached_sndbuf)
>=20
> Hi Paolo -
>=20
> How about
>=20
>       if (READ_ONCE(ssk->sk_sndbuf) !=3D subflow->cached_sndbuf)
>=20
> instead?

Yep, better. This is a left-over from previous revisions where I
actually computed the delta.

I will change in v5

/P

