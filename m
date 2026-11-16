Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811156;
	b=KZY7Mhirf1y23w/NyAq6Cdx33mxYqfcHK17nhtUwHCRLyE3va+Qzt2rXjRkv++czW1tS
	 IT+VUkjUBrbMovvlG+Hd6L6CZQMpg/50LyqCSMu/Iw48Phea1ZNJLUGvU2kfQTNUyizGC
	 PGX6UTtTg18Rz1zikFaIcmH76OV/SsGQLchKaup8IYzoPFNH52qCPysQxWe7xJLDkXXOQ
	 shHVMf58jhNQjrigy2P9uv/3EnGjaoH4Mx1QkqPwvOOwG9CAEfUtmJ4WQcTHd5ziklHKW
	 UsbaNPsF+TUA9yPNFBwLseJPofISoJD3yqQzAxBrmqYIrQMrfQbH62/6uiqYGfOnXaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811156;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tdQzfClLC64o8rIabLyk7/eIR/PZiUYzHwzQNiarD0s=;
	b=4U526ilmpQo8JggzNZOARgI/OTgji/h94tS4jpcjG2Ya83WhizIGi5EWcxcun29lY5JY
	 G92fOUsZVgQQnr4LsHtgNEoX08CvHmjbKPlPOhh3CtSXMyZyDoffZ6nZVvkvjDoRdYt1p
	 nQ7Svqk1X7MTniPkp4eVXiduf5u8EtJAa/ESzlfz8Pi7RSrIxfV2jffoUcjJTLtrz45pb
	 sXuVjls7Nmi8NdtWM84M4q9isfNqM5Qi20G3ThL9khHNIK4Yydz+snc+qJsaqo+DVq3jH
	 0i59eVpYffcUCpeIXAs9Q7WLhAchd/OvS7ZjalyYmv27rVxDIoNWwNa+msDWrFn1zYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv3jGoJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969B606A32C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv3jGoJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360171F000C7
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811156;
	bh=tdQzfClLC64o8rIabLyk7/eIR/PZiUYzHwzQNiarD0s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Vv3jGoJXFgCQv+8CSx42hgshAruGHe9hlox1VFq7KMIwYxhtdOLwaaQWypbGhbvv3
	 bRZTWD4EqPDJAifisZuL1rN0XB7qd0J6W18a0MtmwgbXbNkKRR8Rq7mnZw/2WEqcrl
	 l3dvv+ci0tQLlTjbeDfsv8FEu+OGTdkfm+KMraoaWyRK/ZJj7hZg9Ix8A4hgjj+aNC
	 fFimnyZk7yGgDt5GjNPxGFtJZ1cpDLxmFKEUQlPxX19h0CWtzBYA14JV2gtDBUFAMq
	 bjBgUzXBR7H8fDu02CsjzgVsq1xXDEtfmBtpGEZwpU8c67eN6vn0gWduW6jKJHW72D
	 V0+n4LpmTLkxA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 06/11] mptcp: add flags field to mptcp_skb_cb
Date: Mon, 16 Nov 2026 14:38:59 +0800
Message-ID: <f31e23f95b08c864e69ad13f1d794795b24ead1a.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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

Add a flags field to mptcp_skb_cb and define MPTCP_SKB_CB_F_OFFSET to
mark skbs with a non-zero offset. The flag is set in mptcp_init_skb()
when offset > 0, and checked in __mptcp_try_coalesce() to prevent
coalescing skbs with consumed prefixes.

This is in preparation for the removal of the offset field and the
introduction of copied_seq tracking in subsequent patches.

Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/fastopen.c | 1 +
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index e18b31028e7e..ac0b23882bfd 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -49,6 +49,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	mptcp_data_lock(sk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 41fc2429d2fe..395bdcd0080c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,7 +168,8 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    MPTCP_SKB_CB(from)->offset ||
+	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
+	     MPTCP_SKB_CB_F_OFFSET ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -428,6 +429,7 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4e49d719200..241437deaf2d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,10 +128,13 @@
 #define MPTCP_SYNC_SNDBUF	7
 #define MPTCP_SYNC_SEQ		8
 
+#define MPTCP_SKB_CB_F_OFFSET	(TCPHDR_FLAGS_MASK + 1)
+
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
 	u32 offset;
+	u16 flags;
 	u8  has_rxtstamp;
 };
 
-- 
2.55.0

