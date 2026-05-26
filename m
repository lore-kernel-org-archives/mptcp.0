Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68A3A8741
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765224; cv=none; b=LWuuDj5bZu+/Srd8F9fOs7VkTl8XYNesTqNutyMeHzSBMx6753OuRE99YNdI43Tm5EZ2+PIZHjE7g9cDJm71ZSMWcMyu3iGVO0K0trN4DpTbeYHW7aiNXYuF5P0e42mtDMY/hf8yJYjaChYJwfK9JfHpdsET8cviu3VGswvLRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765224; c=relaxed/simple;
	bh=rBaZO5d3h+mE+NO+JDF7ruFvYN+p52eMF33u8TXqp7c=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Um5UPTfti1U0Q0jiMF5OjpZPXeIMvaqRV2MQqQdqkjCee+WKzFptZ3/XCGCFCCSmdY7BYg7KmXKRYqffN5f+08U/3EUfd/YD8fVoeoXNfXc24rr2lUVs2/d2xLijcmb/R1ZBgPOJFzBPk0a/hyWRb+NkWdcZDrW+y6+c02Ec4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjoQE1p5; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjoQE1p5"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779765221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUjWWI5zuHWWwCPI7/69DBTfIMO4Iw+pILT3vWFw6II=;
	b=ZjoQE1p5f/F7McEL0y/4TtBCHKV3neAQ684vj7SumAaB9WOWWXEV74e1oP+lLP/pMg2T8f
	jzqdy7bAET/+PPL4iAOTB+unGfsmgAxwBNIChA0/pWcPVkQ2xe2rOI3NlkRg2v63nphbZJ
	yF24T8KnJeo3aAxOLbXEvTV1nM9aIlQ=
Date: Tue, 26 May 2026 03:13:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <9c1d28dbc379eff6cc09e9b02a6b77beafcdc4f2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v8 mptcp-next 7/9] mptcp: implemented OoO queue pruning
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Matthieu Baerts" <matttbe@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>
In-Reply-To: <b67f85e91abafcdc87d4b0b8e479f715489ed6f2.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
 <b67f85e91abafcdc87d4b0b8e479f715489ed6f2.1779485511.git.pabeni@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 23, 2026 at 5:43 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20Leverage the hybrid helpers to implement the receive queue and OoO qu=
eue
> collapsing at ingress time when reaching memory bounds.
>=20
>=20If the msk is owned by the user-space at incoming skb time, perform t=
he
> pruning in the release_cb. The prune check is additionally performed
> when the skb reaches the msk-level queues.
>=20
>=20Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v6 -> v7:
>  - fix u64 -> u32 truncation
>=20
>=20v2 -> v3:
>  - deal with unsynced TFO skb at prune time - only possible when prunin=
g
>  in mptcp_over_limit()
>=20
>=20v1 -> v2:
>  - collapse rcv queue, too
>  - deal with MPC map, too
>  - drop left-over sentence in the commit message
>=20
>=20RFC -> v1:
>  - use data_seq only when available
>  - avoid ack_seq lockless access
>  - drop limit on fallback
>  - collapse rcvqueue, too
>  - drop only when pruning is not possible and over rcvbuf * 2
>=20
>=20Note:
>  - sashiko can be confused about fwd memory lifecycle (I can
>  understand that :). Any exceeding amount of fwd allocated memory
>  is always released by the next sk_mem_uncharge() - i.e. fwd memory
>  is not tied to the current skb.
>  - AFAICS KASAN handles bitmap variables in a sane way, and sashiko
>  doesn't know about that
> ---
>  net/mptcp/mib.c | 1 +
>  net/mptcp/mib.h | 1 +
>  net/mptcp/protocol.c | 46 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 45 insertions(+), 3 deletions(-)
>=20
>=20diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index ef65e2df709f..d9bd4f4afcc0 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>  SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
>  SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>  SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
> + SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
>  };
>=20=20
>=20 /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index c84eb853d499..18f35f7e0a2d 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
>  MPTCP_MIB_WINPROBE, /* MPTCP-level zero window probe */
>  MPTCP_MIB_BACKLOGDROP, /* Backlog over memory limit */
>  MPTCP_MIB_RCVPRUNED, /* Dropped due to memory constrains */
> + MPTCP_MIB_OFO_PRUNED, /* MPTCP-level OoO queue pruned */
>  __MPTCP_MIB_MAX
>  };
>=20=20
>=20diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 03d6f8658467..f446e22148b9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -373,6 +373,43 @@ static void mptcp_init_skb(struct sock *ssk, struc=
t sk_buff *skb, int offset,
>  skb_dst_drop(skb);
>  }
>=20=20
>=20+/* "Inspired" from the TCP version */
> +static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
> +{
> + struct mptcp_sock *msk =3D mptcp_sk(sk);
> + struct rb_node *node, *prev;
> + bool pruned =3D false;
> + u64 mem;
> +
> + if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> + return;
> +
> + node =3D &msk->ooo_last_skb->rbnode;
> +
> + do {
> + struct sk_buff *skb =3D rb_to_skb(node);
> +
> + /* Stop pruning if the incoming skb would land in OoO tail. */
> + if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
> + break;
> +
> + pruned =3D true;
> + prev =3D rb_prev(node);
> + rb_erase(node, &msk->out_of_order_queue);
> + mptcp_drop(sk, skb);
> + msk->ooo_last_skb =3D rb_to_skb(prev);
> +
> + mem =3D (unsigned int)atomic_read(&sk->sk_rmem_alloc);
> + if (mem < sk->sk_rcvbuf)
> + break;
Hi Paolo,

Thanks for the v8. While going through the code, I ran into a
point that I'm not entirely sure about.

TCP=E2=80=98s design uses sk->sk_rcvbuf >> 3 (one eighth of the buffer)
as a goal. It we use sk->sk_rcvbuf here, the loop may break after
deleting just one packet, right? This may fail to free enough space
for the incoming out=E2=80=91of=E2=80=91order packet, leading to repeated=
 pruning
calls and potential packet drops.

Perhaps you intend to resolve the differences between TCP and MPTCP
when refactoring this function later?

Thanks
Gang

> +
> + node =3D prev;
> + } while (node);
> +
> + if (pruned)
> + MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
> +}
> +
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  u64 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_s=
eq;
> @@ -386,9 +423,12 @@ static bool __mptcp_move_skb(struct sock *sk, stru=
ct sk_buff *skb)
>  */
>  if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
>  !__mptcp_check_fallback(msk)) {
> - MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> - mptcp_drop(sk, skb);
> - return false;
> + mptcp_prune_ofo_queue(sk, MPTCP_SKB_CB(skb)->map_seq);
> + if (sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) {
> + MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> + mptcp_drop(sk, skb);
> + return false;
> + }
>  }
>=20=20
>=20 if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
> --=20
>=202.54.0
>
