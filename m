Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3921B4257
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506458; cv=none; b=IAUGo5poCOZ28OjvjRgeoN/hVM9T+I4RBwHnGP6gl8g669JX+gyIaCNYr7Vy1KP7MKotZbn/E9R12mU87TgNfFTrzbT2ZeyWCfYhzMbsSBTjUaIRgssPg/+JDX7/HOmOlJL1tVep1ynexN+/D4BttnCA/lHsERRml74FkaSlTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506458; c=relaxed/simple;
	bh=gCvrdfjrMChvB/FjzP2XZWqZFRWyFeOFCW9Jn+EzowA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmbuuC4FDjzZ3c5xBx9uFYncMdsETUsTYDA5IpIItRD1WdgarIX9jV68GaB3CKtGsRZOd+E9IWTOIRnpTfOhAgIdxfITFfl/sANN6Rlyx7byGyR47A9+NNGGEdoPDrtpYPpVnqEPO8L4oBB88KkT24U6OE2wauog+hAFR7L8Puw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHtjLDqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHtjLDqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2C8C4CEF7;
	Fri, 12 Dec 2025 02:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506458;
	bh=gCvrdfjrMChvB/FjzP2XZWqZFRWyFeOFCW9Jn+EzowA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHtjLDqgqIpOq6MQ2PpUFteIxwAJKtbVf3iAuhFEd54A4Dqa/M+4QGEK/5FKWXBSd
	 fJsYgeynFKZ+HeLUGHBV4dxGBZIXrg5tIGrxaxzDjLlzqzA2S4UV9kJ2LIEudAlmWe
	 3mjz7/W1aI3+4NJ4qvrRORPoISriAMVXmGS9BJnjPs5QZ0vHzlaNwBkpw1aYJ4RfDx
	 jJFkI+oDEhpeKGw/dUy9u0rG+LPqVBzPf0WWFvBgBidS7kEOAAqa+HVVb5EcgoaT0I
	 DnaTFtLWyBor7Bd1sKZMrj8aBzLdumMMcU+gYikej8pqGTjv60ZWNA8HczqjYGfbiD
	 XuRURyyECZnDA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 06/10] tls: switch to mptcp_read_done
Date: Fri, 12 Dec 2025 10:27:16 +0800
Message-ID: <aa05a5a3185a1ffe3726ae229df8ef0dc9b00dd7.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, corresponding MPTCP-specific
helper mptcp_read_done() has been implemented.

TLS implementation switches between the respective TCP and MPTCP helpers
based on the detected protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++++++
 net/tls/tls_strp.c   |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3fe60818cada..7346eb9b19bd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -260,6 +260,8 @@ unsigned int mptcp_inq(const struct sock *sk);
 int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
 
 struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off);
+
+void mptcp_read_done(struct sock *sk, size_t len);
 #else
 
 static inline void mptcp_init(void)
@@ -367,6 +369,8 @@ static inline struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
 	return NULL;
 }
+
+static inline void mptcp_read_done(struct sock *sk, size_t len) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 92141e87ed25..205492bc6345 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4532,6 +4532,42 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+void mptcp_read_done(struct sock *sk, size_t len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	size_t left;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
+	left = len;
+	while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		int used;
+
+		used = min_t(size_t, skb->len - offset, left);
+		msk->bytes_consumed += used;
+		MPTCP_SKB_CB(skb)->offset += used;
+		MPTCP_SKB_CB(skb)->map_seq += used;
+		left -= used;
+
+		if (skb->len > offset + used)
+			break;
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	mptcp_rcv_space_adjust(msk, len - left);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	if (left != len)
+		mptcp_cleanup_rbuf(msk, len - left);
+}
+EXPORT_SYMBOL(mptcp_read_done);
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 3bddb871d90b..81ff6be22162 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -132,6 +132,8 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
+	sk_is_msk(strp->sk) ?
+	mptcp_read_done(strp->sk, strp->stm.full_len) :
 	tcp_read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
@@ -596,6 +598,8 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 	WARN_ON(!strp->stm.full_len);
 
 	if (likely(!strp->copy_mode))
+		sk_is_msk(strp->sk) ?
+		mptcp_read_done(strp->sk, strp->stm.full_len) :
 		tcp_read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
-- 
2.51.0

