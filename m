Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45587225413
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870497; cv=none; b=ZizPD/BGv6akQAGE9wkYt1p3ePLKcMxAavndn0JL4gRecq/pHHnzwZCQkQ8PEcnsIALfh1sJiBW7UPitiSRxLjTozrfgzPkugR6He05O+Tq7rTLQdfAlDRTeIn0PifueU2kZvAcda9a8cRhNgACjYR9WPqEWziiEyhJwEMP44R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870497; c=relaxed/simple;
	bh=Xm0mKsaNUyCjaqVcWZ0HE40V7XwoK9Gvc0NYbATmkME=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HxHEl21qsNUfZBd6YNDXRYRZsnjYxf3ZoU1R5+86nRSIqC5sfemJkUYqTc+eq3BV6KuVh+ryr9Kvfr17KqJ79WIy7gskI4UXyZ8Kb1BLLYoPEPQdXZEia/s5af0KGVf01+8o+UK6sdauG/xndH+VpJcjlRVlYGyXl1agBqSy1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jifq0oBj; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jifq0oBj"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779870493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrIogBbUlt8jKgQrHW7phmDaqLrW8rg3kcYCSr6uN1A=;
	b=Jifq0oBjeoNaVxdVdBsxK5o4+iFyIQibplGAw4vP+Dc3keB+B/KGR01eGipLI7Se4US7Dm
	7Ed8Zb5NS0pZWq3zVc/nDgdDh2hZA2DND3JKIBD6SBOacGRwOyhxfa828F24kZNIVKLHdt
	aVNho144kHqYhmjrIP1ZRt8NDKObla8=
Date: Wed, 27 May 2026 08:28:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <f5c9f4f37aaa1c80e4cee213afdeb483ca9d957d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v5 06/12] mptcp: remove CB offset field
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Shardul Bankar" <shardul.b@mpiricsoftware.com>
In-Reply-To: <ec9e2e3d5004c3fc86353fc9a419529c956f8e44.1778446731.git.pabeni@redhat.com>
References: <cover.1778446731.git.pabeni@redhat.com>
 <ec9e2e3d5004c3fc86353fc9a419529c956f8e44.1778446731.git.pabeni@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 11, 2026 at 5:03 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20Instead, use a new msk-level field to track the bytes already consume=
d
> inside each skb, carrying the amount of bytes already copied to
> user-space, alike what TCP is already doing.
>=20
>=20The newly introduce `copied_seq` field is always accessed under the m=
sk
> socket lock, delegating the synchronization with IASN to the msk releas=
e
> CB, when the socket is owned by the user-space at remote key reception
> time. Such synchronization preserves any partial progress (copy) made o=
n
> the TFO packet.
>=20
>=20Note that the explicit synchronization in __mptcp_move_skb() is neede=
d to
> ensure that the TFO skb in the receive queue got its map_seq synched
> before the next skb lands into the receive queue when spooling the back=
log
> at mptcp_release_cb() time, as the release CB synchronization will happ=
en
> later.
>=20
>=20Prior to this patch, the TFO skb dummy mapping was always ignored, no=
w it
> affects the `copied_seq` initial update: be sure to extends the sign
> correctly of such mapping initialization time.
>=20
>=20Overall this simplify a bit the __mptcp_recvmsg_mskq(), mptcp_inq_hin=
t()
> and the __mptcp_move_skb() code and will also make possible the next
> patch.
>=20
>=20Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v4 -> v5:
>  - fix transient build issue, restoring a __mptcp_move_skb() chunk that
>  leaked in the next patch.
>=20
>=20v3 -> v4:
>  - fix peek seq race
>=20
>=20v2 -> v3:
>  - do not use msk->first in release_cb to deal with MPTCP_SYNC_SEQ:
>  subflow->iasn access is (data) racy and msk->first can be null, instea=
d
>  recompute iasn from msk bytes_received and TFO skb len
>  - when updating copied_seq after remote key reception, add iasn to it
>  instead of overwriting, to avoid deleting any partial progress.
>=20
>=20v1 -> v2:
>  - deal correctly with peek, as usally "inspired" from the corresponden=
t
>  tcp code
>  - update mptcp_inq_hint(), too
>=20
>=20Notes:
> - this explicitly relays on "mptcp: do not drop partial packets" to
> avoid dropping partially consumed packets
> - sashiko may confuse the 'offset' in mptcp_init_skb for an MPTCP-level
>  one, but it refers to the TCP sequence space. Conclusion out of the
>  that assumptions are wrong.
> - the data race in mptcp_inq_hint() is real, but pre-existing and can
>  impact only sockopt() output - the other call-sites are race free, as
>  ack_seq updates are serialized by the RX path.
>  Fixing the race for good without sashiko tripping on other similar
>  minor races would require another largish series. Postponed.
> - sashiko may see a race with `copied_seq` in mptcp_recv_skb(), that is
>  not real: subflow_set_remote_key()/__mptcp_sync_rcv_sequence() has see=
n
>  the msk owned; if mptcp_data_ready() has seen again the msk owend, the
>  only skb in the receive queue can be the (unsynched) TFO one, with dum=
my
>  sequence. If mptcp_data_ready() observed msk not owned and queued more
>  skbs, the release_cb() has run and synched `copied_seq` and TFO skb
>  map_seq.
> ---
>  net/mptcp/fastopen.c | 15 +++--
>  net/mptcp/protocol.c | 129 ++++++++++++++++++-------------------------
>  net/mptcp/protocol.h | 8 ++-
>  net/mptcp/subflow.c | 7 ++-
>  4 files changed, 77 insertions(+), 82 deletions(-)
>=20
>=20diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index c7d5bee8088e..03e605b050f8 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -9,6 +9,7 @@
>  void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_con=
text *subflow,
>  struct request_sock *req)
>  {
> + struct mptcp_sock *msk;
>  struct sock *sk, *ssk;
>  struct sk_buff *skb;
>  struct tcp_sock *tp;
> @@ -43,20 +44,24 @@ void mptcp_fastopen_subflow_synack_set_params(struc=
t mptcp_subflow_context *subf
>  subflow->ssn_offset +=3D skb->len;
>  has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
>=20=20
>=20- /* Only the sequence delta is relevant */
> - MPTCP_SKB_CB(skb)->map_seq =3D -skb->len;
> + /* The TFO segment data sits before the IASN; before receiving
> + * the remote key, IASN is assumed being 0.
> + */
> + MPTCP_SKB_CB(skb)->map_seq =3D -(u64)skb->len;
>  MPTCP_SKB_CB(skb)->end_seq =3D 0;
> - MPTCP_SKB_CB(skb)->offset =3D 0;
>  MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
>=20=20
>=20 mptcp_data_lock(sk);
>  DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
>=20=20
>=20- mptcp_sk(sk)->rcvd_dummy_seq =3D true;
> + msk =3D mptcp_sk(sk);
> + msk->rcvd_dummy_seq =3D true;
> + msk->copied_seq =3D MPTCP_SKB_CB(skb)->map_seq;
> + msk->tfo_skb_len =3D skb->len;
>  mptcp_borrow_fwdmem(sk, skb);
>  skb_set_owner_r(skb, sk);
>  __skb_queue_tail(&sk->sk_receive_queue, skb);
> - mptcp_sk(sk)->bytes_received +=3D skb->len;
> + msk->bytes_received +=3D skb->len;
>=20=20
>=20 sk->sk_data_ready(sk);
>=20=20
>=20diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6909586a3090..47df6d4a26a7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -28,7 +28,7 @@
>  #include "protocol.h"
>  #include "mib.h"
>=20=20
>=20-static unsigned int mptcp_inq_hint(const struct sock *sk);
> +static unsigned int mptcp_inq_hint(struct sock *sk);
>=20=20
>=20 #define CREATE_TRACE_POINTS
>  #include <trace/events/mptcp.h>
> @@ -160,7 +160,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, s=
truct sk_buff *to,
>  int limit =3D READ_ONCE(sk->sk_rcvbuf);
>=20=20
>=20 if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq ||
> - MPTCP_SKB_CB(from)->offset ||
>  ((to->len + from->len) > (limit >> 3)) ||
>  !skb_try_coalesce(to, from, fragstolen, delta))
>  return false;
> @@ -342,8 +341,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  skb_set_owner_r(skb, sk);
>  }
>=20=20
>=20-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, in=
t offset,
> - int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int =
offset)
>  {
>  struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> @@ -352,9 +350,9 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset,
>  * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_se=
q
>  * value
>  */
> - MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> - MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> - MPTCP_SKB_CB(skb)->offset =3D offset;
Hi Paolo:

Sorry for digging up this old thread.

Do you still plan to remove the offset field?

I've left some comments on Geliang's TLS patches [1], and the workaround =
patch needs
the offset field. Geliang and I would like to know whether you intend to =
drop it,
address it in the short term, or have no near-term plan for it.


[1] https://patchwork.kernel.org/project/mptcp/patch/6557d95ab11416b3e798=
781cf95811bd6dd60d9e.1779788090.git.tanggeliang@kylinos.cn/

Thanks
Gang

> + MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) =
-
> + offset;
> + MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
>=20=20
>=20 __skb_unlink(skb, &ssk->sk_receive_queue);
> @@ -377,8 +375,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  if (!skb)
>  return;
>=20=20
>=20- MPTCP_SKB_CB(skb)->map_seq =3D msk->ack_seq - skb->len;
> - MPTCP_SKB_CB(skb)->end_seq =3D msk->ack_seq;
> + MPTCP_SKB_CB(skb)->map_seq =3D mptcp_iasn(msk) - skb->len;
> + MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }
>=20=20
>=20 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> @@ -405,6 +403,7 @@ static bool __mptcp_move_skb(struct sock *sk, struc=
t sk_buff *skb)
>  }
>=20=20
>=20 if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
> +add_queue:
>  /* in sequence */
>  msk->bytes_received +=3D copy_len;
>  WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> @@ -418,28 +417,16 @@ static bool __mptcp_move_skb(struct sock *sk, str=
uct sk_buff *skb)
>  } else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
>=20=20mptcp_data_queue_ofo(msk, skb);
>  return false;
> + } else if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> + /* Partial packet: map_seq < ack_seq < end_seq.*/
> + copy_len -=3D msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
> + goto add_queue;
>  }
>=20=20
>=20- /* Completely old data? */
> - if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> - MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> - mptcp_drop(sk, skb);
> - return false;
> - }
> -
> - /* Partial packet: map_seq < ack_seq < end_seq.
> - * Skip the already-acked bytes and enqueue the new data.
> - */
> - copy_len =3D MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> - MPTCP_SKB_CB(skb)->offset +=3D msk->ack_seq - MPTCP_SKB_CB(skb)->map_=
seq;
> - MPTCP_SKB_CB(skb)->map_seq +=3D msk->ack_seq -
> - MPTCP_SKB_CB(skb)->map_seq;
> - msk->bytes_received +=3D copy_len;
> - WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> -
> - skb_set_owner_r(skb, sk);
> - __skb_queue_tail(&sk->sk_receive_queue, skb);
> - return true;
> + /* Completely old data. */
> + MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> + mptcp_drop(sk, skb);
> + return false;
>  }
>=20=20
>=20 static void mptcp_stop_rtx_timer(struct sock *sk)
> @@ -783,7 +770,7 @@ static bool __mptcp_move_skbs_from_subflow(struct m=
ptcp_sock *msk,
>  if (offset < skb->len) {
>  size_t len =3D skb->len - offset;
>=20=20
>=20- mptcp_init_skb(ssk, skb, offset, len);
> + mptcp_init_skb(ssk, skb, offset);
>=20=20
>=20 if (own_msk) {
>  mptcp_subflow_lend_fwdmem(subflow, skb);
> @@ -850,8 +837,6 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *ms=
k)
>  pr_debug("uncoalesced seq=3D%llx ack seq=3D%llx delta=3D%d\n",
>  MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
>  delta);
> - MPTCP_SKB_CB(skb)->offset +=3D delta;
> - MPTCP_SKB_CB(skb)->map_seq +=3D delta;
>  __skb_queue_tail(&sk->sk_receive_queue, skb);
>  }
>  msk->bytes_received +=3D end_seq - msk->ack_seq;
> @@ -2095,34 +2080,22 @@ static void mptcp_eat_recv_skb(struct sock *sk,=
 struct sk_buff *skb)
>  }
>=20=20
>=20 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> - size_t len, int flags, int copied_total,
> + size_t len, int flags, u64 *seq,
>  struct scm_timestamping_internal *tss,
>  int *cmsg_flags, struct sk_buff **last)
>  {
>  struct mptcp_sock *msk =3D mptcp_sk(sk);
>  struct sk_buff *skb, *tmp;
> - int total_data_len =3D 0;
>  int copied =3D 0;
>=20=20
>=20 skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> - u32 delta, offset =3D MPTCP_SKB_CB(skb)->offset;
> - u32 data_len =3D skb->len - offset;
> - u32 count;
> + u64 offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
> + u32 count, data_len =3D skb->len - offset;
>  int err;
>=20=20
>=20- if (flags & MSG_PEEK) {
> - /* skip already peeked skbs */
> - if (total_data_len + data_len <=3D copied_total) {
> - total_data_len +=3D data_len;
> - *last =3D skb;
> - continue;
> - }
> -
> - /* skip the already peeked data in the current skb */
> - delta =3D copied_total - total_data_len;
> - offset +=3D delta;
> - data_len -=3D delta;
> - }
> + /* Skip the already peeked data. */
> + if (offset >=3D skb->len)
> + continue;
>=20=20
>=20 count =3D min_t(size_t, len - copied, data_len);
>  if (!(flags & MSG_TRUNC)) {
> @@ -2140,14 +2113,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk=
, struct msghdr *msg,
>  }
>=20=20
>=20 copied +=3D count;
> + *seq +=3D count;
>=20=20
>=20 if (!(flags & MSG_PEEK)) {
>  msk->bytes_consumed +=3D count;
> - if (count < data_len) {
> - MPTCP_SKB_CB(skb)->offset +=3D count;
> - MPTCP_SKB_CB(skb)->map_seq +=3D count;
> + if (count < data_len)
>  break;
> - }
>=20=20
>=20 mptcp_eat_recv_skb(sk, skb);
>  } else {
> @@ -2296,25 +2267,23 @@ static bool mptcp_move_skbs(struct sock *sk)
>  return enqueued;
>  }
>=20=20
>=20-static unsigned int mptcp_inq_hint(const struct sock *sk)
> +static unsigned int mptcp_inq_hint(struct sock *sk)
>  {
>  const struct mptcp_sock *msk =3D mptcp_sk(sk);
> - const struct sk_buff *skb;
> -
> - skb =3D skb_peek(&sk->sk_receive_queue);
> - if (skb) {
> - u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq=
;
> + u64 hint_val;
>=20=20
>=20- if (hint_val >=3D INT_MAX)
> - return INT_MAX;
> -
> - return (unsigned int)hint_val;
> - }
> + /* Avoid races vs ack_seq updates. */
> + mptcp_data_lock(sk);
> + hint_val =3D msk->ack_seq - msk->copied_seq;
> + mptcp_data_unlock(sk);
> + if (hint_val >=3D INT_MAX)
> + return INT_MAX;
>=20=20
>=20- if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOW=
N))
> + if (!hint_val &&
> + (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  return 1;
>=20=20
>=20- return 0;
> + return (unsigned int)hint_val;
>  }
>=20=20
>=20 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t=
 len,
> @@ -2323,6 +2292,7 @@ static int mptcp_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
>  struct mptcp_sock *msk =3D mptcp_sk(sk);
>  struct scm_timestamping_internal tss;
>  int copied =3D 0, cmsg_flags =3D 0;
> + u64 peek_seq, *seq;
>  int target;
>  long timeo;
>=20=20
>=20@@ -2342,6 +2312,11 @@ static int mptcp_recvmsg(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>=20=20
>=20 len =3D min_t(size_t, len, INT_MAX);
>  target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
> + seq =3D &msk->copied_seq;
> + if (flags & MSG_PEEK) {
> + peek_seq =3D msk->copied_seq;
> + seq =3D &peek_seq;
> + }
>=20=20
>=20 if (unlikely(msk->recvmsg_inq))
>  cmsg_flags =3D MPTCP_CMSG_INQ;
> @@ -2351,7 +2326,7 @@ static int mptcp_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
>  int err, bytes_read;
>=20=20
>=20 bytes_read =3D __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
> - copied, &tss, &cmsg_flags,
> + seq, &tss, &cmsg_flags,
>  &last);
>  if (unlikely(bytes_read < 0)) {
>  if (!copied)
> @@ -2406,6 +2381,10 @@ static int mptcp_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
>  err =3D copied ? : err;
>  goto out_err;
>  }
> +
> + /* Recompute peek offset after eventual seq resync. */
> + if (flags & MSG_PEEK)
> + peek_seq =3D msk->copied_seq + copied;
>  }
>=20=20
>=20 mptcp_cleanup_rbuf(msk, copied);
> @@ -3500,11 +3479,13 @@ static int mptcp_disconnect(struct sock *sk, in=
t flags)
>  msk->bytes_retrans =3D 0;
>  msk->rcvspace_init =3D 0;
>  msk->fastclosing =3D 0;
> + msk->tfo_skb_len =3D 0;
>  mptcp_init_rtt_est(msk);
>=20=20
>=20 /* for fallback's sake */
>  WRITE_ONCE(msk->ack_seq, 0);
>  atomic64_set(&msk->rcv_wnd_sent, 0);
> + msk->copied_seq =3D 0;
>=20=20
>=20 WRITE_ONCE(sk->sk_shutdown, 0);
>  sk_error_report(sk);
> @@ -3729,8 +3710,10 @@ static void mptcp_release_cb(struct sock *sk)
>  __mptcp_error_report(sk);
>  if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
>  __mptcp_sync_sndbuf(sk);
> - if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> + if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> + msk->copied_seq +=3D mptcp_iasn(msk);
>  __mptcp_sync_rcv_sequence(sk);
> + }
>  }
>  }
>=20=20
>=20@@ -4390,7 +4373,7 @@ static struct sk_buff *mptcp_recv_skb(struct so=
ck *sk, u32 *off)
>  mptcp_move_skbs(sk);
>=20=20
>=20 while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
> - offset =3D MPTCP_SKB_CB(skb)->offset;
> + offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  if (offset < skb->len) {
>  *off =3D offset;
>  return skb;
> @@ -4432,11 +4415,9 @@ static int __mptcp_read_sock(struct sock *sk, re=
ad_descriptor_t *desc,
>  copied +=3D count;
>=20=20
>=20 msk->bytes_consumed +=3D count;
> - if (count < data_len) {
> - MPTCP_SKB_CB(skb)->offset +=3D count;
> - MPTCP_SKB_CB(skb)->map_seq +=3D count;
> + msk->copied_seq +=3D count;
> + if (count < data_len)
>  break;
> - }
>=20=20
>=20 mptcp_eat_recv_skb(sk, skb);
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 16a1f4531dad..f3d852e52982 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -129,7 +129,6 @@
>  struct mptcp_skb_cb {
>  u64 map_seq;
>  u64 end_seq;
> - u32 offset;
>  u8 has_rxtstamp;
>  };
>=20=20
>=20@@ -289,6 +288,7 @@ struct mptcp_sock {
>  u64 bytes_sent;
>  u64 snd_nxt;
>  u64 bytes_received;
> + u64 copied_seq;
>  u64 ack_seq;
>  atomic64_t rcv_wnd_sent;
>  u64 rcv_data_fin_seq;
> @@ -308,6 +308,7 @@ struct mptcp_sock {
>  u32 last_ack_recv;
>  unsigned long timer_ival;
>  u32 token;
> + u32 tfo_skb_len;
>  unsigned long flags;
>  unsigned long cb_flags;
>  bool rcvd_dummy_seq;
> @@ -859,6 +860,11 @@ struct sock *mptcp_subflow_get_retrans(struct mptc=
p_sock *msk);
>  int mptcp_sched_get_send(struct mptcp_sock *msk);
>  int mptcp_sched_get_retrans(struct mptcp_sock *msk);
>=20=20
>=20+static inline u64 mptcp_iasn(const struct mptcp_sock *msk)
> +{
> + return msk->ack_seq - msk->bytes_received + msk->tfo_skb_len;
> +}
> +
>  static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
>  {
>  return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed)=
;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 5f371bf773f8..c8ea876bdd03 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -499,10 +499,13 @@ static void subflow_set_remote_key(struct mptcp_s=
ock *msk,
>  WRITE_ONCE(msk->can_ack, true);
>  atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
>=20=20
>=20- if (!sock_owned_by_user(sk))
> + if (!sock_owned_by_user(sk)) {
> + /* User space could have already read partially the TFO skb */
> + msk->copied_seq +=3D subflow->iasn;
>  __mptcp_sync_rcv_sequence(sk);
> - else
> + } else {
>  __set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
> + }
>  }
>=20=20
>=20 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
> --=20
>=202.54.0
>
