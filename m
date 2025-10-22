Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF12347FEC
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143541; cv=none; b=nVJ9LybH74x8aRb0juahDjpCf1SKPpxAFaAmFcQARcfvebbn5sOzloaPBGOJQZR44WZujurXcdqXRSmzZ4REBGBIOWlNrBmpSFILR03ZrZj03yZZZhKAyR0Qs6ea7shOeacI8zzeTxZAassOgHxtceBFTvdotBygEtIC+PdFvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143541; c=relaxed/simple;
	bh=7dVqvgKPaeM/YUjV2fcz1xyIP+/mWLKa43dfXThBShA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tNk5vYJ0ZVseGQL/3pDwB8S9ydPLC19RQOEllrEuAvr0OF/wdae5juL43qXI0vU+Xsl0jTXelj7FgtntxXvtbLCtGjU2rfKCMUT2RG5afLnsEQupXKWAKtdJGs/DisCec7Io5ExbWtopfSqGekX5OxEL+xWZyWVhYBS+Q+mvnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPWQwnjq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPWQwnjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSF375RAz2J4FLfFRCYtSYJAE8SjjJOxSqXyLCAEAA8=;
	b=QPWQwnjqLlBjOApyXeJrWGzI/cjAgGjNobZWg8xPhcSW/C5KDcnl+6AfYyw3boHO6uI5Yf
	iFh1jzMKMEfnanWGJYscv5qLNecIDHXmyaGZK2h/c/ZR8yR2J6kNdET6o8F6chXv6oIpTE
	HBHoKbLeY9kPkx6VVbbQSP7Oo1TOJsE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-Dhiq8K11PPG7_v5ZYGG_lQ-1; Wed,
 22 Oct 2025 10:32:17 -0400
X-MC-Unique: Dhiq8K11PPG7_v5ZYGG_lQ-1
X-Mimecast-MFC-AGG-ID: Dhiq8K11PPG7_v5ZYGG_lQ_1761143536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DF841956068;
	Wed, 22 Oct 2025 14:32:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 082961956056;
	Wed, 22 Oct 2025 14:32:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 08/11] mptcp: make mptcp_destroy_common() static
Date: Wed, 22 Oct 2025 16:31:51 +0200
Message-ID: <f0564608bd37deb4ad72eb0d93e87873e56200c1.1761142784.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: q4tPHfmZaklYkcH8V1tP_QSluBjo08S71izKTMHky_o_1761143536
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
index 8c835ba5a437a2..3653b10d24887e 100644
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
index a3bbce8950a5e0..dc61579282b2fc 100644
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

