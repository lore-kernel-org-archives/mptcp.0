Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BC7CF04
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936138; cv=none; b=Qcwnv2veptkYMcnI4tk+iyOrNcEztWJHD8uriLzhEq+onP1CXzgn7Y/Xe72N6i//D0CskyixcUIfTe5/pntC8bq0rkrauetcJpMK4Sb3aUHqfv1LPLENyTD+0rxi1Wt5um7oBpovjr7+/dANRFedBHM0czbSqZaDmhPtkgd+joE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936138; c=relaxed/simple;
	bh=7rJJHWX04kPETA0xp0m1Ecfw5MqH/nJCYUOrFnnW5mo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8H3WTaswz6/3rrgBRbqDIB4DsEHfnl+OFbcqDYHSdykvVANLe9iDb9CeMqrZK7vd8RoTm0MxDOyPgbsJ/Ms2LzcNSRYQ3ZQSk6fhJngg8tA7uxikb2N8KGDOimCDk0DyDUwVjCE4s4WbOqx+3PnDpw+HF5Mh0L+TBQAJQcGnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkLbdRp+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkLbdRp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705936135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UOWoEQIZeXgatx7N24f9kg+TH790lVe6zdf0engFQ4=;
	b=WkLbdRp+F25zLXfapJb1oOqoWiAjUS7HHvs0dqTIhYfIYc/LklQEyuThQCTO8yOSDgBhPo
	igp4OOMD17OqvQB0yprLZ4uPWgX1+HATzNd+ByaXWHgpcm+m++u3viSeXpXyKNJe0XxFxD
	ioPJ2dMvDFIX4Q/tiBohH/66WWe40lA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Twr2dRBePaeksLGYurhOHA-1; Mon, 22 Jan 2024 10:08:53 -0500
X-MC-Unique: Twr2dRBePaeksLGYurhOHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70BF985A58E
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F29931C060B1
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 4/7] mptcp: cleanup writer wake-up
Date: Mon, 22 Jan 2024 16:08:41 +0100
Message-ID: <a0f30d8084e6d4d3ff26807ae5be40177f627cb0.1705836321.git.pabeni@redhat.com>
In-Reply-To: <cover.1705836321.git.pabeni@redhat.com>
References: <cover.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After commit 5cf92bbadc58 ("mptcp: re-enable sndbuf autotune"), the
MPTCP_NOSPACE bit is redundant: it is always set and cleared together with
SOCK_NOSPACE.

Let's drop the first and always relay on the latter, dropping a bunch
of useless code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 15 +++------------
 net/mptcp/protocol.h | 16 ++++++----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a47834bf6ac..3599205fdceb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1691,15 +1691,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	}
 }
 
-static void mptcp_set_nospace(struct sock *sk)
-{
-	/* enable autotune */
-	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-
-	/* will be cleared on avail space */
-	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
-}
-
 static int mptcp_disconnect(struct sock *sk, int flags);
 
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
@@ -1873,7 +1864,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		continue;
 
 wait_for_memory:
-		mptcp_set_nospace(sk);
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
@@ -3898,8 +3889,8 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
-	mptcp_set_nospace(sk);
-	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
+	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bbc490f36273..3069d5c072b0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,10 +113,9 @@
 #define MPTCP_RST_TRANSIENT	BIT(0)
 
 /* MPTCP socket atomic flags */
-#define MPTCP_NOSPACE		1
-#define MPTCP_WORK_RTX		2
-#define MPTCP_FALLBACK_DONE	4
-#define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_WORK_RTX		1
+#define MPTCP_FALLBACK_DONE	2
+#define MPTCP_WORK_CLOSE_SUBFLOW 3
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -799,12 +798,9 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 
 static inline void mptcp_write_space(struct sock *sk)
 {
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
+	/* pairs with memory barrier in mptcp_poll */
+	smp_mb();
+	sk_stream_write_space(sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
-- 
2.43.0

