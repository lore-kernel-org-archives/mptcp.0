Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB6134BD
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500129; cv=none; b=eFvDPSGVemepZrDJVid4TsdflZM3qwzXOR+KRVXdd+hZ+tu+rtaw9CDra78mMsyRUHYSmJu79kpHx4/p1PxN2oofMp8YQADjcbY+e7uJr77Qu6IAQ99tcZCSjVUowPZ2LWtYf0/5m3xK7lmR8R9G5mxNqbdcEC/gs9vx2KxgvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500129; c=relaxed/simple;
	bh=jqQtfJbFccWEgBHa3xJOB0qkHWJJhnvP//Z4ExzRXDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qS316ZuMtNyzKHE6rbs0zW9PIc3tqjq81V5zhSbXnozz6+VdtLl/tRoe2y0IIvvEUq/3sT7d23ZGQBzcLciJaWppvb4dWaE4qDvUNZ1xfCP5w0fp/hIQZSG4Odv3g9h97saZXCwaL3y2fxGbp+jtUBf6sLqc6PuxnR29162GkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdIYYUxO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdIYYUxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUcMumon5gU519gvTrM5Jo3mGx11g5ibe+R45ZM76tM=;
	b=SdIYYUxOh3vaqPjl3LQ1tb2ib1thtX/37iSbzbh1g4tq91+a98yljc3tI/81zMxcOa8jcx
	gWQRLqeJZH0KoN7IKpqd2CuD24RobKCN/O2AVrNmFuPF7AVkbxkdV0sPpC23ZBSSf5Ymrn
	QLt63n6MiufANWFfzCLt6eXOabd0GTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-K4004hKQOC-irNprL53wkQ-1; Fri,
 03 Oct 2025 10:02:05 -0400
X-MC-Unique: K4004hKQOC-irNprL53wkQ-1
X-Mimecast-MFC-AGG-ID: K4004hKQOC-irNprL53wkQ_1759500124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2251800343
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DC4D180057A
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 7/8] mptcp: make mptcp_destroy_common() static
Date: Fri,  3 Oct 2025 16:01:45 +0200
Message-ID: <59879dfb364477686da1ae5b6ab0ddc3478f84cc.1759499837.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OqnUznaDx5yMhxPYECSS-kPY0t-wkyBml88oay-c6X4_1759500124
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Such function is only used inside protocol.c, there is no need
to expose it to the whole stack.

Note that the function definition most be moved earlier to avoid
forward declaration.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 --
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6ae5ab7595272..e354f16f4a79f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3195,6 +3195,27 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
 }
 
+static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk = (struct sock *)msk;
+
+	__mptcp_clear_xmit(sk);
+
+	/* join list will be eventually flushed (with rst) at sock lock release time */
+	mptcp_for_each_subflow_safe(msk, subflow, tmp)
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+
+	__skb_queue_purge(&sk->sk_receive_queue);
+	skb_rbtree_purge(&msk->out_of_order_queue);
+
+	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
+	 * inet_sock_destruct() will dispose it
+	 */
+	mptcp_token_destroy(msk);
+	mptcp_pm_destroy(msk);
+}
+
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3399,27 +3420,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
-{
-	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk = (struct sock *)msk;
-
-	__mptcp_clear_xmit(sk);
-
-	/* join list will be eventually flushed (with rst) at sock lock release time */
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
-
-	__skb_queue_purge(&sk->sk_receive_queue);
-	skb_rbtree_purge(&msk->out_of_order_queue);
-
-	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
-	 * inet_sock_destruct() will dispose it
-	 */
-	mptcp_token_destroy(msk);
-	mptcp_pm_destroy(msk);
-}
-
 static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0545eab231250..46d8432c72ee7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -979,8 +979,6 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
-
 #define MPTCP_TOKEN_MAX_RETRIES	4
 
 void __init mptcp_token_init(void);
-- 
2.51.0

