Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000195;
	b=okUrbojggC/DeThl83jNbAphHKv2/23XjsCTxoY/RnkBcqqIS0d/J1oT3n7SSDp+HlJO
	 x/Lk5oQIL7eB07f2YQgu+0gFDXjHaasvT4h+9ZaZyMbjqyygDVilFcfee2bglTQIoydlM
	 JZ70PHy8CqgwFCjhhvLRbb+J32genRC/XD2GSeflngxRkPqxopD/vDGkVzilYVRwVjj9d
	 agO4+LEz+dOuDpETcOFi7iQf05emqrQAvQ8hhYHKwjf3ahedyRYWLlsfRw671+Yl8Z39t
	 I/19Upkd3cx2EoWgrP0K1LccmWDY3PHhogbxv33ludS4EYte6AUz0u/OHKBuRPP4qRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2hIX/Lz/3G303jlREL9Smn0gLuA9pRR+Bqfa+bbZuy0=;
	b=Br4GyVaTdAKasNq/fUuaGuATP7pxwfEypOOoa9nL7SuP5pWy4iFA+53nGHl5l8Aw3bzK
	 JtocZdVrfS6lQ1i/opp7VgIB/v2wVMg+Vqb2kJ0o/wXarae92hlfxToB3ULMXIitWGonF
	 j7EnP13EmvlZlG0EWbUWyO1VEWYIxtBXT7HTF1XG45UcDBlGv76FozxCa3Y+QMff48adb
	 nwjhY9dn/241BlVc1UWBJr48NE5f6N2Qi2+gvTQsjTJfyKJUQN4NV7DorZZloOgJ+UDM+
	 q7L3I0H5L3FWhRo0f9uo/sKD8+bDRDtqw6zd3tAjPebUrEfM8mbqbA8n0862lWK9+Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxXDWMwi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3668606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxXDWMwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4E11F01825;
	Mon, 26 Oct 2026 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000194;
	bh=2hIX/Lz/3G303jlREL9Smn0gLuA9pRR+Bqfa+bbZuy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxXDWMwi1laTVPiQOeo9nqvZLVJlOXLbKbD48dwTdyzgA8oOsih+0N30L4VQdXQZc
	 IrYBz+sE01W7yYdIuNypn9h++ro50xV2Gmxowr6o6yObyBY25YHS/dZD/Tjf5cXSWp
	 7Ny1sTBpwxlv28ltQWEDsog8gf/GLoV7wiyeyPQ6IvJsfzgOr4Vzxhu8krCa3479ps
	 aGXLzSVnUFXZzmD6aESVlnUm4p9TUYa8ku6iygIXzp7IvAfpmIC81rVCDsyCXPKnKS
	 LLlWBK119EQshkv0J8UoqOxVh08Xdl4lUsIA6kwks9Di8gIQ6Yxrg/QnCVLgD7drZQ
	 5f5r57L5qeCcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next 3/6] mptcp: implement peek_len for proto_ops
Date: Mon, 26 Oct 2026 15:36:19 +0800
Message-ID: <22bc848942a31334be17f49a2488c51e2f307eb5.1792999988.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute the number of readable bytes at the MPTCP
level. It derives the count from ack_seq - copied_seq, returns 0 while
the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), returns
0 when the connection is closed (TCP_CLOSE or RCV_SHUTDOWN), and
subtracts 1 once a FIN has been received, mirroring tcp_inq().

READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
ack_seq and copied_seq because mptcp_inq() will be called from TLS
contexts with the socket lock held - taking the spinlock would deadlock.

On 32-bit systems a torn read can produce a wrapped subtraction (close to
2^64). When hint_val >= INT_MAX, we return 0 instead of INT_MAX to avoid
reporting 2GB of readable data when there may be none. This is likely
caused by a torn read rather than a legitimate large receive window, as
normal receive queues should not exceed INT_MAX bytes.

Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops. This is preparatory work for
an upcoming kTLS-over-MPTCP series.

Note: mptcp_inq() intentionally differs from mptcp_inq_hint() when the
calculated value is 0. mptcp_inq_hint() returns 1 to signal EOF to
ioctl/cmsg users (mirroring tcp_inq_hint()), while mptcp_inq() returns
0 because peek_len should report the actual readable byte count
(mirroring tcp_inq()).

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0caa31525b90..71a0a28b0d3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -30,6 +30,7 @@
 #include "mib.h"
 
 static unsigned int mptcp_inq_hint(const struct sock *sk);
+static int mptcp_inq(struct sock *sk);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -4188,7 +4189,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 		lock_sock(sk);
 		if (mptcp_move_skbs(sk))
 			mptcp_cleanup_rbuf(msk, 0);
-		*karg = mptcp_inq_hint(sk);
+		*karg = mptcp_inq(sk);
 		release_sock(sk);
 		break;
 	case SIOCOUTQ:
@@ -4797,6 +4798,39 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct sk_buff *skb;
+	u64 hint_val;
+	int answ;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (!skb)
+		return 0;
+
+	hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	if (hint_val >= INT_MAX)
+		return 0;
+
+	answ = (unsigned int)hint_val;
+
+	/* Subtract 1, if FIN was received. Mirror tcp_inq() */
+	if (answ &&
+	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
+		answ--;
+
+	return answ;
+}
+
+static int mptcp_peek_len(struct socket *sock)
+{
+	return mptcp_inq(sock->sk);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4819,6 +4853,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4931,6 +4966,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

