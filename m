Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0F3CCE7
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695239177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsBokOW4qhFUz3fSdNCr5GMIo1GABgPQweh4L8fiJZk=;
	b=Uf1ovNkg05sKOGUuf7W8fxjPIkzdGJbTITr5LyhewqSdORjgYfwgbndjPgLhZ3EGGrlZJw
	9TuGUR+RxCsGDmW0V50iQMdV8lhXAwVTfQMUxabdsiAIp3RXDWqgd+17E9HdB6TYqDiq3I
	LS3DwKjK32GJAs5GF7Kk8GLL4F1NOHc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-aob7V9moPxmN1xYffUDypw-1; Wed, 20 Sep 2023 15:46:15 -0400
X-MC-Unique: aob7V9moPxmN1xYffUDypw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401b91039b4so647175e9.0
        for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239174; x=1695843974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tDjuURjkwMNguzTqEc5tWn8OKpRx7rZTB56H5Gz6d0=;
        b=eVtOChn9HtaKlZx35QhUJ/k3OCsc0H9Nd9uncIPzd8bH9HfyN5NN44HzEfdOZBXh0W
         b0IYGIEfVyQNg0N86TGoMkttLOemmj1aWgl3dEjjyBtW9At95guHu6gMUFHmp6NmEA8l
         qbSGovPm3HuSLWR/pUR/dcOYJVqrpg8wm1U0zyPf0GjRXgK8YsY1fQSRMoSCrUZRX/IV
         IN+cGeNHBVB7nIn4oUOfpMbeopsWY/acMyCImE5iQ6M5tIpEAZ11b2L7Tiy1XAVOBCgm
         TORjq8PHrS5643gO85tPe83o6/u8CRlspeXztuldEJEG7k6nNL1Sne927mBP9C58/ANk
         TTDA==
X-Gm-Message-State: AOJu0Yx9e7wSQGCJMBaBoibN7JD3DNzQHEkgSBCqhffJVQ4wsAxrM0Eo
	qo4Eb5emQ2WZqGTKtx9YoJmpM1eNxdZP3n8/yi+yZdivTCsLNedp/wsC2m9IdMClQfoKBzfEeZq
	Rha/BzOv6UX1rFQJ33O9CBdUBPwvBcXBiGhnMlgm+kG37ctdeequCpcIR8jKLURQHHpmZP1re
X-Received: by 2002:a5d:6902:0:b0:31a:ed75:75d4 with SMTP id t2-20020a5d6902000000b0031aed7575d4mr3116943wru.2.1695239173878;
        Wed, 20 Sep 2023 12:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2GfsjQ65BTf9CjncqU8e61S0BaxPBMg3lRLou5hZosAmEGEsaKBElFaMp35VhdjK1Z9pj2w==
X-Received: by 2002:a5d:6902:0:b0:31a:ed75:75d4 with SMTP id t2-20020a5d6902000000b0031aed7575d4mr3116920wru.2.1695239173348;
        Wed, 20 Sep 2023 12:46:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-127-187.dyn.eolo.it. [146.241.127.187])
        by smtp.gmail.com with ESMTPSA id j3-20020a056000124300b0031fb91f23e9sm19531905wrx.43.2023.09.20.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:46:12 -0700 (PDT)
Message-ID: <e0b969bcbf3839acd1a866128ba3b3b52a88b21d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 1/4] mptcp: fix delegated action races.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Wed, 20 Sep 2023 21:46:11 +0200
In-Reply-To: <93a4a1fde9b8b8e1a723ae8c2938954af9388eb5.1695200723.git.pabeni@redhat.com>
References: <cover.1695200723.git.pabeni@redhat.com>
	 <93a4a1fde9b8b8e1a723ae8c2938954af9388eb5.1695200723.git.pabeni@redhat.com>
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

On Wed, 2023-09-20 at 11:09 +0200, Paolo Abeni wrote:
> The delegated action infrastructure is prone to the following
> race: different CPUs can try to schedule different delegated
> actions on the same subflow at the same time.
>=20
> Each of them will check different bits via mptcp_subflow_delegate(),
> and will try to schedule the action on the related per-cpu napi
> instance.
>=20
> Depending on the timing, both can observe an empty delegated list
> node, causing the same entry to be added simultaneously on two different
> lists.
>=20
> The root cause is that the delegated actions infra does not provide
> a single synchronization point. Address the issue reserving an additional
> bit to mark the subflow as scheduled for delegation. Acquiring such bit
> guarantee the caller to own the delegated list node, and being able to
> safely schedule the subflow.
>=20
> Clear such bit only when the subflow scheduling is completed, ensuring
> proper barrier in place.
>=20
> Additionally swap the meaning of the delegated_action bitmask, to allow
> the usage of the existing helper to set multiple bit at once.

I just noted this last paragraph is obsolete - it refers to a previous,
never shared, revision of this patch.

Should be dropped at merge time.

>=20
> Fixes: bcd97734318d ("mptcp: use delegate action to schedule 3rd ack retr=
ans")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 28 ++++++++++++++--------------
>  net/mptcp/protocol.h | 35 ++++++++++++-----------------------
>  net/mptcp/subflow.c  |  6 ++++--
>  3 files changed, 30 insertions(+), 39 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1a0b463f8c97..04eda1b8f7a4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3425,24 +3425,21 @@ static void schedule_3rdack_retransmission(struct=
 sock *ssk)
>  =09sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
>  }
> =20
> -void mptcp_subflow_process_delegated(struct sock *ssk)
> +void mptcp_subflow_process_delegated(struct sock *ssk, long status)
>  {
>  =09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  =09struct sock *sk =3D subflow->conn;
> =20
> -=09if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
> +=09if (status & BIT(MPTCP_DELEGATE_SEND)) {
>  =09=09mptcp_data_lock(sk);
>  =09=09if (!sock_owned_by_user(sk))
>  =09=09=09__mptcp_subflow_push_pending(sk, ssk, true);
>  =09=09else
>  =09=09=09__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
>  =09=09mptcp_data_unlock(sk);
> -=09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
>  =09}
> -=09if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
> +=09if (status & BIT(MPTCP_DELEGATE_ACK))
>  =09=09schedule_3rdack_retransmission(ssk);
> -=09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
> -=09}
>  }
> =20
>  static int mptcp_hash(struct sock *sk)
> @@ -3968,14 +3965,17 @@ static int mptcp_napi_poll(struct napi_struct *na=
pi, int budget)
>  =09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> =20
>  =09=09bh_lock_sock_nested(ssk);
> -=09=09if (!sock_owned_by_user(ssk) &&
> -=09=09    mptcp_subflow_has_delegated_action(subflow))
> -=09=09=09mptcp_subflow_process_delegated(ssk);
> -=09=09/* ... elsewhere tcp_release_cb_override already processed
> -=09=09 * the action or will do at next release_sock().
> -=09=09 * In both case must dequeue the subflow here - on the same
> -=09=09 * CPU that scheduled it.
> -=09=09 */
> +=09=09if (!sock_owned_by_user(ssk)) {
> +=09=09=09mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_s=
tatus, 0));
> +=09=09} else {
> +=09=09=09/* tcp_release_cb_override already processed
> +=09=09=09 * the action or will do at next release_sock().
> +=09=09=09 * In both case must dequeue the subflow here - on the same
> +=09=09=09 * CPU that scheduled it.
> +=09=09=09 */
> +=09=09=09smp_wmb();
> +=09=09=09clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status)=
;
> +=09=09}
>  =09=09bh_unlock_sock(ssk);
>  =09=09sock_put(ssk);
> =20
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3c938e3560e4..7c7ad087d8ac 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -444,9 +444,11 @@ struct mptcp_delegated_action {
> =20
>  DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> =20
> -#define MPTCP_DELEGATE_SEND=09=090
> -#define MPTCP_DELEGATE_ACK=09=091
> +#define MPTCP_DELEGATE_SCHEDULED=090
> +#define MPTCP_DELEGATE_SEND=09=091
> +#define MPTCP_DELEGATE_ACK=09=092
> =20
> +#define MPTCP_DELEGATE_ACTIONS_MASK=09(~BIT(MPTCP_DELEGATE_SCHEDULED))
>  /* MPTCP subflow context */
>  struct mptcp_subflow_context {
>  =09struct=09list_head node;/* conn_list of subflows */
> @@ -564,23 +566,24 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_sub=
flow_context *subflow)
>  =09return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
>  }
> =20
> -void mptcp_subflow_process_delegated(struct sock *ssk);
> +void mptcp_subflow_process_delegated(struct sock *ssk, long actions);
> =20
>  static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *=
subflow, int action)
>  {
> +=09long old, mask =3D BIT(MPTCP_DELEGATE_SCHEDULED) | BIT(action);
>  =09struct mptcp_delegated_action *delegated;
>  =09bool schedule;
> =20
>  =09/* the caller held the subflow bh socket lock */
>  =09lockdep_assert_in_softirq();
> =20
> -=09/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
> -=09 * ensures the below list check sees list updates done prior to statu=
s
> -=09 * bit changes
> +=09/* The implied barrier pairs with tcp_release_cb_override()
> +=09 * mptcp_napi_poll(), and ensures the below list check sees list
> +=09 * updates done prior to delegated status bits changes
>  =09 */
> -=09if (!test_and_set_bit(action, &subflow->delegated_status)) {
> -=09=09/* still on delegated list from previous scheduling */
> -=09=09if (!list_empty(&subflow->delegated_node))
> +=09old =3D set_mask_bits(&subflow->delegated_status, 0, mask);
> +=09if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED))) {
> +=09=09if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
>  =09=09=09return;
> =20
>  =09=09delegated =3D this_cpu_ptr(&mptcp_delegated_actions);
> @@ -605,20 +608,6 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_=
action *delegated)
>  =09return ret;
>  }
> =20
> -static inline bool mptcp_subflow_has_delegated_action(const struct mptcp=
_subflow_context *subflow)
> -{
> -=09return !!READ_ONCE(subflow->delegated_status);
> -}
> -
> -static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_con=
text *subflow, int action)
> -{
> -=09/* pairs with mptcp_subflow_delegate, ensures delegate_node is update=
d before
> -=09 * touching the status bit
> -=09 */
> -=09smp_wmb();
> -=09clear_bit(action, &subflow->delegated_status);
> -}
> -
>  int mptcp_is_enabled(const struct net *net);
>  unsigned int mptcp_get_add_addr_timeout(const struct net *net);
>  int mptcp_is_checksum_enabled(const struct net *net);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 918c1a235790..0d860cb730b4 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1956,9 +1956,11 @@ static void subflow_ulp_clone(const struct request=
_sock *req,
>  static void tcp_release_cb_override(struct sock *ssk)
>  {
>  =09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +=09long status;
> =20
> -=09if (mptcp_subflow_has_delegated_action(subflow))
> -=09=09mptcp_subflow_process_delegated(ssk);
> +=09status =3D set_mask_bits(&subflow->delegated_status, MPTCP_DELEGATE_A=
CTIONS_MASK, 0);
> +=09if (status)
> +=09=09mptcp_subflow_process_delegated(ssk, status);
> =20
>  =09tcp_release_cb(ssk);
>  }

