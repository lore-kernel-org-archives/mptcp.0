Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000197;
	b=A/UZ9h/jYdrvheL4r3Uap3p0COAnKa4dOncxzulsLqrT5KKyLeUcvuwW1dsxBCrLeR0+
	 R75UO85pmUuoDR2w++H3gZJVgfKEtH3YO+nM0c9BtexGsuCM3b3ePn+aOZvUjUKeCaGk/
	 WKub9JAQSec7bkEIapVCUAlDagDxxC7NPSToCn4SdXb/xrs5Nq+EK8SyGAoaR0fh6ytUU
	 Z6WZ9i/Xo5I8RnPb4ucpxRZlJrPgW8V48EzTjCbWO95GUz+jffDKS4D1678hXoTusgivU
	 XE8OEbYlCUZpAOhRon+xS8MDmbbs1zhuJClufZi/yetWIpP/W3GhSH0BiAXdwjQYP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cCjFYuKXoZDpQfS0zwNSHiokVANG3aQcpI7kE7Wm9sY=;
	b=OAR2c9jJ8XxlxaLzdHgGJ3Mi6e1tM0R4B3MlTV3etvDEL6a0f7eoDSZj7iSZD73a/g4L
	 vk9F5Vj855ButR9VemNQfWV2xtVQcKCTJw0hmYqaQ2LUK1/nmsw2F/P2MR+4VC8DwUA1R
	 OiEyuFuPuJOpXytsspsHh0DM24tIx2ZtMl1FPvyQ3w6MjE7tQfKcaMSn/kTqwl7I5MvPo
	 Tg+8AjX1MOl/wADBRliBypb4KhN4DBr6Rqex+qR3iXqhLhMOAlEOgYj1NMKioyol2KoSu
	 20y9MiQ7eJqMvj46a8yjf20rdh2hGivciRhSOI4PUb16JPC4DEeRZ/+Vk40sxsHmX2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhAGuA+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD5606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhAGuA+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20781F01828;
	Mon, 26 Oct 2026 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000197;
	bh=cCjFYuKXoZDpQfS0zwNSHiokVANG3aQcpI7kE7Wm9sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PhAGuA+v4IT/6DCoso4sE/0pFWmIlQKNIMoZipR7VtZiFvH918ywfaNyDJn+vjdEB
	 gbHXLU15s35mmJ7uRcEgjfRmMNQ32rpeAkrgxzWMhOGblLWb2qoygoCng/wmNbWO3F
	 D/+e9JP00JYOvI/AGAFGNqI9Xv9ZfEqGjwlJcfM6nfrvCB2vM1FgmZwmOEnYLZwXLd
	 samMjqKB2g48vMMtr5JiGlGvlhlH3mqlV40TO/TLBQag7x772Qv8wseuAU5ks/8jji
	 ciPcPnr1UnbAwtJgfwAku+RFe9nIo/mQsiw4eX4y+JVEDTvD95homfrLpQpynF9L+d
	 6ttwjC2WXyLWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/6] mptcp: add sendmsg_locked to proto_ops
Date: Mon, 26 Oct 2026 15:36:20 +0800
Message-ID: <949a4262ea959da66bcb9fbac72b23f0eecf2879.1792999988.git.tanggeliang@kylinos.cn>
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

MPTCP currently provides a standard sendmsg() implementation which
acquires and releases the socket lock internally. However, certain
upper layers need to call the sendmsg method while the socket lock
is already held.

Split the existing mptcp_sendmsg() into mptcp_sendmsg_locked() which
assumes the caller holds the socket lock, and a tiny wrapper
mptcp_sendmsg() that acquires the lock and calls the locked version.

Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71a0a28b0d3c..8aad55e0cce7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2039,7 +2039,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2051,8 +2051,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2168,7 +2166,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2181,6 +2178,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
@@ -4854,6 +4862,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4967,6 +4976,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

