Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972500;
	b=hSurEYjhrvOEDATXWXtktIZKLBzTrNw/HUt81fVhlUAcxeAHbYwppGuNk4dwNa7KUxNY
	 pM7SYGjmKFpA+uBfKRfz1mLLWG3RXwL3OEIZkWk29hxbZMmfs7ArFzfig1XkKyYPkavvh
	 LqKwB+GQk+ojy9NKOWnb8ysh3h3fZCxRdqDIc0rnoTivZg4Pm1Zhu1TSC0RneqSW1QlY6
	 uSDv6gbMfQa70g0PfQwwsMkdpoIS+RCtzdUjsYnlILFGGJh/lnksOqqK0FSE0hd/ESMA3
	 eUyAs/N6+MpnoTKVXwdtxSNuWVetBCkqiS3/UCaSuCdTglksZDx2SMM/mzh60t+V1WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PnSBw+8ySExzRzuX/ef/1ua+7w8PA6EWG6Pz/lygCfk=;
	b=BgkB/h5ABOOHRcHjO/hyPylHxWI6OyRqrSxD+0QHKR8RKyWg3kbq4Hi13GtQFeACuyko
	 fildu/l1zufuhV1y2knLzMMAY8hHzFYQakeky5+cRjiW0efk+8NAJH0RNMOhGg3WLAh8+
	 s1D5d3adUap46gC4e31bQVGI8VESTrdDtDl3gmiAC4TJiFGwHZ2r6jqDZGNMfgsmdx1N7
	 FgYBaI9gNYX9xJd5QodnslywwE2jksxtUelZyAcbS5d/FvcjtRbNSD+cEsvw1vfFtCZK6
	 lIkbkjnkkDHGIujmQ/l30kxTpKpP2TCmtKfHIkUg/WIu3WhiGcU32mdzlt7JiLy4nQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+sG71c5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A4606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+sG71c5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3FD1F008A4;
	Fri,  6 Nov 2026 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972499;
	bh=PnSBw+8ySExzRzuX/ef/1ua+7w8PA6EWG6Pz/lygCfk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l+sG71c51AhBuMtZbxmNOi0br3ihrri+r/5Po8upPQUd85Cfb9wxQQviXkis/gz+N
	 Q0FWSwIY4muFKW9hpjnUAMlNTUYHJ00r3wIlcy1lkXgEpMtOI/o0HWyKeJ/xc25ofL
	 Ig22/nn/j+gXGMLv8q/Z8RmP4yAOMZWZGQAudnskz+LBRVYtfTMZmcXaziRIpJ3MQH
	 OXzKgBEw0lXxpVJ+I1svguZ1ZJuyfK2Jszb478SqQKxG9Tq+mPqGf2JIhkcdxwqKMu
	 1sNBl1f7zOD+CSc26W0X5BMOygKXpe1sBalLQpSnoOiPafKEBgKgTFcv2Nuh2e7sKk
	 RrdD+ezm05Baw==
Message-ID: <sashiko-outbox-201486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v23 6/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <bf2faa4c21a3faf79fece4448402bfd726fbf9e4.1793969127.git.tanggeliang@kylinos.cn>
References: <cover.1793969127.git.tanggeliang@kylinos.cn>
 <bf2faa4c21a3faf79fece4448402bfd726fbf9e4.1793969127.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:41:39 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] mptcp: truesize corruption after pskb_pull() in
  mptcp_init_skb()
- [Medium] mptcp: unpulled skb prefix in mptcp_init_skb() rewinds
  map_seq
--

commit 6d46cc996583689225db9776f596454406aeafdb
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the per-skb MPTCP_SKB_CB(skb)->offset field with an
msk-level copied_seq counter to track consumed receive data across skbs.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a6c4bad0a8b96..f75297c4d6b0d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -415,25 +414,38 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
> =20
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset,
> -			   int copy_len)
> +static bool mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> =20
> +	/* Detect mapping boundary: skb spans multiple mappings */
> +	if (unlikely(offset > 0 &&
> +		     before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
> +			    subflow->map_subflow_seq))) {
> +		if (offset >=3D skb->len || !pskb_pull(skb, offset)) {
> +			WARN_ON_ONCE(1);
> +			sk_eat_skb(ssk, skb);
> +			return false;
> +		}
> +		offset =3D 0;
> +	}

[Severity: High]
Can calling pskb_pull() here corrupt skb->truesize and socket memory
accounting when skb is nonlinear?

At this point skb is still owned by ssk with skb->destructor set to
sock_rfree.  When offset exceeds skb_headlen(skb) and the linear head
lacks tailroom (or skb is cloned), __pskb_pull_tail() calls
pskb_expand_head(), which increases skb_end_offset(skb) without updating
skb->truesize because skb->sk is set:

net/core/skbuff.c:pskb_expand_head() {
	...
	if (!skb->sk || skb->destructor =3D=3D sock_edemux)
		skb->truesize +=3D size - osize;
}

pskb_pull() then advances skb->data to skb->tail, leaving
skb_headlen(skb) =3D=3D 0.  If this skb is later coalesced as the from
buffer in __mptcp_try_coalesce() -> skb_try_coalesce(), the
skb_headlen(from) =3D=3D 0 path computes:

	delta =3D from->truesize - SKB_TRUESIZE(skb_end_offset(from));

Because skb_end_offset(from) grew while from->truesize did not, delta is
underestimated by the head expansion size and can be smaller than
from->len or negative, triggering WARN_ON_ONCE(delta < len) in
skb_try_coalesce() and corrupting to->truesize and sk_rmem_alloc.

> +
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;

[Severity: Medium]
When a TCP subflow queues a partially overlapping segment that starts
within the current DSS mapping, offset is positive while
before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
subflow->map_subflow_seq) is false.  Does rewinding map_seq by offset
without pulling the prefix expose unvalidated bytes to the MPTCP queues?

When data checksums are enabled, validate_data_csum() starts at
tcp_sk(ssk)->copied_seq + subflow->map_csum_len, so the already-consumed
prefix skb[0..offset) in an overlapping segment was never checked
against the DSS checksum.  Rewinding map_seq to include that prefix
causes mptcp_data_queue_ofo() to treat the unpulled bytes as valid
payload covering earlier DSNs, replacing and dropping previously
validated out-of-order skbs:

net/mptcp/protocol.c:mptcp_data_queue_ofo() {
	...
			} else {
				/* skb's seq =3D=3D skb1's seq and skb covers skb1.
				 * Replace skb1 with skb.
				 */
				rb_replace_node(&skb1->rbnode, &skb->rbnode,
						&msk->out_of_order_queue);
				mptcp_drop(sk, skb1);
				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
				goto merge_right;
			}
}

When msk->ack_seq later advances to that mapping, userspace reads the
unvalidated prefix from skb instead of the validated bytes that were in
skb1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793969127.gi=
t.tanggeliang@kylinos.cn?part=3D6
