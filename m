Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3141B6D06
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500119; cv=none; b=XtUiIka1tagWn3QB+BJ+yyI+bbyEey17FK1SreoB5A7jQmwCLEoTb2wlFmBb8YaZnWfD3fSzMYu1HeFoL9gNQON09GVPku9qQdFyi2xZLjLlwgYa50tWZoZBcULC003o2rL4CUNtskDhQjEy8B0XeTdYA/ldHJZNq6k80eXF1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500119; c=relaxed/simple;
	bh=t5EM9sTNa6jp1TsHRTto1TYcoIdeASiDiytfXEu5jjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=suLgMKYT3i5xHHEJiaO8oK5gQrMk28fEzQuOopzjN6AJ8kKCvpAPcpo5kcpxAoA4qikLlkrHnhxG8UYBN62RsUfV6ap7kpIDtXVYw50x/acohnbyBqyCf+GVMbPtjPC3X55WI3hFB/z2J4mG4PiTwdHz9GVcIxvugOjvYuVqoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8MeNIXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8MeNIXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGuG+CeeCwFekLq09ZQq+rY5Zz/Td85BVZSx0qxji1w=;
	b=a8MeNIXyjGlxb5aNqiYy3y6V7mdSEf5ib8eKSjxs0CNksAWIuxiiaIWrWOR9uo1FtljAbF
	Hek+ASbZAkdUT5b7mQtZbwk0fmN6H4knsY0u7CJPs9o58Wiq2FfiWwcEJ11j7HF2zQSeKK
	XuV3D6IKPpqbIwi7YxuizmT1ZXgfotM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-TMMn3YhRNnu5KabwkO-sJg-1; Fri,
 03 Oct 2025 10:01:56 -0400
X-MC-Unique: TMMn3YhRNnu5KabwkO-sJg-1
X-Mimecast-MFC-AGG-ID: TMMn3YhRNnu5KabwkO-sJg_1759500115
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AE3B180057F
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69D0E1800577
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 1/8] mptcp: borrow forward memory from subflow
Date: Fri,  3 Oct 2025 16:01:39 +0200
Message-ID: <db89c7930def69c9e0741f1461e17097a8b4c04b.1759499837.git.pabeni@redhat.com>
In-Reply-To: <cover.1759499837.git.pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xPtPCKTvTbt-xewdrLwLKBe38qb5bvVFOMyMrY8mtuw_1759500115
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In the MPTCP receive path, we release the subflow allocated
fwd memory just to allocate it again shortly after for the msk.

That could increases the failures chances, especially during
backlog processing, when other actions could consume the just
released memory before the msk socket has a chance to do the
rcv allocation.

Replace the skb_orphan() call with an open-coded variant that
explicitly borrows, with a PAGE_SIZE granularity, the fwd memory
from the subflow socket instead of releasing it. During backlog
processing the borrowed memory is accounted at release_cb time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - rebased
  - explain why skb_orphan is removed
---
 net/mptcp/protocol.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 574a1e222d9cf..34661ab979158 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -337,11 +337,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk,
-			   struct sk_buff *skb, int offset, int copy_len)
+static int mptcp_init_skb(struct sock *ssk,
+			  struct sk_buff *skb, int offset, int copy_len)
 {
 	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	int borrowed;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -357,6 +358,13 @@ static void mptcp_init_skb(struct sock *ssk,
 
 	skb_ext_reset(skb);
 	skb_dst_drop(skb);
+
+	/* "borrow" the fwd memory from the subflow, instead of reclaiming it */
+	skb->destructor = NULL;
+	borrowed = ssk->sk_forward_alloc - sk_unused_reserved_mem(ssk);
+	borrowed &= ~(PAGE_SIZE - 1);
+	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
+	return borrowed;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -690,9 +698,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
+			int bmem;
 
-			mptcp_init_skb(ssk, skb, offset, len);
-			skb_orphan(skb);
+			bmem = mptcp_init_skb(ssk, skb, offset, len);
+			skb->sk = NULL;
+			sk_forward_alloc_add(sk, bmem);
+			atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
 			ret = __mptcp_move_skb(sk, skb) || ret;
 			seq += len;
 
-- 
2.51.0

