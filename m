Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C6287245
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506449; cv=none; b=T90BJv2jiS0sKGqVrSieHWgvVHsbbB6aqBL9Yu9HZjdcE3x0oyQmDkn9uvVyb6T9dsM0SKNJsqLg6FjZBR48F3k/mTUKvhpDB0GAsxFv0kM9r6gHwHOL8DZIyHVVdQbsWkqC/8WMyD4qMcLrQyyk2bsVU2kSwauAw31/ndX7m6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506449; c=relaxed/simple;
	bh=tPaghPmLGRJTUlN1s8E2PHNc3lFIXXRBgG0Ew/QGudE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brr9HLhpUXsyTOqkGMfN384sR+C2/H+uBqOABllpCdH2HXo64gUjYRwUhKkPU71dXu5bBMI+Nxc71dDZf1NgKpBN/aI9xulon4s4kEyK1gk6/6BSH1NUmQ814QN3iFHjDQhjAVDrychvQdXFu0wreTf4Xb0ZjyC3o94Uj2wlSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnpMHbMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnpMHbMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C072C113D0;
	Fri, 12 Dec 2025 02:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506449;
	bh=tPaghPmLGRJTUlN1s8E2PHNc3lFIXXRBgG0Ew/QGudE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnpMHbMmmkRJNCtFD4FzDqFvXpyGll3EEPv8UydhNwtptFTNQqvlZqRyvib/7xJE1
	 WloASIe13r9Ji/v0ZCsrR+Lj+upQ99AuA+gcd1LfekTytqrMGoMq/ZPjFhqU9FkeHD
	 M2xk9xO3rnyUt4nC0TQNyDCB57IN1uhQXQuCRDqm4st1E1i6UyOLS1FgSvWYwPGA2U
	 cN29Ruhz8YWQmW2aiQ2GYrLa5KYLkGshfnFoKT3AxaqsqQXjBWyxzgo3fYK/rjt16u
	 rRFdySaYrexC/aocE7L6oOdLOIBSk5nmWGZtc9dhOP+LJKtKP6L9Ez2Hee+35dm/x5
	 WpVdVaSn9d9rA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 02/10] tls: switch to MPTCP_SKB_CB
Date: Fri, 12 Dec 2025 10:27:12 +0800
Message-ID: <31e6e239c93a18940f6332ae01186a2491bed62f.1765505775.git.tanggeliang@kylinos.cn>
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
macro MPTCP_SKB_CB() has been exported into net/mptcp.h.

TLS implementation switches between the respective TCP and MPTCP macros
based on the detected protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 10 ++++++++++
 net/mptcp/protocol.h | 10 ----------
 net/tls/tls_strp.c   |  8 ++++++--
 net/tls/tls_sw.c     |  4 +++-
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 82660374859a..050c2e820fc4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,16 @@ struct mptcp_pm_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+struct mptcp_skb_cb {
+	u64 map_seq;
+	u64 end_seq;
+	u32 offset;
+	u8  has_rxtstamp;
+	u8  cant_coalesce;
+};
+
+#define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd5266099993..75f2fd05ece4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -125,16 +125,6 @@
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
 
-struct mptcp_skb_cb {
-	u64 map_seq;
-	u64 end_seq;
-	u32 offset;
-	u8  has_rxtstamp;
-	u8  cant_coalesce;
-};
-
-#define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
-
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
 	return (__s64)(seq1 - seq2) < 0;
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..cdbcb07a52f8 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -439,7 +439,9 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
 	first = skb_shinfo(strp->anchor)->frag_list;
 	skb = first;
-	seq = TCP_SKB_CB(first)->seq;
+	seq = sk_is_msk(strp->sk) ?
+	      MPTCP_SKB_CB(first)->map_seq :
+	      TCP_SKB_CB(first)->seq;
 
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
@@ -449,7 +451,9 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if ((sk_is_msk(strp->sk) ?
+		     MPTCP_SKB_CB(skb)->map_seq :
+		     TCP_SKB_CB(skb)->seq) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..c35c25abc40c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2489,7 +2489,9 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     (sk_is_msk(strp->sk) ?
+				      MPTCP_SKB_CB(skb)->map_seq :
+				      TCP_SKB_CB(skb)->seq) + strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.51.0

