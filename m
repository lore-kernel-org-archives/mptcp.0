Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5C3B52E6
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864759; cv=none; b=MWRfJChLuzTiQajUPQ+szzTO3bLHm5Nw5SjV9tavzoXoLPhqv+nBqgSoVzvPdMIJBLhPPtJA51edtSY/P2gVRmdHE/S8wjrhcvhYWyaZ1eenn2KhDLKSGwFFf1h4K7NNfOH31jTA+Jrmu0DA/mKG349E5QtIgYTmn/qrFor9NNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864759; c=relaxed/simple;
	bh=akA7hGHJGL4l3vj39Lp06IVTbOUZ0HsSCSb9QfLnWHM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=pTHxN4SLo33NGcFwDVKwA1RTdMpxumJssD4yRtp7q/kb0XTKL8LJTgN9nV1bDmhD7b4q0shBWCcj5EHeE5SIw8v+fPYGVUSyBNAekqG1fG3wmFIws8b9PDXNN7MHECY/7FGSXUBc0T9Uznv7g+SSeR084moMvwyPvcxdyG1wNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=irw2fmE5; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="irw2fmE5"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779864754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBAsJzD49Xbi7qwSksXzaP1nwXfu8ns3HeQOgrVaHnY=;
	b=irw2fmE5QPSCjl+sA/No5gbAzKfU20yh9e5qqFUZybAhL8JmM3kmdlvUcMPhznD6539MH3
	ptm3hHQWuhqIp2QBAh3YJufQG4tEV6Vap04KGf0KbRRV0Yb2xcYqKRVz12SjmD0ZbIjA3U
	jOunr7zfJxlOHcBBcy+ygFEDygaUZsU=
Date: Wed, 27 May 2026 06:52:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <836e21cb106dd2288b48132e736dff6efe2d0178@linux.dev>
TLS-Required: No
Subject: Re: [RFC mptcp-next v20 05/15] mptcp: implement tls_mptcp_ops
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: "Geliang Tang" <tanggeliang@kylinos.cn>, "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <6557d95ab11416b3e798781cf95811bd6dd60d9e.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
 <6557d95ab11416b3e798781cf95811bd6dd60d9e.1779788090.git.tanggeliang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

May 26, 2026 at 5:46 PM, "Geliang Tang" <geliang@kernel.org mailto:gelian=
g@kernel.org?to=3D%22Geliang%20Tang%22%20%3Cgeliang%40kernel.org%3E > wro=
te:


>=20
>=20From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
>=20This patch implements the MPTCP-specific struct tls_prot_ops, named
> 'tls_mptcp_ops'.
>=20
>=20Passing an MPTCP socket to tcp_sock_rate_check_app_limited() can
> trigger a crash. Here, an MPTCP version of check_app_limited() is
> implemented, which calls tcp_sock_rate_check_app_limited() for each
> subflow.
>=20
>=20When MPTCP implements lock_is_held interface, it not only checks
> sock_owned_by_user_nocheck(sk) as TCP does, but also needs to check
> whether the MPTCP data lock is held. This is required because TLS
> may call lock_is_held from softirq context with bh_lock_sock held.
> Checking both conditions ensures TLS always defers to workqueue when
> the MPTCP data lock is held, avoiding deadlock.
>=20
>=20Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h | 2 +
>  include/net/tcp.h | 1 +
>  net/ipv4/tcp.c | 9 +++-
>  net/mptcp/protocol.c | 121 +++++++++++++++++++++++++++++++++++++++++--
>  net/mptcp/protocol.h | 1 +
>  net/tls/tls_main.c | 13 +++++
>  6 files changed, 141 insertions(+), 6 deletions(-)
>=20
>=20diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 4cf59e83c1c5..02564eceeb7e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -132,6 +132,8 @@ struct mptcp_pm_ops {
>  void (*release)(struct mptcp_sock *msk);
>  } ____cacheline_aligned_in_smp;
>=20=20
>=20+extern struct tls_prot_ops tls_mptcp_ops;
> +
>  #ifdef CONFIG_MPTCP
>  void mptcp_init(void);
>=20=20
>=20diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f063eccbbba3..1c8201f69ef1 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -849,6 +849,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_=
sock *tp, int pktsize)
>=20=20
>=20 /* tcp.c */
>  void tcp_get_info(struct sock *, struct tcp_info *);
> +void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
>  void tcp_rate_check_app_limited(struct sock *sk);
>=20=20
>=20 /* Read 'sendfile()'-style from a TCP socket */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a058f350a759..bdad459e6605 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1097,9 +1097,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct =
msghdr *msg, int *copied,
>  }
>=20=20
>=20 /* If a gap is detected between sends, mark the socket application-l=
imited. */
> -void tcp_rate_check_app_limited(struct sock *sk)
> +void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
>  {
> - struct tcp_sock *tp =3D tcp_sk(sk);
> + struct sock *sk =3D (struct sock *)tp;
>=20=20
>=20 if (/* We have less than one packet to send. */
>  tp->write_seq - tp->snd_nxt < tp->mss_cache &&
> @@ -1112,6 +1112,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
>  tp->app_limited =3D
>  (tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
>  }
> +
> +void tcp_rate_check_app_limited(struct sock *sk)
> +{
> + tcp_sock_rate_check_app_limited(tcp_sk(sk));
> +}
>  EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
>=20=20
>=20 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t s=
ize)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a36ef97155a7..505eac23f35d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -24,6 +24,7 @@
>  #include <net/mptcp.h>
>  #include <net/hotdata.h>
>  #include <net/xfrm.h>
> +#include <net/tls.h>
>  #include <asm/ioctls.h>
>  #include "protocol.h"
>  #include "mib.h"
> @@ -1909,7 +1910,7 @@ static void mptcp_rps_record_subflows(const struc=
t mptcp_sock *msk)
>  }
>  }
>=20=20
>=20-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t=
 len)
> +static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, s=
ize_t len)
>  {
>  struct mptcp_sock *msk =3D mptcp_sk(sk);
>  struct page_frag *pfrag;
> @@ -1921,8 +1922,6 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
>  msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>  MSG_FASTOPEN | MSG_EOR;
>=20=20
>=20- lock_sock(sk);
> -
>  mptcp_rps_record_subflows(msk);
>=20=20
>=20 if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
> @@ -2038,7 +2037,6 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
>  }
>=20=20
>=20 out:
> - release_sock(sk);
>  return copied;
>=20=20
>=20 do_error:
> @@ -2049,6 +2047,17 @@ static int mptcp_sendmsg(struct sock *sk, struct=
 msghdr *msg, size_t len)
>  goto out;
>  }
>=20=20
>=20+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t=
 len)
> +{
> + int ret;
> +
> + lock_sock(sk);
> + ret =3D mptcp_sendmsg_locked(sk, msg, len);
> + release_sock(sk);
> +
> + return ret;
> +}
> +
>  static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)=
;
>=20=20
>=20 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
> @@ -4726,3 +4735,107 @@ int __init mptcp_proto_v6_init(void)
>  return err;
>  }
>  #endif
> +
> +static int mptcp_inq(struct sock *sk)
> +{
> + const struct mptcp_sock *msk =3D mptcp_sk(sk);
> + const struct sk_buff *skb;
> +
> + if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> + return 0;
> +
> + skb =3D skb_peek(&sk->sk_receive_queue);
> + if (skb) {
> + u64 answ =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +
> + if (answ >=3D INT_MAX)
> + answ =3D INT_MAX;
> +
> + /* Subtract 1, if FIN was received */
> + if (answ &&
> + (sk->sk_state =3D=3D TCP_CLOSE ||
> + (sk->sk_shutdown & RCV_SHUTDOWN)))
> + answ--;
> +
> + return (int)answ;
> + }
> +
> + return 0;
> +}
> +
> +static bool mptcp_lock_is_held(struct sock *sk)
> +{
> + return sock_owned_by_user_nocheck(sk) ||
> + mptcp_data_is_locked(sk);
> +}
> +
> +static void mptcp_read_done(struct sock *sk, size_t len)
> +{
> + struct mptcp_sock *msk =3D mptcp_sk(sk);
> + struct sk_buff *skb;
> + size_t left;
> + u32 offset;
> +
> + msk_owned_by_me(msk);
> +
> + if (sk->sk_state =3D=3D TCP_LISTEN)
> + return;
> +
> + left =3D len;
> + while (left && (skb =3D mptcp_recv_skb(sk, &offset)) !=3D NULL) {
> + int used;
> +
> + used =3D min_t(size_t, skb->len - offset, left);
> + msk->bytes_consumed +=3D used;
> + MPTCP_SKB_CB(skb)->offset +=3D used;
> + MPTCP_SKB_CB(skb)->map_seq +=3D used;
> + left -=3D used;
> +
> + if (skb->len > offset + used)
> + break;
> +
> + mptcp_eat_recv_skb(sk, skb);
> + }
> +
> + mptcp_rcv_space_adjust(msk, len - left);
> +
> + /* Clean up data we have read: This will do ACK frames. */
> + if (left !=3D len)
> + mptcp_cleanup_rbuf(msk, len - left);
> +}
> +
> +static u32 mptcp_get_skb_seq(struct sk_buff *skb)
> +{
> + return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
> +}
> +
> +static void mptcp_check_app_limited(struct sock *sk)
> +{
> + struct mptcp_sock *msk =3D mptcp_sk(sk);
> + struct mptcp_subflow_context *subflow;
> +
> + mptcp_for_each_subflow(msk, subflow) {
> + struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> + bool slow;
> +
> + slow =3D lock_sock_fast(ssk);
> + tcp_sock_rate_check_app_limited(tcp_sk(ssk));
> + unlock_sock_fast(ssk, slow);
> + }
> +}
> +
> +struct tls_prot_ops tls_mptcp_ops =3D {
> + .owner =3D THIS_MODULE,
> + .protocol =3D IPPROTO_MPTCP,
> + .inq =3D mptcp_inq,
> + .sendmsg_locked =3D mptcp_sendmsg_locked,
> + .recv_skb =3D mptcp_recv_skb,
> + .lock_is_held =3D mptcp_lock_is_held,
> + .read_sock =3D mptcp_read_sock,
> + .read_done =3D mptcp_read_done,
> + .get_skb_seq =3D mptcp_get_skb_seq,

Hi Geliang,

I think we need a get_skb_off callback, something like:

+static u32 mptcp_get_skb_off(struct sk_buff *skb)
+{
+       return MPTCP_SKB_CB(skb)->offset;
+}
+
 struct tls_prot_ops tls_mptcp_ops =3D {
        .owner                  =3D THIS_MODULE,
        .protocol               =3D IPPROTO_MPTCP,
@@ -5156,6 +5181,7 @@ struct tls_prot_ops tls_mptcp_ops =3D {
        .read_sock              =3D mptcp_read_sock,
        .read_done              =3D mptcp_read_done,
        .get_skb_seq            =3D mptcp_get_skb_seq,
+       .get_skb_off            =3D mptcp_get_skb_off,

The reason is that some functions in TLS still call skb_copy_bits directl=
y,
which completely ignores the MPTCP-level offset stored in the SKB. That c=
auses
data corruption / transmission errors.

Here is one concrete example:

The expected TLS record header is 17 03 03. We get 17 03 from the first s=
kb, and the final 03 should come from the next skb at offset 2. But skb_c=
opy_bits reads from offset 0 of that next skb, so we end up with 17 03 17=
 =E2=80=94 and that causes error -22:
'''
  [  180.277464][ T2744] tls_rx_msg_size: bad TLS header: 17 03 17, offse=
t=3D30 anchor_len=3D4590 anchor_dlen=3D4590  map_seq=3D127900655565954678=
61 end_seq=3D12790065556595467863frag_list=3D00000000683d062a fl_len=3D32=
 next=3D00000000d63e8c38 next_len=3D510=20=20=20=20=20=20=20=20=20=20
=20 map_seq=3D12790065556595467863=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20 [  180.279420][ T2744] tls_rx_msg_size: next_skb first 8 bytes: 17 03=
 03 00 19 00 00 00=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20 # # tls.c:629:multi_chunk_sendfile:Expected recv(self->cfd, buf, test=
_payload_size, MSG_WAITALL) (3945) =3D=3D test_payload_size (4097)=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20 [  180.279828][ T2744] YGYG return: copied:3945, err:-22=20=20=20=20=
=20=20
'''

In=20other places the same class of problem also triggers a -74 error.

After looking into this, here is a work-around patch I came up with:
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c24aa4ec2687..bcd05f15bc68 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -452,7 +452,8 @@ static bool tls_strp_check_queue_ok(struct tls_strpar=
ser *strp)
                seq +=3D skb->len;
                len -=3D skb->len;
                skb =3D skb->next;
-
+               if (ctx->proto->ops->get_skb_off(skb))
+                       return false;
                if (ctx->proto->ops->get_skb_seq(skb) !=3D seq)
                        return false;
                if (skb_cmp_decrypted(first, skb))
@@ -531,6 +532,18 @@ static int tls_strp_read_sock(struct tls_strparser *=
strp)
                return tls_strp_read_copy(strp, true);
=20
=20       tls_strp_load_anchor_with_queue(strp, inq);
+
+       /* If the next skb has non-zero MPTCP offset, skb_copy_bits
+        * would read stale data. Fallback to copy mode before
+        * tls_rx_msg_size touches the data.
+        */
+       if (ctx->proto->ops->get_skb_off) {
+               struct sk_buff *first =3D skb_shinfo(strp->anchor)->frag_=
list;
+
+               if (first->next && ctx->proto->ops->get_skb_off(first->ne=
xt))
+                       return tls_strp_read_copy(strp, false);
+       }
+

The first chunk prevents the -74 error by forcing TLS into copy mode
(no direct skb_copy_bits on those SKBs for decryption) when it detects an=
 MPTCP
offset.

The second chunk is a work-around that avoids the bad skb_copy_bits read =
inside
tls_rx_msg_size by falling back to copy mode when the next SKB in the fra=
g_list
has a non-zero offset.

Longer term I think we should refactor tls_rx_msg_size to properly handle=
 the
MPTCP offset, rather than relying on these fallback paths.

Thanks
Gang


> + .poll =3D mptcp_poll,
> + .epollin_ready =3D mptcp_epollin_ready,
> + .check_app_limited =3D mptcp_check_app_limited,
> +};
> +EXPORT_SYMBOL(tls_mptcp_ops);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 661600f8b573..1c604a1ded6f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -380,6 +380,7 @@ struct mptcp_sock {
>=20=20
>=20 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
>  #define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
> +#define mptcp_data_is_locked(sk) spin_is_locked(&(sk)->sk_lock.slock)
>=20=20
>=20 #define mptcp_for_each_subflow(__msk, __subflow) \
>  list_for_each_entry(__subflow, &((__msk)->conn_list), node)
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index c840a228af0d..fbb60dc1832e 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -1425,6 +1425,12 @@ static int __init tls_register(void)
>  if (err)
>  goto err_strp;
>=20=20
>=20+#ifdef CONFIG_MPTCP
> + err =3D tls_register_prot_ops(&tls_mptcp_ops);
> + if (err)
> + goto err_tcp;
> +#endif
> +
>  err =3D tls_device_init();
>  if (err)
>  goto err_ops;
> @@ -1433,6 +1439,10 @@ static int __init tls_register(void)
>=20=20
>=20 return 0;
>  err_ops:
> +#ifdef CONFIG_MPTCP
> + tls_unregister_prot_ops(&tls_mptcp_ops);
> +err_tcp:
> +#endif
>  tls_unregister_prot_ops(&tls_tcp_ops);
>  err_strp:
>  tls_strp_dev_exit();
> @@ -1444,6 +1454,9 @@ static int __init tls_register(void)
>  static void __exit tls_unregister(void)
>  {
>  tcp_unregister_ulp(&tcp_tls_ulp_ops);
> +#ifdef CONFIG_MPTCP
> + tls_unregister_prot_ops(&tls_mptcp_ops);
> +#endif
>  tls_unregister_prot_ops(&tls_tcp_ops);
>  tls_proto_cleanup();
>  tls_strp_dev_exit();
> --=20
>=202.53.0
>
