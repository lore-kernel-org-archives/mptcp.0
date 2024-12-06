Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6B1FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487065; cv=none; b=NVet54ydMBhsQSwtxCaWrACw4ZsJzUwHZpZpB6d4A50ZioyT9+wiSB4UcT8fb9zQ3gra04Q+qAGDR7R2klcN0FXLWebmaMOOZU0Yn1QKO/tP7BMoqt5Av+StR16zo40zdw+rD6G1PN6d40gRiV9glUSxz7VaDWCaj8nMAhoVkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487065; c=relaxed/simple;
	bh=DvQdryvpYGYbciXu4RM0QTa41Fp39OU7gU58Ab9TmFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GHEUZqbQb4bRFS45tbz4c4WTmIdESN4rlDiGgypZBsUfCfnrhPeQ4ZEwTtiUZU/+RGIEfEbTrK4oCtSFK4lEGLI3E+VqapxhY6Llq3paLbS/mwanEMKL3km3w4ZZHOW8E8UM+eHcnPzgaTsINVp8oT3NH8ix9oERxVpsQJTycoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAmCukHy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAmCukHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKFeTDlZpv4iRoURERTidb2hJTsEoHN8u4bNK8zmEVc=;
	b=AAmCukHyCL4tm236AR3nlDrPYk+LJcbl3TUTlsOHHXt27U+SmEAlYN8YVfEhNoiv/sryIq
	M+t1zVxWtHBQlRDoAP+OR4aXvJj1gf0yreUTCC5lum4jGgbX2zl+DTpuNImxrYGnVDzzSy
	e1ptLpTklxGzkK7alePA95HXmgsAahI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-Lni6XAklOy2WBKN0PifNeQ-1; Fri,
 06 Dec 2024 07:10:59 -0500
X-MC-Unique: Lni6XAklOy2WBKN0PifNeQ-1
X-Mimecast-MFC-AGG-ID: Lni6XAklOy2WBKN0PifNeQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D94021955F40
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E6ED19560A0
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 4/7] mptcp: consolidate subflow cleanup
Date: Fri,  6 Dec 2024 13:10:55 +0100
Message-ID: <6d5225e24b2ddd80a356714ee3655b2d2734a92d.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2HEbfIUNyK4rUZuXYQ3AlQDCKX5bIarfBVjNCgvv0jA_1733487059
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Consolidate all the cleanup actions requiring the worker in a single
helper and ensure the dummy data fin creation for fallback socket is
performed only when the tcp rx queue is empty.

There are no functional changes intended, but this will simplify the
next patch, when the tcp rx queue spooling could be delayed at release_cb
time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd021cf8286e..2926bdf88e42 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1271,7 +1271,12 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 		subflow->map_valid = 0;
 }
 
-/* sched mptcp worker to remove the subflow if no more data is pending */
+static bool subflow_is_done(const struct sock *sk)
+{
+	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
+}
+
+/* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -1281,8 +1286,18 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
-	if (skb_queue_empty(&ssk->sk_receive_queue) &&
-	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+	if (!skb_queue_empty(&ssk->sk_receive_queue))
+		return;
+
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		mptcp_schedule_work(sk);
+
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
+	    msk->first == ssk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
 		mptcp_schedule_work(sk);
 }
 
@@ -1842,11 +1857,6 @@ static void __subflow_state_change(struct sock *sk)
 	rcu_read_unlock();
 }
 
-static bool subflow_is_done(const struct sock *sk)
-{
-	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
-}
-
 static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -1873,13 +1883,6 @@ static void subflow_state_change(struct sock *sk)
 		subflow_error_report(sk);
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
-
-	/* when the fallback subflow closes the rx side, trigger a 'dummy'
-	 * ingress data fin, so that the msk state will follow along
-	 */
-	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
-		mptcp_schedule_work(parent);
 }
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
-- 
2.45.2

