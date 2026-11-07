Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053871;
	b=Dkvsvoho03FAGkAoH05kmMVZU/V3w4Usw+JuJ54875Xr2rvF8I7GCOoYf1K/TycN5MLA
	 +pn0t1gi80NeVKg9WKURGwqveT36tcIgnqkZ3w4GLE7q4k1uPaYZgD6Sa5guCYeU23sku
	 ocOmCDoHBd+d6Er9kiKveRRxe8E6FMA7c+HlNu/2ozMmmHA2ANlWVVLTXCS6HbONAWxIt
	 J+ajgK4h8PSolG4T2FjUUPHQqZ0iTMnX3ryfQ+iJqT40VvfwZfNACr8y8Db5ITgi3+/f9
	 suLLtPOW5wFaS9VbjG2EEnP6/xkHVtoMWSYrpz1zeQ/mOMnjUzAY2aQW8vcYvK8Nuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ENsdALkfUX9tGdOXL4nELYO0+LVHl7DFp0e6QBEKZkc=;
	b=SmyNyZJzgvcNEWueZTslBKDcjQub5avg6+O3FQzPeU3iKChcC0ceGbjPdV3tKnFimfxd
	 JMijLSpMPL3LJWvnMfhaXRVRuOh2pVRsTtvYqVdOaahBMSt6ZnWxuTu1KjvIxykiZPZI5
	 zfPB43AjEvjjhlPZgupIywaXL/RqvbIaYobR0J+Inm8VlyLfgYn9n/Pl0B42FCnKz98Nr
	 +7zgj+Cyhe5mbytnLeepGA2ZNuTnPuFjfBqgJ2sTQhtkSf1v9NL/Kpn907vUnROTjtSaR
	 UUITNstwivq8coMBqa9d3U5SpXUpJZaPh1BkPI9Nv387+se3FqFbopQEBXRDL9YGAtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBNjqhaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA1606A331
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBNjqhaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6AD1F008BE;
	Sat,  7 Nov 2026 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053870;
	bh=ENsdALkfUX9tGdOXL4nELYO0+LVHl7DFp0e6QBEKZkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TBNjqhaJNSJ47+FCZUae2WNOAe4r9oyaz75aFVFEJm2gZ0dnqhtL4HshdMgMYFbIB
	 oRx5VPg7PMQ5vJ6N8DaL+SXqh979lGEiAbXBxUDN/g0PXjQyKuwjFoW5syRKaTh6L+
	 01o+6I5vsTTHwMsoI33CXTukYqvFNymkzLA0KW4GqfnAxllS6KPQbUMJZSvfB9b+KT
	 47MfIGb/E46dZORn82IcrAXO75gma4+BZat+WUXIzn0tnACDElUTb1vYrSQsk2utSH
	 5Nbh9tSoqliIhFZ5Uw7ovC+s11QFm6T6fAAIAHlz0WBbbsqwO/slvALE361OLhvrZy
	 XF9T7oK/aYpEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v7 1/7] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Sat,  7 Nov 2026 20:17:14 +0800
Message-ID: <2f671ecca0dbe9268e6ac8b36e24914be91d5749.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
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

Fix mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
(bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
map_seq.

On passive TFO connections, the TFO skb has map_seq set to -skb->len.
Without the removed __mptcp_fastopen_gen_msk_ackseq() to adjust the TFO
skb's map_seq, mptcp_inq_hint() computes "ack_seq - map_seq = iasn + len",
almost always >= INT_MAX, causing SIOCINQ/FIONREAD and TCP_CM_INQ to
report INT_MAX.

Using mptcp_data_avail() avoids this by tracking bytes directly. When
RCV_SHUTDOWN is set (DATA_FIN received), add 1 to include the FIN byte,
matching the previous ack_seq - map_seq behavior.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..421df3af1ef9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2402,22 +2402,18 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val = mptcp_data_avail(msk);
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		hint_val++;
 
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val && sk->sk_state == TCP_CLOSE)
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

