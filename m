Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110EB32E68E
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354467; cv=none; b=geXuQHD8csNhVaQOwTTGR+zLYXpJvrJghgI82oStUxiF98CNqBfyjXJD94JgBQv/j/4ECac5RqrewF2/O7Fec004x9ZwV9FM2fLOuWemarIpxpGHeG56lQQ0gH76qHVzFsnEFqQkalEkzUkn/VqPewnZ9ESwqMvVL34vzNVTyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354467; c=relaxed/simple;
	bh=xeFRSwHuYlopYEEYaVKQ9MUrSsWNLD0SHO+P6uyDQJs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=aNoD8mt5B3Fn/D93w7ojylqy4KdiHykliMqHWc88sUMsqdHf4L292CNJdrkvEFtvh2FuIihr+KSJPHpTuZQLn2AwCV7wIGZ8yWJDbE4Umv9I8P/2rB/3GVphVqgMc5WptrCEgVPX9AtX/uwZX0U5PtvhpdBbBsLXiBIFLb66TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dru0vuKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dru0vuKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m5o1kOp/Qjw/DnFLpZE7XdY78QoC4HzN42mwWdp7ed4=;
	b=Dru0vuKzLQOMClnhV9Cw7QOdyIs1BzwNEM1o1Hz0ytrzgq8FTJ2fW9JGo7Z96jRFG+aeW0
	w32pU0DVyOcqkffe9mk1ugW3WcGC+Rl9bWai+Xo3VK2iBEf9164iiV+x1J9qsL2lMKEgYR
	g4x0qsYuBYsEYDoWsKQKVOYpYBmc5VE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-LnHngFTlOsyV6t5uuupx-w-1; Wed,
 05 Nov 2025 09:54:23 -0500
X-MC-Unique: LnHngFTlOsyV6t5uuupx-w-1
X-Mimecast-MFC-AGG-ID: LnHngFTlOsyV6t5uuupx-w_1762354463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DECE81956095
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:54:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.34.105])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FB84300018D
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:54:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: decouple mptcp fastclose from tcp close
Date: Wed,  5 Nov 2025 15:54:11 +0100
Message-ID: <962efc0fd760155328967f4023a899e520e6f9a7.1762354419.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m5YNOb4lyhSQR79IqLmmgn1ROMTUOExIf4TLkA6rie4_1762354463
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With the current fastclose implementation, the mptcp_do_fastclose() helper
is in charge of two distinct actions: send the fastclose reset and cleanup
the subflows.

Formally decouple the two steps, ensuring that mptcp explicitly closes all
the subflows after the mentioned helper.

This will make the upcoming fix simpler, and allows dropping the 2nd
argument from mptcp_destroy_common().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e2cb3cfbcdae..7c66300c9fe1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2791,7 +2791,11 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(sk);
 
 	if (mptcp_close_tout_expired(sk)) {
+		struct mptcp_subflow_context *subflow, *tmp;
+
 		mptcp_do_fastclose(sk);
+		mptcp_for_each_subflow_safe(msk, subflow, tmp)
+			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
 		mptcp_close_wake_up(sk);
 	}
 
@@ -3194,7 +3198,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
 }
 
-static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
+static void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -3203,7 +3207,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
@@ -3237,7 +3241,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
-	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+	mptcp_do_fastclose(sk);
+	mptcp_destroy_common(msk);
 
 	/* The first subflow is already in TCP_CLOSE status, the following
 	 * can't overlap with a fallback anymore
@@ -3425,7 +3430,7 @@ static void mptcp_destroy(struct sock *sk)
 
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
-	mptcp_destroy_common(msk, 0);
+	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
-- 
2.51.0

