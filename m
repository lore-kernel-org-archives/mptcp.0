Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588348;
	b=A9u1YHGUbHCtY0KruB+xPpJyRWa6ZodX43jKjESXRhBzYPQM4BlrJoOLIRv/JK28qt/s
	 u1p0uN53Ur5raITLeRC01KzrHpk4d79Z+WhoFw0C266IZjvQSA+JSKBqj93YMiQvrOmSB
	 2oTkJ1I8M1BJ3vyIDaIoFCBQQGrV8KpdY5GTHL6YxjA0p07oTjfJ5XFYlAoLsZZ2MN6qU
	 L9tU8lO/GPFGXkLg+A2/GO/Mjks6Snam/RF3wfMcq8yvxmkM395IivUaX5a02/88umOfm
	 mYM04eo8YuZxOfmLhY5UexWhFc1cPTjuqbgJ3q6cvm3RFt9+dXP7ZCjBwm+HgVD33cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JwjnGkL2ppzQfw5hphzRjedJSbkXkKpf+YZS3GSTc0o=;
	b=OQbz1Fn2U87XpX2dk5x9HbTnVwEVEJZ4+k+TtcNKQ/kR72QGIBN/Nbk39p5DG4I8Wfc0
	 wXiOsh03MIkWs4AiymMBHbDSrvBmHAl02Mb51JNt4tdi2EN3UqQsXzCelfwzI+Jn5QIYW
	 tibu5inIrSNQMpYFePPJ2FZpG5bN/Mqo/+Xh3hVqTKx4VgJSQRS8rHxJPbU2OJZLuah5O
	 ffZTZI3uHgA6WQpuSGVKE95p0nrW4Fur/jhoMjDbidoW6BNVZhXOKEb+5zUQAeMBlDTto
	 nZJvwP2Nm37UpknmGg7mCcVailBuao/CQXlg3MhZU/rAwLeBguxKhyLpHHlJAu9O/VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+dE9JNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E2606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+dE9JNA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF44D1F0093A;
	Mon,  2 Nov 2026 02:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588348;
	bh=JwjnGkL2ppzQfw5hphzRjedJSbkXkKpf+YZS3GSTc0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U+dE9JNAKErW+R6MKYNNX6rmLyZYoEm4JSLyc9FBN/xiD0qeH3k5YZFh8UDWkKTJg
	 i7IWZflrPQX3adLwbWu0J0KcbJVYQlV1Ka9x/NZ5zK4py9TDruvjY6UFU+4ukh4AN7
	 IhBpF4wW5fKNMrT18Fnyld8AhXSuJbGZFK4yK9zAumD8oNH9iLV/KDZ/3oy+d7Xw5I
	 hBpCnd61PpK92GpHbQRU3U2jObeLO4DfTN1XoA4ilbR8yZUMb8se/RVJ9LQPBehJzU
	 H4h8Ta7bLA8Q/HccYKtkcPR6SAdTlLfOznPmossxLt0NZKsnZ1hvy1Lk8ZbsFN1Kf4
	 M9x6p1wTVTsjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v4 2/5] mptcp: implement peek_len for proto_ops
Date: Mon,  2 Nov 2026 10:58:55 +0800
Message-ID: <60417d840527fb839aec6e9a15a3a4a906d59919.1793588257.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
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

Add mptcp_inq() to compute readable bytes at the MPTCP level using
mptcp_data_avail() (bytes_received - bytes_consumed) to avoid TFO
overflow issues. Returns 0 during handshake or when avail >= INT_MAX.

Wire into mptcp_peek_len() and assign .peek_len in both mptcp_stream_ops
and mptcp_v6_stream_ops.

Also fix mptcp_inq_hint() to return 0 instead of INT_MAX when ack_seq
minus the head skb's map_seq overflows. On passive TFO the head skb has
map_seq = -skb->len while ack_seq is later set to iasn, so the subtraction
overflows INT_MAX. Returning 0 prevents SIOCINQ from reporting 2GB and
stops mptcp_rcv_space_adjust() from skipping autotuning.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0caa31525b90..c6d354900e7d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2409,7 +2409,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
 
 		if (hint_val >= INT_MAX)
-			return INT_MAX;
+			return 0;
 
 		return (unsigned int)hint_val;
 	}
@@ -4797,6 +4797,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 avail;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	avail = mptcp_data_avail(msk);
+	if (avail >= INT_MAX)
+		return 0;
+
+	return (unsigned int)avail;
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
@@ -4819,6 +4839,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4931,6 +4952,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

