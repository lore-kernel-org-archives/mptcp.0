Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0B34C121
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143533; cv=none; b=ZchsyBCqEmrNqQ0G7t1PcYUtSlahLX3RrZDlVki1P/Fr8xx2vCzzn8nfhk1VxEJjPc+W4r7ODy5kXiPaikQnz0XppjfCUhFHCMMfu2GhxChG1pBfO6zLMTwA3SG/887uoUycUztK2etsLK3ZKpUrsjCeXjTKe4qWLqXjfn7zTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143533; c=relaxed/simple;
	bh=M65r3wGCHhYypEpcgzmf3MFhS27QAlIJwXkabHyllF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jAHt61JT8Z7UXWho7LIETq6bwtInUCu1paI23gO82xlqGYWPRArFw2WQRKTZhN+bPktUegU+hM4KRp+bsguT7sU7ZQachqND3B6uJztOwL2zx317N9LoFI4jJfnbRHgDlitCWUl+9/o4VukogzzvdcCjShi+unrTu7SDQEA85W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW9ndJ1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW9ndJ1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKg15c9LhlrMfzKU6Z28kLvA5dar/+ZIlwoPtQsyR7M=;
	b=NW9ndJ1YHQMTS/aHcmzhcgMcFjikp+ZI9vbcr9feeCX+H0kiSs5HGXB/bjDQILEV7IkTH2
	jaSRzRbYO4+TLLkcJC0DgW/D2D9sRvPLtEzItjZUzgvrrWW4CJaXOFrBvintGZCpmXP6Z0
	flCpbAP1zXN3dIStF0SyZ1w4Pewkwk8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-mVrw4jyeOHuyuAuZWUN5jg-1; Wed,
 22 Oct 2025 10:32:05 -0400
X-MC-Unique: mVrw4jyeOHuyuAuZWUN5jg-1
X-Mimecast-MFC-AGG-ID: mVrw4jyeOHuyuAuZWUN5jg_1761143524
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1241800245;
	Wed, 22 Oct 2025 14:32:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 447651956056;
	Wed, 22 Oct 2025 14:32:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 02/11] mptcp: borrow forward memory from subflow
Date: Wed, 22 Oct 2025 16:31:45 +0200
Message-ID: <bca701062e618dd595ba395fce0f71ae6a26981c.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qtuBAwSDfjg5wY73XKGjK0nDlKTu51EoXhaEGgfZloY_1761143524
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
index 804227736638e3..372ae2d9fd229e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -337,11 +337,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-			   int copy_len)
+static int mptcp_init_skb(struct sock *ssk,
+			  struct sk_buff *skb, int offset, int copy_len)
 {
 	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	int borrowed;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -357,6 +358,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 
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

