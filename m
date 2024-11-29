Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED31A01C4
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902320; cv=none; b=LLTb+8VmUma31DW9+r+8wq1efoZsruZSRdhBK/Xb90YFj8llbI+afkr7qtMjpnDxYT6b9vutPhp5ao7TlWTr3JiPhHMh2e/PYiaZsWopw6aCwW1xeMfjvNZJ8vOq/HHCGFvoiYkljryW/WySG5pkf9b6ZlX9tyRvGdpbsHupzDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902320; c=relaxed/simple;
	bh=KF+J4q7oRd+I7I9zatDjqHDiqm1jVBpye/Kyn9MvDg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=axFGc507I+4hfTLyKlyoxxyVYwtOBsCZS0HmIfTnu9zRuzh4UbXETB3TBrMoB83+G5d03LjkfnZ27CLZssR30weiI8mOg5+MgL7GnUvGO3MRnYfWNAaxZ8JGFv8pC2MGvnsX4hU+/NCL7c/4GuERIN/qmP9aRX36CUDPn7gnqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7+NTTMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7+NTTMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732902316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRG4XVTr7kH+D8O6lfBhwViJt6foO4w32ofzaV73Htk=;
	b=e7+NTTMlfH1G+gAfLkgiawYd+mVSOJHQXLVvoxb8FBQKH4uuPoCs5uA3EzMCbXSjwDmwtw
	ZpEF6ITiC4oNh5ttcUiLEjUTjsMHg09BE995ogCWXbIpYO1WBxro4SYSflFLY8Wf+cThRx
	wDTeYV7vsJW/3ixfJVKLeA/1a4+qWKQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-jWUYZqo1NsGzGzPZX3gGLA-1; Fri,
 29 Nov 2024 12:45:15 -0500
X-MC-Unique: jWUYZqo1NsGzGzPZX3gGLA-1
X-Mimecast-MFC-AGG-ID: jWUYZqo1NsGzGzPZX3gGLA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 794C31944DC5
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AED5B1955D45
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next-next 1/3] mptcp: consolidate subflow cleanup
Date: Fri, 29 Nov 2024 18:45:03 +0100
Message-ID: <4a640805e72901a59f0029d61a3eacf2068f0ca8.1732902181.git.pabeni@redhat.com>
In-Reply-To: <cover.1732902181.git.pabeni@redhat.com>
References: <cover.1732902181.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7ya4_p_4GG6gjRf1Rxg5w7cMDGUW9MJ9-iW7_YrgYBc_1732902314
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Consolidate all the cleanup actions requiring the worked in a single
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

