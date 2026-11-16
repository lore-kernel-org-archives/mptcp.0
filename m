Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814658;
	b=DzeYiGWOUEj4c8SYn6R41VwoaOlNbyLeduL+DKn0QH4mOEUQBjcbxXUeiPBsj9f8H1I9
	 hI/91L2wogRTE90dL6LsbLMAIJ3ktWCxX392rljjlLa5PwvQ9uvijhE72tcyL1ZZbzMc9
	 lCpCqReJd3l+Uf+0R9bwU1Vg8Au8bbcgbN0cAuLhkqBoFmpiyfRygua1pS18ezZekTHWY
	 KNMjA2wdu6bx1eLDWUMttfD4jeap+cexV6tOsWI995u0UfwLkF6/zeTXZ8BoPVGfzhGGo
	 npB/nBA5R3soJx3KO4Qd4jO1mLhRfapUx6TTf2ye8qtGUYruKlv0hhOzwB8X2J7VtwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tnKehny1oV/xAzvtSwPpJ65EC+xGBwroQWONq+hfeaI=;
	b=RkqqLHX5FlKv7EarahtBl6DRq/yrts+PZeauU8bEgEWagyiZ3a9q+1acD9EArWY6PzW2
	 qGRwo8SRPYYu/h6Xk5lLhixRq6Iu0ZCu9SwFT13rB1uZ7QoD/JCvbui2DLLEdhW69Iwpa
	 E6TZm6tXcCi/GMugmaPUvc2XlbCp4qDRj1FiI3+dZyBVZA7S+IYEOClTPn1F59oa+FXSq
	 kSlRkPw0lYF9U41Am3j8AyKNJqgxbPFrKHkC38gt9PQEkzk7+51+MdgU5t4d+YsC1XPnd
	 z0GjsjA/346MIjL2FAapJnlEPHN7nGm7dsYTLgQ1EzgtznJn8qDz6Jq7I6wkdTvWdoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCvBDaEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A7606A323
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCvBDaEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC111F000C6;
	Mon, 16 Nov 2026 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794814658;
	bh=tnKehny1oV/xAzvtSwPpJ65EC+xGBwroQWONq+hfeaI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dCvBDaEM/L0JDNqRiHToPNuxwHTUfO8soKmZ1bjv+EOiLHgKAGgH4WC2Te2mqItpY
	 B+uZuiT/1pdOLpS7GoNkHOjPzOx7ljaky0hnMhGxqEs9Ll8T25ofGgao1kmM54Xxo3
	 QNNgjLQ0b5GFRNZYOq8pxmm8KsUGVC0bIRmjUXHLY2EMZkUGvdaEnYKhcfIDsfbDPu
	 9JzakFond2udcJ0FVRejBt4xnUr7CJ1idkP4xO1iwArsawHilpGDIHJVuYHHx7bBIm
	 twF3yd3tjDj34rYnRkrEIdlxxsa3svto5aY+4nOoDzIL430nVbUrGUQJ6yYgy7vrVf
	 dmfReFQBI5Hbg==
Message-ID: <sashiko-outbox-216443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v28 09/11] mptcp: drop data after DATA_FIN
 before skb init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <0b6321dafceaf638b198d43b6918ed87a58cf5f1.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
 <0b6321dafceaf638b198d43b6918ed87a58cf5f1.1794810809.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:37:37 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Critical] mptcp: unadvanced tp->copied_seq when dropping data after
  DATA_FIN
- [High] mptcp: premature data drop on local RCV_SHUTDOWN in
  mptcp_seq_after_data_fin()
- [High] mptcp: post-DATA_FIN OOO, backlog, and straddling skbs bypass
  filtering
- [High] mptcp: rcv_data_fin clearing in mptcp_check_data_fin() allows
  DATA_FIN bypass
--

commit 16698b96108faa15e512d4467eb72e9ebc40cd5c
Author: Geliang Tang <geliang@kernel.org>

mptcp: drop data after DATA_FIN before skb init

This commit adds mptcp_seq_after_data_fin() and calls it in
__mptcp_move_skbs_from_subflow() before mptcp_init_skb() to drop incoming
subflow data at or after the DATA_FIN sequence number.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 71579238a951c..425a7fe94e0c4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1177,6 +1177,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *m=
sk, u64 data_fin_seq, bool us
> =20
>  	WRITE_ONCE(msk->rcv_data_fin_seq,
>  		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
> +	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
>  	WRITE_ONCE(msk->rcv_data_fin, 1);
> =20
>  	return true;

[Severity: High]
Can data at or after the initial DATA_FIN bypass mptcp_seq_after_data_fin()
once mptcp_check_data_fin() clears msk->rcv_data_fin?

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);

		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    ...
}

mptcp_update_rcv_data_fin() only checks READ_ONCE(msk->rcv_data_fin), so
after mptcp_check_data_fin() clears msk->rcv_data_fin to 0, a peer sending
a second DATA_FIN with a higher data_fin_seq overwrites
msk->rcv_data_fin_seq.

In addition, mptcp_check_data_fin() clears msk->rcv_data_fin before setting
RCV_SHUTDOWN in sk->sk_shutdown without mptcp_data_lock(sk) or a write
barrier, so a concurrent mptcp_seq_after_data_fin() can observe both as 0:

CPU0                              CPU1
mptcp_check_data_fin()
  WRITE_ONCE(msk->ack_seq, ...)
  WRITE_ONCE(msk->rcv_data_fin, 0)
                                  __mptcp_move_skbs_from_subflow()
                                    mptcp_seq_after_data_fin()
                                      READ_ONCE(msk->rcv_data_fin) =3D=3D 0
                                      (sk->sk_shutdown & RCV_SHUTDOWN) =3D=
=3D 0
                                      return false  <-- bypasses check
  WRITE_ONCE(sk->sk_shutdown,
             ... | RCV_SHUTDOWN)

In either case, data at or after the original DATA_FIN is queued into
sk->sk_receive_queue after msk->ack_seq has advanced past msk->copied_seq,
triggering offset wraparound in __mptcp_recvmsg_mskq() and wrapping
mptcp_data_avail() to U64_MAX.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddc98497f0eb0..78ca580c6d9c5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -811,6 +811,25 @@ static void __mptcp_add_backlog(struct sock *sk,
>  		msk->backlog_unaccounted +=3D delta;
>  }
> =20
> +static bool mptcp_seq_after_data_fin(struct mptcp_sock *msk,
> +				     struct sock *ssk, u32 len)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	if (READ_ONCE(msk->rcv_data_fin) || (sk->sk_shutdown & RCV_SHUTDOWN)) {
> +		u64 seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> +		u64 fin_seq;
> +
> +		smp_rmb(); /* ensure we see the updated rcv_data_fin_seq */
> +		fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);

[Severity: High]
Does checking (sk->sk_shutdown & RCV_SHUTDOWN) drop valid in-sequence peer
data when RCV_SHUTDOWN was set locally before any DATA_FIN arrived?

__mptcp_close() and inet_shutdown() both set RCV_SHUTDOWN on
sk->sk_shutdown while msk->rcv_data_fin_seq is still 0 (or holds a stale
value from a previous connection after mptcp_disconnect()).  When
fin_seq =3D=3D 0, !before64(seq, 0) is (__s64)seq >=3D 0, which is true for=
 half
of all random initial 64-bit DSNs.  Dropping the peer's pre-DATA_FIN data
prevents msk->ack_seq from reaching the peer's DATA_FIN sequence number, so
the connection hangs in TCP_FIN_WAIT1 or TCP_FIN_WAIT2 until the close
timer expires.

> +		if (!before64(seq, fin_seq) ||
> +		    !before64(seq + len, fin_seq + 1))
> +			return true;
> +	}
> +	return false;
> +}

[Severity: High]
What happens when post-DATA_FIN segments are already queued in
msk->out_of_order_queue or msk->backlog_list before DATA_FIN arrives, or
when a single skb straddles fin_seq?

Segments that arrived before the packet carrying DATA_FIN have already
passed __mptcp_move_skbs_from_subflow().  When DATA_FIN later arrives,
__mptcp_ofo_queue() and __mptcp_move_skbs() move those post-DATA_FIN
segments into sk->sk_receive_queue without checking rcv_data_fin_seq,
causing the same offset underflow in __mptcp_recvmsg_mskq(),
mptcp_data_avail() wraparound to U64_MAX, and skipped DATA_FIN
acknowledgment.

Conversely, if a single segment straddles fin_seq (seq < fin_seq and
seq + len > fin_seq), !before64(seq + len, fin_seq + 1) drops the entire
skb including the valid [seq, fin_seq) prefix, preventing msk->ack_seq from
reaching fin_seq.

> +
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  					   struct sock *ssk, bool own_msk)
>  {
> @@ -826,7 +845,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>  		u32 map_remaining, offset;
>  		u32 seq =3D tp->copied_seq;
>  		struct sk_buff *skb;
> -		bool fin;
> +		bool fin, data_fin;
> +		size_t len;
> =20
>  		/* try to move as much data as available */
>  		map_remaining =3D subflow->map_data_len -
> @@ -850,9 +870,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>  		if (fin)
>  			seq++;
> =20
> -		if (offset < skb->len) {
> -			size_t len =3D skb->len - offset;
> -
> +		len =3D skb->len - offset;
> +		data_fin =3D mptcp_seq_after_data_fin(msk, ssk, len);
> +		if (len > 0 && !data_fin) {
>  			mptcp_init_skb(ssk, skb, offset, len);
> =20
>  			if (own_msk) {
> @@ -870,7 +890,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>  		} else {
>  			sk_eat_skb(ssk, skb);
> =20
> -			if (unlikely(!fin)) {
> +			if (len =3D=3D 0 && unlikely(!fin)) {
>  				DEBUG_NET_WARN_ON_ONCE(1);
>  				mptcp_dss_corruption(msk, ssk);
>  			}

[Severity: Critical]
When len > 0 and data_fin is true, does the else branch eat skb without
advancing seq by len before writing tp->copied_seq?

Leaving tp->copied_seq behind by len prevents mptcp_subflow_data_available()
from clearing subflow->map_valid and causes offset =3D tp->copied_seq -
TCP_SKB_CB(skb)->seq to underflow u32 on the next segment on that subflow.
In subflow_check_data_avail() -> mptcp_subflow_discard_data(), that
underflow triggers WARN_ON_ONCE(offset > skb->len) and returns without
advancing tp->copied_seq or freeing the skb, causing the caller's loop to
spin forever in softirq context:

net/mptcp/subflow.c:subflow_check_data_avail() {
    ...
		old_ack =3D READ_ONCE(msk->ack_seq);
		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
		if (unlikely(before64(ack_seq, old_ack))) {
			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
			continue;
		}
    ...
}

Replacing "if (offset < skb->len)" with an unconditional
"len =3D skb->len - offset" also wraps len in 32-bit unsigned arithmetic if
offset ever exceeds skb->len.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794810809.gi=
t.tanggeliang@kylinos.cn?part=3D9
