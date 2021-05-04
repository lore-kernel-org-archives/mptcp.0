Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254070
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOWtWLmPQ8xa2dUGpJuNX1d7KZsuF0IXiJ6EAyLCgAA=;
	b=W2Leb+DeCUcLctphuO6nUiv7gyuuAS+3cYDhVhSFs01VwF2UTeakp3wj4glk16ujvLlOnj
	SM+AE+/LcUkI1cBL12VIqSiNncX/yZBzkEoaljYz7DHBLaYn2KnnqIel8FRY8Milg4ksWc
	hqARYwPXdwkncZO35I1IUDsL5SE8dLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-unaKoKZ8PXqcGfo5xh-uRw-1; Tue, 04 May 2021 17:29:47 -0400
X-MC-Unique: unaKoKZ8PXqcGfo5xh-uRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DCF91006C80;
	Tue,  4 May 2021 21:29:46 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB8716090F;
	Tue,  4 May 2021 21:29:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 02/21] Squash-to: "mptcp: generate the data checksum"
Date: Tue,  4 May 2021 23:29:12 +0200
Message-Id: <6525941e117435c08f154b62bdfd10197169d36e.1620162984.git.pabeni@redhat.com>
In-Reply-To: <cover.1620162984.git.pabeni@redhat.com>
References: <cover.1620162984.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

We must generate the csum for zero window probe, too.

Do the csum update incrementally, to avoid multiple csum computation
when the data is appended to existing skb.

Note that in a later patch we will skip unneeded csum related
operation. Changes not included here to keep the delta small.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - build the csum incrementally
 - pseudo hdr fields are in NBO/BE
 - must use len in NBO when updating the csum for data fin
---
 net/mptcp/options.c  |  3 +++
 net/mptcp/protocol.c | 29 ++++++++++++-----------------
 net/mptcp/protocol.h |  6 +++---
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 99fc21406168..beac01f58cba 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -519,6 +519,9 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		 */
 		ext->data_fin = 1;
 		ext->data_len++;
+
+		/* the pseudo header has changed, update the csum accordingly */
+		csum_replace2(&ext->csum, htons(ext->data_len - 1), htons(ext->data_len));
 	}
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a094d35a099..f2874afca3ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1279,23 +1279,16 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 
-static __sum16 mptcp_generate_data_checksum(struct sk_buff *skb)
+/* note: this always recompute the csum on the whole skb, even
+ * if we just appended a single frag. More status info needed
+ */
+static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 {
-	struct csum_pseudo_header header;
-	struct mptcp_ext *mpext;
-	__wsum csum;
-
-	mpext = mptcp_get_ext(skb);
-
-	header.data_seq = mpext->data_seq;
-	header.subflow_seq = mpext->subflow_seq;
-	header.data_len = mpext->data_len;
-	header.csum = 0;
+	struct mptcp_ext *mpext = mptcp_get_ext(skb);
+	__wsum csum = csum_unfold(mpext->csum);
+	int offset = skb->len - added;
 
-	csum = skb_checksum(skb, 0, skb->len, 0);
-	csum = csum_partial(&header, sizeof(header), csum);
-
-	return csum_fold(csum);
+	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
@@ -1392,12 +1385,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (zero_window_probe) {
 		mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 		mpext->frozen = 1;
-		ret = 0;
+		if (READ_ONCE(msk->csum_enabled))
+			mptcp_update_data_checksum(tail, ret);
 		tcp_push_pending_frames(ssk);
+		return 0;
 	}
 out:
 	if (READ_ONCE(msk->csum_enabled))
-		mpext->csum = mptcp_generate_data_checksum(tail);
+		mptcp_update_data_checksum(tail, ret);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 63a1651f9069..236782702bfb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -336,9 +336,9 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 }
 
 struct csum_pseudo_header {
-	u64 data_seq;
-	u32 subflow_seq;
-	u16 data_len;
+	__be64 data_seq;
+	__be32 subflow_seq;
+	__be16 data_len;
 	__sum16 csum;
 };
 
-- 
2.26.2

