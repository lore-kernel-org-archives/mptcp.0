Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427F3161A8
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215726; cv=none; b=R+Ys9Pqhf7IK5Kjt6udxmxQSpGQ7fQRaThCxzQCveNbDBBcd+d3PTAtqs450/6FPD289X/l2+WnqTeKJqXEN2JFrLUHTNpJRaYkzgM9zhKh+5tJshiaBAiZRjN5HGRIHucbL8mig//uyl6fOpkqONzFwt5ZQLxxZf2wQ1TWg0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215726; c=relaxed/simple;
	bh=V0GM+sRubdPWRs7ChWeacHsdYylpQzXLkNLa3kL0g+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=a4m6g2CszANa3aOOsHD6st/f1eIi77eFZIkTj/nC+5s75YB9HTkUpqtZZpLpnbRFzUodRMA1bB2c67gQdryBh1lBJFzlNijEfNVa22TWyyyQJWQEKNasXixyNJHcXC7Aojd21KPlBAdvdUEo8NzDQUYvg90cX1PXMrF17rlusHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxgnpnX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxgnpnX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmMJZmYuvIseK5SnGzV3FexO0VmdG0puRiy1xlEi/s4=;
	b=dxgnpnX/RDx7K4Iu1lkDBMtsEL+0PeSIVSoFeQJ7JJAwKgu4A1A+aLz7oHrgW4c2/JOMTe
	Az70isV/vpuO4ZLM26B4p2dpSpXB/Vci2c1a51O+MYaulTkdIEEVxlQXFTyrmU9f+DD9AU
	MOBJqbSEp5ExYm+GIxjAvn7EvNSFVcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-UyJM8aZlOxqoh9Q9YsjnHg-1; Thu,
 18 Sep 2025 13:15:21 -0400
X-MC-Unique: UyJM8aZlOxqoh9Q9YsjnHg-1
X-Mimecast-MFC-AGG-ID: UyJM8aZlOxqoh9Q9YsjnHg_1758215721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8DB2180034D
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A46130002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 11/12] mptcp: borrow forward memory from subflow
Date: Thu, 18 Sep 2025 19:14:54 +0200
Message-ID: <21f14b453c27466c05eaa5f5cd4af5ec49576759.1758214564.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xOijNmCDvw-ctOikIvlt-NIgWrbH_vRGBJsbTPuDouc_1758215721
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
 net/mptcp/protocol.c | 27 +++++++++++++++++++++------
 net/mptcp/protocol.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c514b6be4eb9..50c63c40d5bca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -333,11 +333,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
@@ -353,6 +354,15 @@ static void mptcp_init_skb(struct sock *ssk,
 
 	skb_ext_reset(skb);
 	skb_dst_drop(skb);
+
+	/* "borrow" the fwd memory from the subflow, instead of reclaiming it */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+	borrowed = ssk->sk_forward_alloc - sk_unused_reserved_mem(ssk);
+	borrowed &= ~(PAGE_SIZE - 1);
+	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
+	return borrowed;
 }
 
 static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
@@ -712,14 +722,17 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
+			int bmem;
 
-			mptcp_init_skb(ssk, skb, offset, len);
-			skb_orphan(skb);
+			bmem = mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk)
+			if (own_msk) {
+				sk_forward_alloc_add(sk, bmem);
 				ret |= __mptcp_move_skb(sk, skb);
-			else
+			} else {
+				msk->borrowed_fwd_mem += bmem;
 				__mptcp_add_backlog(sk, ssk, skb);
+			}
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -3506,6 +3519,8 @@ static void mptcp_release_cb(struct sock *sk)
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
 	}
+	sk_forward_alloc_add(sk, msk->borrowed_fwd_mem);
+	msk->borrowed_fwd_mem = 0;
 }
 
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a295ce11774ea..ff87dd9a0da5a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -298,6 +298,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		borrowed_fwd_mem;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
-- 
2.51.0

