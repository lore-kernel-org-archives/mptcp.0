Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F93728BB
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040058; cv=none; b=CIamzZ07x/LQQ8ikO2KNGPp52AC5wWI2ikrWFHMmFhIQbWqBQcwyc5I3EQWxdmKPm0e+I5D7hBjpE+p/D3KfFVHlri0lrsYqgk7FfV5ACeDT1duPIqb6oRsSht51veJ5+pUpQj3vxoukXUv+tfUPATSL0rrxx31M3freb8bO6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040058; c=relaxed/simple;
	bh=0yAQeNL9S7huaiEkZqoNfIS8+QbBeUYeY9R+rGC/OE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=o/c3YItFsc5AXZ0QcNty1oVDGiECou6zMpkfdiwMSBkG+b1QMeeb9/DmHtw7qCXm2ssd+f0Rd99E6UegMN0mHowSONWOC5G8KxW8Ev0tEdL6yftDqiGDz+ZFGYKsUUBTkC/9IQNVxtO2Hdfrut61X2kzjF0xq37ejzX/+FMkGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI3QXGrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI3QXGrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MwOWkdJt7xZFcquPO37uZ9jZzo6PlW4CuZ15oYasL8=;
	b=EI3QXGrh6ioAxqTqSXoIB9qc+RsHQGB/eCdAtOefCY6HpZEBpDC0iTJD8mepWz+rsf4e68
	0y01Zp8skEms0RkMlRY0wMTTG3PMW5duXGnlSZ+6JI6wtrB9G2LnYiMUZHEhDMseJlJuSv
	BXiO8UshgU3+GzEVedqYJwl3gBvNUkA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-dUL_hv9ZNHSLwG8zRcwqBg-1; Tue,
 16 Sep 2025 12:27:34 -0400
X-MC-Unique: dUL_hv9ZNHSLwG8zRcwqBg-1
X-Mimecast-MFC-AGG-ID: dUL_hv9ZNHSLwG8zRcwqBg_1758040053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 981091800293
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC3EF19560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 04/12] mptcp: introduce the mptcp_init_skb helper.
Date: Tue, 16 Sep 2025 18:27:14 +0200
Message-ID: <e070cc84b7d00a3b0ec31f95c810fe2e7bf85059.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QZucPffE-cTZHOUH_cJOCBR9EM4NtRYVIDSu3XPikpE_1758040053
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Factor out all the skb initialization step in a new helper and
use it. Note that this change moves the MPTCP CB initialization
earlier: we can do such step as soon as the skb leaves the
subflow socket receive queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 46 ++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 671c51cb9539c..879157a1f4fb1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -323,27 +323,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
-static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
-			     struct sk_buff *skb, unsigned int offset,
-			     size_t copy_len)
+static void mptcp_init_skb(struct sock *ssk,
+			   struct mptcp_subflow_context *subflow,
+			   struct sk_buff *skb, int offset, int copy_len)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *tail;
-	bool has_rxtstamp;
-
-	__skb_unlink(skb, &ssk->sk_receive_queue);
-
-	skb_ext_reset(skb);
-	skb_orphan(skb);
-
-	/* try to fetch required memory from subflow */
-	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
-
-	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -355,6 +339,24 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+
+	skb_ext_reset(skb);
+	skb_dst_drop(skb);
+}
+
+static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sk_buff *skb)
+{
+	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	struct sock *sk = (struct sock *)msk;
+	struct sk_buff *tail;
+
+	/* try to fetch required memory from subflow */
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		goto drop;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -662,7 +664,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			ret = __mptcp_move_skb(msk, ssk, skb, offset, len) || ret;
+			mptcp_init_skb(ssk, subflow, skb, offset, len);
+			skb_orphan(skb);
+			ret = __mptcp_move_skb(msk, skb) || ret;
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
-- 
2.51.0

