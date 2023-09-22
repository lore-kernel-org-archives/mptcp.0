Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023C442D
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 06:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695364922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuq9Qc6e79mqwULZ+hePlcrV55PVEwabFdehN6gRpo=;
	b=W85RWa0vLDeQR8SVtvZYIj+7ZvFQeFpHrjeeDxopbYBAKB2mdb2sHQ/nhAnDRyf2fBY10W
	fWXlhou9rhbH3aCkRGPCyCNF2rE2UBbl7k4n8x3R+3h2tRzRTPEEtGVYRyf9GNPaxQZa7P
	vI26XhOwecEJyoWPxsuovB6QQJoj3jg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-fbPRY9UCN46JYj3fUmAi9Q-1; Fri, 22 Sep 2023 02:42:01 -0400
X-MC-Unique: fbPRY9UCN46JYj3fUmAi9Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b04d5ed394so3879131fa.1
        for <mptcp@lists.linux.dev>; Thu, 21 Sep 2023 23:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695364919; x=1695969719;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/27atGIR1LCaOYSrb6wNFOvOU3m8mAfAf4s3uQuIvX4=;
        b=BX5uUI+fi0VaSXSv8PDRc5cwjH5s0uK3XqpdCWR2NA0H0988ILgx6UtSXG+VADpR5I
         USBYrvv37Hw/eAUj71lz/mhcfK6KP2qqGQ4GZ3GgQCaodMMFlJqAgQEhCdTWM6zD+pBE
         UG3WSh9iechoIcTrRCPxRqPsnEujjm5ku4SmLikWhQFcIlPKCbXALYUKBbtnOLvjxXON
         M3o8i7BGLwrEuo9HgrgZ4p66TqRRazLniZ+ULW9QjEH97sXcPAogvzJCHZkeOjT8Z4qN
         MIAKzyKTwn43MT0AlQnZdoxmRGnAqAz/xUe2+/6Yn7jjpbXpICuJ6CymV6tmAKP2dPU9
         2oXQ==
X-Gm-Message-State: AOJu0YwKoes8KlIhc76H7SXZA0opxIiwteCLnEvj6bxMkF/r3q6rub1J
	0isHQjUltm3a499efamFbvZCJoD+pbyPU/mqH0WLepZEY0//JF/f2e4tdtVO87vwJcq+VloBRes
	Mycohnd6iV4k4aR0=
X-Received: by 2002:a2e:b947:0:b0:2bf:e5dc:aa68 with SMTP id 7-20020a2eb947000000b002bfe5dcaa68mr6308665ljs.3.1695364919431;
        Thu, 21 Sep 2023 23:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmoEYI1Xr1EDgncy+/G9ngtDAW7kNnaHx4zl6n1eHkGjgPsilOvdNXqGqGUgAeHVvEGrjUwg==
X-Received: by 2002:a2e:b947:0:b0:2bf:e5dc:aa68 with SMTP id 7-20020a2eb947000000b002bfe5dcaa68mr6308656ljs.3.1695364918929;
        Thu, 21 Sep 2023 23:41:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090685c800b009ad7fc17b2asm2218470ejy.224.2023.09.21.23.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:41:58 -0700 (PDT)
Message-ID: <c0c95797d0c323fc7ba98d2cc96e0a7743848f7d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 1/4] mptcp: fix delegated action races.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Date: Fri, 22 Sep 2023 08:41:57 +0200
In-Reply-To: <c2229739-1a72-e19e-9014-25a6d1055ced@kernel.org>
References: <cover.1695200723.git.pabeni@redhat.com>
	 <93a4a1fde9b8b8e1a723ae8c2938954af9388eb5.1695200723.git.pabeni@redhat.com>
	 <c2229739-1a72-e19e-9014-25a6d1055ced@kernel.org>
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

On Thu, 2023-09-21 at 16:42 -0700, Mat Martineau wrote:
> On Wed, 20 Sep 2023, Paolo Abeni wrote:
>=20
> > The delegated action infrastructure is prone to the following
> > race: different CPUs can try to schedule different delegated
> > actions on the same subflow at the same time.
> >=20
> > Each of them will check different bits via mptcp_subflow_delegate(),
> > and will try to schedule the action on the related per-cpu napi
> > instance.
> >=20
> > Depending on the timing, both can observe an empty delegated list
> > node, causing the same entry to be added simultaneously on two differen=
t
> > lists.
> >=20
> > The root cause is that the delegated actions infra does not provide
> > a single synchronization point. Address the issue reserving an addition=
al
> > bit to mark the subflow as scheduled for delegation. Acquiring such bit
> > guarantee the caller to own the delegated list node, and being able to
> > safely schedule the subflow.
> >=20
> > Clear such bit only when the subflow scheduling is completed, ensuring
> > proper barrier in place.
> >=20
> > Additionally swap the meaning of the delegated_action bitmask, to allow
> > the usage of the existing helper to set multiple bit at once.
> >=20
> > Fixes: bcd97734318d ("mptcp: use delegate action to schedule 3rd ack re=
trans")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 28 ++++++++++++++--------------
> > net/mptcp/protocol.h | 35 ++++++++++++-----------------------
> > net/mptcp/subflow.c  |  6 ++++--
> > 3 files changed, 30 insertions(+), 39 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1a0b463f8c97..04eda1b8f7a4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3425,24 +3425,21 @@ static void schedule_3rdack_retransmission(stru=
ct sock *ssk)
> > =09sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
> > }
> >=20
> > -void mptcp_subflow_process_delegated(struct sock *ssk)
> > +void mptcp_subflow_process_delegated(struct sock *ssk, long status)
> > {
> > =09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > =09struct sock *sk =3D subflow->conn;
> >=20
> > -=09if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
> > +=09if (status & BIT(MPTCP_DELEGATE_SEND)) {
> > =09=09mptcp_data_lock(sk);
> > =09=09if (!sock_owned_by_user(sk))
> > =09=09=09__mptcp_subflow_push_pending(sk, ssk, true);
> > =09=09else
> > =09=09=09__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> > =09=09mptcp_data_unlock(sk);
> > -=09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
> > =09}
> > -=09if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
> > +=09if (status & BIT(MPTCP_DELEGATE_ACK))
> > =09=09schedule_3rdack_retransmission(ssk);
> > -=09=09mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
> > -=09}
> > }
> >=20
> > static int mptcp_hash(struct sock *sk)
> > @@ -3968,14 +3965,17 @@ static int mptcp_napi_poll(struct napi_struct *=
napi, int budget)
> > =09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >=20
> > =09=09bh_lock_sock_nested(ssk);
> > -=09=09if (!sock_owned_by_user(ssk) &&
> > -=09=09    mptcp_subflow_has_delegated_action(subflow))
> > -=09=09=09mptcp_subflow_process_delegated(ssk);
> > -=09=09/* ... elsewhere tcp_release_cb_override already processed
> > -=09=09 * the action or will do at next release_sock().
> > -=09=09 * In both case must dequeue the subflow here - on the same
> > -=09=09 * CPU that scheduled it.
> > -=09=09 */
> > +=09=09if (!sock_owned_by_user(ssk)) {
> > +=09=09=09mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated=
_status, 0));
> > +=09=09} else {
> > +=09=09=09/* tcp_release_cb_override already processed
> > +=09=09=09 * the action or will do at next release_sock().
> > +=09=09=09 * In both case must dequeue the subflow here - on the same
> > +=09=09=09 * CPU that scheduled it.
> > +=09=09=09 */
> > +=09=09=09smp_wmb();
> > +=09=09=09clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_statu=
s);
> > +=09=09}
> > =09=09bh_unlock_sock(ssk);
> > =09=09sock_put(ssk);
> >=20
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 3c938e3560e4..7c7ad087d8ac 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -444,9 +444,11 @@ struct mptcp_delegated_action {
> >=20
> > DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions)=
;
> >=20
> > -#define MPTCP_DELEGATE_SEND=09=090
> > -#define MPTCP_DELEGATE_ACK=09=091
> > +#define MPTCP_DELEGATE_SCHEDULED=090
> > +#define MPTCP_DELEGATE_SEND=09=091
> > +#define MPTCP_DELEGATE_ACK=09=092
> >=20
> > +#define MPTCP_DELEGATE_ACTIONS_MASK=09(~BIT(MPTCP_DELEGATE_SCHEDULED))
> > /* MPTCP subflow context */
> > struct mptcp_subflow_context {
> > =09struct=09list_head node;/* conn_list of subflows */
> > @@ -564,23 +566,24 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_s=
ubflow_context *subflow)
> > =09return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
> > }
> >=20
> > -void mptcp_subflow_process_delegated(struct sock *ssk);
> > +void mptcp_subflow_process_delegated(struct sock *ssk, long actions);
> >=20
> > static inline void mptcp_subflow_delegate(struct mptcp_subflow_context =
*subflow, int action)
> > {
> > +=09long old, mask =3D BIT(MPTCP_DELEGATE_SCHEDULED) | BIT(action);
> > =09struct mptcp_delegated_action *delegated;
> > =09bool schedule;
> >=20
> > =09/* the caller held the subflow bh socket lock */
> > =09lockdep_assert_in_softirq();
> >=20
> > -=09/* The implied barrier pairs with mptcp_subflow_delegated_done(), a=
nd
> > -=09 * ensures the below list check sees list updates done prior to sta=
tus
> > -=09 * bit changes
> > +=09/* The implied barrier pairs with tcp_release_cb_override()
> > +=09 * mptcp_napi_poll(), and ensures the below list check sees list
> > +=09 * updates done prior to delegated status bits changes
> > =09 */
> > -=09if (!test_and_set_bit(action, &subflow->delegated_status)) {
> > -=09=09/* still on delegated list from previous scheduling */
> > -=09=09if (!list_empty(&subflow->delegated_node))
> > +=09old =3D set_mask_bits(&subflow->delegated_status, 0, mask);
>=20
> Hi Paolo -
>=20
> The naming of the 'mask' variable here made it a little harder to=20
> understand at first glance, as the middle arg of the set_mask_bits macro=
=20
> is the one that does the masking (clearing) of bits. How about 'set_bits'=
=20
> (or similar) instead.

Indeed a better name would help. 'set_bits' is fine by me.

>=20
> > +=09if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED))) {
> > +=09=09if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
> > =09=09=09return;
> >=20
> > =09=09delegated =3D this_cpu_ptr(&mptcp_delegated_actions);
> > @@ -605,20 +608,6 @@ mptcp_subflow_delegated_next(struct mptcp_delegate=
d_action *delegated)
> > =09return ret;
> > }
> >=20
> > -static inline bool mptcp_subflow_has_delegated_action(const struct mpt=
cp_subflow_context *subflow)
> > -{
> > -=09return !!READ_ONCE(subflow->delegated_status);
> > -}
> > -
> > -static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_c=
ontext *subflow, int action)
> > -{
> > -=09/* pairs with mptcp_subflow_delegate, ensures delegate_node is upda=
ted before
> > -=09 * touching the status bit
> > -=09 */
> > -=09smp_wmb();
> > -=09clear_bit(action, &subflow->delegated_status);
> > -}
> > -
> > int mptcp_is_enabled(const struct net *net);
> > unsigned int mptcp_get_add_addr_timeout(const struct net *net);
> > int mptcp_is_checksum_enabled(const struct net *net);
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 918c1a235790..0d860cb730b4 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1956,9 +1956,11 @@ static void subflow_ulp_clone(const struct reque=
st_sock *req,
> > static void tcp_release_cb_override(struct sock *ssk)
> > {
> > =09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +=09long status;
> >=20
> > -=09if (mptcp_subflow_has_delegated_action(subflow))
> > -=09=09mptcp_subflow_process_delegated(ssk);
> > +=09status =3D set_mask_bits(&subflow->delegated_status, MPTCP_DELEGATE=
_ACTIONS_MASK, 0);
>=20
> Can you add a comment here regarding the interaction with=20
> mptcp_napi_poll()?

I'll add something alike:

=09/* process and clear all the pending actions, but leave the=C2=A0
=09 * subflow into the napi queue. To respect locking, =C2=A0
=09 * only the same CPU that originated the action can touch
=09 * the list. mptcp_napi_poll will take care of it.
=09 */


/P

