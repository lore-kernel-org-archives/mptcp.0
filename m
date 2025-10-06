Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E425B1FC
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738341; cv=none; b=iXkSw+LygzIS45rvGqzvm8DRdpuQqmnw41BVeHvfzVFWn4zunDcUc9yJa3/q2kiuUjqHGU6iiaHX5OtMCrNrsuKthu2fW5+tojm18HvSvG6BQuaoKKw4eUkOQ9rQ/V2yi/ohhT/QDAIHzqCFNP9W/4CA63im7jIyEWoI5LALr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738341; c=relaxed/simple;
	bh=t5EM9sTNa6jp1TsHRTto1TYcoIdeASiDiytfXEu5jjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SiiwnFJt3fDBc4OjfGOTXlCoEjBrvaASZOyN+r+z21zynzPdeoSXwS7mLlpFWn/TKyIxZt87l0NyOlq7Spi9YqLriISo19W55Odhhf5R5paXy2BWc+ghZpm6bLWJjsOMEN/94LcFgrCJT0APgIXYkAqjRRKD7uC8RKqP0OM37/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFEjC6wV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFEjC6wV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGuG+CeeCwFekLq09ZQq+rY5Zz/Td85BVZSx0qxji1w=;
	b=WFEjC6wVgjtNFIk5Yzf+v7KFLT49c7UGD0xb7v+ibR8gezrTnY2A5AJbdyzJ5yMTLTnRSN
	ke0gEwzyi3HZVQa6Fp1SQN8HgOEnbCHkliac8N04fO47TfVOJ7tyo/NZDPp9vOkoG/Iq/F
	vTJRpQyh0YL3ofcZzoEzoxFisR8lt4U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-e78iJ2zHNzqGaLFeWcCFXQ-1; Mon,
 06 Oct 2025 04:12:17 -0400
X-MC-Unique: e78iJ2zHNzqGaLFeWcCFXQ-1
X-Mimecast-MFC-AGG-ID: e78iJ2zHNzqGaLFeWcCFXQ_1759738336
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D43311800366
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00E96180035E
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 01/10] mptcp: borrow forward memory from subflow
Date: Mon,  6 Oct 2025 10:12:00 +0200
Message-ID: <db89c7930def69c9e0741f1461e17097a8b4c04b.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XHjWjZTZdUB7PQX4Nk1USYctSBYbMVTkV98_zj_2bLY_1759738336
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

